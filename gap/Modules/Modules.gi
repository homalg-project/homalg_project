#############################################################################
##
##  Modules.gi                  homalg package               Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Implementations of homalg procedures for modules.
##
#############################################################################

##
InstallGlobalFunction( ReducedBasisOfModule,	### defines: ReducedBasisOfModule (ReducedBasisOfModule)
  function( arg )
    local nargs, M, COMPUTE_BASIS, ar, R;
    
    nargs := Length( arg );
    
    if nargs > 0 and IsFinitelyPresentedModuleRep( arg[1] ) then
        M := CallFuncList( ReducedBasisOfModule,
                     Concatenation( [ RelationsOfModule( arg[1] ) ], arg{[2..nargs]} ) );
        if not HasRankOfModule( arg[1] ) and HasIsInjectivePresentation( M ) and IsInjectivePresentation( M ) then
            SetRankOfModule( arg[1], NrGenerators( M ) - NrRelations( M ) );
        fi;
        if not HasIsTorsion( arg[1] ) and HasIsTorsion( M ) then
            SetIsTorsion( arg[1], IsTorsion( M ) );
        fi;
        return M;
    fi;
    
    if not ( nargs > 0 and IsRelationsOfFinitelyPresentedModuleRep( arg[1] ) ) then
        Error( "the first argument must be a module or a set of relations\n" );
    fi;
    
    ## M is a set of relations (of a module)
    M := arg[1];
    
    COMPUTE_BASIS := false;
    
    for ar in arg{[ 2 .. nargs ]} do
        if ar = "COMPUTE_BASIS" then
            COMPUTE_BASIS := true;
        fi;
    od;
    
    if NrRelations( M ) = 0 then
        return M;
    fi;
    
    if COMPUTE_BASIS and IsBound( M!.ReducedBasisOfModule ) then
        return M!.ReducedBasisOfModule;
    elif not COMPUTE_BASIS and IsBound( M!.ReducedBasisOfModule_DID_NOT_COMPUTE_BASIS) then
        return M!.ReducedBasisOfModule_DID_NOT_COMPUTE_BASIS;
    fi;
    
    if COMPUTE_BASIS then
        M := BasisOfModule( M );
    fi;
    
    R := HomalgRing( M );
    
    if IsHomalgRelationsOfLeftModule( M ) then
        M := MatrixOfRelations( M );
        if HasRingRelations( R ) then
            M := GetRidOfObsoleteRows( M );
        fi;
        M := ReducedBasisOfRowModule( M );
        M := HomalgRelationsForLeftModule( M );
    else
        M := MatrixOfRelations( M );
        if HasRingRelations( R ) then
            M := GetRidOfObsoleteColumns( M );
        fi;
        M := ReducedBasisOfColumnModule( M );
        M := HomalgRelationsForRightModule( M );
    fi;
    
    if COMPUTE_BASIS then
        arg[1]!.ReducedBasisOfModule := M;
        M!.ReducedBasisOfModule := M;	## thanks GAP4
    else
        arg[1]!.ReducedBasisOfModule_DID_NOT_COMPUTE_BASIS := M;
        M!.ReducedBasisOfModule_DID_NOT_COMPUTE_BASIS := M;	## thanks GAP4
    fi;
    
    if IsList( DegreesOfGenerators( arg[1] ) ) then
        M!.DegreesOfGenerators := DegreesOfGenerators( arg[1] );
    fi;
    
    return M;
    
end );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( CheckIfTheyLieInTheSameCategory,
        "for two homalg modules, submodules, or maps",
        [ IsHomalgModuleOrMap, IsHomalgModuleOrMap ],
        
  function( M, N )
    
    if AssertionLevel( ) >= HOMALG.AssertionLevel_CheckIfTheyLieInTheSameCategory then
        if not IsIdenticalObj( HomalgRing( M ), HomalgRing( N ) ) then
            Error( "the rings of the two modules/submodules/maps are not identical\n" );
        elif not ( ( IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) and
                IsHomalgLeftObjectOrMorphismOfLeftObjects( N ) ) or
                ( IsHomalgRightObjectOrMorphismOfRightObjects( M ) and
                  IsHomalgRightObjectOrMorphismOfRightObjects( N ) ) ) then
            Error( "the two modules/submodules/maps must either be both left or both right modules/submodules/maps\n" );
        fi;
    fi;
    
