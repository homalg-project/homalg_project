# SPDX-License-Identifier: GPL-2.0-or-later
# GradedModules: A homalg based package for the Abelian category of finitely presented graded modules over computable graded rings
#
# Declarations
#

##  Declarations of procedures for ring maps.

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "SegreMap",
        [ IsHomalgRing, IsString ] );

DeclareOperation( "PlueckerMap",
        [ IsInt, IsInt, IsHomalgRing, IsString ] );

DeclareOperation( "VeroneseMap",
        [ IsInt, IsInt, IsHomalgRing, IsString ] );

