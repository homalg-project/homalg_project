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
    
    # basis of rel
    B := BasisOfModule( M );
    
    # normal forms of mat with respect to B
    N := DecideZero( mat, B );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        N := HomalgGeneratorsForLeftModule( N );
    else
        N := HomalgGeneratorsForRightModule( N );
    fi;
    
    # get a better basis for N
    N := GetRidOfObsoleteGenerators( N );
    
    gen := N * GeneratorsOfModule( M );
    
    # compute the syzygies of N modulo B, i.e. the relations among N modulo B
    S := SyzygiesGenerators( N, B );
    
    S := Presentation( N, S );
    
    return AddANewPresentation( S, gen );
    
end );

##
InstallMethod( \/,				## needed by _Functor_Kernel_OnObjects since SyzygiesGenerators returns a set of relations
        "for a set of homalg relations",
        [ IsHomalgRelations, IsFinitelyPresentedModuleRep ],
        
  function( rel, M )
    
    return MatrixOfRelations( rel ) / M;
    
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
    
    if _q < 1 then
        if IsHomalgRelationsOfLeftModule( M ) and HasLeftGlobalDimension( M ) then
            q := LeftGlobalDimension( M );
        elif IsHomalgRelationsOfRightModule( M ) and HasRightGlobalDimension( M ) then
            q := RightGlobalDimension( M );
        elif HasGlobalDimension( M ) then
            q := GlobalDimension( M );
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
    if _q > 0 then
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
    
    return Resolution( 0, M );
    
end );

InstallMethod( Resolution,
        "for homalg modules",
        [ IsInt, IsFinitelyPresentedModuleRep ],
        
  function( q, M )
    local rel, d, d_1;
    
    rel := RelationsOfModule( M );
    
    d := Resolution( q, rel );
    
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
    
    return Resolution( 0, M );
    
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
    
    epi := PostDivide( CertainMorphism( d, q ), mu );
    
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
