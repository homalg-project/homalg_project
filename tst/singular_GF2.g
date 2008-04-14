LoadPackage( "homalg" );
LoadPackage( "RingsForHomalg" );
HOMALG_IO.color_display := true;
SetInfoLevel( InfoIO_ForHomalg, 7 );
GF2 := RingForHomalgInSingular( "32003,(x,y,z),dp", IsGF2ForHomalgInSingular );
Display( GF2 );
