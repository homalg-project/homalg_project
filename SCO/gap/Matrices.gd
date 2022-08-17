# SPDX-License-Identifier: GPL-2.0-or-later
# SCO: SCO - Simplicial Cohomology of Orbifolds
#
# Declarations
#

##  Declaration stuff for matrix creation.

##
DeclareGlobalFunction( "BoundaryOperator" );

##
DeclareOperation( "CreateCoboundaryMatrices",
        [ IsSimplicialSet, IsInt, IsHomalgRing ] );

##
DeclareOperation( "CreateCoboundaryMatrices",
        [ IsSimplicialSet, IsHomalgRing ] );

##
DeclareOperation( "CreateBoundaryMatrices",
        [ IsSimplicialSet, IsInt, IsHomalgRing ] );

##
DeclareOperation( "CreateBoundaryMatrices",
        [ IsSimplicialSet, IsHomalgRing ] );
