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
InstallMethod( \/,			## defines: / (SubfactorModule)
        "for a homalg matrix",
        [ IsHomalgMatrix, IsFinitelyPresentedModuleRep ],
        
  function( mat, M )
    local B, N, gen, S;
    
    # basis of rel
    B := BasisOfModule( M );
    
    # normal forms of mat with respect to B
    N := DecideZero( mat, B );
    
    if IsLeftModule( M ) then
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
InstallMethod( \/,					## needed by _Functor_Kernel_OnObjects since SyzygiesGenerators returns a set of relations
        "for a set of homalg relations",
        [ IsHomalgRelations, IsFinitelyPresentedModuleRep ],
        
  function( rel, M )
    
    return MatrixOfRelations( rel ) / M;
    
end );

##
InstallMethod( FreeHullModule,
        "for sets of homalg relations",
        [ IsHomalgRelationsOfFinitelyPresentedModuleRep ],
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if IsHomalgRelationsOfLeftModule( M ) then
        HomalgFreeLeftModule( NrGenerators( M ), R );
    else
        HomalgFreeRightModule( NrGenerators( M ), R );
    fi;
    
end );

##
InstallMethod( FreeHullModule,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    FreeHullModule( RelationsOfModule( M ) );
    
end );

## ( cf. [BR, Subsection 3.2.1] )
InstallGlobalFunction( ResolutionOfModule,	### defines: ResolutionOfModule
  function( arg )
    local nargs, M, R, q, B, d, indices, j, d_j, F_j, id, S, i, left;
    
    ## all options of Maple's homalg are obsolete now:
    ## "SIMPLIFY", "GEOMETRIC", "TARGETRELATIONS", "TRUNCATE", "LOWERBOUND"
    
    nargs := Length( arg );
    
    if nargs = 0 or not ( IsHomalgRelations( arg[1] ) or IsHomalgModule( arg[1] ) ) then
        Error( "the first argument must be a module or a set of relations\n" );
    fi;
    
    M := arg[1];
    
    if IsHomalgModule( M ) then
        M := RelationsOfModule( M );
    fi;
    
    R := HomalgRing( M );
    
    if nargs > 1 and IsInt( arg[2] ) then
        q := arg[2];
    elif IsHomalgRelationsOfLeftModule( M ) and HasLeftGlobalDimension( M ) then
        q := LeftGlobalDimension( M );
    elif IsHomalgRelationsOfRightModule( M ) and HasRightGlobalDimension( M ) then
        q := RightGlobalDimension( M );
    elif HasGlobalDimension( M ) then
        q := GlobalDimension( M );
    elif IsBound( M!.MaximumNumberOfResolutionSteps )
      and IsInt( M!.MaximumNumberOfResolutionSteps ) then
        q := M!.MaximumNumberOfResolutionSteps;
    elif IsBound( arg[1]!.MaximumNumberOfResolutionSteps )
      and IsInt( arg[1]!.MaximumNumberOfResolutionSteps ) then
        q := arg[1]!.MaximumNumberOfResolutionSteps;
    elif IsBound( R!.MaximumNumberOfResolutionSteps )
      and IsInt( R!.MaximumNumberOfResolutionSteps ) then
        q := R!.MaximumNumberOfResolutionSteps;
    elif IsBound( HOMALG.MaximumNumberOfResolutionSteps )
      and IsInt( HOMALG.MaximumNumberOfResolutionSteps ) then
        q := HOMALG.MaximumNumberOfResolutionSteps;
    else
        q := infinity;
    fi;
    
    if HasFreeResolution( M ) then
        d := FreeResolution( M );
        indices := ObjectDegreesOfComplex( d );
        j := Length( indices );
        j := indices[j];
        d_j := CertainMorphism( d, j );
        if not IsBound( d!.LastSyzygies ) then
            d!.LastSyzygies := SyzygiesGenerators( d_j );
        fi;
    else
        B := ReducedBasisOfModule( M, "COMPUTE_BASIS", "STORE_SYZYGIES" );
        j := 1;
        d_j := HomalgMorphism( B );
        d := HomalgComplex( d_j, 1 );
        d!.LastSyzygies := B!.SyzygiesGenerators;
        
        ## only for j = 1:
        if IsHomalgModule( arg[1] ) then
            id := HomalgIdentityMatrix( NrGenerators( B ), R );
            ## the zero'th component of the quasi-isomorphism,
            ## which in this case is simplfy the natural epimorphism on the module
            SetCokernelEpi( d_j, HomalgMorphism( id, Target( d_j ), arg[1] ) );
            SetIsEpimorphism( d_j!.CokernelEpi, true );
        fi;
        SetFreeResolution( M, d );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    F_j := Source( d_j );
    
    S := d!.LastSyzygies;
    
    while NrRelations( S ) > 0 and j < q do
        
        B := ReducedBasisOfModule( S, "COMPUTE_BASIS", "STORE_SYZYGIES" );
        j := j + 1;
        d_j := HomalgMorphism( B, "free", F_j );
        
        Add( d, d_j );
        S := B!.SyzygiesGenerators;
        
        F_j := Source( d_j );
        
        d!.LastSyzygies := S;
        
    od;
    
    if NrRelations( S ) = 0 then
        SetHasFiniteFreeResolution( M, true );
    fi;
    
    ## fill up with zero morphisms:
    if q < infinity then
        left := IsLeftModule( F_j );
        for i in [ 1 .. q - j ] do
            if left then
                d_j := HomalgZeroMorphism( HomalgZeroLeftModule( R ), F_j );	## always create a new zero module to be able to distinguish them
            else
                d_j := HomalgZeroMorphism( HomalgZeroRightModule( R ), F_j );	## always create a new zero module to be able to distinguish them
            fi;
            
            Add( d, d_j );
            F_j := Source( d_j );
        od;
    fi;
    
    SetIsComplex( d, true );
    
    return d;
    
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
        
        par := HomalgMorphism( par, arg[1], F );
        
        SetIsMorphism( par, true );
        
    fi;
    
    return par;
    
end );
