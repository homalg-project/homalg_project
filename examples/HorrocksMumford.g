LoadPackage( "GradedRingForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x0..x4";

S := GradedRing( R );

A := KoszulDualRing( S, "e0..e4" );

LoadPackage( "GradedModules" );

## [EFS, Example 7.3]:
## A famous Beilinson monad was discovered by Horrocks and Mumford [HM]:

mat := HomalgMatrix( "[ \
e1*e4, e2*e0, e3*e1, e4*e2, e0*e3, \
e2*e3, e3*e4, e4*e0, e0*e1, e1*e2  \
]",
2, 5, A );

L := RightPresentationWithDegrees( mat );

phi := GradedMap( mat, "free", "free", "left", A );

IsMorphism( phi );

M := ExteriorAlgebraMapToModule( 2, phi );
