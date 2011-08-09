## Bahman Engheta's Thesis: Bounds on Projective Dimension, Example 1.5
LoadPackage( "RingsForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "a,b,c,d,e,f";

LoadPackage( "Modules" );

I := LeftSubmodule( "a*c*e, b*d*f, a*b*c*d + a*b*e*f + c*d*e*f", R );

M := FactorObject( I );

Assert( 0, ProjectiveDimension( M ) = 5 );
