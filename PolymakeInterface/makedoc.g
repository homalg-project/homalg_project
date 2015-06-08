#
# Generate the manual using AutoDoc
#
LoadPackage("AutoDoc", "2014.03.04");

AutoDoc("PolymakeInterface" : scaffold := true,
        autodoc := rec(
            files := [
                    "doc/Intro.autodoc",
                    ]
            )
     );

PrintTo("VERSION", PackageInfo("PolymakeInterface")[1].Version);

QUIT;