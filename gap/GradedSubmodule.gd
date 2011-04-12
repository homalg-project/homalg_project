#############################################################################
##
##  GradedSubmodule.gd             Graded Modules package
##
##  Copyright 2010,      Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Declaration stuff for graded submodules.
##
#############################################################################

DeclareOperation( "GradedLeftSubmodule",
        [ IsHomalgMatrix ] );

DeclareOperation( "GradedLeftSubmodule",
        [ IsHomalgRing ] );

DeclareOperation( "GradedLeftSubmodule",
        [ IsList ] );

DeclareOperation( "GradedLeftSubmodule",
        [ IsList, IsHomalgRing ] );

DeclareOperation( "GradedRightSubmodule",
        [ IsHomalgMatrix ] );

DeclareOperation( "GradedRightSubmodule",
        [ IsHomalgRing ] );

DeclareOperation( "GradedRightSubmodule",
        [ IsList ] );

DeclareOperation( "GradedRightSubmodule",
        [ IsList, IsHomalgRing ] );

DeclareOperation( "GradedLeftIdealOfMinors",
        [ IsInt, IsHomalgMatrix ] );

DeclareOperation( "GradedLeftIdealOfMaximalMinors",
        [ IsHomalgMatrix ] );

DeclareOperation( "GradedRightIdealOfMinors",
        [ IsInt, IsHomalgMatrix ] );

DeclareOperation( "GradedRightIdealOfMaximalMinors",
        [ IsHomalgMatrix ] );

DeclareOperation( "MaximalGradedLeftIdeal",
        [ IsHomalgGradedRing ] );

DeclareOperation( "MaximalGradedRightIdeal",
        [ IsHomalgGradedRing ] );
