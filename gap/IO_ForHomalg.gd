#############################################################################
##
##  IO_ForHomalg.gd           IO_ForHomalg package           Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for IO_ForHomalg.
##
#############################################################################


# our info class:
DeclareInfoClass( "InfoHomalgToCAS" );
SetInfoLevel( InfoHomalgToCAS, 1 );

# a central place for configurations:
DeclareGlobalVariable( "HOMALG_IO" );

####################################
#
# global functions and methods:
#
####################################

DeclareGlobalFunction( "FigureOutAnAlternativeDirectoryForTemporaryFiles" );

DeclareGlobalFunction( "homalgIOMode" );
