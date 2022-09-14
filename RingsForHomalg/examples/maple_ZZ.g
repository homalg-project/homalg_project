ReadPackage( "RingsForHomalg", "examples/homalg.g" );
LoadPackage( "RingsForHomalg" );
ZZ := HomalgRingOfIntegersInMaple( );
Display( ZZ );
wmat := imat * ZZ;
W := LeftPresentation( wmat );
