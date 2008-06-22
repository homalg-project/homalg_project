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
        [ IsRelationsOfFinitelyPresentedModuleRep, IsInt ],
        
  function( M, _q )
    local R, q, B, d, degrees, j, d_j, F_j, id, S, left, i;
    
    ## all options of Maple's homalg are now obsolete:
    ## "SIMPLIFY", "GEOMETRIC", "TARGETRELATIONS", "TRUNCATE", "LOWERBOUND"
    
    R := HomalgRing( M );
    
    if _q < 1 then
        q := infinity;
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
    
    if NrRelations( S ) = 0 then
        SetIsMonomorphism( d_j, true );
        SetHasFiniteFreeResolution( M, true );
    fi;
    
    ## fill up with zero morphisms:
    if q < infinity then
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
    local R, q;
    
    R := HomalgRing( M );
    
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
        q := 0;
    fi;
    
    return Resolution( M, q );
    
end );

InstallMethod( Resolution,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep, IsInt ],
        
  function( M, q )
    local rel, d, d_1;
    
    rel := RelationsOfModule( M );
    
    d := Resolution( rel, q );
    
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
    local R, q;
    
    R := HomalgRing( M );
    
    if IsHomalgRelationsOfLeftModule( M ) and HasLeftGlobalDimension( M ) then
        q := LeftGlobalDimension( M );
    elif IsHomalgRelationsOfRightModule( M ) and HasRightGlobalDimension( M ) then
        q := RightGlobalDimension( M );
    elif HasGlobalDimension( M ) then
        q := GlobalDimension( M );
    elif IsBound( M!.MaximumNumberOfResolutionSteps )
      and IsInt( M!.MaximumNumberOfResolutionSteps ) then
        q := M!.MaximumNumberOfResolutionSteps;
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
        q := 0;
    fi;
    
    return Resolution( M, q );
    
end );

##
InstallMethod( SyzygiesModuleEmb,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep, IsInt ],
        
  function( M, q )
    local d;
    
    if q < 0 then
        Error( "a negative integer does not make sense\n" );
    elif q = 0 then
        ## this is not really an embedding, but spares us case distinctions at several places (e.g. Left/RightSatelliteOfFunctor)
	return TheZeroMorphism( M );
    elif q = 1 then
        return KernelEmb( SyzygiesModuleEpi( M, 0 ) );
    fi;
    
    d := Resolution( M, q - 1 );
    
    return KernelEmb( CertainMorphism( d, q - 1 ) );
    
end );

##
InstallMethod( SyzygiesModule,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep, IsInt ],
        
  function( M, q )
    local d;
    
    if q < 0 then
        return 0 * M;
    elif q = 0 then
        return M;
    fi;
    
    return Source( SyzygiesModuleEmb( M, q ) );
    
end );

##
InstallMethod( SyzygiesModuleEpi,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep, IsInt ],
        
  function( M, q )
    local d, mu, epi;
    
    if q < 0 then
        Error( "a netative integer does not make sense\n" );
    elif q = 0 then
        d := Resolution( M, 1 );
        return CokernelEpi( CertainMorphism( d, 1 ) );
    fi;
    
    d := Resolution( M, q );
    
    mu := SyzygiesModuleEmb( M , q );
    
    epi := PostDivide( CertainMorphism( d, q ), mu );
    
    SetIsEpimorphism( epi, true );
    
    return epi;
    
end );

##
InstallMethod( FreeHullMap,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return SyzygiesModuleEpi( M, 0 );
    
end );

##
InstallMethod( FreeHullModule,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return Source( FreeHullMap( M ) );
    
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
