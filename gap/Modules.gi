#############################################################################
##
##  Modules.gi                  Modules package              Mohamed Barakat
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
        if not HasRankOfObject( arg[1] ) and HasIsInjectivePresentation( M ) and IsInjectivePresentation( M ) then
            SetRankOfObject( arg[1], NrGenerators( M ) - NrRelations( M ) );
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
    if HasRankOfObject( M ) and RankOfObject( M ) = 0 then
        SetRankOfObject( SF, 0 );
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
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local rel, R, q;
    
    rel := RelationsOfModule( M );
    
    R := HomalgRing( rel );
    
    if IsBound( rel!.MaximumNumberOfResolutionSteps )
       and IsInt( rel!.MaximumNumberOfResolutionSteps ) then
        q := rel!.MaximumNumberOfResolutionSteps;
    elif IsBound( R!.MaximumNumberOfResolutionSteps )
      and IsInt( R!.MaximumNumberOfResolutionSteps ) then
        q := R!.MaximumNumberOfResolutionSteps;
    elif IsBound( HOMALG_MODULES.MaximumNumberOfResolutionSteps )
      and IsInt( HOMALG_MODULES.MaximumNumberOfResolutionSteps ) then
        q := HOMALG_MODULES.MaximumNumberOfResolutionSteps;
    elif IsBound( HOMALG.MaximumNumberOfResolutionSteps )
      and IsInt( HOMALG.MaximumNumberOfResolutionSteps ) then
        q := HOMALG.MaximumNumberOfResolutionSteps;
    else
        q := infinity;
    fi;
    
    return q;
    
end );

## ( cf. [BR08, Subsection 3.2.1] )
InstallMethod( CurrentResolution,		### defines: Resolution (ResolutionOfModule/ResolveModule)
        "for homalg relations",
        [ IsInt, IsFinitelyPresentedModuleRep ],
        
  function( _q, M )
    local q, rel, d, degrees, j, d_j, epi, F_j, S, R, left, i;
    
    ## all options of Maple's homalg are now obsolete:
    ## "SIMPLIFY", "GEOMETRIC", "TARGETRELATIONS", "TRUNCATE", "LOWERBOUND"
    
    R := HomalgRing( M );
    
    if _q < 0 then
        q := BoundForResolution( M );
    elif _q = 0 then
        q := 1;		## this is the minimum
    else
        q := _q;
    fi;
    
    if HasCurrentResolution( M ) then
        d := CurrentResolution( M );
        degrees := ObjectDegreesOfComplex( d );
        j := Length( degrees );
        j := degrees[j];
        d_j := CertainMorphism( d, j );
    else
        rel := RelationsOfModule( M );
        ## "COMPUTE_BASIS" saves computations
        d_j := ReducedBasisOfModule( rel, "COMPUTE_BASIS" );
        j := 1;
        d_j := HomalgMap( d_j );
        d := HomalgComplex( d_j );
        
        if not HasCokernelEpi( d_j ) then
            ## the zero'th component of the quasi-isomorphism,
            ## which in this case is simplfy the natural epimorphism onto the module
            epi := HomalgIdentityMap( Range( d_j ), M );
            SetIsEpimorphism( epi, true );
            SetCokernelEpi( d_j, epi );
        fi;
        
        SetCurrentResolution( M, d );
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
        
        d_j := HomalgMap( S, "free", F_j );
        
        Add( d, d_j );
        
        F_j := Source( d_j );
        
    od;
    
    R := HomalgRing( M );
    
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
        Assert( 3, IsRightAcyclic( d ) );
        
        SetIsRightAcyclic( d, true );
        
    else
        
        ## check assertion
        Assert( 3, IsAcyclic( d ) );
        
        SetIsAcyclic( d, true );
    fi;
    
    return d;
    
end );

##
InstallMethod( BoundForResolution,
        "for homalg modules",
        [ IsHomalgModule ],
        
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
        [ IsInt, IsHomalgModule ],
        
  function( _q, M )
    local q, d, rank;
    
    if _q < 0 then
        M!.MaximumNumberOfResolutionSteps := BoundForResolution( M );
        q := _q;
    elif _q = 0 then
        q := 1;		## this is the minimum
    else
        q := _q;
    fi;
    
    d := CurrentResolution( q, M );
    
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
        SetRankOfObject( M, rank );
        if HasTorsionFreeFactorEpi( M ) then
            SetRankOfObject( Range( TorsionFreeFactorEpi( M ) ), rank );
        fi;
    fi;
    
    return d;
    
end );

