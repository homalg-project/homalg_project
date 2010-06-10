#############################################################################
##
##  Modules.gi                  homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
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
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep, IsFinitelyPresentedSubmoduleRep ],
        
  function( K, J )
    local M, mapK, mapJ, phi, im, iso, def, emb;
    
    M := SuperObject( J );
    
    if not IsIdenticalObj( M, SuperObject( K ) ) then
        Error( "the super objects must coincide\n" );
    fi;
    
    mapK := MapHavingSubobjectAsItsImage( K );
    mapJ := MapHavingSubobjectAsItsImage( J );
    
    phi := PreCompose( mapK, CokernelEpi( mapJ ) );
    
    im := ImageObject( phi );
    
    ## recall that im was created as a submodule of
    ## Cokernel( mapJ ) which in turn is a factor module of M,
    ## but since we need to view im as a subfactor of M
    ## we will construct an isomorphism iso onto im
    iso := AnIsomorphism( im );
    
    ## and call its source def (for defect)
    def := Source( iso );
    
    ## then: the following compositions give the
    ## desired generalized embedding of def into M
    emb := PreCompose( iso, NaturalGeneralizedEmbedding( im ) );
    
    emb := PreCompose( emb, CokernelNaturalGeneralizedIsomorphism( mapJ ) );
    
    ## check assertion
    Assert( 4, IsGeneralizedMonomorphism( emb ) );
    
    SetIsGeneralizedMonomorphism( emb, true );
    
    def!.NaturalGeneralizedEmbedding := emb;
    
    return def;
    
end );

##
InstallMethod( \/,
        "for homalg submodules",
        [ IsFinitelyPresentedModuleRep, IsFinitelyPresentedSubmoduleRep ],
        
  function( M, N )	## M must be either the super object of N or 1 * R or R * 1
    local R;
    
    R := HomalgRing( M );
    
    if not IsIdenticalObj( HomalgRing( N ), R ) then
        Error( "the ring of the module and the ring of the submodule are not identical\n" );
    fi;
    
    if not ( IsIdenticalObj( M, SuperObject( N ) ) or IsIdenticalObj( M, 1 * R ) or IsIdenticalObj( M, R * 1 ) ) then
        TryNextMethod( );
    fi;
    
    return FactorObject( N );
    
end );

##
InstallMethod( \/,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep, IsFinitelyPresentedModuleRep and HasUnderlyingSubobject ],
        
  function( M, N )	## M must be either the super object of N or 1 * R or R * 1
    
    return M / UnderlyingSubobject( N );
    
end );

