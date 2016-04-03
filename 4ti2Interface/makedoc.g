LoadPackage( "AutoDoc", "2016.02.16" );

AutoDoc( rec( scaffold := true ) );

PrintTo( "VERSION", GAPInfo.PackageInfoCurrent.Version );

QUIT;
