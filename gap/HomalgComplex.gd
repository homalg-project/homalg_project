#############################################################################
##
##  HomalgComplex.gd            homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for homalg complexes.
##
#############################################################################

####################################
#
# categories:
#
####################################

# a new GAP-category:

##  <#GAPDoc Label="IsHomalgComplex">
##  <ManSection>
##    <Filt Type="Category" Arg="C" Name="IsHomalgComplex"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; category of &homalg; (co)complexes. <Br/><Br/>
##      (It is a subcategory of the &GAP; category <C>IsHomalgObject</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgComplex",
        IsHomalgObject );

####################################
#
# properties:
#
####################################

##  <#GAPDoc Label="IsSequence">
##  <ManSection>
##    <Prop Arg="C" Name="IsSequence"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if all maps in <A>C</A> are well-defined.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsSequence",
        IsHomalgComplex );

##  <#GAPDoc Label="IsComplex">
##  <ManSection>
##    <Prop Arg="C" Name="IsComplex"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if <A>C</A> is complex.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsComplex",
        IsHomalgComplex );

##  <#GAPDoc Label="IsAcyclic">
##  <ManSection>
##    <Prop Arg="C" Name="IsAcyclic"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; complex <A>C</A> is acyclic, i.e. exact except at its boundaries.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsAcyclic",
        IsHomalgComplex );

##  <#GAPDoc Label="IsRightAcyclic">
##  <ManSection>
##    <Prop Arg="C" Name="IsRightAcyclic"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; complex <A>C</A> is acyclic, i.e. exact except at its left boundary.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsRightAcyclic",
        IsHomalgComplex );

##  <#GAPDoc Label="IsLeftAcyclic">
##  <ManSection>
##    <Prop Arg="C" Name="IsLeftAcyclic"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; complex <A>C</A> is acyclic, i.e. exact except at its right boundary.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsLeftAcyclic",
        IsHomalgComplex );

##  <#GAPDoc Label="IsGradedObject">
##  <ManSection>
##    <Prop Arg="C" Name="IsGradedObject"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; complex <A>C</A> is a graded object, i.e. if all maps between the objects in <A>C</A> vanish.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsGradedObject",
        IsHomalgComplex );

##  <#GAPDoc Label="IsExactSequence">
##  <ManSection>
##    <Prop Arg="C" Name="IsExactSequence"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; complex <A>C</A> is exact.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsExactSequence",
        IsHomalgComplex );

##  <#GAPDoc Label="IsShortExactSequence">
##  <ManSection>
##    <Prop Arg="C" Name="IsShortExactSequence"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; complex <A>C</A> is a short exact sequence.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsShortExactSequence",	## we also need this as property!!!
        IsHomalgComplex );

##  <#GAPDoc Label="IsSplitShortExactSequence">
##  <ManSection>
##    <Prop Arg="C" Name="IsSplitShortExactSequence"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; complex <A>C</A> is a split short exact sequence.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsSplitShortExactSequence",
        IsHomalgComplex );

##  <#GAPDoc Label="IsTriangle">
##  <ManSection>
##    <Prop Arg="C" Name="IsTriangle"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Set to true if the &homalg; complex <A>C</A> is a triangle.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsTriangle",
        IsHomalgComplex );

##  <#GAPDoc Label="IsExactTriangle">
##  <ManSection>
##    <Prop Arg="C" Name="IsExactTriangle"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; complex <A>C</A> is an exact triangle.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsExactTriangle",
        IsHomalgComplex );

DeclareProperty( "IsATwoSequence",		## the output of AsATwoSequence (and only this) is marked as IsATwoSequence in order to distinguish
        IsHomalgComplex );			##  between different methods for DefectOfExactness which all apply to complexes

####################################
#
# attributes:
#
####################################

##  <#GAPDoc Label="BettiDiagram:complex">
##  <ManSection>
##    <Attr Arg="C" Name="BettiDiagram" Label="for complexes"/>
##    <Returns>a &homalg; diagram</Returns>
##    <Description>
##      The Betti diagram of the &homalg; complex <A>C</A> of graded modules.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "BettiDiagram",
        IsHomalgComplex );

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareGlobalFunction( "HomalgComplex" );

DeclareGlobalFunction( "HomalgCocomplex" );

# basic operations:

DeclareOperation( "homalgResetFilters",
        [ IsHomalgComplex ] );

DeclareOperation( "PositionOfTheDefaultSetOfRelations",
        [ IsHomalgComplex ] );			## provided to avoid branching in the code and always returns fail

DeclareOperation( "ObjectDegreesOfComplex",
        [ IsHomalgComplex ] );

DeclareOperation( "MorphismDegreesOfComplex",
        [ IsHomalgComplex ] );

DeclareOperation( "CertainMorphism",
        [ IsHomalgComplex, IsInt ] );

DeclareOperation( "CertainObject",
        [ IsHomalgComplex, IsInt ] );

DeclareOperation( "MorphismsOfComplex",
        [ IsHomalgComplex ] );

DeclareOperation( "ObjectsOfComplex",
        [ IsHomalgComplex ] );

DeclareOperation( "LowestDegree",
        [ IsHomalgComplex ] );

DeclareOperation( "HighestDegree",
        [ IsHomalgComplex ] );

DeclareOperation( "LowestDegreeObject",
        [ IsHomalgComplex ] );

DeclareOperation( "HighestDegreeObject",
        [ IsHomalgComplex ] );

DeclareOperation( "LowestDegreeMorphism",
        [ IsHomalgComplex ] );

DeclareOperation( "HighestDegreeMorphism",
        [ IsHomalgComplex ] );

DeclareOperation( "SupportOfComplex",
        [ IsHomalgComplex ] );

DeclareOperation( "Add",
        [ IsHomalgComplex, IsHomalgMorphism ] );

DeclareOperation( "Add",
        [ IsHomalgMorphism, IsHomalgComplex ] );

DeclareOperation( "Add",
        [ IsHomalgComplex, IsHomalgModule ] );

DeclareOperation( "Add",
        [ IsHomalgComplex, IsHomalgMatrix ] );

DeclareOperation( "Shift",
        [ IsHomalgComplex, IsInt ] );

DeclareOperation( "CertainMorphismAsSubcomplex",
        [ IsHomalgComplex, IsInt ] );

DeclareOperation( "CertainTwoMorphismsAsSubcomplex",
        [ IsHomalgComplex, IsInt ] );

DeclareOperation( "PreCompose",
        [ IsHomalgComplex, IsHomalgComplex ] );

DeclareOperation( "LongSequence",
        [ IsHomalgComplex ] );