end );

## ( cf. [BR08, Subsection 3.2.2] )
InstallMethod( \/,				### defines: / (SubfactorModule)
        "for a homalg matrix",
        [ IsHomalgMatrix, IsFinitelyPresentedModuleRep ],
        
  function( mat, M )
    local B, N, gen, S, SF;
    
    # basis of the set of relations of M:
    B := BasisOfModule( M );
    
    # normal form of mat with respect to B:
    N := DecideZero( mat, B );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        N := HomalgGeneratorsForLeftModule( N );
    else
        N := HomalgGeneratorsForRightModule( N );
    fi;
    
    # get a better basis for N (by default, it only throws away the zero generators):
    N := GetRidOfObsoleteGenerators( N );
    
    # this matrix of generators is often enough the identity matrix
    # and knowing this will avoid computations:
    IsOne( MatrixOfGenerators( N ) );
    
    # compute the syzygies of N modulo B, i.e. the relations among N modulo B:
    S := SyzygiesGenerators( N, B );	## using ReducedSyzygiesGenerators here causes too many operations (cf. the ex. Triangle.g)
    
    # the subfactor module
    SF := Presentation( N, S );
    
    SetParent( S, SF );
    
    # keep track of the original generators:
    gen := N * GeneratorsOfModule( M );
    
    # set properties and attributes
    if HasRankOfModule( M ) and RankOfModule( M ) = 0 then
        SetRankOfModule( SF, 0 );
    fi;
    
    return AddANewPresentation( SF, gen );
    
end );

##
InstallMethod( \/,				## needed by _Functor_Kernel_OnObjects since SyzygiesGenerators returns a set of relations
        "for a set of homalg relations",
        [ IsHomalgRelations, IsFinitelyPresentedModuleRep ],
        
  function( rel, M )
    
    return MatrixOfRelations( rel ) / M;
    
end );

##
InstallMethod( \/,
        "for homalg ideals",
        [ IsHomalgRing, IsFinitelyPresentedSubmoduleRep and ConstructedAsAnIdeal ],
        
  function( R, J )
    
    if not IsIdenticalObj( HomalgRing( J ), R ) then
        Error( "the given ring and the ring of the ideal are not identical\n" );
    fi;
    
    return ResidueClassRing( J );
    
end );

##
InstallMethod( \/,
        "for homalg modules",
        [ IsHomalgRing, IsFinitelyPresentedModuleRep and HasUnderlyingSubobject ],
        
  function( R, N )
    
    return R / UnderlyingSubobject( N );
    
end );

##
InstallMethod( BoundForResolution,
        "for homalg relations",
        [ IsHomalgRelations ],
        
  function( rel )
    local R, q;
    
    R := HomalgRing( rel );
    
    if IsBound( rel!.MaximumNumberOfResolutionSteps )
       and IsInt( rel!.MaximumNumberOfResolutionSteps ) then
        q := rel!.MaximumNumberOfResolutionSteps;
    elif IsBound( R!.MaximumNumberOfResolutionSteps )
      and IsInt( R!.MaximumNumberOfResolutionSteps ) then
        q := R!.MaximumNumberOfResolutionSteps;
    elif IsBound( HOMALG.MaximumNumberOfResolutionSteps )
      and IsInt( HOMALG.MaximumNumberOfResolutionSteps ) then
        q := HOMALG.MaximumNumberOfResolutionSteps;
    else
        q := infinity;
    fi;
    
    return q;
    
end );

