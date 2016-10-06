#
# Generate the manual using AutoDoc
#
LoadPackage( "AutoDoc", "2016.02.16" );



Read( "PackageInfo.g" ); 
PrintTo( "VERSION", GAPInfo.PackageInfoCurrent.Version ); 


AutoDoc( rec( scaffold := true,
        autodoc := rec(
            files := [
                    "doc/Intro.autodoc",
                    ]
            )
     ) );


QUIT;