#############################################################################
##
##  HomalgFiltration.gd         homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for a filtration.
##
#############################################################################

####################################
#
# categories:
#
####################################

# A new GAP-category:

##  <#GAPDoc Label="IsHomalgFiltration">
##  <ManSection>
##    <Filt Type="Category" Arg="filt" Name="IsHomalgFiltration"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of &homalg; filtrations.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgFiltration",
        IsAttributeStoringRep );

## CAUTION: in the code the following two categories are the only ones for sets of generators,
##          i.e. IsHomalgFiltration and not IsHomalgFiltrationOfLeftObject => IsHomalgFiltrationOfRightObject

DeclareCategory( "IsHomalgFiltrationOfLeftObject",
        IsHomalgFiltration );

DeclareCategory( "IsHomalgFiltrationOfRightObject",
        IsHomalgFiltration );

DeclareCategory( "IsDescendingFiltration",
        IsHomalgFiltration );

DeclareCategory( "IsAscendingFiltration",
        IsHomalgFiltration );

####################################
#
# properties:
#
####################################

DeclareProperty( "IsGradation",
        IsHomalgFiltration );

DeclareProperty( "IsFiltration",
        IsHomalgFiltration );

DeclareProperty( "IsPurityFiltration",
        IsHomalgFiltration );

####################################
#
# attributes:
#
####################################

##  <#GAPDoc Label="SpectralSequence:filt">
##  <ManSection>
##    <Attr Arg="BC" Name="SpectralSequence" Label="for filtrations"/>
##    <Returns>a &homalg; (co)homological spectral sequence</Returns>
##    <Description>
##      The spectral sequence used to construct the filtration (if any).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "SpectralSequence",
        IsHomalgFiltration );

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareGlobalFunction( "HomalgFiltration" );

DeclareGlobalFunction( "HomalgDescendingFiltration" );

DeclareGlobalFunction( "HomalgAscendingFiltration" );

# basic operations:

DeclareOperation( "DegreesOfFiltration",
        [ IsHomalgFiltration ] );

DeclareOperation( "LowestDegree",
        [ IsHomalgFiltration ] );

DeclareOperation( "HighestDegree",
        [ IsHomalgFiltration ] );

DeclareOperation( "CertainMorphism",
        [ IsHomalgFiltration, IsInt ] );

DeclareOperation( "CertainObject",
        [ IsHomalgFiltration, IsInt ] );

DeclareOperation( "ObjectsOfFiltration",
        [ IsHomalgFiltration ] );

DeclareOperation( "LowestDegreeObject",
        [ IsHomalgFiltration ] );

DeclareOperation( "HighestDegreeObject",
        [ IsHomalgFiltration ] );

DeclareOperation( "HomalgRing",
        [ IsHomalgFiltration ] );

DeclareOperation( "MorphismsOfFiltration",
        [ IsHomalgFiltration ] );

DeclareOperation( "LowestDegreeMorphism",
        [ IsHomalgFiltration ] );

DeclareOperation( "HighestDegreeMorphism",
        [ IsHomalgFiltration ] );

DeclareOperation( "UnderlyingObject",
        [ IsHomalgFiltration ] );

DeclareOperation( "IsomorphismOfFiltration",
        [ IsHomalgFiltration ] );

DeclareOperation( "UnlockOjbect",
        [ IsHomalgFiltration ] );

DeclareOperation( "AssociatedSecondSpectralSequence",
        [ IsHomalgFiltration ] );

