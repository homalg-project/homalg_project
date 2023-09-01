LoadPackage( "Modules" );

zz := HomalgRingOfIntegers( );

C0 := HomalgComplex( 3 * zz );

Add( C0, HomalgMatrix( "[ 0, 1, 0,   0, 0, 1,   0, 0, 0,   0, 0, 0 ]", 4, 3, zz ) );

C1 := HomalgComplex( 0 * zz );

Add( C1, 2 * zz );

cm := HomalgChainMorphism( HomalgZeroMatrix( 3, 0, zz ), C0, C1 );

Add( cm, HomalgMatrix( "[ -1, 0,   0, -1,   2, 0,   0, 12 ]", 4, 2, zz ) );

C := HomalgCocomplex( cm );

Assert( 0, IsComplex( C ) );

BC := HomalgBicomplex( C );

tBC := TransposedBicomplex( BC );