##
InstallMethod( SyzygiesObjectEpi,
        "for homalg modules",
        [ IsInt, IsHomalgModule ],
        
  function( q, M )
    local d, mu, epi, mat;
    
    if q < 0 then
        Error( "a negative integer does not make sense\n" );
    elif q = 0 then
        return CokernelEpi( FirstMorphismOfResolution( M ) );
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
InstallMethod( AnyParametrization,
        "for homalg relations",
        [ IsHomalgRelations ],
        
  function( rel )
    local mat;
    
    mat := MatrixOfRelations( rel );
    
    if IsHomalgRelationsOfLeftModule( rel ) then
        return SyzygiesOfColumns( mat );
    else
        return SyzygiesOfRows( mat );
    fi;
    
end );

##
InstallMethod( AnyParametrization,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local rel, par;
    
    rel := RelationsOfModule( M );
    
    par := AnyParametrization( rel );
    
    par := HomalgMap( par, M, "free" );
    
    SetPropertiesIfKernelIsTorsionObject( par );
    
    return par;
    
end );

##
InstallMethod( MinimalParametrization,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local rel, par, pr;
    
    if not HasRankOfObject( M ) then
        ## automatically sets the rank if it succeeds
        ## to compute a complete free resolution:
        Resolution( M );
        
        ## Resolution didn't succeed to set the rank
        if not HasRankOfObject( M ) then
            Error( "Unable to figure out the rank\n" );
        fi;
        
    fi;
    
    rel := RelationsOfModule( M );
    
    par := AnyParametrization( rel );
    
    if IsHomalgRelationsOfLeftModule( rel ) then
        pr := CertainColumns;
    else
        pr := CertainRows;
    fi;
    
    ## a minimal parametrization due to Alban:
    ## project the parametrization onto a free factor of rank = Rank( M )
    par := pr( par, [ 1 .. RankOfObject( M ) ] );
    
    par := HomalgMap( par, M, "free" );
    
    SetPropertiesIfKernelIsTorsionObject( par );
    
    return par;
    
end );

##
InstallMethod( Parametrization,
        "for homalg modules",
        [ IsHomalgModule ],
        
  function( M )
    
    if not HasRankOfObject( M ) then
        ## automatically sets the rank if it succeeds
        ## to compute a complete free resolution:
        Resolution( M );
    fi;
    
    if HasRankOfObject( M ) then
        return MinimalParametrization( M );
    fi;
    
    ## Resolution didn't succeed to set the rank
    return AnyParametrization( M );
    
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
    
    pos := PairOfPositionsOfTheDefaultPresentations( iso );
    
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
    
    pb := PullbackPairOfMorphisms( AsChainMorphismForPullback( r1, r2 ) )[1];
    
    im := PreCompose( pb, r1 );
    
    im := HomalgRelationsForRightModule( MatrixOfMap( im ) );
    
    if IsBound( HOMALG_MODULES.Intersect_uses_ReducedBasisOfModule ) and
       HOMALG_MODULES.Intersect_uses_ReducedBasisOfModule = true then
        
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
    
    pb := PullbackPairOfMorphisms( AsChainMorphismForPullback( r1, r2 ) )[1];
    
    im := PreCompose( pb, r1 );
    
    im := HomalgRelationsForLeftModule( MatrixOfMap( im ) );
    
    if IsBound( HOMALG_MODULES.Intersect_uses_ReducedBasisOfModule ) and
       HOMALG_MODULES.Intersect_uses_ReducedBasisOfModule = true then
        
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
    local syz;
    
    if IsHomalgRelationsOfLeftModule( rel ) then
        syz := List( [ 1 .. NrRows( mat ) ], i -> CertainRows( mat, [ i ] ) );
    else
        syz := List( [ 1 .. NrColumns( mat ) ], j -> CertainColumns( mat, [ j ] ) );
    fi;
    
    syz := List( syz, r -> ReducedSyzygiesGenerators( r, rel ) );
    
    syz := Iterated( syz, Intersect2 );
    
    syz := MatrixOfRelations( syz );
    
    if IsHomalgRelationsOfLeftModule( rel ) then
        return LeftSubmodule( syz );
    else
        return RightSubmodule( syz );
    fi;
    
end );

##
InstallMethod( AnnihilatorsOfGenerators,
        "for homalg modules",
        [ IsHomalgModule ],
        
  function( M )
    
    return List( GeneratingElements( M ), Annihilator );
    
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

##  <#GAPDoc Label="SubobjectQuotient">
##  <ManSection>
##    <Oper Arg="K, J" Name="SubobjectQuotient" Label="for submodules"/>
##    <Returns>a &homalg; ideal</Returns>
##    <Description>
##      Compute the submodule quotient ideal <M><A>K</A>:<A>J</A></M> of the submodules <A>K</A> and <A>J</A>
##      of a common <M>R</M>-module <M>M</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallOtherMethod( SubobjectQuotient,
        "for homalg submodules",
        [ IsStaticFinitelyPresentedSubobjectRep, IsStaticFinitelyPresentedSubobjectRep ],
        
  function( K, J )
    local M, R, MmodK, gen_iso_K, coker_epi_K, mapJ, ker;
    
    M := SuperObject( J );
    
    if not IsIdenticalObj( M, SuperObject( K ) ) then
        Error( "the super objects must coincide\n" );
    fi;
    
    R := HomalgRing( M );
    
    MmodK := M / K;
    
    ## the generalized isomorphism M/K -> M
    gen_iso_K := NaturalGeneralizedEmbedding( MmodK );
    
    Assert( 1, IsGeneralizedIsomorphism( gen_iso_K ) );
    
    ## the natural epimorphism M -> M/K
    coker_epi_K := gen_iso_K ^ -1;
    
    Assert( 1, IsEpimorphism( coker_epi_K ) );
    
    mapJ := PreCompose( MorphismHavingSubobjectAsItsImage( J ), coker_epi_K );
    
    mapJ := MatrixOfMap( mapJ );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        R := 1 * R;
        mapJ := List( [ 1 .. NrRows( mapJ ) ], i -> CertainRows( mapJ, [ i ] ) );
    else
        R := R * 1;
        mapJ := List( [ 1 .. NrColumns( mapJ ) ], i -> CertainColumns( mapJ, [ i ] ) );
    fi;
    
    mapJ := List( mapJ, g -> HomalgMap( g, R, MmodK ) );
    
    if IsBound( HOMALG.SubobjectQuotient_uses_Intersect ) and
       HOMALG.SubobjectQuotient_uses_Intersect = true then
        
        ker := List( mapJ, KernelSubobject );
        
        return Intersect( ker );
    fi;
    
    mapJ := Iterated( mapJ, ProductMorphism );
    
    return KernelSubobject( mapJ );
    
end );

##
InstallMethod( Eliminate,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep and ConstructedAsAnIdeal, IsList ],
        
  function( N, indets )
    local gen;
    
    gen := MatrixOfGenerators( N );
    
    gen := EntriesOfHomalgMatrix( gen );
    
    gen := Eliminate( gen, indets );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( N ) then
        return LeftSubmodule( gen );
    else
        return RightSubmodule( gen );
    fi;
    
end );

