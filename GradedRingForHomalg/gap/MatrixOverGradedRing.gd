# SPDX-License-Identifier: GPL-2.0-or-later
# GradedRingForHomalg: Endow Commutative Rings with an Abelian Grading
#
# Declarations
#

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

##  <#GAPDoc Label="HomogeneousPartOfMatrix">
##  <ManSection>
##    <Prop Arg="A, degrees" Name="HomogeneousPartOfMatrix" Label="for matrices over graded rings and listlist of degrees"/>
##    <Returns>a homalg matrix over graded ring</Returns>
##    <Description>
##      The output is the homogeneous part of the matrix <A>A</A> with respect to the given degrees 
##      <A>degrees</A>. See <A>HomogeneousPartOfRingElement</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "HomogeneousPartOfMatrix", [ IsMatrixOverGradedRing, IsList ] );

##  <#GAPDoc Label="IsMatrixOverGradedRingWithHomogeneousEntries">
##  <ManSection>
##    <Prop Arg="A" Name="IsMatrixOverGradedRingWithHomogeneousEntries" Label="for matrices over graded rings"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if every entry in a given matrix <A>A</A> over a graded ring is homogeneous.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsMatrixOverGradedRingWithHomogeneousEntries", 
        IsMatrixOverGradedRing );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "UnderlyingNonGradedRing",
        [ IsMatrixOverGradedRing ] );

DeclareOperation( "UnderlyingMatrixOverNonGradedRing",
        [ IsMatrixOverGradedRing ] );

DeclareOperation( "MonomialMatrix",
        [ IsInt, IsHomalgGradedRing ] );

DeclareOperation( "MonomialMatrix",
        [ IsInt, IsHomalgGradedRing, IsList, IsBool ] );

DeclareOperation( "MonomialMatrix",
        [ IsHomalgElement, IsHomalgGradedRing, IsList, IsBool ] );

DeclareOperation( "MonomialMatrix",
        [ IsList, IsHomalgGradedRing ] );

DeclareOperation( "RandomMatrixBetweenGradedFreeLeftModules",
        [ IsList, IsList, IsHomalgGradedRing ] );

DeclareOperation( "RandomMatrixBetweenGradedFreeRightModules",
        [ IsList, IsList, IsHomalgGradedRing ] );

DeclareOperation( "RandomMatrix",
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

DeclareOperation( "BlindlyCopyMatrixPropertiesToMatrixOverGradedRing",
        [ IsHomalgMatrix, IsMatrixOverGradedRing ] );

DeclareOperation( "MatrixOverGradedRing",
        [ IsHomalgMatrix, IsHomalgGradedRing ] );

DeclareOperation( "MatrixOverGradedRing",
        [ IsHomalgMatrix, IsInt, IsInt, IsHomalgGradedRing ] );

DeclareOperation( "MatrixOverGradedRing",
        [ IsList, IsInt, IsInt, IsHomalgGradedRing ] );