## ( cf. [BR08, Subsection 3.2.1] )
InstallMethod( Resolution,			### defines: Resolution (ResolutionOfModule/ResolveModule)
        "for homalg relations",
        [ IsInt, IsHomalgRelations ],
        
  function( _q, rel )
    local R, q, d, degrees, j, d_j, F_j, S, left, i;
    
    ## all options of Maple's homalg are now obsolete:
    ## "SIMPLIFY", "GEOMETRIC", "TARGETRELATIONS", "TRUNCATE", "LOWERBOUND"
    
    R := HomalgRing( rel );
    
    if _q < 0 then
        q := BoundForResolution( rel );
    elif _q = 0 then
        q := 1;		## this is the minimum
    else
        q := _q;
    fi;
    
    if HasFreeResolution( rel ) then
        d := FreeResolution( rel );
        degrees := ObjectDegreesOfComplex( d );
        j := Length( degrees );
        j := degrees[j];
        d_j := CertainMorphism( d, j );
    else
        d_j := ReducedBasisOfModule( rel, "COMPUTE_BASIS" );	## "COMPUTE_BASIS" saves computations
        j := 1;
        d_j := HomalgMap( d_j );
        d := HomalgComplex( d_j );
        
        SetFreeResolution( rel, d );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    F_j := Source( d_j );
    
    ## the main loop to compute iterated "minimal" syzygies
    while j < q do
        
        S := ReducedSyzygiesGenerators( d_j );
        
        if NrRelations( S ) = 0 then
            break;
        fi;
        
        ## really enter the loop
        j := j + 1;
        
        if IsList( DegreesOfGenerators( F_j ) ) then
            S!.DegreesOfGenerators := DegreesOfGenerators( F_j );
        fi;
        
        d_j := HomalgMap( S, "free", F_j );
        
        Add( d, d_j );
        
        F_j := Source( d_j );
        
    od;
    
    if NrGenerators( Source( d_j ) ) = 1 and
       HasIsIntegralDomain( R ) and IsIntegralDomain( R ) then
        S := SyzygiesGenerators( d_j );	## this will be handled by internal logic
    fi;
    
    if IsBound( S ) and NrRelations( S ) = 0 and not IsBound( d!.LengthOfResolution ) then
        d!.LengthOfResolution := j;
    fi;
    
    ## fill up with zero morphisms:
    if _q >= 0 then
        left := IsHomalgLeftObjectOrMorphismOfLeftObjects( F_j );
        for i in [ 1 .. q - j ] do
            if left then
                d_j := TheZeroMorphism( 0 * R, F_j );
            else
                d_j := TheZeroMorphism( R * 0, F_j );
            fi;
            
            Add( d, d_j );
            F_j := Source( d_j );
        od;
    fi;
    
    if IsBound( S ) and NrRelations( S ) = 0 then
        
        ## check assertion
        Assert( 4, IsRightAcyclic( d ) );
        
        SetIsRightAcyclic( d, true );
        
    else
        
        ## check assertion
        Assert( 4, IsAcyclic( d ) );
        
        SetIsAcyclic( d, true );
    fi;
    
    return d;
    
end );

##
InstallMethod( Resolution,
        "for homalg relations",
        [ IsHomalgRelations ],
        
  function( M )
    
    return Resolution( -1, M );
    
end );

