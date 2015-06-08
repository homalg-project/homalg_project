LoadPackage( "RingsForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x0,x1";

LoadPackage( "GradedRingForHomalg" );

R := GradedRing( R );

A := KoszulDualRing( R );

m := HomalgMatrix( "[ e0, e1, 0,  0, e0, e1 ]", 2, 3, A );
