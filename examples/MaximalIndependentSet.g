LoadPackage( "RingsForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "a,b,c,d,e,f,g,h";

LoadPackage( "Modules" );

I :=LeftSubmodule( "abc,bcd,cde,adf,cgh,b3f,a3g", R );

u := MaximalIndependentSet( I );

Assert( 0, u = [ "a" / R, "b" / R, "d" / R, "e" / R, "h" / R ] );
