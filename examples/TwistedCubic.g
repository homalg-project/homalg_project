LoadPackage( "RingsForHomalg" );

LoadPackage( "Modules" );

R := HomalgFieldOfRationalsInDefaultCAS() * "x,y,z";
I := LeftSubmodule( "y^2-x*z,x*y-z,x^2-y", R );

## Serre's test
e := Ext( 1, I );
ByASmallerPresentation( e );
Assert( 0, IsCyclic( e ) );

## indeed, the *affine* twisted cubic
## is an ideal-theoretic complete intersection
J := LeftSubmodule( "x*y-z,x^2-y", R );
Assert( 0, I = J );