##
InstallMethod( BoundForResolution,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local R, q;
    
    R := HomalgRing( M );
    
    #if HasProjectiveDimension( M ) then
    #    q := ProjectiveDimension( M );			## +1 ???
    #elif IsBound( M!.UpperBoundForProjectiveDimension )
    #  and IsInt( M!.UpperBoundForProjectiveDimension ) then
    #    q := M!.UpperBoundForProjectiveDimension;	## +1 ???
    if IsBound( M!.MaximumNumberOfResolutionSteps )
      and IsInt( M!.MaximumNumberOfResolutionSteps ) then
        q := M!.MaximumNumberOfResolutionSteps;
    elif IsBound( R!.MaximumNumberOfResolutionSteps )
      and IsInt( R!.MaximumNumberOfResolutionSteps ) then
        q := R!.MaximumNumberOfResolutionSteps;
    elif IsBound( HOMALG.MaximumNumberOfResolutionSteps )
      and IsInt( HOMALG.MaximumNumberOfResolutionSteps ) then
        q := HOMALG.MaximumNumberOfResolutionSteps;
    else
        q := infinity;
    fi;
    
    return q;
    
end );

##
InstallMethod( Resolution,
        "for homalg modules",
        [ IsInt, IsFinitelyPresentedModuleRep ],
        
  function( _q, M )
    local rel, q, d, rank, d_1;
    
    rel := RelationsOfModule( M );
    
    if _q < 0 then
        rel!.MaximumNumberOfResolutionSteps := BoundForResolution( M );
        q := _q;
    elif _q = 0 then
        q := 1;		## this is the minimum
    else
        q := _q;
    fi;
    
    d := Resolution( q, rel );
    
    if IsBound( d!.LengthOfResolution ) then
        M!.UpperBoundForProjectiveDimension := d!.LengthOfResolution;
    elif IsBound( M!.UpperBoundForProjectiveDimension ) then			## the last map is not a monomorphism:
        if _q < 0 or M!.UpperBoundForProjectiveDimension <= q then		## but still its kernel is projective
            d!.LengthOfResolution := Length( MorphismDegreesOfComplex( d ) );
        fi;
    fi;
    
    if HasIsRightAcyclic( d ) and IsRightAcyclic( d ) then
        SetFiniteFreeResolutionExists( M, true );
        ResetFilterObj( M, AFiniteFreeResolution );
        SetAFiniteFreeResolution( M, d );
        rank := Sum( ObjectDegreesOfComplex( d ),
                     i -> (-1)^i *  NrGenerators( CertainObject( d, i ) ) );
        SetRankOfModule( M, rank );
        if HasTorsionFreeFactorEpi( M ) then
            SetRankOfModule( Range( TorsionFreeFactorEpi( M ) ), rank );
        fi;
    fi;
    
    d_1 := CertainMorphism( d, 1 );
    
    if not HasCokernelEpi( d_1 ) then
        ## the zero'th component of the quasi-isomorphism,
        ## which in this case is simplfy the natural epimorphism onto the module
        SetCokernelEpi( d_1, HomalgIdentityMap( Range( d_1 ), M ) );
        SetIsEpimorphism( d_1!.CokernelEpi, true );
    fi;
    
    return d;
    
end );

##
InstallMethod( SyzygiesObjectEpi,
        "for homalg modules",
        [ IsInt, IsFinitelyPresentedModuleRep ],
        
  function( q, M )
    local d, mu, epi, mat;
    
    if q < 0 then
        Error( "a netative integer does not make sense\n" );
    elif q = 0 then
        return CokernelEpi( PresentationMap( M ) );
    fi;
    
    d := Resolution( q, M );
    
    mu := SyzygiesObjectEmb( q, M );
    
    epi := CertainMorphism( d, q ) / mu;	## lift
    
    SetIsEpimorphism( epi, true );
    
    ## this might simplify things later:
    IsOne( MatrixOfMap( epi ) );
    
    return epi;
    
end );

##
InstallMethod( FiniteFreeResolution,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    if HasAFiniteFreeResolution( M ) then
        return AFiniteFreeResolution( M );
    elif not HasFiniteFreeResolutionExists( M ) or FiniteFreeResolutionExists( M ) then	## in words: either a finite free resolution exists or its existence is not known yet
        Resolution( M );
    fi;
    
    ## now check again:
    if HasAFiniteFreeResolution( M ) then
        return AFiniteFreeResolution( M );
    fi;
    
    return fail;
    
end );

