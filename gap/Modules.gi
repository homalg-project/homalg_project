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
InstallMethod( \/,
        "for a set of homalg relations",
	[ IsHomalgRelations, IsFinitelyPresentedModuleRep ],
        
  function( rel, M )
    
    return MatrixOfRelations( rel ) / M;
    
end );
