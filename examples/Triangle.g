Read( "homalg.g" );

SetAssertionLevel( 4 );

iota := TorsionSubobjectEmb( M );
pi := TorsionFreeFactorEpi( M );

C := HomalgComplex( pi );
Add( C, iota );

T := TorsionSubobject( M );

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