##
InstallMethod( Eliminate,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep and ConstructedAsAnIdeal, IsHomalgRingElement ],
        
  function( N, v )
    
    return Eliminate( N, [ v ] );
    
end );

##
InstallMethod( CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries,
        "for a homalg module and two lists",
        [ IsFinitelyPresentedModuleRep, IsList, IsList ],
        
  function( M, weights, degrees )
    
    return CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( MatrixOfRelations( M ), weights, degrees );
    
end );

##
InstallMethod( CoefficientsOfNumeratorOfHilbertPoincareSeries,
        "for a homalg module and two lists",
        [ IsFinitelyPresentedModuleRep, IsList, IsList ],
        
  function( M, weights, degrees )
    
    return CoefficientsOfNumeratorOfHilbertPoincareSeries( MatrixOfRelations( M ), weights, degrees );
    
end );

##
InstallMethod( UnreducedNumeratorOfHilbertPoincareSeries,
        "for a homalg module, two lists, and a ring element",
        [ IsFinitelyPresentedModuleRep, IsList, IsList, IsRingElement ],
        
  function( M, weights, degrees, lambda )
    
    return UnreducedNumeratorOfHilbertPoincareSeries( MatrixOfRelations( M ), weights, degrees, lambda );
    
end );

##
InstallMethod( UnreducedNumeratorOfHilbertPoincareSeries,
        "for a homalg module, two lists, and a string",
        [ IsFinitelyPresentedModuleRep, IsList, IsList, IsString ],
        
  function( M, weights, degrees, lambda )
    
    return UnreducedNumeratorOfHilbertPoincareSeries( M, weights, degrees, Indeterminate( Rationals, lambda ) );
    
end );

