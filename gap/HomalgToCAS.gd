#############################################################################
##
##  HomalgToCAS.gd           HomalgToCAS package             Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for HomalgToCAS.
##
#############################################################################


# our info class:
DeclareInfoClass( "InfoHomalgToCAS" );
SetInfoLevel( InfoHomalgToCAS, 1 );

# a central place for configurations:
DeclareGlobalVariable( "HOMALG_IO" );

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "FigureOutAnAlternativeDirectoryForTemporaryFiles" );

DeclareGlobalFunction( "homalgTime" );

DeclareGlobalFunction( "homalgMemoryUsage" );

DeclareGlobalFunction( "homalgIOMode" );
