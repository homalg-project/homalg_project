#
# LoopIntegrals
#
# This file is a script which compiles the package manual.
#

if fail = LoadPackage("AutoDoc", "2019.05.20") then
    Error("AutoDoc version 2019.05.20 or newer is required.");
fi;

AutoDoc(rec(
    gapdoc := rec(
        LaTeXOptions := rec(
            LateExtraPreamble := """
                \usepackage{amsmath}
                \usepackage[T1]{fontenc}
                \usepackage{tikz}
                \usetikzlibrary{shapes,arrows,matrix}
                \usepackage{faktor}
                """
        ),
    ),
    scaffold := rec(
        entities := [ "GAP4", "CAP" ],
    ),
    autodoc := rec( ),
    extract_examples := rec( units := "Single" ),
    maketest := rec( folder := ".",
                     commands :=
                       [ "LoadPackage( \"4ti2Interface\" );",
                       ]
                      ),
));

QUIT;