##
InstallMethod( UnreducedNumeratorOfHilbertPoincareSeries,
        "for a homalg module and two lists",
        [ IsFinitelyPresentedModuleRep, IsList, IsList ],
        
  function( M, weights, degrees )
    
    return UnreducedNumeratorOfHilbertPoincareSeries( M, weights, degrees, HOMALG_MODULES.variable_for_Hilbert_polynomial );
    
end );

##
InstallMethod( NumeratorOfHilbertPoincareSeries,
        "for a homalg module, two lists, and a ring element",
        [ IsFinitelyPresentedModuleRep, IsList, IsList, IsRingElement ],
        
  function( M, weights, degrees, lambda )
    
    return NumeratorOfHilbertPoincareSeries( MatrixOfRelations( M ), weights, degrees, lambda );
    
end );

##
InstallMethod( NumeratorOfHilbertPoincareSeries,
        "for a homalg module, two lists, and a string",
        [ IsFinitelyPresentedModuleRep, IsList, IsList, IsString ],
        
  function( M, weights, degrees, lambda )
    
    return NumeratorOfHilbertPoincareSeries( M, weights, degrees, Indeterminate( Rationals, lambda ) );
    
end );

##
InstallMethod( NumeratorOfHilbertPoincareSeries,
        "for a homalg module and two lists",
        [ IsFinitelyPresentedModuleRep, IsList, IsList ],
        
  function( M, weights, degrees )
    
    return NumeratorOfHilbertPoincareSeries( M, weights, degrees, HOMALG_MODULES.variable_for_Hilbert_polynomial );
    
end );

##
InstallMethod( HilbertPoincareSeries,
        "for a homalg module, two lists, and a ring element",
        [ IsFinitelyPresentedModuleRep, IsList, IsList, IsRingElement ],
        
  function( M, weights, degrees, lambda )
    local mat;
    
    if IsZero( M ) then
        return 0 * lambda;
    fi;
    
    mat := MatrixOfRelations( M );
    
    if IsHomalgRightObjectOrMorphismOfRightObjects( M ) then
        mat := Involution( mat );
    fi;
    
    return HilbertPoincareSeries( mat, weights, degrees, lambda );
    
end );

##
InstallMethod( HilbertPoincareSeries,
        "for a homalg module, two lists, and a string",
        [ IsHomalgModule, IsList, IsList, IsString ],
        
  function( M, weights, degrees, lambda )
    
    return HilbertPoincareSeries( M, weights, degrees, Indeterminate( Rationals, lambda ) );
    
end );

##
InstallMethod( HilbertPoincareSeries,
        "for a homalg module and two lists",
        [ IsHomalgModule, IsList, IsList ],
        
  function( M, weights, degrees )
    
    return HilbertPoincareSeries( M, weights, degrees, HOMALG_MODULES.variable_for_Hilbert_polynomial );
    
end );

##
InstallMethod( HilbertPoincareSeries,
        "for a homalg module and a ring element",
        [ IsFinitelyPresentedModuleRep, IsRingElement ],
        
  function( M, lambda )
    local mat;
    
    if IsZero( M ) then
        return 0 * lambda;
    fi;
    
    mat := MatrixOfRelations( M );
    
    if IsHomalgRightObjectOrMorphismOfRightObjects( M ) then
        mat := Involution( mat );
    fi;
    
    return HilbertPoincareSeries( mat, lambda );
    
end );

##
InstallMethod( HilbertPoincareSeries,
        "for a homalg module and a string",
        [ IsHomalgModule, IsString ],
        
  function( M, lambda )
    
    return HilbertPoincareSeries( M, Indeterminate( Rationals, lambda ) );
    
end );

##
InstallMethod( HilbertPoincareSeries,
        "for a homalg module",
        [ IsHomalgModule ],
        
  function( M )
    
    return HilbertPoincareSeries( M, HOMALG_MODULES.variable_for_Hilbert_polynomial );
    
end );

