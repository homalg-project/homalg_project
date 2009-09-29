LoadPackage( "Sheaves" );

R := HomalgFieldOfRationalsInSingular() * "x,y,z,w";
CL := GradedRightSubmodule( "y*w-x^2,z*w^2-x^3", R );
C := Saturate( CL, GradedRightSubmodule( "x,w", R ) );
CL := Scheme( CL );
C := Scheme( C );
Degree( C );
Dimension( C );
ArithmeticGenus( C );
