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
        
  function( M )
    local R, q;
    
    R := HomalgRing( M );
    
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

## ( cf. [BR, Subsection 3.2.1] )
InstallMethod( Resolution,			### defines: Resolution (ResolutionOfModule/ResolveModule)
        "for homalg relations",
        [ IsInt, IsRelationsOfFinitelyPresentedModuleRep ],
        
  function( _q, M )
    local R, max, q, B, d, degrees, j, d_j, F_j, id, S, left, i;
    
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
    
    if HasFreeResolution( M ) then
        d := FreeResolution( M );
        degrees := ObjectDegreesOfComplex( d );
        j := Length( degrees );
        j := degrees[j];
        d_j := CertainMorphism( d, j );
        if not IsBound( d!.LastSyzygies ) then
            d!.LastSyzygies := SyzygiesGenerators( d_j );
        fi;
    else
        B := ReducedBasisOfModule( M, "COMPUTE_BASIS", "STORE_SYZYGIES" );
        j := 1;
        d_j := HomalgMap( B );
        d := HomalgComplex( d_j );
        d!.LastSyzygies := B!.SyzygiesGenerators;
        
        SetFreeResolution( M, d );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    F_j := Source( d_j );
    
    S := d!.LastSyzygies;
    
    while NrRelations( S ) > 0 and j < q do
        
        B := ReducedBasisOfModule( S, "COMPUTE_BASIS", "STORE_SYZYGIES" );
        j := j + 1;
        d_j := HomalgMap( B, "free", F_j );
        
        Add( d, d_j );
        S := B!.SyzygiesGenerators;
        
        F_j := Source( d_j );
        
        d!.LastSyzygies := S;
        
    od;
    
    if NrRelations( S ) = 0 and not IsBound( d!.LengthOfResolution ) then
        d!.LengthOfResolution := j;
        SetIsMonomorphism( d_j, true );
        SetHasFiniteFreeResolution( M, true );
    fi;
    
    ## fill up with zero morphisms:
    if _q >= 0 then
        left := IsHomalgLeftObjectOrMorphismOfLeftObjects( F_j );
        for i in [ 1 .. q - j ] do
            if left then
                d_j := HomalgZeroMap( HomalgZeroLeftModule( R ), F_j );		## always create a new zero module to be able to distinguish them
            else
                d_j := HomalgZeroMap( HomalgZeroRightModule( R ), F_j );	## always create a new zero module to be able to distinguish them
            fi;
            
            Add( d, d_j );
            F_j := Source( d_j );
        od;
    fi;
    
    if NrRelations( S ) = 0 then
        SetIsAcyclic( d, true );
    else
        SetIsComplex( d, true );
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
    
    if HasLeftGlobalDimension( M ) then
        q := LeftGlobalDimension( M );
    elif HasRightGlobalDimension( M ) then
        q := RightGlobalDimension( M );
    elif HasGlobalDimension( M ) then
        q := GlobalDimension( M );
    elif IsBound( M!.UpperBoundForProjectiveDimension )
      and IsInt( M!.UpperBoundForProjectiveDimension ) then
        q := M!.UpperBoundForProjectiveDimension;
    elif IsBound( M!.MaximumNumberOfResolutionSteps )
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
    local rel, q, d, d_1;
    
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

InstallMethod( Resolution,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return Resolution( -1, M );
    
end );

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
        d := Resolution( 1, M );
        return CokernelEpi( CertainMorphism( d, 1 ) );
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
        d := Resolution( 1, M );
        dq1 := CertainMorphism( d, 1 );
        res := AsATwoSequence( dq1, TheZeroMorphism( FreeHullModule( M ) ) );
        if HasIsMonomorphism( dq1 ) and IsMonomorphism( dq1 ) then
            SetIsAcyclic( res, true );
        else
            SetIsComplex( res, true );
        fi;
        return res;
    fi;
    
    d := Resolution( q + 1, M );
    
    dq1 := CertainMorphism( d, q + 1 );
    
    res := AsATwoSequence( dq1, CertainMorphism( d, q ) );
    
    res := Shift( res, -q );
    
    if HasIsMonomorphism( dq1 ) and IsMonomorphism( dq1 ) then
        SetIsAcyclic( res, true );
    else
        SetIsComplex( res, true );
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
        d := Resolution( 1, M );
        dq1 := CertainMorphism( d, 1 );
        res := AsATwoSequence( TheZeroMorphism( FreeHullModule( M ) ), dq1 );
        if HasIsMonomorphism( dq1 ) and IsMonomorphism( dq1 ) then
            SetIsAcyclic( res, true );
        else
            SetIsComplex( res, true );
        fi;
        return res;
    fi;
    
    d := Resolution( q + 1, M );
    
    dq1 := CertainMorphism( d, q + 1 );
    
    res := AsATwoSequence( CertainMorphism( d, q ), dq1 );
    
    res := Shift( res, -q );
    
    if HasIsMonomorphism( dq1 ) and IsMonomorphism( dq1 ) then
        SetIsAcyclic( res, true );
    else
        SetIsComplex( res, true );
    fi;
    
    SetIsATwoSequence( res, true );
    
    return res;
    
end );

##
InstallGlobalFunction( ParametrizeModule,	### defines: ParametrizeModule	(incomplete)
  function( arg )
    local nargs, M, R, mat, par, F;
    
    nargs := Length( arg );
    
    if IsHomalgModule( arg[1] ) then
        M := RelationsOfModule( arg[1] );
    elif IsHomalgRelations( arg[1] ) then
        M := arg[1];
    fi;
    
    R := HomalgRing( M );
    
    mat := MatrixOfRelations( M );
    
    if IsHomalgRelationsOfLeftModule( M ) then
        
        par := SyzygiesGeneratorsOfColumns( mat );
        
        F := HomalgFreeLeftModule( NrColumns( par ), R );
        
    else
        
        par := SyzygiesGeneratorsOfRows( mat );
        
        F := HomalgFreeRightModule( NrRows( par ), R );
        
    fi;
    
    if IsHomalgModule( arg[1] ) then
        
        par := HomalgMap( par, arg[1], F );
        
        SetIsMorphism( par, true );
        
    fi;
    
    return par;
    
end );

##
InstallGlobalFunction( AsEpimorphicImage,
  function( phi )
    local nargs, M, rel, TI, T;
    
    if not IsMapOfFinitelyGeneratedModulesRep( phi ) then
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
