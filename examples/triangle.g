Read( "ReducedBasisOfModule.g" );

triangle := RHom( 3, C, T, "t" );
lecs := LongSequence( triangle );
IsExactSequence( lecs );
Triangle := LTensorProduct( 4, C, T, "t" );
lehs := LongSequence( Triangle );
IsExactSequence( lehs );
