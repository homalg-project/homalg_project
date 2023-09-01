ReadPackage( "RingsForHomalg", "examples/homalg.g" );
LoadPackage( "RingsForHomalg" );
zz := HomalgRingOfIntegersInMAGMA( );
Display( zz );
wmat := imat * zz;
W := LeftPresentation( wmat );
