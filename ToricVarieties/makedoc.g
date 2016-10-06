LoadPackage( "AutoDoc", "2016.02.16" );



Read( "PackageInfo.g" ); 
PrintTo( "VERSION", GAPInfo.PackageInfoCurrent.Version ); 


AutoDoc( rec(
    autodoc := false,
    gapdoc := rec( scan_dirs := [ "gap", "examples/examplesmanual" ] ),
));


QUIT;