##
InstallMethod( HilbertPolynomial,
        "for a homalg module, two lists, and a ring element",
        [ IsFinitelyPresentedModuleRep, IsList, IsList, IsRingElement ],
        
  function( M, weights, degrees, lambda )
    local mat;
    
    if IsZero( M ) then
        return 0 * lambda;
    fi;
    
    mat := MatrixOfRelations( M );
    
    if IsHomalgRightObjectOrMorphismOfRightObjects( M ) then
        mat := Involution( mat );
    fi;
    
    return HilbertPolynomial( mat, weights, degrees, lambda );
    
end );

##
InstallMethod( HilbertPolynomial,
        "for a homalg module, two lists, and a string",
        [ IsHomalgModule, IsList, IsList, IsString ],
        
  function( M, weights, degrees, lambda )
    
    return HilbertPolynomial( M, weights, degrees, Indeterminate( Rationals, lambda ) );
    
end );

##
InstallMethod( HilbertPolynomial,
        "for a homalg module and two lists",
        [ IsHomalgModule, IsList, IsList ],
        
  function( M, weights, degrees )
    
    return HilbertPolynomial( M, weights, degrees, HOMALG_MODULES.variable_for_Hilbert_polynomial );
    
end );

##
InstallMethod( HilbertPolynomial,
        "for a homalg module and a ring element",
        [ IsFinitelyPresentedModuleRep, IsRingElement ],
        
  function( M, lambda )
    local mat;
    
    if IsZero( M ) then
        return 0 * lambda;
    fi;
    
    mat := MatrixOfRelations( M );
    
    if IsHomalgRightObjectOrMorphismOfRightObjects( M ) then
        mat := Involution( mat );
    fi;
    
    return HilbertPolynomial( mat, lambda );
    
end );

##
InstallMethod( HilbertPolynomial,
        "for a homalg module and a string",
        [ IsHomalgModule, IsString ],
        
  function( M, lambda )
    
    return HilbertPolynomial( M, Indeterminate( Rationals, lambda ) );
    
end );

##
InstallMethod( HilbertPolynomial,
        "for a homalg module",
        [ IsHomalgModule ],
        
  function( M )
    
    return HilbertPolynomial( M, HOMALG_MODULES.variable_for_Hilbert_polynomial );
    
end );

##
InstallMethod( AffineDimension,
        "for a homalg module and two lists",
        [ IsFinitelyPresentedModuleRep, IsList, IsList ],
        
  function( M, weights, degrees )
    local R, mat;
    
    R := HomalgRing( M );
    
    ## we may use AffineDimension to decide IsZero( M )
    if ( HasIsZero( M ) and IsZero( M ) ) or NrGenerators( M ) = 0 then
        return HOMALG_MODULES.DimensionOfZeroModules;;
    elif NrRelations( M ) = 0 and HasKrullDimension( R ) then
        return KrullDimension( R );
    fi;
    
    mat := MatrixOfRelations( M );
    
    if IsHomalgRightObjectOrMorphismOfRightObjects( M ) then
        mat := Involution( mat );
    fi;
    
    return AffineDimension( mat, weights, degrees );
    
end );

##
InstallMethod( AffineDimension,
        "for a homalg module",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local R, mat;
    
    R := HomalgRing( M );
    
    ## we may use AffineDimension to decide IsZero( M )
    if ( HasIsZero( M ) and IsZero( M ) ) or NrGenerators( M ) = 0 then
        return HOMALG_MODULES.DimensionOfZeroModules;;
    elif NrRelations( M ) = 0 and HasKrullDimension( R ) then
        return KrullDimension( R );
    fi;
    
    mat := MatrixOfRelations( M );
    
    if IsHomalgRightObjectOrMorphismOfRightObjects( M ) then
        mat := Involution( mat );
    fi;
    
    return AffineDimension( mat );
    
end );

##
InstallMethod( AffineDegree,
        "for a homalg module and two lists",
        [ IsFinitelyPresentedModuleRep, IsList, IsList ],
        
  function( M, weights, degrees )
    local mat;
    
    if IsZero( M ) then
        return 0;
    elif NrRelations( M ) = 0 then
        return Rank( M );
    fi;
    
    mat := MatrixOfRelations( M );
    
    if IsHomalgRightObjectOrMorphismOfRightObjects( M ) then
        mat := Involution( mat );
    fi;
    
    return AffineDegree( mat, weights, degrees );
    
end );

