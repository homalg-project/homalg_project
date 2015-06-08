#############################################################################
##
##  LIMOD.gd                    LIMOD subpackage             Mohamed Barakat
##
##         LIMOD = Logical Implications for homalg MODules
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for the LIMOD subpackage.
##
#############################################################################

# our info class:
DeclareInfoClass( "InfoLIMOD" );
SetInfoLevel( InfoLIMOD, 1 );

# a central place for configurations:
DeclareGlobalVariable( "LIMOD" );

####################################
#
# global variables:
#
####################################

DeclareGlobalVariable( "LogicalImplicationsForHomalgModules" );

DeclareGlobalVariable( "LogicalImplicationsForHomalgModulesOverSpecialRings" );

DeclareGlobalFunction( "IsProjectiveOfConstantRankByCheckingFittingsCondition" );

DeclareGlobalFunction( "IsProjectiveByCheckingIfExt1WithValuesInFirstSyzygiesModuleIsZero" );
