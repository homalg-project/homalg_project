LoadPackage( "RingsForHomalg" );

LoadPackage( "homalg" );

Zx := HomalgRingOfIntegersInDefaultCAS( ) * "x";

R := Zx / "x^2 + 5";

I := HomalgMatrix( "[ 2, 1+x ]", 2, 1, R );

I := LeftSubmodule( I );

M := UnderlyingObject( I );

e := FreeHullEpi( M );

s := PreInverse( e );

a := PreCompose( s, e );

IsIsomorphism( a );

DecideZero( a );

N := Hom( R, M );

f := FreeHullEpi( N );

t := PreInverse( f );

b := PreCompose( t, f );

IsIsomorphism( b );

DecideZero( b );

