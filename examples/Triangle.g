Read( "ReducedBasisOfModule.g" );

triangle := RGradedHom( C, T );
lecs := LongSequence( triangle );
IsExactSequence( lecs );
Triangle := LTensorProduct( C, T );
lehs := LongSequence( Triangle );
IsExactSequence( lehs );
ByASmallerPresentation( lecs );
homalgResetFilters( lecs );
Assert( 0, IsExactSequence( lecs ) );
ByASmallerPresentation( lehs );
homalgResetFilters( lehs );
Assert( 0, IsExactSequence( lehs ) );

Display( StringTime( homalgTime( Qxyzt ) ) );
