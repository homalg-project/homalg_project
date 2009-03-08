LoadPackage( "homalg" );

ZZ := HomalgRingOfIntegers( );

F := 1 * ZZ;
T := 0 * ZZ;

lambda := HomalgMap( "[ 2 ]", F, F );
id := HomalgIdentityMap( F, F );
zz := HomalgZeroMap( T, T );
zf := HomalgZeroMap( T, F );
fz := HomalgZeroMap( F, T );

C0 := HomalgComplex( zz, -1 );
Add( C0, fz );
Add( C0, lambda );

C1 := HomalgComplex( fz, -1 );

Add( C1, lambda );
Add( C1, zf );

C2 := HomalgComplex( lambda, -1 );

Add( C2, zf );
Add( C2, zz );

c1 := HomalgChainMap( zz, C1, C0 );

Add( c1, fz );
Add( c1, id );
Add( c1, zf );

c2 := HomalgChainMap( fz, C2, C1 );

Add( c2, id );
Add( c2, zf );
Add( c2, zz );

C := HomalgComplex( c1 );

Add( C, c2 );

BC := HomalgBicomplex( C );

tot := TotalComplex( BC );

## the second spectral sequence together with
## the collapsed first spectral sequence
I_E := HomalgSpectralSequence( BC, 1 );
AddSpectralFiltrationOfTotalDefects( I_E, [ 0 ] );

filt := FiltrationBySpectralSequence( I_E, 0 );

ByASmallerPresentation( filt );

m := IsomorphismOfFiltration( filt );
