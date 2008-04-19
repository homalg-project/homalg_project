LoadPackage( "homalg" );
LoadPackage( "RingsForHomalg" );
HOMALG_IO.color_display := true;
ZZ := HomalgRingOfIntegersInExternalGAP( );
Display( ZZ );
wmat := HomalgMatrix( imat, ZZ );
W := LeftPresentation( wmat );
