LoadPackage( "homalg" );
LoadPackage( "RingsForHomalg" );
HOMALG_RINGS.color_display := true;
SetInfoLevel( InfoRingsForHomalg, 7 );
GF2 := RingForHomalgInSingular( "32003,(x,y,z),dp", IsGF2ForHomalgInSingular );
Display( GF2 );
