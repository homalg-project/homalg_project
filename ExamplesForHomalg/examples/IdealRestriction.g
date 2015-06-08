LoadPackage("RingsForHomalg");

LoadPackage( "Modules" );

R := HomalgFieldOfRationalsInDefaultCAS() * "x,y,z";

M := HomalgMatrix( "[x,y]", 2, 1, R );

I := LeftSubmodule( M );

conormal := I / I^2;

S := R / M;

C := S * conormal;
