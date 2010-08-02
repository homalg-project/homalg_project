Read( "homalg.g" );

iota := TorsionObjectEmb( M );
pi := TorsionFreeFactorEpi( M );

C := HomalgComplex( pi );
Add( C, iota );

T := TorsionObject( M );

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