##
InstallGlobalFunction( ParametrizeModule,	### defines: ParametrizeModule
  function( arg )
    local nargs, ALL, ANY, ar, rel, R, left, mat, par, M, rk, F;
    
    nargs := Length( arg );
    
    ALL := false;
    ANY := false;
    
    for ar in arg{[ 2 .. nargs ]} do
        if ar = "ALL" then
            ALL := true;
        elif ar = "ANY" then
            ANY := true;
        fi;
    od;
    
    if IsHomalgModule( arg[1] ) then
        rel := RelationsOfModule( arg[1] );
    elif IsHomalgRelations( arg[1] ) then
        rel := arg[1];
    else
        Error( "the first argument must be a homalg module or a homalg set of relations\n" );
    fi;
    
    R := HomalgRing( rel );
    
    left := IsHomalgRelationsOfLeftModule( rel );
    
    mat := MatrixOfRelations( rel );
    
    if left then
        par := SyzygiesOfColumns( mat );
    else
        par := SyzygiesOfRows( mat );
    fi;
    
    if IsHomalgModule( arg[1] ) then
        
        M := arg[1];
        
        if not ANY then
            if not HasRankOfModule( M ) then
                Resolution( M );
            fi;
            if HasRankOfModule( M ) then
                rk := RankOfModule( M );
                if left then
                    F := HomalgFreeLeftModule( rk, R );
                    par := CertainColumns( par, [ 1 .. rk ] );	## a minimal parametrization due to Alban
                else
                    F := HomalgFreeRightModule( rk, R );
                    par := CertainRows( par, [ 1 .. rk ] );	## a minimal parametrization due to Alban
                fi;
            fi;
        fi;
        
        if ANY or not HasRankOfModule( M ) then
            if left then
                F := HomalgFreeLeftModule( NrColumns( par ), R );
            else
                F := HomalgFreeRightModule( NrRows( par ), R );
            fi;
        fi;
        
        par := HomalgMap( par, M, F );
        
        SetIsMorphism( par, true );
        
    fi;
    
    return par;
    
end );

##
InstallMethod( PushPresentationByIsomorphism,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and IsIsomorphism ],
        
  function( phi )
    local M, iso, pos, TI, T;
    
    M := Range( phi );
    
    ## copying phi is important for the lazy evaluation below
    ## otherwise phi will be part of the transition matrix data
    ## of M, which might be needed to compute phi!
    iso := ShallowCopy( phi );
    
    pos := PairOfPositionsOfTheDefaultSetOfRelations( iso );
    
    TI := MatrixOfMap( iso );
    
    T := HomalgMatrix( HomalgRing( TI ) );
    
    SetNrRows( T, NrColumns( TI ) );
    SetNrColumns( T, NrRows( TI ) );
    
    SetEvalMatrixOperation( T, [ a -> MatrixOfMap( a^-1, pos[2], pos[1] ), [ iso ] ] );
    
    return AddANewPresentation( M, RelationsOfModule( Source( iso ), pos[1] ), T, TI );
    
end );

##
InstallMethod( Intersect2,
        "for homalg relations",
        [ IsHomalgRelationsOfRightModule, IsHomalgRelationsOfRightModule ],
        
  function( R1, R2 )
    local pb, r1, r2, im;
    
    r1 := HomalgMap( MatrixOfRelations( R1 ), "r" );
    r2 := HomalgMap( MatrixOfRelations( R2 ), "free", Range( r1 ) );
    
    pb := PullbackPairOfMaps( AsChainMapForPullback( r1, r2 ) )[1];
    
    im := PreCompose( pb, r1 );
    
    im := HomalgRelationsForRightModule( MatrixOfMap( im ) );
    
    if IsBound( HOMALG.Intersect_uses_ReducedBasisOfModule ) and
       HOMALG.Intersect_uses_ReducedBasisOfModule = true then
        
        return ReducedBasisOfModule( im, "COMPUTE_BASIS" );
    fi;
    
    return im;
    
end );

