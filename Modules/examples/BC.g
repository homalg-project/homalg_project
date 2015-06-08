LoadPackage( "Modules" );

ZZ := HomalgRingOfIntegers( );

C0 := HomalgComplex( 3 * ZZ );

Add( C0, HomalgMatrix( "[ 0, 1, 0,   0, 0, 1,   0, 0, 0,   0, 0, 0 ]", 4, 3, ZZ ) );

C1 := HomalgComplex( 0 * ZZ );

Add( C1, 2 * ZZ );

cm := HomalgChainMorphism( HomalgZeroMatrix( 3, 0, ZZ ), C0, C1 );

Add( cm, HomalgMatrix( "[ -1, 0,   0, -1,   2, 0,   0, 12 ]", 4, 2, ZZ ) );

C := HomalgCocomplex( cm );

Assert( 0, IsComplex( C ) );

BC := HomalgBicomplex( C );

tBC := TransposedBicomplex( BC );
