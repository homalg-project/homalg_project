#
# Generate the manual using AutoDoc
#
LoadPackage( "AutoDoc", "2016.02.16" );

AutoDoc( rec( scaffold := true,
        autodoc := rec(
            files := [
                    "doc/Intro.autodoc",
                    ]
            )
     ) );

PrintTo( "VERSION", GAPInfo.PackageInfoCurrent.Version );

QUIT;