##
InstallMethod( Intersect2,
        "for homalg relations",
        [ IsHomalgRelationsOfLeftModule, IsHomalgRelationsOfLeftModule ],
        
  function( R1, R2 )
    local pb, r1, r2, im;
    
    r1 := HomalgMap( MatrixOfRelations( R1 ) );
    r2 := HomalgMap( MatrixOfRelations( R2 ), "free", Range( r1 ) );
    
    pb := PullbackPairOfMaps( AsChainMapForPullback( r1, r2 ) )[1];
    
    im := PreCompose( pb, r1 );
    
    im := HomalgRelationsForLeftModule( MatrixOfMap( im ) );
    
    if IsBound( HOMALG.Intersect_uses_ReducedBasisOfModule ) and
       HOMALG.Intersect_uses_ReducedBasisOfModule = true then
        
        return ReducedBasisOfModule( im, "COMPUTE_BASIS" );
    fi;
    
    return im;
    
end );

##
InstallMethod( Intersect2,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep, IsFinitelyPresentedSubmoduleRep ],
        
  function( K, J )
    local M, mapK, mapJ, int;
    
    M := SuperObject( J );
    
    if not IsIdenticalObj( M, SuperObject( K ) ) then
        Error( "the super objects must coincide\n" );
    fi;
    
    mapK := MatrixOfSubobjectGenerators( K );
    mapJ := MatrixOfSubobjectGenerators( J );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( J ) then
        mapK := HomalgRelationsForLeftModule( mapK );
        mapJ := HomalgRelationsForLeftModule( mapJ );
    else
        mapK := HomalgRelationsForRightModule( mapK );
        mapJ := HomalgRelationsForRightModule( mapJ );
    fi;
    
    int := Intersect2( mapK, mapJ );
    int := MatrixOfRelations( int );
    
    return Subobject( int, M );
    
end );

##
InstallMethod( Annihilator,
        "for homalg relations",
        [ IsHomalgMatrix, IsHomalgRelations ],
        
  function( mat, rel )
    local syz, graded;
    
    if IsHomalgRelationsOfLeftModule( rel ) then
        syz := List( [ 1 .. NrRows( mat ) ], i -> CertainRows( mat, [ i ] ) );
    else
        syz := List( [ 1 .. NrColumns( mat ) ], j -> CertainColumns( mat, [ j ] ) );
    fi;
    
    syz := List( syz, r -> ReducedSyzygiesGenerators( r, rel ) );
    
    syz := Iterated( syz, Intersect2 );
    
    syz := MatrixOfRelations( syz );
    
    graded := IsList( DegreesOfGenerators( rel ) );
    
    if IsHomalgRelationsOfLeftModule( rel ) then
        if graded then
            return GradedLeftSubmodule( syz );
        else
            return LeftSubmodule( syz );
        fi;
    else
        if graded then
            return GradedRightSubmodule( syz );
        else
            return RightSubmodule( syz );
        fi;
    fi;
    
end );

##
InstallMethod( Annihilator,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local mat, rel;
    
    mat := HomalgIdentityMatrix( NrGenerators( M ), HomalgRing( M ) );
    rel := RelationsOfModule( M );
    
    return Annihilator( mat, rel );
    
end );

