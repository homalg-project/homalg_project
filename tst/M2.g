LoadPackage( "RingsForHomalg" );
SetInfoLevel( InfoRingsForHomalg, 7 );
HOMALG_RINGS.color_display := true;
m2_stream := LaunchM2( );
init := HomalgExternalObject( "clearEcho stdio", "Macaulay2", m2_stream );
