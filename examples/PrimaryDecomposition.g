LoadPackage( "RingsForHomalg" );

R := HomalgFieldOfRationalsInSingular( ) * "x,y";

LoadPackage( "Modules" );

I := LeftSubmodule( "x", R );
J := LeftSubmodule( "x,y", R );

K := I * J;

pp := PrimaryDecomposition( K );
