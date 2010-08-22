LoadPackage( "RingsForHomalg" );

LoadPackage( "Modules" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";

J := LeftSubmodule( "x*z-y^2,x^2-y", R );

I := LeftSubmodule( "x,y", R );

J_I := SubmoduleQuotient( J, I );
