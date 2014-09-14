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
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of &homalg; (co)complexes. <P/>
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
##    <Returns><C>true</C> or <C>false</C></Returns>
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
##    <Returns><C>true</C> or <C>false</C></Returns>
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
##    <Returns><C>true</C> or <C>false</C></Returns>
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
##    <Returns><C>true</C> or <C>false</C></Returns>
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
##    <Returns><C>true</C> or <C>false</C></Returns>
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
##    <Returns><C>true</C> or <C>false</C></Returns>
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
##    <Returns><C>true</C> or <C>false</C></Returns>
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
##    <Returns><C>true</C> or <C>false</C></Returns>
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
##    <Returns><C>true</C> or <C>false</C></Returns>
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
##    <Returns><C>true</C> or <C>false</C></Returns>
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
##    <Returns><C>true</C> or <C>false</C></Returns>
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

##  <#GAPDoc Label="BettiTable:complex">
##  <ManSection>
##    <Attr Arg="C" Name="BettiTable" Label="for complexes"/>
##    <Returns>a &homalg; diagram</Returns>
##    <Description>
##      The Betti diagram of the &homalg; complex <A>C</A> of graded modules.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "BettiTable",
        IsHomalgComplex );

DeclareSynonym( "BettiDiagram", BettiTable );

##  <#GAPDoc Label="FiltrationByShortExactSequence">
##  <ManSection>
##    <Attr Arg="C" Name="FiltrationByShortExactSequence" Label="for complexes"/>
##    <Returns>a &homalg; diagram</Returns>
##    <Description>
##      The filtration induced by the short exact sequence <A>C</A> on its middle object.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "FiltrationByShortExactSequence",
        IsHomalgComplex );

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareGlobalFunction( "HomalgComplex" );

DeclareGlobalFunction( "HomalgCocomplex" );

DeclareOperation( "*",
        [ IsStructureObject, IsHomalgComplex ] );

DeclareOperation( "*",
        [ IsHomalgComplex, IsStructureObject ] );

# basic operations:

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
        [ IsHomalgComplex, IsHomalgStaticObject ] );

DeclareOperation( "Add",
        [ IsHomalgStaticObject, IsHomalgComplex ] );

DeclareOperation( "Shift",
        [ IsHomalgComplex, IsInt ] );

DeclareOperation( "Reflect",
        [ IsHomalgComplex, IsInt ] );

DeclareOperation( "Reflect",
        [ IsHomalgComplex ] );

DeclareOperation( "Subcomplex",
        [ IsHomalgComplex, IsInt, IsInt ] );

DeclareOperation( "CertainMorphismAsSubcomplex",
        [ IsHomalgComplex, IsInt ] );

DeclareOperation( "CertainTwoMorphismsAsSubcomplex",
        [ IsHomalgComplex, IsInt ] );

DeclareOperation( "PreCompose",
        [ IsHomalgComplex, IsHomalgComplex ] );

DeclareOperation( "LongSequence",
        [ IsHomalgComplex ] );

DeclareOperation( "SetCurrentResolution",
        [ IsHomalgStaticObject, IsHomalgComplex ] );

