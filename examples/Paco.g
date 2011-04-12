LoadPackage( "GradedModules" );

S := GradedRing( HomalgFieldOfRationalsInSingular( ) * "x0..2" );

I := LeftSubmodule ( "x0*x1^2-x2^3", S );

J := I + LeftSubmodule( "x0^10", S );

M := FactorObject( J );

A := KoszulDualRing( S, "e0..2" );
