Read( "ReducedBasisOfModule.g" );

triangle := RHom( C, T );
lecs := LongSequence( triangle );
IsExactSequence( lecs );
Triangle := LTensorProduct( C, T );
lehs := LongSequence( Triangle );
IsExactSequence( lehs );
ByASmallerPresentation( lecs );
homalgResetFilters( lecs );
IsExactSequence( lecs );
ByASmallerPresentation( lehs );
homalgResetFilters( lehs );
IsExactSequence( lehs );
