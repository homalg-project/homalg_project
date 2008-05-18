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

DeclareInfoClass( "InfoHomalgBasicOperations" );
SetInfoLevel( InfoHomalgBasicOperations, 1 );

# a central place for configurations:
DeclareGlobalVariable( "HOMALG" );

####################################
#
# categories:
#
####################################

# a new category of objects:

DeclareCategory( "IsContainerForWeakPointers",
        IsComponentObjectRep );

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "ContainerForWeakPointers" );

DeclareGlobalFunction( "homalgTotalRuntimes" );

DeclareGlobalFunction( "LogicalImplicationsForHomalg" );

DeclareGlobalFunction( "InstallLogicalImplicationsForHomalg" );

DeclareGlobalFunction( "homalgNamesOfComponentsToIntLists" );

# basic operations:

DeclareOperation( "homalgLaTeX",
        [ IsObject ] ); 

