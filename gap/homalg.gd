#############################################################################
##
##  homalg.gd                   homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for homalg.
##
#############################################################################


# our info classes:
DeclareInfoClass( "InfoHomalg" );
SetInfoLevel( InfoHomalg, 1 );

DeclareInfoClass( "InfoHomalgOperations" );
SetInfoLevel( InfoHomalgOperations, 1 );

# a central place for configurations:
DeclareGlobalVariable( "HOMALG" );

DeclareGlobalFunction( "homalgTotalRuntimes" );

DeclareGlobalFunction( "LogicalImplicationsForHomalg" );

DeclareGlobalFunction( "homalgNamesOfComponentsToIntLists" );

