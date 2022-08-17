# SPDX-License-Identifier: GPL-2.0-or-later
# SCO: SCO - Simplicial Cohomology of Orbifolds
#
# Declarations
#

##  Declaration stuff for SCO.

##
DeclareCategory( "IsSimplicialSet",
        IsAttributeStoringRep );

DeclareOperation( "SimplicialSet",
        [ IsOrbifoldTriangulation ] );

DeclareOperation( "SimplicialSet",
        [ IsSimplicialSet, IsInt ] );

DeclareOperation( "ComputeNextDimension",
        [ IsSimplicialSet ] );

DeclareOperation( "Extend",
        [ IsSimplicialSet, IsInt ] );