##
InstallMethod( \/,
        "for homalg submodules",
        [ IsHomalgRing, IsFinitelyPresentedSubmoduleRep and ConstructedAsAnIdeal ],
        
  function( R, J )
    
    if not IsIdenticalObj( HomalgRing( J ), R ) then
        Error( "the given ring and the ring of the submodule are not identical\n" );
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

InstallMethod( Resolution,
        "for homalg relations",
        [ IsHomalgRelations ],
        
  function( M )
    
    return Resolution( -1, M );
    
end );

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
InstallMethod( Resolution,
        "for homalg submodules",
        [ IsInt, IsFinitelyPresentedSubmoduleRep ],
        
  function( q, N )
    
    return Resolution( q, UnderlyingObject( N ) );
    
end );

##
InstallMethod( Resolution,
        "for homalg modules",
        [ IsFinitelyPresentedModuleOrSubmoduleRep ],
        
  function( M )
    
    return Resolution( -1, M );
    
end );

##
InstallMethod( LengthOfResolution,
        "for homalg modules",
        [ IsFinitelyPresentedModuleOrSubmoduleRep ],
        
  function( M )
    local d;
    
    d := Resolution( M );
    
    if IsBound(d!.LengthOfResolution) then
        return d!.LengthOfResolution;
    else
        return fail;
    fi;
    
end );

##
InstallMethod( PresentationMap,
        "for homalg modules",
        [ IsFinitelyPresentedModuleOrSubmoduleRep ],
        
  function( M )
    local d;
    
    d := Resolution( 1, M );
    
    return CertainMorphism( d, 1 );
    
end );

##
InstallMethod( SyzygiesObjectEmb,
        "for homalg modules",
        [ IsInt, IsFinitelyPresentedModuleRep ],
        
  function( q, M )
    local d;
    
    if q < 0 then
        Error( "a negative integer does not make sense\n" );
    elif q = 0 then
        ## this is not really an embedding, but spares us case distinctions at several places (e.g. Left/RightSatelliteOfFunctor)
        return TheMorphismToZero( M );
    elif q = 1 then
        return KernelEmb( FreeHullEpi( M ) );
    fi;
    
    d := Resolution( q - 1, M );
    
    return KernelEmb( CertainMorphism( d, q - 1 ) );
    
end );

##
InstallMethod( SyzygiesObjectEmb,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return SyzygiesObjectEmb( 1, M );
    
end );

##
InstallMethod( SyzygiesObject,
        "for homalg modules",
        [ IsInt, IsFinitelyPresentedModuleRep ],
        
  function( q, M )
    local d;
    
    if q < 0 then
        return 0 * M;
    elif q = 0 then
        return M;
    fi;
    
    return Source( SyzygiesObjectEmb( q, M ) );
    
end );

##
InstallMethod( SyzygiesObject,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return SyzygiesObject( 1, M );
    
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
InstallMethod( SyzygiesObjectEpi,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return SyzygiesObjectEpi( 1, M );
    
end );

##
InstallMethod( FreeHullEpi,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return SyzygiesObjectEpi( 0, M );
    
end );

InstallMethod( FreeHullEpi,
        "for homalg modules",
        [ IsFinitelyPresentedSubmoduleRep ],
        
  function( M )
    
    return FreeHullEpi( UnderlyingObject( M ) );
    
end );

##
InstallMethod( FreeHullModule,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return Source( FreeHullEpi( M ) );
    
end );

##
InstallMethod( SubResolution,
        "for homalg modules",
        [ IsInt, IsFinitelyPresentedModuleRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( q, M )
    local d, dq1, res;
    
    if q < 0 then
        Error( "a negative integer does not make sense\n" );
    elif q = 0 then
        dq1 := PresentationMap( M );
        res := AsATwoSequence( dq1, TheMorphismToZero( FreeHullModule( M ) ) );
        if HasIsMonomorphism( dq1 ) and IsMonomorphism( dq1 ) then
            SetIsRightAcyclic( res, true );
        else
            SetIsAcyclic( res, true );
        fi;
        return res;
    fi;
    
    d := Resolution( q + 1, M );
    
    dq1 := CertainMorphism( d, q + 1 );
    
    res := AsATwoSequence( dq1, CertainMorphism( d, q ) );
    
    res := Shift( res, -q );
    
    if HasIsMonomorphism( dq1 ) and IsMonomorphism( dq1 ) then
        SetIsRightAcyclic( res, true );
    else
        SetIsAcyclic( res, true );
    fi;
    
    SetIsATwoSequence( res, true );
    
    return res;
    
end );

##
InstallMethod( SubResolution,
        "for homalg modules",
        [ IsInt, IsFinitelyPresentedModuleRep and IsHomalgRightObjectOrMorphismOfRightObjects ],
        
  function( q, M )
    local d, dq1, res;
    
    if q < 0 then
        Error( "a negative integer does not make sense\n" );
    elif q = 0 then
        dq1 := PresentationMap( M );
        res := AsATwoSequence( TheMorphismToZero( FreeHullModule( M ) ), dq1 );
        if HasIsMonomorphism( dq1 ) and IsMonomorphism( dq1 ) then
            SetIsRightAcyclic( res, true );
        else
            SetIsAcyclic( res, true );
        fi;
        return res;
    fi;
    
    d := Resolution( q + 1, M );
    
    dq1 := CertainMorphism( d, q + 1 );
    
    res := AsATwoSequence( CertainMorphism( d, q ), dq1 );
    
    res := Shift( res, -q );
    
    if HasIsMonomorphism( dq1 ) and IsMonomorphism( dq1 ) then
        SetIsRightAcyclic( res, true );
    else
        SetIsAcyclic( res, true );
    fi;
    
    SetIsATwoSequence( res, true );
    
    return res;
    
end );

#=======================================================================
# Shorten a given resolution q times if possible
#
# I learned it from Alban's thesis
#
# see also Alban and Daniel:
# Constructive Computation of Bases of Free Modules over the Weyl Algebras
#
# (see also [Rotman, Lemma 9.40])
#
#_______________________________________________________________________
InstallMethod( ShortenResolution,
        "for homalg relations",
        [ IsInt, IsComplexOfFinitelyPresentedObjectsRep and IsRightAcyclic ],
        
  function( q, d )
    local max, min, m, mx, n, d_m, F_m, d_m_1, s_m_1, d_m_2, d_short, l, epi;
    
    max := HighestDegree( d );
    min := LowestDegree( d );
    
    m := max - min;
    
    if q = 0 or m < 2 then
        return d;
    fi;
    
    ## initialize
    n := q;
    mx := max;
    
    ## first step
    d_m := CertainMorphism( d, mx );
    d_m_1 := CertainMorphism( d, mx - 1 );
    
    F_m := Source( d_m );
    
    s_m_1 := PostInverse( d_m );
    
    if IsBool( s_m_1 ) then
        return d;
    fi;
    
    SetIsEpimorphism( s_m_1, true );	## only during the first step
    
    d_m := ProductMorphism( d_m_1, s_m_1 );
    SetIsMonomorphism( d_m, true );	## only during the first step
    
    if m > 2 then
        d_m_2 := CertainMorphism( d, mx - 2 );
        d_m_1 := CoproductMorphism( d_m_2, TheZeroMorphism( F_m, Range( d_m_2 ) ) );
    fi;
    
    mx := mx - 1;
    m := m - 1;
    n := n - 1;
    
    ## iterate:
    while n <> 0 and m > 1 do
        
        d_m := CertainMorphism( d, mx );
        d_m_1 := CertainMorphism( d, mx - 1 );
        
        F_m := Source( d_m );
        
        s_m_1 := PostInverse( d_m );
        
        if IsBool( s_m_1 ) then
            break;
        fi;
        
        d_m := ProductMorphism( d_m_1, s_m_1 );
        
        if m > 2 then
            d_m_2 := CertainMorphism( d, mx - 2 );
            d_m_1 := CoproductMorphism( d_m_2, TheZeroMorphism( F_m, Range( d_m_2 ) ) );
        fi;
        
        mx := mx - 1;
        m := m - 1;
        n := n - 1;
    od;
    
    if m > 2 then
        d_short := HomalgComplex( CertainMorphism( d, min + 1 ), min + 1 );
        for l in [ 2 .. m - 2 ] do
            Add( d_short, CertainMorphism( d, min + l ) );
        od;
        Add( d_short, d_m_1 );
        Add( d_short, d_m );
    elif m = 2 then
        d_short := HomalgComplex( d_m_1, min + 1 );
        Add( d_short, d_m );
    else
        epi := PreCompose( EpiOnLeftFactor( Range( d_m ) ), CokernelEpi( d_m_1 ) );
        SetCokernelEpi( d_m, epi );
        d_short := HomalgComplex( d_m, min + 1 );
    fi;
    
    d_short!.LengthOfResolution := m;
    
    SetIsRightAcyclic( d_short, true );
    
    return d_short;
    
end );

##
InstallMethod( ShortenResolution,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedObjectsRep and IsRightAcyclic ],
        
  function( d )
    
    return ShortenResolution( -1, d );
    
end );

##
InstallMethod( ShortenResolution,
        "for homalg modules",
        [ IsInt, IsFinitelyPresentedModuleRep ],
        
  function( q, M )
    local d, l;
    
    d := Resolution( M );
    
    d := ShortenResolution( q, d );
    
    l := Length( MorphismDegreesOfComplex( d ) );
    
    if IsBound(M!.UpperBoundForProjectiveDimension) and
       M!.UpperBoundForProjectiveDimension > l then
        M!.UpperBoundForProjectiveDimension := l;
    fi;
    
    ResetFilterObj( M, AFiniteFreeResolution );
    SetAFiniteFreeResolution( M, d );
    
    RelationsOfModule( M )!.FreeResolution := d;
    
    return d;
    
end );

##
InstallMethod( ShortenResolution,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return ShortenResolution( -1, M );
    
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
InstallMethod( AsEpimorphicImage,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    local M, rel, pos, TI, psi, T;
    
    if not ( HasIsEpimorphism( phi ) and IsEpimorphism( phi ) ) and
       not IsZero( Cokernel( phi ) ) then	## I do not require phi to be a morphism, that's why I don't use IsEpimorphism
        Error( "the first argument must be an epimorphism\n" );
    fi;
    
    M := Range( phi );
    
    rel := RelationsOfModule( M );
    
    ## copying phi is important for the lazy evaluation below
    ## otherwise phi will be part of the transition matrix data
    ## of M, which might be needed to compute phi!
    psi := ShallowCopy( phi );
    
    pos := PairOfPositionsOfTheDefaultSetOfRelations( psi );
    
    TI := MatrixOfMap( psi );
    
    T := HomalgMatrix( HomalgRing( TI ) );
    
    SetNrRows( T, NrColumns( TI ) );
    SetNrColumns( T, NrRows( TI ) );
    
    ## phi^-1 is not necessarily a morphism
    SetEvalMatrixOperation( T, [ a -> MatrixOfMap( a^-1, pos[2], pos[1] ), [ psi ] ] );		## Source( psi ) does not play any role!!!
    
    return AddANewPresentation( M, rel * T, T, TI );
    
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
InstallGlobalFunction( Intersect,
  function( arg )
    local nargs;
    
    nargs := Length( arg );
    
    if nargs = 1 and IsFinitelyPresentedSubmoduleRep( arg[1] ) then
        return arg[1];
    elif nargs = 1 and IsList( arg[1] ) and arg[1] <> [ ] and ForAll( arg[1], IsFinitelyPresentedSubmoduleRep ) then
        return Iterated( arg[1], Intersect2 );
    elif nargs > 1 and ForAll( arg, IsFinitelyPresentedSubmoduleRep ) then
        return Iterated( arg, Intersect2 );
    fi;
    
    Error( "wrong input\n" );
    
end );

##  <#GAPDoc Label="IntersectWithMultiplicity">
##  <ManSection>
##    <Oper Arg="ideals, mults" Name="IntersectWithMultiplicity"/>
##    <Returns>a &homalg; left or right ideal</Returns>
##    <Description>
##      Intersect the ideals in the list <A>ideals</A> after raising them to the corresponding power specified in the list of
##      multiplicities <A>mults</A>.
##      <Example><![CDATA[
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( IntersectWithMultiplicity,
        "for homalg ideals",
        [ IsList, IsList ],
        
  function( ideals, mults )
    local s, left, intersection;
    
    if not ForAll( ideals, p -> IsFinitelyPresentedSubmoduleRep( p ) and HasConstructedAsAnIdeal( p ) and ConstructedAsAnIdeal( p ) ) then
        Error( "the first argument is not a list of ideals\n" );
    fi;
    
    ## the number of ideals
    s := Length( ideals );
    
    if s = 0 then
        Error( "the list of ideals is empty\n" );
    fi;
    
    if s <> Length( mults ) then
        Error( "the length of the list of ideals and the length of the list of their multiplicities must coincide\n" );
    fi;
    
    ## decide if we are dealing with left or right ideals
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( ideals[1] );
    
    if not ForAll( ideals, a -> IsHomalgLeftObjectOrMorphismOfLeftObjects( a ) = left ) then
        Error( "all ideals must be provided either by left or by right ideals\n" );
    fi;
    
    intersection := Iterated( List( [ 1 .. s ], i -> ideals[i]^mults[i] ), Intersect );
    
    intersection!.Genesis := [ IntersectWithMultiplicity, ideals, mults ];
    
    return intersection;
    
end );

##
InstallMethod( \+,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep, IsFinitelyPresentedSubmoduleRep ],
        
  function( K, J )
    local M, mapK, mapJ, sum;
    
    M := SuperObject( J );
    
    if not IsIdenticalObj( M, SuperObject( K ) ) then
        Error( "the super objects must coincide\n" );
    fi;
    
    mapK := MatrixOfSubobjectGenerators( K );
    mapJ := MatrixOfSubobjectGenerators( J );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( J ) then
        sum := UnionOfRows( mapK, mapJ );
    else
        sum := UnionOfColumns( mapK, mapJ );
    fi;
    
    return Subobject( sum, M );
    
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

##
InstallMethod( EmbeddingsInCoproductObject,
        "for homalg modules",
        [ IsHomalgModule, IsList ],
        
  function( coproduct, degrees )
    local l, embeddings, emb_summand, summand, i;
    
    if ( IsBound( coproduct!.EmbeddingsInCoproductObject ) and
         IsBound( coproduct!.EmbeddingsInCoproductObject.degrees ) and
         coproduct!.EmbeddingsInCoproductObject.degrees = degrees ) then
        
        return coproduct!.EmbeddingsInCoproductObject;
        
    fi;
    
    l := Length( degrees );
    
    if l < 2 then
        return fail;
    fi;
    
    embeddings := rec( );
    
    ## contruct the total embeddings of summands into their coproduct
    if l = 2 then
        embeddings.(String(degrees[1])) := MonoOfRightSummand( coproduct );
        embeddings.(String(degrees[2])) := MonoOfLeftSummand( coproduct );
    else
        emb_summand := TheIdentityMorphism( coproduct );
        summand := coproduct;
        embeddings.(String(degrees[1])) := MonoOfRightSummand( summand );
        
        for i in [ 2 .. l - 1 ] do
            emb_summand := PreCompose( MonoOfLeftSummand( summand ), emb_summand );
            summand := Genesis( summand )!.arguments_of_functor[1];
            embeddings.(String(degrees[i])) := PreCompose( MonoOfRightSummand( summand ), emb_summand );
        od;
        
        embeddings.(String(degrees[l])) := PreCompose( MonoOfLeftSummand( summand ), emb_summand );
    fi;
    
    coproduct!.EmbeddingsInCoproductObject := embeddings;
    
    return embeddings;
    
end );

##
InstallMethod( ProjectionsFromProductObject,
        "for homalg modules",
        [ IsHomalgModule, IsList ],
        
  function( product, degrees )
    local l, projections, prj_factor, factor, i;
    
    if ( IsBound( product!.ProjectionsFromProductObject ) and
         IsBound( product!.ProjectionsFromProductObject.degrees ) and
         product!.ProjectionsFromProductObject.degrees = degrees ) then
        
        return product!.ProjectionsFromProductObject;
        
    fi;
    
    l := Length( degrees );
    
    if l < 2 then
        return fail;
    fi;
    
    projections := rec( );
    
    ## contruct the total projections from the product onto the factors
    if l = 2 then
        projections.(String(degrees[1])) := EpiOnRightFactor( product );
        projections.(String(degrees[2])) := EpiOnLeftFactor( product );
    else
        prj_factor := TheIdentityMorphism( product );
        factor := product;
        projections.(String(degrees[1])) := EpiOnRightFactor( factor );
        
        for i in [ 2 .. l - 1 ] do
            prj_factor := PreCompose( prj_factor, EpiOnLeftFactor( factor ) );
            factor := Genesis( factor )!.arguments_of_functor[1];
            projections.(String(degrees[i])) := PreCompose( prj_factor, EpiOnRightFactor( factor ) );
        od;
        
        projections.(String(degrees[l])) := PreCompose( prj_factor, EpiOnLeftFactor( factor ) );
    fi;
    
    product!.ProjectionsFromProductObject := projections;
    
    return projections;
    
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

##  <#GAPDoc Label="Saturate">
##  <ManSection>
##    <Oper Arg="K, J" Name="Saturate" Label="for ideals"/>
##    <Returns>a &homalg; ideal</Returns>
##    <Description>
##      Compute the saturation ideal <M><A>K</A>:<A>J</A>^\infty</M> of the ideals <A>K</A> and <A>J</A>.
##    <P/>
##    <#Include Label="Saturate:example">
##    <P/>
##    <Listing Type="Code"><![CDATA[
InstallMethod( Saturate,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep, IsFinitelyPresentedSubmoduleRep ],
        
  function( K, J )
    local quotient_last, quotient;
    
    quotient_last := SubmoduleQuotient( K, J );
    
    quotient := SubmoduleQuotient( quotient_last, J );
    
    while not IsSubset( quotient_last, quotient ) do
        quotient_last := quotient;
        quotient := SubmoduleQuotient( quotient_last, J );
    od;
    
    return quotient_last;
    
end );

##
InstallMethod( \-,	## a geometrically motivated definition
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep, IsFinitelyPresentedSubmoduleRep ],
        
  function( K, J )
    
    return Saturate( K, J );
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

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

