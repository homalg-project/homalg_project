LoadPackage("RingsForHomalg");

LoadPackage( "homalg" );

R := HomalgFieldOfRationalsInDefaultCAS() * "x,y,z";

M := HomalgMatrix( "[x,y]", 2, 1, R );

J := LeftSubmodule( M );

conormal := J / J^2;

S := R / M;

C := S * conormal;
