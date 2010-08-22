LoadPackage( "RingsForHomalg" );

LoadPackage( "Modules" );

R := HomalgFieldOfRationalsInSingular() * "x,y,z,w";
T := Saturate( GradedRightSubmodule( "y*w-x^2,z*w^2-x^3", R ), GradedRightSubmodule( "x,w", R ) );
