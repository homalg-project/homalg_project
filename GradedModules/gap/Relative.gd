# SPDX-License-Identifier: GPL-2.0-or-later
# GradedModules: A homalg based package for the Abelian category of finitely presented graded modules over computable graded rings
#
# Declarations
#

##  Declarations of procedures for the relative situation.

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "RelativeRepresentationMapOfKoszulId",
        [ IsHomalgModule, IsHomalgRing ] );

DeclareOperation( "RelativeRepresentationMapOfKoszulId",
        [ IsHomalgModule ] );

DeclareOperation( "DegreeZeroSubcomplex",
        [ IsHomalgComplex, IsHomalgRing ] );

DeclareOperation( "DegreeZeroSubcomplex",
        [ IsHomalgComplex ] );

