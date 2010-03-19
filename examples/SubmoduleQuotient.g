LoadPackage( "RingsForHomalg" );

LoadPackage( "homalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";

K := LeftSubmodule( "x*z-y^2,x^2-y", R );

J := LeftSubmodule( "x,y", R );

K_J := SubmoduleQuotient( K, J );
