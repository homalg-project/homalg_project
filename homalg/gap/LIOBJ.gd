# SPDX-License-Identifier: GPL-2.0-or-later
# homalg: A homological algebra meta-package for computable Abelian categories
#
# Declarations
#

##         LIOBJ = Logical Implications for homalg static OBJects

# our info class:
DeclareInfoClass( "InfoLIOBJ" );
SetInfoLevel( InfoLIOBJ, 1 );

# a central place for configurations:
DeclareGlobalVariable( "LIOBJ" );

####################################
#
# global variables:
#
####################################

DeclareGlobalVariable( "LogicalImplicationsForHomalgStaticObjects" );

DeclareGlobalFunction( "IsProjectiveByCheckingForASplit" );
