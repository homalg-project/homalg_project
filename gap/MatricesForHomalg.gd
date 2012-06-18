#############################################################################
##
##  MatricesForHomalg.gd                           MatricesForHomalg package
##
##  Copyright 2007-2012, Mohamed Barakat, University of Kaiserslautern
##                  Markus Lange-Hegermann, RWTH-Aachen University
##
##  Declarations for MatricesForHomalg.
##
#############################################################################


# our info classes:
DeclareInfoClass( "InfoMatricesForHomalg" );
SetInfoLevel( InfoMatricesForHomalg, 1 );

DeclareInfoClass( "InfoHomalgBasicOperations" );
SetInfoLevel( InfoHomalgBasicOperations, 1 );

# a central place for configurations:
DeclareGlobalVariable( "HOMALG_MATRICES" );

####################################
#
# categories:
#
####################################

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "homalgMode" );
