LoadPackage( "AutoDoc", "2016.02.16" );



Read( "PackageInfo.g" ); 
PrintTo( "VERSION", GAPInfo.PackageInfoCurrent.Version ); 


AutoDoc( rec(
) );


QUIT;
