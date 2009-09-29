LoadPackage( "Sheaves" );

R := HomalgFieldOfRationalsInSingular() * "x,y,z";
C := GradedRightSubmodule( "y^2 * z - (x+z) * x * (x-z)", R );
C := Scheme( C );
Degree( C );
Dimension( C );
ArithmeticGenus( C );
