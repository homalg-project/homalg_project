LoadPackage("RingsForHomalg");

R := HomalgFieldOfRationalsInDefaultCAS() * "x,y,z";

M := HomalgMatrix( "[x,y]", 2, 1, R );

J := LeftSubmodule( M );

conormal := J / J^2;

S := R / HomalgRelationsForLeftModule( M );

C := S * conormal;
