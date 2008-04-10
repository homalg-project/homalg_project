LoadPackage( "homalg" );
LoadPackage( "RingsForHomalg" );
HOMALG_RINGS.color_display := true;
ZZ := HomalgRingOfIntegersInSage( );
Display( ZZ );
wmat := HomalgMatrix( imat, ZZ );
W := LeftPresentation( wmat );
