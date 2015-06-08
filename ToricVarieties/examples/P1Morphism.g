LoadPackage( "ToricVarieties" );

F := Fan( [[[1]],[[-1]]] );

T:= ToricVariety( F );

M :=ToricMorphism( T, [[-1]], T );

TorusInvariantDivisorGroup( T );

#MorphismOnWeilDivisorGroup( M );

ClassGroup( T );

#MorphismOnClassGroup( M );