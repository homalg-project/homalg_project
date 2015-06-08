LoadPackage( "RingsForHomalg" );

Q := HomalgFieldOfRationalsInDefaultCAS();
R := Q * "x,y,z";
D := RingOfDerivations( R, "Dx,Dy,Dz" );