##
InstallMethod( AffineDegree,
        "for a homalg module",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local mat;
    
    if IsZero( M ) then
        return 0;
    elif NrRelations( M ) = 0 then
        return Rank( M );
    fi;
    
    mat := MatrixOfRelations( M );
    
    if IsHomalgRightObjectOrMorphismOfRightObjects( M ) then
        mat := Involution( mat );
    fi;
    
    return AffineDegree( mat );
    
end );

##
InstallMethod( ConstantTermOfHilbertPolynomial,
        "for a homalg module and two lists",
        [ IsFinitelyPresentedModuleRep, IsList, IsList ],
        
  function( M, weights, degrees )
    local mat;
    
    if IsZero( M ) then
        return 0;
    fi;
    
    mat := MatrixOfRelations( M );
    
    if IsHomalgRightObjectOrMorphismOfRightObjects( M ) then
        mat := Involution( mat );
    fi;
    
    return ConstantTermOfHilbertPolynomial( mat, weights, degrees );
    
end );

##
InstallMethod( ConstantTermOfHilbertPolynomial,
        "for a homalg module",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local mat;
    
    if IsZero( M ) then
        return 0;
    elif NrRelations( M ) = 0 then
        return Rank( M );
    fi;
    
    mat := MatrixOfRelations( M );
    
    if IsHomalgRightObjectOrMorphismOfRightObjects( M ) then
        mat := Involution( mat );
    fi;
    
    return ConstantTermOfHilbertPolynomial( mat );
    
end );

##
InstallMethod( PrimaryDecomposition,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local tr, subobject, mat, primary_decomposition;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        tr := a -> a;
        subobject := LeftSubmodule;
    else
        tr := Involution;
        subobject := RightSubmodule;
    fi;
    
    mat := MatrixOfRelations( M );
    
    primary_decomposition := PrimaryDecompositionOp( tr( mat ) );
    
    primary_decomposition :=
      List( primary_decomposition,
            function( pp )
              local primary, prime;
              
              primary := subobject( tr( pp[1] ) );
              prime := subobject( tr( pp[2] ) );
              
              return [ primary, prime ];
              
            end
          );
    
    return primary_decomposition;
    
end );

##
InstallMethod( FittingIdeal,
        "for homalg modules",
        [ IsInt, IsFinitelyPresentedModuleRep ],
        
  function( i, M )
    local R, mor, n, Fitt, left, m, mat, Fitt_i;
    
    R := HomalgRing( M );
    
    if not HasIsCommutative( R ) then
        Error( "the ring is not known to be commutative\n" );
    elif not IsCommutative( R ) then
        Error( "the ring is not commutative\n" );
    fi;
    
    mor := PresentationMorphism( M );
    
    n := NrGenerators( M );
    
    if not IsBound( mor!.FittingIdeals ) then
        mor!.FittingIdeals := rec( );
    fi;
    
    Fitt := mor!.FittingIdeals;
    
    if IsBound( Fitt.(String( n - i )) ) then
        return Fitt.(String( n - i ));
    fi;
    
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( M );
    
    mor := PresentationMorphism( M );
    
    ## better than NrRelations( M )
    m := NrGenerators( Source( mor ) );
    
    if i >= n then	## <=> n - i <= 0
        if left then
            Fitt_i := LeftSubmodule( R );
        else
            Fitt_i := RightSubmodule( R );
        fi;
    elif i < Maximum( n - m, 0 ) then	## <=> n - i > Minimum( n, m )
        if left then
            Fitt_i := ZeroLeftSubmodule( R );
        else
            Fitt_i := ZeroRightSubmodule( R );
        fi;
    else
        mat := MatrixOfMap( mor );
        if left then
            Fitt_i := LeftIdealOfMinors( n - i, mat );
        else
            Fitt_i := RightIdealOfMinors( n - i, mat );
        fi;
    fi;
    
    Fitt.(String( n - i )) := Fitt_i;
    
    return Fitt_i;
    
end );

##
InstallMethod( NumberOfFirstNonZeroFittingIdeal,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local R, i;
    
    if IsZero( M ) then
        return 0;
    fi;
    
    for i in [ 0 .. NrGenerators( M ) - 1 ] do
        
        if not IsZero( FittingIdeal( i, M ) ) then
            
            SetRankOfObject( M, i );
            
            return i;
            
        fi;
        
    od;
    
    SetRankOfObject( M, NrGenerators( M ) );
    
    return NrGenerators( M );
    
end );
