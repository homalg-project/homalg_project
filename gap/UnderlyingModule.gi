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
InstallMethod( PositionOfTheDefaultSetOfGenerators,
        "for homalg graded modules",
        [ IsGradedSubmoduleRep ],
        
  function( M )
    
    return PositionOfTheDefaultSetOfGenerators( UnderlyingModule( M ) );
    
end );

##
InstallMethod( SetPositionOfTheDefaultSetOfGenerators,
        "for homalg graded modules",
        [ IsGradedSubmoduleRep, IsInt ],
        
  function( M, p )
    
    SetPositionOfTheDefaultSetOfGenerators( UnderlyingModule( M ), p );
    
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
    local N;
    
    N := UnderlyingModule( M );
    
    ByASmallerPresentation( N );
    
    ## the graded version of Nakayama's Lemma
    SetIsFree( N, NrRelations( N ) = 0 );
    
    return M;
    
end );

##
InstallMethod( SetsOfGenerators,
        "for homalg graded modules",
        [ IsGradedModuleOrGradedSubmoduleRep ],
        
  function( M )
    
    return SetsOfGenerators( UnderlyingModule( M ) );
    
end );

##
InstallMethod( SetsOfRelations,
        "for homalg graded modules",
        [ IsGradedModuleOrGradedSubmoduleRep ],
        
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
    
    return MatrixOverGradedRing( MatrixOfGenerators( UnderlyingModule( M ) ), HomalgRing( M ) );
    
end );

##
InstallMethod( MatrixOfRelations,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return MatrixOverGradedRing( MatrixOfRelations( UnderlyingModule( M ) ), HomalgRing( M ) );
    
end );

##
InstallMethod( MatrixOfGenerators,
        "for homalg graded modules",
        [ IsGradedModuleOrGradedSubmoduleRep, IsPosInt ],
        
  function( M, pos )
    
    return MatrixOverGradedRing( MatrixOfGenerators( UnderlyingModule( M ), pos ), HomalgRing( M ) );
    
end );

##
InstallMethod( MatrixOfRelations,
        "for homalg graded modules",
        [ IsGradedModuleRep, IsPosInt ],
        
  function( M, pos )
    
    return MatrixOverGradedRing( MatrixOfRelations( UnderlyingModule( M ), pos ), HomalgRing( M ) );
    
end );

##
InstallMethod( TransitionMatrix,
        "for homalg graded modules",
        [ IsGradedModuleRep, IsInt, IsInt ],
        
  function( M, pos1, pos2 )
    
    return MatrixOverGradedRing( TransitionMatrix( UnderlyingModule( M ), pos1, pos2 ), HomalgRing( M ) );
    
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
InstallMethod( SyzygiesGenerators,
        "for homalg graded modules",
        [ IsHomalgMatrixOverGradedRingRep, IsGradedModuleOrGradedSubmoduleRep ],
        
  function( A, M )
    
    return SyzygiesGenerators( UnderlyingMatrixOverNonGradedRing( A ), M );
    
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
InstallMethod( ReducedSyzygiesGenerators,
        "for homalg graded modules",
        [ IsHomalgMatrixOverGradedRingRep, IsGradedModuleOrGradedSubmoduleRep ],
        
  function( A, M )
    
   return ReducedSyzygiesGenerators( UnderlyingMatrixOverNonGradedRing( A ), M );
    
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
    return MatrixOverGradedRing( DecideZero( A, UnderlyingModule( M ) ), HomalgRing( M ) );
    
end );

##
InstallMethod( DecideZero,
        "for homalg graded modules",
        [ IsHomalgMatrixOverGradedRingRep, IsGradedModuleOrGradedSubmoduleRep ],
        
  function( A, M )
    return MatrixOverGradedRing( DecideZero( UnderlyingMatrixOverNonGradedRing( A ), UnderlyingModule( M ) ), HomalgRing( M ) );
    
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
        [ IsHomalgMatrixOverGradedRingRep, IsGradedModuleRep ],
        
  function( A, M )
    
    return UnionOfRelations( UnderlyingMatrixOverNonGradedRing( A ), UnderlyingModule( M ) );
    
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

##
InstallMethod( AffineDimension,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return AffineDimension( UnderlyingModule( M ) );
    
end );

##
InstallMethod( AffineDegree,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return AffineDegree( UnderlyingModule( M ) );
    
end );

##
InstallMethod( ConstantTermOfHilbertPolynomial,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return ConstantTermOfHilbertPolynomial( UnderlyingModule( M ) );
    
end );

##
InstallMethod( IsSubset,
        "for homalg graded submodules",
        [ IsHomalgModule, IsGradedSubmoduleRep ],
        
  function( K, J )  ## GAP-standard: is J a subset of K
    local M, mapJ, mapK, rel, div;
    
    return IsSubset( UnderlyingModule( K ), UnderlyingModule( J ) );
    
end );

##
InstallMethod( Intersect2,
        "for homalg graded submodules",
        [ IsGradedSubmoduleRep, IsGradedSubmoduleRep ],
        
  function( K, J )
    local M, int, map;
    
    M := SuperObject( J );
    
    if not IsIdenticalObj( M, SuperObject( K ) ) then
        Error( "the super objects must coincide\n" );
    fi;
    
    int := Intersect2( UnderlyingModule( K ), UnderlyingModule( J ) );
    
    map := GradedMap( int!.map_having_subobject_as_its_image, "create", M );
    
    return ImageSubobject( map );
    
end );

InstallOtherMethod( SubobjectQuotient,
        "for homalg submodules",
        [ IsGradedSubmoduleRep, IsGradedSubmoduleRep ],
        
  function( K, J )
    local result;
    
    result := SubobjectQuotient( UnderlyingModule( K ), UnderlyingModule( J ) );
    
    result := GradedMap( result!.map_having_subobject_as_its_image, "create", SuperObject( K ) );
    
    return ImageSubobject( result );
    
end );
