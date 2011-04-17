#############################################################################
##
##  HomogeneousMatrix.gd                         GradedRingForHomalg package
##
##  Copyright 2009-2010, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH-Aachen University
##
##  Declarations for homogeneous matrices.
##
#############################################################################

####################################
#
# categories:
#
####################################

DeclareCategory( "IsMatrixOverGradedRing",
        IsHomalgMatrix );

####################################
#
# properties:
#
####################################

##
DeclareProperty( "Twitter",
        IsHomalgMatrix );

####################################
#
# attributes:
#
####################################

##
## the attributes below are intrinsic:
##
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
## should all be added by hand to LIHMAT.intrinsic_attributes
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

##  <#GAPDoc Label="DegreesOfEntries">
##  <ManSection>
##    <Attr Arg="A" Name="DegreesOfEntries"/>
##    <Returns>a listlist of degrees/multi-degrees</Returns>
##    <Description>
##      The matrix of degrees of the matrix <A>A</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "DegreesOfEntries",
        IsMatrixOverGradedRing );

##  <#GAPDoc Label="NonTrivialDegreePerRow">
##  <ManSection>
##    <Attr Arg="A[, col_degrees]" Name="NonTrivialDegreePerRow"/>
##    <Returns>a list of degrees/multi-degrees</Returns>
##    <Description>
##      The list of first nontrivial degree per row of the matrix <A>A</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "NonTrivialDegreePerRow",
        IsMatrixOverGradedRing );

##  <#GAPDoc Label="NonTrivialDegreePerColumn">
##  <ManSection>
##    <Attr Arg="A[, row_degrees]" Name="NonTrivialDegreePerColumn"/>
##    <Returns>a list of degrees/multi-degrees</Returns>
##    <Description>
##      The list of first nontrivial degree per column of the matrix <A>A</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "NonTrivialDegreePerColumn",
        IsMatrixOverGradedRing );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "UnderlyingNonGradedRing",
        [ IsMatrixOverGradedRing ] );

DeclareOperation( "UnderlyingNonHomogeneousMatrix",
        [ IsMatrixOverGradedRing ] );

DeclareOperation( "MonomialMatrix",
        [ IsInt, IsHomalgGradedRing ] );

DeclareOperation( "MonomialMatrix",
        [ IsList, IsHomalgGradedRing ] );

DeclareOperation( "RandomMatrixBetweenGradedFreeLeftModules",
        [ IsList, IsList, IsHomalgGradedRing ] );

DeclareOperation( "RandomMatrixBetweenGradedFreeRightModules",
        [ IsList, IsList, IsHomalgGradedRing ] );

DeclareOperation( "NonTrivialDegreePerRow",
        [ IsMatrixOverGradedRing, IsList ] );

DeclareOperation( "NonTrivialDegreePerColumn",
        [ IsMatrixOverGradedRing, IsList ] );

DeclareOperation( "DegreesOfEntries",
        [ IsHomalgMatrix, IsHomalgGradedRing ] );

DeclareOperation( "NonTrivialDegreePerRow",
        [ IsHomalgMatrix, IsHomalgGradedRing ] );

DeclareOperation( "NonTrivialDegreePerRow",
        [ IsHomalgMatrix, IsHomalgGradedRing, IsList ] );

DeclareOperation( "NonTrivialDegreePerColumn",
        [ IsHomalgMatrix, IsHomalgGradedRing ] );

DeclareOperation( "NonTrivialDegreePerColumn",
        [ IsHomalgMatrix, IsHomalgGradedRing, IsList ] );

# constructor methods:

DeclareOperation( "BlindlyCopyMatrixPropertiesToHomogeneousMatrix",
        [ IsHomalgMatrix, IsMatrixOverGradedRing ] );

DeclareOperation( "HomogeneousMatrix",
        [ IsHomalgMatrix, IsHomalgGradedRing ] );

DeclareOperation( "HomogeneousMatrix",
        [ IsHomalgMatrix, IsInt, IsInt, IsHomalgGradedRing ] );

DeclareOperation( "HomogeneousMatrix",
        [ IsList, IsInt, IsInt, IsHomalgGradedRing ] );

