LoadPackage( "homalg" );
LoadPackage( "RingsForHomalg" );
HOMALG_IO.color_display := true;
ZZ := HomalgRingOfIntegersInMaple( );
Display( ZZ );
wmat := HomalgMatrix( imat, ZZ );
W := LeftPresentation( wmat );
