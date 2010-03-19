LoadPackage( "RingsForHomalg" );

LoadPackage( "homalg" );

Zx := HomalgRingOfIntegersInDefaultCAS( ) * "x";

ZIQ5 := Zx / "x^2 + 5";

SetIsDedekindDomain( ZIQ5, true );
SetIsPrincipalIdealRing( ZIQ5, false );

P2 := HomalgMatrix( "[ 2 ]", 1, 1, ZIQ5 );
P2 := LeftSubmodule( P2 );

P3 := HomalgMatrix( "[ 3 ]", 1, 1, ZIQ5 );
P3 := LeftSubmodule( P3 );

PP := HomalgMatrix( "[ 1 + x ]", 1, 1, ZIQ5 );
PP := LeftSubmodule( PP );

QQ := HomalgMatrix( "[ 1 - x ]", 1, 1, ZIQ5 );
QQ := LeftSubmodule( QQ );

P6 := HomalgMatrix( "[ 6 ]", 1, 1, ZIQ5 );
P6 := LeftSubmodule( P6 );

J := HomalgMatrix( "[ 2, 1 + x ]", 2, 1, ZIQ5 );
J := LeftSubmodule( J );

K := HomalgMatrix( "[ 3, 1 + x ]", 2, 1, ZIQ5 );
K := LeftSubmodule( K );

L := HomalgMatrix( "[ 3, 1 - x ]", 2, 1, ZIQ5 );
L := LeftSubmodule( L );

Display( P2 = J^2 );
Display( P3 = K * L );
Display( PP = K * J );
Display( QQ = L * J );
