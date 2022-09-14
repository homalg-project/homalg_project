ReadPackage( "RingsForHomalg", "examples/homalg.g" );
LoadPackage( "RingsForHomalg" );
ZZ := HomalgRingOfIntegersInMAGMA( );
Display( ZZ );
wmat := imat * ZZ;
W := LeftPresentation( wmat );
