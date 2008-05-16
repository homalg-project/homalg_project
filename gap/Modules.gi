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

##
InstallMethod( \/,				### defines: SubfactorModule (incomplete)
        "for a homalg matrix",
	[ IsHomalgGeneratorsOfFinitelyGeneratedModuleRep, IsHomalgGeneratorsOfFinitelyGeneratedModuleRep ],
        
  function( gen1, gen2 )
    local R, RP, B, N, S;
    
    R := HomalgRing( gen1 );
    
    RP := homalgTable( R );
    
    #=====# begin of the core procedure #=====#
    
    # basis of gen2
    B := BasisOfModule( gen2 );
    
    # normal forms of generators of gen1 with respect to B
    N := DecideZero( gen1, B );
    
    if IsHomalgGeneratorsOfLeftModule( gen1 ) then
        N := HomalgGeneratorsForLeftModule( N );
    else
        N := HomalgGeneratorsForRightModule( N );
    fi;
    
    # get a better basis for N
    N := GetRidOfObsoleteGenerators( N );
    
    # compute the syzygies module of N modulo B
    S := SyzygiesGenerators( N, B );
    
    return Presentation( S );
    
end );

##
InstallMethod( \/,
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
    
    # compute the syzygies module of N modulo B
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

##
InstallGlobalFunction( ResolutionOfModule,	### defines: ResolutionOfModule
  function( arg )
    local nargs, M, R, q, B, d, indices, j, d_j, F_j, id, S;
    
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
        indices := d!.indices;
        j := Length( indices );
        j := indices[j];
        d_j := d!.( j );
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
            d_j!.CokernelEpi := HomalgMorphism( id, TargetOfMorphism( d_j ), arg[1] );
            SetIsEpimorphism( d_j!.CokernelEpi, true );
        fi;
        SetFreeResolution( M, d );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    F_j := SourceOfMorphism( d_j );
    
    S := d!.LastSyzygies;
    
    while NrRelations( S ) > 0 and j < q do
        
        B := ReducedBasisOfModule( S, "COMPUTE_BASIS", "STORE_SYZYGIES" );
        j := j + 1;
        d_j := HomalgMorphism( B, "free", F_j );
        
        Add( d, d_j );
        S := B!.SyzygiesGenerators;
        
        F_j := SourceOfMorphism( d_j );
        
        d!.LastSyzygies := S;
    
    od;
    
    return d;
    
end );

