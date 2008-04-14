LoadPackage( "RingsForHomalg" );
SetInfoLevel( InfoIO_ForHomalg, 7 );
HOMALG_IO.color_display := true;
m2_stream := LaunchM2( );
init := HomalgExternalObject( "clearEcho stdio", "Macaulay2", m2_stream );
