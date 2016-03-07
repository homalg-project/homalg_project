LoadPackage( "AutoDoc", "2016.02.16" );

AutoDoc( rec(
    autodoc := false,
    gapdoc := rec( scan_dirs := [ "gap", "examples/examplesmanual" ] ),
));

PrintTo( "VERSION", GAPInfo.PackageInfoCurrent.Version );

QUIT;
