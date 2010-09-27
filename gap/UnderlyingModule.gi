#############################################################################
##
##  UnderlyingModule.gi
##
##  Copyright 2010,      Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Implementation stuff
##
#############################################################################

##
InstallMethod( TheMorphismToZero,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
      return GradedMap( TheMorphismToZero( UnderlyingModule( M ) ), M, 0 * HomalgRing( M ), HomalgRing( M ) );
    else
      return GradedMap( TheMorphismToZero( UnderlyingModule( M ) ), M, HomalgRing( M ) * 0, HomalgRing( M ) );
    fi;
     
end );

##
InstallMethod( PositionOfTheDefaultPresentation,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return PositionOfTheDefaultPresentation( UnderlyingModule( M ) );
    
end );

##
InstallMethod( SetPositionOfTheDefaultPresentation,
        "for homalg graded modules",
        [ IsGradedModuleRep, IsInt ],
        
  function( M, p )
    
    SetPositionOfTheDefaultPresentation( UnderlyingModule( M ), p );
    
end );

##
InstallMethod( HasNrGenerators,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return HasNrGenerators( UnderlyingModule( M ) );
    
end );

InstallMethod( NrGenerators,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return NrGenerators( UnderlyingModule( M ) );
    
end );

InstallMethod( HasNrGenerators,
        "for homalg graded modules",
        [ IsGradedModuleRep, IsPosInt ],
        
  function( M, a )
    
    return HasNrGenerators( UnderlyingModule( M ), a );
    
end );

InstallMethod( NrGenerators,
        "for homalg graded modules",
        [ IsGradedModuleRep, IsPosInt ],
        
  function( M, a )
    
    return NrGenerators( UnderlyingModule( M ), a );
    
end );

InstallMethod( CertainGenerators,
        "for homalg graded modules",
        [ IsGradedModuleRep, IsList ],
        
  function( M, a )
    
    return CertainGenerators( UnderlyingModule( M ), a );
    
end );

InstallMethod( CertainGenerator,
        "for homalg graded modules",
        [ IsGradedModuleRep, IsPosInt ],
        
  function( M, a )
    
    return CertainGenerator( UnderlyingModule( M ), a );
    
end );

InstallMethod( HasNrRelations,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return HasNrGenerators( UnderlyingModule( M ) );
    
end );

InstallMethod( NrRelations,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return NrRelations( UnderlyingModule( M ) );
    
end );

InstallMethod( HasNrRelations,
        "for homalg graded modules",
        [ IsGradedModuleRep, IsPosInt ],
        
  function( M, a )
    
    return HasNrRelations( UnderlyingModule( M ), a );
    
end );

InstallMethod( NrRelations,
        "for homalg graded modules",
        [ IsGradedModuleRep, IsPosInt ],
        
  function( M, a )
    
    return NrGenerators( UnderlyingModule( M ), a );
    
end );

InstallMethod( ByASmallerPresentation,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return ByASmallerPresentation( UnderlyingModule( M ) );
    
end );

##
InstallMethod( SetsOfGenerators,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return SetsOfGenerators( UnderlyingModule( M ) );
    
end );

##
InstallMethod( SetsOfRelations,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return SetsOfRelations( UnderlyingModule( M ) );
    
end );

##
InstallMethod( ListOfPositionsOfKnownSetsOfRelations,
        "for homalg modules",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return ListOfPositionsOfKnownSetsOfRelations( UnderlyingModule( M ) );
    
end );

##
InstallMethod( GeneratorsOfModule,
        "for homalg graded modules",
        [ IsGradedModuleOrGradedSubmoduleRep ],
        
  function( M )
    
    return GeneratorsOfModule( UnderlyingModule( M ) );
    
end );

##
InstallMethod( RelationsOfModule,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return RelationsOfModule( UnderlyingModule( M ) );
    
end );

##
InstallMethod( GeneratorsOfModule,
        "for homalg graded modules",
        [ IsGradedModuleOrGradedSubmoduleRep, IsPosInt ],
        
  function( M, pos )
    
    return GeneratorsOfModule( UnderlyingModule( M ), pos );
    
end );

##
InstallMethod( RelationsOfModule,
        "for homalg graded modules",
        [ IsGradedModuleRep, IsPosInt ],
        
  function( M, pos )
    
    return RelationsOfModule( UnderlyingModule( M ), pos );
    
end );

##
InstallMethod( MatrixOfGenerators,
        "for homalg graded modules",
        [ IsGradedModuleOrGradedSubmoduleRep ],
        
  function( M )
    
    return HomogeneousMatrix( MatrixOfGenerators( UnderlyingModule( M ) ), HomalgRing( M ) );
    
end );

