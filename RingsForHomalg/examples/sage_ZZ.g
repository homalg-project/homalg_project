ReadPackage( "RingsForHomalg", "examples/homalg.g" );
LoadPackage( "RingsForHomalg" );
zz := HomalgRingOfIntegersInSage( );
Display( zz );
wmat := imat * zz;
W := LeftPresentation( wmat );
