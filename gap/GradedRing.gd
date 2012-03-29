#############################################################################
##
##  GradedRing.gd                                GradedRingForHomalg package
##
##  Copyright 2010, Mohamed Barakat, University of Kaiserslautern
##           Markus Lange-Hegermann, RWTH-Aachen University
##
##  Declarations of procedures for graded rings.
##
#############################################################################

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

##  <#GAPDoc Label="MatrixOfWeightsOfIndeterminates">
##  <ManSection>
##    <Attr Arg="S" Name="MatrixOfWeightsOfIndeterminates"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      A &homalg; matrix where the list (or listlist) of degrees of the indeterminates
##      of the graded ring <A>S</A> is stored.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "MatrixOfWeightsOfIndeterminates",
        [ IsHomalgGradedRing ] );

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

DeclareOperation( "ListOfDegreesOfMultiGradedRing",
        [ IsInt, IsHomalgRing, IsList ] );

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
        
# constructor methods:

DeclareGlobalFunction( "GradedRingElement" );

DeclareOperation ( "GradedRing",
        [ IsHomalgRing ] );
