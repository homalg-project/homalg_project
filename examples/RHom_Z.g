LoadPackage( "RingsForHomalg" );

LoadPackage( "homalg" );

## Define the ring of integers:
R := HomalgRingOfIntegersInDefaultCAS( );
#Display( R );
m := HomalgMatrix( "[ 8, 0,    0, 2 ]", 2, 2, R );
#Display( m );
M := LeftPresentation( m );
#Display( M );
a := HomalgMatrix( "[ 2, 0 ]", 1, 2, R );
alpha := HomalgMap( a, "free", M );
pi := CokernelEpi( alpha );
#Display( pi );
iota := KernelEmb( pi );
#Display( iota );
N := Kernel( pi );
#Display( N );
C := HomalgComplex( pi );
Add( C, iota );
ByASmallerPresentation( C );
#Display( C );
T := RHom( C, N );
ByASmallerPresentation( T );
L := LongSequence( T );
#Display( L );
IsExactSequence( L );
#L;
