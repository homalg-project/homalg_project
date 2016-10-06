#############################################################################
##
##  makedoc.g           ToricVarieties package
##                      Sebastian Gutsche
##                      Martin Bies
##
##  Copyright 2011-2016 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  A package to handle toric varieties
##
#############################################################################

LoadPackage( "AutoDoc" );

AutoDoc( "ToricVarieties" : scaffold := true, autodoc :=
             rec( files := [ "doc/Intros.autodoc",
                         "gap/ToricVarieties.gd",
                         "examples/examplesmanual/Hirzebruch5.g",
                         #"examples/examplesmanual/RationalNormalCone.g",
                         "gap/ToricSubvarieties.gd",
                         "gap/AffineToricVarieties.gd",
                         "examples/examplesmanual/AffineSpace.g",
                         "gap/ProjectiveToricVarieties.gd",
                         "examples/examplesmanual/P1P1.g",
                         "gap/ToricMorphisms.gd",
                         "examples/examplesmanual/Morphism.g",
                         "gap/ToricDivisors.gd",
                         "examples/examplesmanual/Divisors.g",
                         ],
             scan_dirs := []
             ),
         maketest := rec( folder := ".",
                          commands :=
                            [ "LoadPackage( \"IO_ForHomalg\" );",
                              "LoadPackage( \"GaussForHomalg\" );",
                              "LoadPackage( \"ToricVarieties\" );",
                              "HOMALG_IO.show_banners := false;",
                              "HOMALG_IO.suppress_PID := true;",
                              "HOMALG_IO.use_common_stream := true;",
                             ]
                           )
);

QUIT;
