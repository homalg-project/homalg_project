LoadPackage( "Modules" );

ZZ := HomalgRingOfIntegers( );

F := 1 * ZZ;
T := 0 * ZZ;

lambda := HomalgMatrix( "[ 2 ]", 1, 1, ZZ );
lambda := HomalgMap( lambda, F, F );
id := HomalgIdentityMap( F, F );
zz := HomalgZeroMap( T, T );
zf := HomalgZeroMap( T, F );
fz := HomalgZeroMap( F, T );

C_2 := HomalgComplex( zz, 1 );
Add( C_2, fz );
Add( C_2, lambda );

C_1 := HomalgComplex( fz, 1 );

Add( C_1, -lambda );
Add( C_1, zf );

C_0 := HomalgComplex( lambda, 1 );

Add( C_0, zf );
Add( C_0, zz );

c_1 := HomalgChainMorphism( zz, C_1, C_2 );

Add( c_1, fz );
Add( c_1, id );
Add( c_1, zf );

c_0 := HomalgChainMorphism( fz, C_0, C_1 );

Add( c_0, id );
Add( c_0, zf );
Add( c_0, zz );

C := HomalgComplex( c_1, -1 );

Add( C, c_0 );

Assert( 0, IsComplex( C ) );

BC := HomalgBicomplex( C );

tBC := TransposedBicomplex( BC );

Tot := TotalComplex( BC );

## converges after 1 step
I_E := SpectralSequenceWithFiltrationOfCollapsedToZeroTransposedSpectralSequence( BC );

filt := FiltrationBySpectralSequence( I_E, 0 );

ByASmallerPresentation( filt );

m := IsomorphismOfFiltration( filt );
