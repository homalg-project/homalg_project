LoadPackage( "AutoDoc", "2016.02.16" );

AutoDoc( rec( gapdoc := rec( main := "ModulesForHomalg.xml" ) ) );

PrintTo( "VERSION", GAPInfo.PackageInfoCurrent.Version );

QUIT;
