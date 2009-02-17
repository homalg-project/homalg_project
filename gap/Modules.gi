#############################################################################
##
##  Modules.gi                  homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations of homalg procedures for modules.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

## ( cf. [BR, Subsection 3.2.2] )
InstallMethod( \/,				### defines: / (SubfactorModule)
        "for a homalg matrix",
        [ IsHomalgMatrix, IsFinitelyPresentedModuleRep ],
        
  function( mat, M )
    local B, N, gen, S;
    
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
    
    # compute the syzygies of N modulo B, i.e. the relations among N modulo B:
    S := SyzygiesGenerators( N, B );	## using ReducedSyzygiesGenerators here causes too many operations (cf. the ex. Triangle.g)
    
    S := Presentation( N, S );
    
    ## this matrix of generators is often enough the identity matrix
    ## and knowing this will avoids computations:
    IsIdentityMatrix( MatrixOfGenerators( N ) );
    
    ## keep track of the original generators:
    gen := N * GeneratorsOfModule( M );
    
    return AddANewPresentation( S, gen );
    
end );

##
InstallMethod( \/,				## needed by _Functor_Kernel_OnObjects since SyzygiesGenerators returns a set of relations
        "for a set of homalg relations",
        [ IsHomalgRelations, IsFinitelyPresentedModuleRep ],
        
  function( rel, M )
    
    return MatrixOfRelations( rel ) / M;
    
end );

