LoadPackage( "RingsForHomalg" );

SetAssertionLevel( 4 );

LoadPackage( "LocalizeRingForHomalg" );

GlobalR := HomalgRingOfIntegersInExternalGAP(  );

R := LocalizeAt( GlobalR , [ 2 ] );

M := HomalgMatrix( [ 2^5 ], GlobalR );
_M := HomalgMatrix( [ 2^3 ], GlobalR );
M := HomalgLocalMatrix( M , R );
_M := HomalgLocalMatrix( _M , R );
M := LeftPresentation( M );
_M := LeftPresentation( _M );

alpha2 := HomalgMap( HomalgLocalMatrix( HomalgMatrix( [ 1 ] , GlobalR ) , R ) , M, _M );
M_ := Kernel( alpha2 );
alpha1 := KernelEmb( alpha2 );
seq := HomalgComplex( alpha2 );
Add( seq, alpha1 );
IsShortExactSequence( seq );

K := HomalgMatrix( [ 2^7 ], GlobalR );
L := HomalgMatrix( [ 2^4 ], GlobalR );
K := HomalgLocalMatrix( K, R );
L := HomalgLocalMatrix( L, R );
K := LeftPresentation( K );
L := RightPresentation( L );

triangle := LHomHom( 4, seq, K, L, "t" );
lehs := LongSequence( triangle );
ByASmallerPresentation( lehs );

IsExactSequence( lehs );
