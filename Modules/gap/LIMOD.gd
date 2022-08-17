# SPDX-License-Identifier: GPL-2.0-or-later
# Modules: A homalg based package for the Abelian category of finitely presented modules over computable rings
#
# Declarations
#

##         LIMOD = Logical Implications for homalg MODules

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
