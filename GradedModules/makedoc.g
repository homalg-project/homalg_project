LoadPackage( "AutoDoc", "2016.02.16" );

AutoDoc( rec( gapdoc := rec( main := "GradedModulesForHomalg.xml" ) ) );

PrintTo( "VERSION", GAPInfo.PackageInfoCurrent.Version );

QUIT;
