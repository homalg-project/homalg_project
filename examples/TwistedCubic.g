LoadPackage( "RingsForHomalg" );

LoadPackage( "Modules" );

R := HomalgFieldOfRationalsInDefaultCAS() * "x,y,z,w";
T := Saturate( RightSubmodule( "y*w-x^2,z*w^2-x^3", R ), RightSubmodule( "x,w", R ) );
