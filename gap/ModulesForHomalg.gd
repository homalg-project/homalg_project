#############################################################################
##
##  ModulesForHomalg.gd         Modules package              Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Declaration stuff for the package Modules.
##
#############################################################################


# our info classes:
DeclareInfoClass( "InfoModulesForHomalg" );
SetInfoLevel( InfoModulesForHomalg, 1 );

# a central place for configurations:
DeclareGlobalVariable( "HOMALG_MODULES" );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "HomalgRing",
        [ IsHomalgObjectOrMorphism ] );

DeclareOperation( "BasisOfModule",
        [ IsHomalgObjectOrMorphism ] );

DeclareOperation( "OnLessGenerators",
        [ IsHomalgObjectOrMorphism ] );

