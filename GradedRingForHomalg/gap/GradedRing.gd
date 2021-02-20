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

DeclareCategory( "IsHomalgGradedRing",
        IsHomalgRing );

DeclareCategory( "IsHomalgGradedRingElement",
        IsHomalgRingElement );

####################################
#
# attributes:
#
####################################

DeclareAttribute( "DegreeOfRingElementFunction",
        IsHomalgGradedRing );

DeclareAttribute( "DegreeOfRingElement",
        IsHomalgGradedRingElement );

DeclareAttribute( "DegreesOfEntriesFunction",
        IsHomalgGradedRing );

DeclareAttribute( "NonTrivialDegreePerRowWithColPositionFunction",
        IsHomalgGradedRing );

DeclareAttribute( "NonTrivialDegreePerColumnWithRowPositionFunction",
        IsHomalgGradedRing );

##  <#GAPDoc Label="DegreeGroup">
##  <ManSection>
##    <Attr Arg="S" Name="DegreeGroup"/>
##    <Returns>a left &ZZ;-module</Returns>
##    <Description>
##      The degree Abelian group of the commutative graded ring <A>S</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
##DeclareAttribute( "DegreeGroup",
##        IsHomalgGradedRing );

##  <#GAPDoc Label="CommonNonTrivialWeightOfIndeterminates">
##  <ManSection>
##    <Attr Arg="S" Name="CommonNonTrivialWeightOfIndeterminates"/>
##    <Returns>a degree</Returns>
##    <Description>
##      The common nontrivial weight of the indeterminates of the graded ring <A>S</A> if it exists. Otherwise an error is issued.
##      WARNING: Since the DegreeGroup and WeightsOfIndeterminates are in some cases bound together, you MUST not set the DegreeGroup by hand and let the algorithm
##      create the weights. Set both by hand, set only weights or use the method WeightsOfIndeterminates to set both. Never set the DegreeGroup
##      without the WeightsOfIndeterminates, because it simply wont work!
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CommonNonTrivialWeightOfIndeterminates",
        IsHomalgGradedRing );

##  <#GAPDoc Label="WeightsOfIndeterminates">
##  <ManSection>
##    <Attr Arg="S" Name="WeightsOfIndeterminates"/>
##    <Returns>a list or listlist of integers</Returns>
##    <Description>
##      The list of degrees of the indeterminates of the graded ring <A>S</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
##DeclareAttribute( "WeightsOfIndeterminates",
##        IsHomalgRing );

## for internal use only, do not document for the end user,
## see MatrixOfWeightsOfIndeterminates in SingularTools.gi
DeclareOperation( "MatrixOfWeightsOfIndeterminates",
        [ IsHomalgGradedRing ] );

DeclareAttribute( "IrrelevantIdealColumnMatrix",
        IsHomalgGradedRing );

DeclareProperty( "IsHomogeneousRingElement",
        IsHomalgGradedRingElement );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "UnderlyingNonGradedRing",
        [ IsHomalgGradedRing ] );
        
DeclareOperation( "UnderlyingNonGradedRing",
        [ IsHomalgGradedRingElement ] );

DeclareOperation( "UnderlyingNonGradedRingElement",
        [ IsHomalgGradedRingElement ] );
        
DeclareOperation( "HomogeneousPartOfRingElement",
        [ IsHomalgGradedRingElement, IsHomalgModuleElement ] );
        
DeclareOperation( "AreLinearSyzygiesAvailable",
        [ IsHomalgRing ] );
        
DeclareOperation( "MatrixOfWeightsOfIndeterminates",
        [ IsHomalgRing, IsList ] );
        
DeclareOperation( "WeightsOfIndeterminates",
        [ IsHomalgGradedRing ] );
        
DeclareOperation( "HasWeightsOfIndeterminates",
        [ IsHomalgGradedRing ] );
        
DeclareOperation( "SetWeightsOfIndeterminates",
        [ IsHomalgGradedRing, IsList ] );
        
DeclareOperation( "DegreeGroup",
        [ IsHomalgGradedRing ] );
        
DeclareOperation( "HasDegreeGroup",
        [ IsHomalgGradedRing ] );
        
DeclareOperation( "SetDegreeGroup",
        [ IsHomalgGradedRing, IsHomalgModule ] );

DeclareProperty( "CanComputeMonomialsWithGivenDegreeForRing", IsHomalgGradedRing );

KeyDependentOperation( "MonomialsWithGivenDegree",
        IsHomalgGradedRing, IsHomalgModuleElement, ReturnTrue );

# constructor methods:

DeclareGlobalFunction( "GradedRingElement" );

DeclareOperation ( "GradedRing",
        [ IsHomalgRing ] );