##
InstallMethod( MatrixOfRelations,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return HomogeneousMatrix( MatrixOfRelations( UnderlyingModule( M ) ), HomalgRing( M ) );
    
end );

##
InstallMethod( MatrixOfGenerators,
        "for homalg graded modules",
        [ IsGradedModuleOrGradedSubmoduleRep, IsPosInt ],
        
  function( M, pos )
    
    return HomogeneousMatrix( MatrixOfGenerators( UnderlyingModule( M ), pos ), HomalgRing( M ) );
    
end );

##
InstallMethod( MatrixOfRelations,
        "for homalg graded modules",
        [ IsGradedModuleRep, IsPosInt ],
        
  function( M, pos )
    
    return HomogeneousMatrix( MatrixOfRelations( UnderlyingModule( M ), pos ), HomalgRing( M ) );
    
end );

##
InstallMethod( TransitionMatrix,
        "for homalg graded modules",
        [ IsGradedModuleRep, IsInt, IsInt ],
        
  function( M, pos1, pos2 )
    
    return HomogeneousMatrix( TransitionMatrix( UnderlyingModule( M ), pos1, pos2 ), HomalgRing( M ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for homalg graded modules",
        [ IsGradedModuleOrGradedSubmoduleRep ],
        
  function( M )
    
    return SyzygiesGenerators( UnderlyingModule( M ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for homalg graded modules",
        [ IsHomalgMatrix, IsGradedModuleOrGradedSubmoduleRep ],
        
  function( A, M )
    
    return SyzygiesGenerators( A, UnderlyingModule( M ) );
    
end );


##
InstallMethod( ReducedSyzygiesGenerators,
        "for homalg graded modules",
        [ IsGradedModuleOrGradedSubmoduleRep ],
        
  function( M )
    
    return ReducedSyzygiesGenerators( UnderlyingModule( M ) );
    
end );

##
InstallMethod( ReducedSyzygiesGenerators,
        "for homalg graded modules",
        [ IsHomalgMatrix, IsGradedModuleOrGradedSubmoduleRep ],
        
  function( A, M )
    
    return ReducedSyzygiesGenerators( A, UnderlyingModule( M ) );
    
end );

##
InstallMethod( BasisOfModule,
        "for homalg graded modules",
        [ IsGradedModuleOrGradedSubmoduleRep ],
        
  function( M )
    
    return BasisOfModule( UnderlyingModule( M ) );
    
end );

##
InstallMethod( DecideZero,
        "for homalg graded modules",
        [ IsHomalgMatrix, IsGradedModuleOrGradedSubmoduleRep ],
        
  function( A, M )
    return HomogeneousMatrix( DecideZero( A, UnderlyingModule( M ) ), HomalgRing( M ) );
    
end );

##
InstallMethod( DecideZero,
        "for homalg graded modules",
        [ IsHomalgHomogeneousMatrixRep, IsGradedModuleOrGradedSubmoduleRep ],
        
  function( A, M )
    return HomogeneousMatrix( DecideZero( UnderlyingNonHomogeneousMatrix( A ), UnderlyingModule( M ) ), HomalgRing( M ) );
    
end );

##
InstallMethod( IsZero,
        "for homalg graded modules and submodules",
        [ IsGradedModuleOrGradedSubmoduleRep ],
        
  function( M )
    
    return IsZero( UnderlyingModule( M ) );
    
end );

##
InstallMethod( UnionOfRelations,
        "for homalg graded modules",
        [ IsHomalgHomogeneousMatrixRep, IsGradedModuleRep ],
        
  function( A, M )
    
    return UnionOfRelations( UnderlyingNonHomogeneousMatrix( A ), UnderlyingModule( M ) );
    
end );

##
InstallMethod( UnionOfRelations,
        "for homalg graded modules",
        [ IsHomalgMatrix, IsGradedModuleRep ],
        
  function( A, M )
    
    return UnionOfRelations( A, UnderlyingModule( M ) );
    
end );

##
InstallMethod( AnIsomorphism,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return GradedMap( AnIsomorphism( UnderlyingModule( M ) ), "create", M );
    
end );

##
InstallMethod( TheIdentityMorphism,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return GradedMap( TheIdentityMorphism( UnderlyingModule( M ) ), M, M );
    
end );

##
InstallMethod( LockObjectOnCertainPresentation,
        "for homalg graded modules",
        [ IsGradedModuleRep, IsInt ],
        
  function( M, p )
    
    LockObjectOnCertainPresentation( UnderlyingModule( M ), p );
    
end );

##
InstallMethod( LockObjectOnCertainPresentation,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    
    LockObjectOnCertainPresentation( UnderlyingModule( M ) );
    
end );
