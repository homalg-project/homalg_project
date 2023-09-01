ReadPackage( "RingsForHomalg", "examples/homalg.g" );
LoadPackage( "RingsForHomalg" );
zz := HomalgRingOfIntegersInExternalGAP( );
Display( zz );
wmat := imat * zz;
W := LeftPresentation( wmat );
