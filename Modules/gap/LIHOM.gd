# SPDX-License-Identifier: GPL-2.0-or-later
# Modules: A homalg based package for the Abelian category of finitely presented modules over computable rings
#
# Declarations
#

##  Declaration stuff for the LIHOM subpackage.

# our info class:
DeclareInfoClass( "InfoLIHOM" );
SetInfoLevel( InfoLIHOM, 1 );

# a central place for configurations:
DeclareGlobalVariable( "LIHOM" );

####################################
#
# global variables:
#
####################################

DeclareGlobalVariable( "LogicalImplicationsForHomalgMaps" );

DeclareGlobalVariable( "LogicalImplicationsForHomalgSelfMaps" );
