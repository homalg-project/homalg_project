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

DeclareAttribute( "NonTrivialDegreePerRowFunction",
        IsHomalgGradedRing );

DeclareAttribute( "NonTrivialDegreePerRowWithColDegreesFunction",
        IsHomalgGradedRing );

DeclareAttribute( "NonTrivialDegreePerRowWithColPositionFunction",
        IsHomalgGradedRing );

DeclareAttribute( "NonTrivialDegreePerColumnFunction",
        IsHomalgGradedRing );

DeclareAttribute( "NonTrivialDegreePerColumnWithRowDegreesFunction",
        IsHomalgGradedRing );

DeclareAttribute( "NonTrivialDegreePerColumnWithRowPositionFunction",
        IsHomalgGradedRing );

##  <#GAPDoc Label="CommonNonTrivialWeightOfIndeterminates">
##  <ManSection>
##    <Attr Arg="S" Name="CommonNonTrivialWeightOfIndeterminates"/>
##    <Returns>a degree</Returns>
##    <Description>
##      The common nontrivial weight of the indeterminates of the graded ring <A>S</A> if it exists. Otherwise an error is issued.
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
DeclareAttribute( "WeightsOfIndeterminates",
        IsHomalgRing );

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
DeclareAttribute( "MatrixOfWeightsOfIndeterminates",
        IsHomalgRing );

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
        [ IsInt, IsHomalgGradedRing, IsList ] );

DeclareOperation( "AreLinearSyzygiesAvailable",
        [ IsHomalgRing ] );
        
# constructor methods:

DeclareGlobalFunction( "GradedRingElement" );

DeclareOperation ( "GradedRing",
        [ IsHomalgRing ] );
