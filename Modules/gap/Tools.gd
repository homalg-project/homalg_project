# SPDX-License-Identifier: GPL-2.0-or-later
# Modules: A homalg based package for the Abelian category of finitely presented modules over computable rings
#
# Declarations
#

##  Declarations of tool procedures.

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "IntersectWithSubalgebra",
        [ IsHomalgModule, IsList ] );

DeclareOperation( "IntersectWithSubalgebra",
        [ IsHomalgModule, IsRingElement ] );

DeclareOperation( "MaximalIndependentSet",
        [ IsHomalgModule ] );

DeclareOperation( "EliminateOverBaseRing",
        [ IsHomalgMatrix, IsList, IsInt ] );

DeclareOperation( "EliminateOverBaseRing",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "SimplifiedInequalities",
        [ IsList ] );

DeclareOperation( "SimplifiedInequalities",
        [ IsHomalgMatrix ] );

DeclareOperation( "DefiningIdealFromNameOfResidueClassRing",
        [ IsHomalgRing, IsString ] );
