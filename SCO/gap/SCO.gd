# SPDX-License-Identifier: GPL-2.0-or-later
# SCO: SCO - Simplicial Cohomology of Orbifolds
#
# Declarations
#

##  Declaration stuff for SCO.

##
DeclareOperation( "ComplexOfSimplicialSet",
        [ IsSimplicialSet, IsInt, IsHomalgRing ] );

##
DeclareOperation( "CocomplexOfSimplicialSet",
        [ IsSimplicialSet, IsInt, IsHomalgRing ] );

##
DeclareOperation( "Homology",
        [ IsList, IsHomalgRing ] );

##
DeclareOperation( "Homology",
        [ IsList ] );

##
DeclareOperation( "Cohomology",
        [ IsList, IsHomalgRing ] );

##
DeclareOperation( "Cohomology",
        [ IsList ] );

##
DeclareGlobalFunction( "SCO_Examples" );
