# SPDX-License-Identifier: GPL-2.0-or-later
# SCO: SCO - Simplicial Cohomology of Orbifolds
#
# Declarations
#

##  Declaration stuff for Orbifold Triangulations.

##
DeclareCategory( "IsOrbifoldTriangulation",
        IsAttributeStoringRep );

##
DeclareGlobalFunction( "OrbifoldTriangulation" );

##
DeclareOperation( "Vertices",
        [ IsOrbifoldTriangulation ] );

##
DeclareOperation( "Simplices",
        [ IsOrbifoldTriangulation ] );

##
DeclareOperation( "Isotropy",
        [ IsOrbifoldTriangulation ] );

##
DeclareOperation( "Mu",
        [ IsOrbifoldTriangulation ] );

##
DeclareOperation( "MuData",
        [ IsOrbifoldTriangulation ] );

##
DeclareOperation( "InfoString",
        [ IsOrbifoldTriangulation ] );

