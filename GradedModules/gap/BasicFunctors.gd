# SPDX-License-Identifier: GPL-2.0-or-later
# GradedModules: A homalg based package for the Abelian category of finitely presented graded modules over computable graded rings
#
# Declarations
#

##  Declaration stuff for basic functors of graded modules and maps.

####################################
#
# global variables:
#
####################################

####################################
#
# global functions and operations:
#
####################################

# basic operations:
 
DeclareOperation( "BaseChange_OnGradedModules",
                 [ IsHomalgRing, IsHomalgMap ] );

DeclareOperation( "GradedHom",
        [ IsHomalgObject, IsHomalgObject ] );

DeclareOperation( "GradedExt",
        [ IsInt, IsHomalgObject, IsHomalgObject ] );