##  <#GAPDoc Label="SubmoduleOfIdealMultiples">
##  <ManSection>
##    <Oper Arg="J, M" Name="\*" Label="constructor for ideal multiples"/>
##    <Returns>a &homalg; submodule</Returns>
##    <Description>
##      Compute the submodule <A>J</A><A>M</A> (resp. <A>M</A><A>J</A>) of the given left (resp. right)
##      <M>R</M>-module <A>M</A>, where <A>J</A> is a left (resp. right) ideal in <M>R</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallOtherMethod( \*,
        "for homalg modules",
        [ IsFinitelyPresentedSubmoduleRep, IsFinitelyPresentedModuleRep ],
        
  function( J, M )
    local R, n, r_list, scalar;
    
    R := HomalgRing( M );
    
    n := NrGenerators( M );
    
    r_list := EntriesOfHomalgMatrix( MatrixOfGenerators( J ) );
    
    scalar := List( r_list, r -> HomalgScalarMatrix( r, n, R ) );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        scalar := Iterated( scalar, UnionOfRows );
    else
        scalar := Iterated( scalar, UnionOfColumns );
    fi;
    
    scalar := HomalgMap( scalar, "free", M );
    
    return ImageSubobject( scalar );
    
end );

##  <#GAPDoc Label="SubmoduleQuotient">
##  <ManSection>
##    <Oper Arg="K, J" Name="SubmoduleQuotient" Label="for submodules"/>
##    <Returns>a &homalg; ideal</Returns>
##    <Description>
##      Compute the submodule quotient ideal <M><A>K</A>:<A>J</A></M> of the submodules <A>K</A> and <A>J</A>
##      of a common <M>R</M>-module <M>M</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallOtherMethod( SubmoduleQuotient,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep, IsFinitelyPresentedSubmoduleRep ],
        
  function( K, J )
    local M, R, degrees, graded, M_K, gen_iso_K, coker_epi_K, mapJ;
    
    M := SuperObject( J );
    
    if not IsIdenticalObj( M, SuperObject( K ) ) then
        Error( "the super objects must coincide\n" );
    fi;
    
    R := HomalgRing( M );
    
    degrees := DegreesOfGenerators( M );
    
    graded := IsList( degrees ) and degrees <> [ ];
    
    M_K := M / K;
    
    ## the generalized isomorphism M/K -> M
    gen_iso_K := NaturalGeneralizedEmbedding( M_K );
    
    Assert( 1, IsGeneralizedIsomorphism( gen_iso_K ) );
    
    ## the natural epimorphism M -> M/K
    coker_epi_K := gen_iso_K ^ -1;
    
    Assert( 1, IsEpimorphism( coker_epi_K ) );
    
    mapJ := PreCompose( MapHavingSubobjectAsItsImage( J ), coker_epi_K );
    
    mapJ := MatrixOfMap( mapJ );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        if graded then
            R := ( 1 * R )^0;
        else
            R := 1 * R;
        fi;
        
        mapJ := List( [ 1 .. NrRows( mapJ ) ], i -> CertainRows( mapJ, [ i ] ) );
    else
        if graded then
            R := ( R * 1 )^0;
        else
            R := R * 1;
        fi;
        
        mapJ := List( [ 1 .. NrColumns( mapJ ) ], i -> CertainColumns( mapJ, [ i ] ) );
    fi;
    
    mapJ := List( mapJ, g -> HomalgMap( g, R, M_K ) );
    
    if IsBound( HOMALG.SubQuotient_uses_Intersect ) and
       HOMALG.SubQuotient_uses_Intersect = true then
        
        mapJ := List( mapJ, KernelSubobject );
        
        return Intersect( mapJ );
    fi;
    
    mapJ := Iterated( mapJ, ProductMorphism );
    
    return KernelSubobject( mapJ );
    
end );

##
InstallMethod( Saturate,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep ],
        
  function( K )
    local degrees, max;
    
    degrees := DegreesOfGenerators( K );
    
    if not ( IsList( degrees ) and degrees <> [ ] ) then
        TryNextMethod( );
    elif not ( HasConstructedAsAnIdeal( K ) and ConstructedAsAnIdeal( K ) ) then
        TryNextMethod( );
    fi;
    
    max := Indeterminates( HomalgRing( K ) );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( K ) then
        max := GradedLeftSubmodule( max );
    else
        max := GradedRightSubmodule( max );
    fi;
    
    return Saturate( K, max );
    
end );

