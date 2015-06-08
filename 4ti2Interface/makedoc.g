LoadPackage( "AutoDoc" );

AutoDoc( "4ti2Interface" : scaffold := true );

PrintTo( "VERSION", PackageInfo( "4ti2Interface" )[1].Version );

QUIT;
