LoadPackage( "RingsForHomalg" );
LoadPackage( "Modules" );

Q := HomalgFieldOfRationalsInSingular( );
S := Q * "x,y,z";
R := S / "x*y";

AssignGeneratorVariables( R );

a := x+1;
b := x*z;

Assert( 0, IsRegularSequence( [ a, b ], 1 * R ) );
Assert( 0, not IsRegularSequence( [ b, a ], 1 * R ) );
