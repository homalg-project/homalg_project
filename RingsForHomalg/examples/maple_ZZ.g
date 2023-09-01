ReadPackage( "RingsForHomalg", "examples/homalg.g" );
LoadPackage( "RingsForHomalg" );
zz := HomalgRingOfIntegersInMaple( );
Display( zz );
wmat := imat * zz;
W := LeftPresentation( wmat );
