# SPDX-License-Identifier: GPL-2.0-or-later
# GradedModules: A homalg based package for the Abelian category of finitely presented graded modules over computable graded rings
#
# Declarations
#

##  Declaration stuff for graded submodules.

####################################
#
# attributes:
#
####################################

DeclareAttribute( "MaximalGradedLeftIdeal",
        IsHomalgGradedRing );

DeclareAttribute( "MaximalGradedRightIdeal",
        IsHomalgGradedRing );

DeclareAttribute( "ResidueClassRingAsGradedLeftModule",
        IsHomalgGradedRing );

DeclareAttribute( "ResidueClassRingAsGradedRightModule",
        IsHomalgGradedRing );

DeclareAttribute( "JacobianIdeal",
        IsHomalgModule );

DeclareAttribute( "JacobianIdeal",
        IsHomalgRingElement );

####################################
#
# global functions and operations:
#
####################################

# basic operations

DeclareOperation( "GradedLeftSubmodule",
        [ IsHomalgMatrix ] );

DeclareOperation( "GradedLeftSubmodule",
        [ IsHomalgRing ] );

DeclareOperation( "GradedLeftSubmodule",
        [ IsList ] );

DeclareOperation( "GradedLeftSubmodule",
        [ IsHomalgRingElement ] );

DeclareOperation( "GradedLeftSubmodule",
        [ IsList, IsHomalgRing ] );

DeclareOperation( "GradedRightSubmodule",
        [ IsHomalgMatrix ] );

DeclareOperation( "GradedRightSubmodule",
        [ IsHomalgRing ] );

DeclareOperation( "GradedRightSubmodule",
        [ IsList ] );

DeclareOperation( "GradedRightSubmodule",
        [ IsHomalgRingElement ] );

DeclareOperation( "GradedRightSubmodule",
        [ IsList, IsHomalgRing ] );

DeclareOperation( "GradedLeftIdealOfMinors",
        [ IsInt, IsHomalgMatrix ] );

DeclareOperation( "GradedLeftIdealOfMaximalMinors",
        [ IsHomalgMatrix ] );

DeclareOperation( "GradedRightIdealOfMinors",
        [ IsInt, IsHomalgMatrix ] );

DeclareOperation( "GradedRightIdealOfMaximalMinors",
        [ IsHomalgMatrix ] );
