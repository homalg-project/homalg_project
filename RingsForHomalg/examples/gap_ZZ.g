ReadPackage( "RingsForHomalg", "examples/homalg.g" );
LoadPackage( "RingsForHomalg" );
ZZ := HomalgRingOfIntegersInExternalGAP( );
Display( ZZ );
wmat := imat * ZZ;
W := LeftPresentation( wmat );
