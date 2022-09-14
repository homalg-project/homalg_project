ReadPackage( "RingsForHomalg", "examples/homalg.g" );
LoadPackage( "RingsForHomalg" );
ZZ := HomalgRingOfIntegersInSage( );
Display( ZZ );
wmat := imat * ZZ;
W := LeftPresentation( wmat );