##
InstallMethod( BoundForResolution,
        "for homalg relations",
        [ IsRelationsOfFinitelyPresentedModuleRep ],
        
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

## ( cf. [BR, Subsection 3.2.1] )
InstallMethod( Resolution,			### defines: Resolution (ResolutionOfModule/ResolveModule)
        "for homalg relations",
        [ IsInt, IsRelationsOfFinitelyPresentedModuleRep ],
        
  function( _q, rel )
    local R, SYZYGIES_ALREADY_MINIMAL, q, B, d, degrees, j, d_j, F_j, id, S,
          left, i;
    
    ## all options of Maple's homalg are now obsolete:
    ## "SIMPLIFY", "GEOMETRIC", "TARGETRELATIONS", "TRUNCATE", "LOWERBOUND"
    
    R := HomalgRing( rel );
    
    ## do we need to find a "minimal" set of syzygies?
    if IsList( DegreesOfGenerators( rel ) ) and
       HasSyzygiesAlgorithmReturnsMinimalSyzygies( R ) and
       SyzygiesAlgorithmReturnsMinimalSyzygies( R ) then
        SYZYGIES_ALREADY_MINIMAL := true;
    else
        SYZYGIES_ALREADY_MINIMAL := false;
    fi;
    
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
        B := ReducedBasisOfModule( rel, "COMPUTE_BASIS" );	## "COMPUTE_BASIS" saves computations
        j := 1;
        d_j := HomalgMap( B );
        d := HomalgComplex( d_j );
        
        SetFreeResolution( rel, d );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    F_j := Source( d_j );
    
    ## the main loop to compute iterated "minimal" syzygies
    while j < q do
        
        S := SyzygiesGenerators( d_j );
        
        if NrRelations( S ) = 0 then
            break;
        fi;
        
        ## really enter the loop
        j := j + 1;
        
        if IsList( DegreesOfGenerators( F_j ) ) then
            S!.DegreesOfGenerators := DegreesOfGenerators( F_j );
        fi;
        
        ## minimize the set of syzygies
        if SYZYGIES_ALREADY_MINIMAL then
            B := S;
            if IsHomalgRelationsOfLeftModule( B ) then
                SetZeroRows( MatrixOfRelations( B ), [ ] );
            else
                SetZeroColumns( MatrixOfRelations( B ), [ ] );
            fi;
        else
            B := ReducedBasisOfModule( S );	## "COMPUTE_BASIS" causes obsolete computations, at least in general
        fi;
        
        d_j := HomalgMap( B, "free", F_j );
        
        Add( d, d_j );
        
        F_j := Source( d_j );
        
    od;
    
    if NrGenerators( Source( d_j ) ) = 1 and
       HasIsIntegralDomain( R ) and IsIntegralDomain( R ) then
        S := SyzygiesGenerators( d_j );	## this will be handled by internal logical
    fi;
    
    if IsBound( S ) and NrRelations( S ) = 0 and not IsBound( d!.LengthOfResolution ) then
        d!.LengthOfResolution := j;
    fi;
    
    ## fill up with zero morphisms:
    if _q >= 0 then
        left := IsHomalgLeftObjectOrMorphismOfLeftObjects( F_j );
        for i in [ 1 .. q - j ] do
            if left then
                d_j := TheZeroMap( 0 * R, F_j );
            else
                d_j := TheZeroMap( R * 0, F_j );
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
        [ IsRelationsOfFinitelyPresentedModuleRep ],
        
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
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return Resolution( -1, M );
    
end );

##
InstallMethod( LengthOfResolution,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
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
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local d;
    
    d := Resolution( 1, M );
    
    return CertainMorphism( d, 1 );
    
end );

##
InstallMethod( SyzygiesModuleEmb,
        "for homalg modules",
        [ IsInt, IsFinitelyPresentedModuleRep ],
        
  function( q, M )
    local d;
    
    if q < 0 then
        Error( "a negative integer does not make sense\n" );
    elif q = 0 then
        ## this is not really an embedding, but spares us case distinctions at several places (e.g. Left/RightSatelliteOfFunctor)
        return TheZeroMorphism( M );
    elif q = 1 then
        return KernelEmb( FreeHullEpi( M ) );
    fi;
    
    d := Resolution( q - 1, M );
    
    return KernelEmb( CertainMorphism( d, q - 1 ) );
    
end );

##
InstallMethod( SyzygiesModuleEmb,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return SyzygiesModuleEmb( 1, M );
    
end );

##
InstallMethod( SyzygiesModule,
        "for homalg modules",
        [ IsInt, IsFinitelyPresentedModuleRep ],
        
  function( q, M )
    local d;
    
    if q < 0 then
        return 0 * M;
    elif q = 0 then
        return M;
    fi;
    
    return Source( SyzygiesModuleEmb( q, M ) );
    
end );

##
InstallMethod( SyzygiesModule,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return SyzygiesModule( 1, M );
    
end );

##
InstallMethod( SyzygiesModuleEpi,
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
    
    mu := SyzygiesModuleEmb( q, M );
    
    epi := CertainMorphism( d, q ) / mu;
    
    SetIsEpimorphism( epi, true );
    
    ## this might simplify things later:
    IsIdentityMatrix( MatrixOfMap( epi ) );
    
    return epi;
    
end );

##
InstallMethod( SyzygiesModuleEpi,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return SyzygiesModuleEpi( 1, M );
    
end );

##
InstallMethod( FreeHullEpi,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return SyzygiesModuleEpi( 0, M );
    
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
        res := AsATwoSequence( dq1, TheZeroMorphism( FreeHullModule( M ) ) );
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
        res := AsATwoSequence( TheZeroMorphism( FreeHullModule( M ) ), dq1 );
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
    
    d_m := AugmentMaps( d_m_1, s_m_1 );
    SetIsMonomorphism( d_m, true );	## only during the first step
    
    if m > 2 then
        d_m_2 := CertainMorphism( d, mx - 2 );
        d_m_1 := StackMaps( d_m_2, TheZeroMap( F_m, Range( d_m_2 ) ) );
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
        
        d_m := AugmentMaps( d_m_1, s_m_1 );
        
        if m > 2 then
            d_m_2 := CertainMorphism( d, mx - 2 );
            d_m_1 := StackMaps( d_m_2, TheZeroMap( F_m, Range( d_m_2 ) ) );
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
InstallGlobalFunction( AsEpimorphicImage,
  function( arg )
    local nargs, phi, M, rel, TI, T;
    
    nargs := Length( arg );
    
    if nargs = 0 then
        Error( "too few arguments\n" );
    fi;
    
    phi := arg[1];
    
    if IsHomalgMatrix( phi ) then
        if nargs > 1 and IsHomalgModule( arg[2] ) then
            phi := HomalgMap( phi, "free", arg[2] );
        else
            Error( "if the first argument is a homalg matrix then the second argument must be a homalg module\n" );
        fi;
    elif not IsMapOfFinitelyGeneratedModulesRep( phi ) then
        Error( "the first argument must be a map\n" );
    fi;
    
    if not IsZero( Cokernel( phi ) ) then	## I do not require phi to be a morphism, that's why I don't use IsEpimorphism
        Error( "the first argument must be an epimorphism\n" );
    fi;
    
    M := Range( phi );
    
    rel := RelationsOfModule( M );
    
    TI := MatrixOfMap( phi );
    
    ## phi^-1 is not necessarily a morphism
    T := MatrixOfMap( phi^-1 );		## Source( phi ) does not play any role!!!
    
    return AddANewPresentation( M, rel * T, T, TI );
    
end );

##
InstallMethod( Intersect,
        "for homalg relations",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule,
          IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
  function( R1, R2 )
    local pb, r1, r2, im;
    
    r1 := HomalgMap( MatrixOfRelations( R1 ) );
    r2 := HomalgMap( MatrixOfRelations( R2 ), "free", Range( r1 ) );
    
    pb := PullbackPairOfMaps( AsChainMapForPullback( r1, r2 ) )[1];
    
    im := PreCompose( pb, r1 );
    
    im := HomalgRelationsForLeftModule( MatrixOfMap( im ) );
    
    return ReducedBasisOfModule( im, "COMPUTE_BASIS" );
    
end );

##
InstallMethod( Intersect,
        "for homalg relations",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule,
          IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
  function( R1, R2 )
    local pb, r1, r2, im;
    
    r1 := HomalgMap( MatrixOfRelations( R1 ), "r" );
    r2 := HomalgMap( MatrixOfRelations( R2 ), "free", Range( r1 ) );
    
    pb := PullbackPairOfMaps( AsChainMapForPullback( r1, r2 ) )[1];
    
    im := PreCompose( pb, r1 );
    
    im := HomalgRelationsForRightModule( MatrixOfMap( im ) );
    
    return ReducedBasisOfModule( im, "COMPUTE_BASIS" );
    
end );

##
InstallMethod( Annihilator,
        "for homalg relations",
        [ IsHomalgMatrix, IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
  function( mat, rel )
    local syz;
    
    syz := List( [ 1 .. NrRows( mat ) ], i -> CertainRows( mat, [ i ] ) );
    syz := List( syz, r -> ReducedSyzygiesGenerators( r, rel ) );
    
    return Iterated( syz, Intersect );
    
end );

##
InstallMethod( Annihilator,
        "for homalg relations",
        [ IsHomalgMatrix, IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
  function( mat, rel )
    local syz;
    
    syz := List( [ 1 .. NrColumns( mat ) ], j -> CertainColumns( mat, [ j ] ) );
    syz := List( syz, c -> ReducedSyzygiesGenerators( c, rel ) );
    
    return Iterated( syz, Intersect );
    
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
##    <Oper Arg="r_list, M" Name="SubmoduleOfIdealMultiples" Label="constructor for submodules"/>
##    <Returns>a &homalg; module</Returns>
##    <Description>
##      The constructor returns the submodule <M>I</M><A>M</A> (resp. <A>M</A><M>I</M>) of the given left (resp. right)
##      <M>R</M>-module <A>M</A>, where <M>I = \langle</M><A>r_list</A><M>\rangle</M> is the left (resp. right) ideal
##      in <M>R</M> generated by all ring elements in <A>r_list</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( SubmoduleOfIdealMultiples,
        "constructor of homalg maps",
        [ IsList, IsFinitelyPresentedModuleRep ],
        
  function( r_list, M )
    local R, n, scalar;
    
    if not ForAll( r_list, IsRingElement ) then
        Error( "not all entries of the first argument are ring elements\n" );
    fi;
    
    R := HomalgRing( M );
    
    n := NrGenerators( M );
    
    scalar := List( r_list, r -> HomalgScalarMatrix( r, n, R ) );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        scalar := Iterated( scalar, UnionOfRows );
    else
        scalar := Iterated( scalar, UnionOfColumns );
    fi;
    
    scalar := HomalgMap( scalar, "free", M );
    
    return ImageSubmodule( scalar );
    
end );

