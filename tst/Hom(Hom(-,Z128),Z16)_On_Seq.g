LoadPackage( "homalg" );

R := HomalgRingOfIntegers( ) / 2^8;

M := LeftPresentation( [ 2^5 ], R );
_M := LeftPresentation( [ 2^3 ], R );
alpha2 := HomalgMap( [ 1 ], M, _M );
M_ := Kernel( alpha2 );
alpha1 := KernelEmb( alpha2 );
seq := HomalgComplex( alpha2 );
Add( seq, alpha1 );
IsShortExactSequence( seq );
K := LeftPresentation( [ 2^7 ], R );
L := RightPresentation( [ 2^4 ], R );

triangle := LHomHom( 4, seq, K, L, "t" );
lehs := LongSequence( triangle );
ByASmallerPresentation( lehs );

IsExactSequence( lehs );
