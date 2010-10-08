Read( "ReducedBasisOfModule.g" );

triangle := RHom( C, T );
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

Display( TimeToString( homalgTime( Qxyz ) ) );
