#############################################################################
##
##  HomalgModuleElement.gd                                   Modules package
##
##  Copyright 2011 Mohamed Barakat, University of Kaiserslautern
##
##  Declarations for module elements.
##
#############################################################################

# a new GAP-category:

##  <#GAPDoc Label="IsHomalgModuleElement">
##  <ManSection>
##    <Filt Type="Category" Arg="M" Name="IsHomalgElement"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of module elements.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgModuleElement",
        IsHomalgElement );

####################################
#
# properties:
#
####################################

##  <#GAPDoc Label="IsElementOfIntegers">
##  <ManSection>
##    <Prop Arg="m" Name="IsElementOfIntegers"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the <A>m</A> is an element of the integers viewed as a module over itself.
##      <#Include Label="IsElementOfIntegers:example">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsElementOfIntegers",
        IsHomalgModuleElement );

####################################
#
# attributes:
#
####################################

####################################
#
# global functions and operations:
#
####################################

# global functions

DeclareOperation( "TheZeroElement",
        [ IsHomalgModule ] );

# constructors:

DeclareOperation( "HomalgModuleElement",
        [ IsHomalgMatrix, IsHomalgModule ] );

DeclareOperation( "HomalgModuleElement",
        [ IsList, IsHomalgModule ] );

DeclareOperation( "HomalgModuleElement",
        [ IsList, IsInt, IsInt, IsHomalgModule ] );

DeclareOperation( "LessThan",
         [ IsHomalgModuleElement, IsHomalgModuleElement ] );

DeclareOperation( "LessThanOrEqual",
         [ IsHomalgModuleElement, IsHomalgModuleElement ] );

DeclareOperation( "GreaterThan",
         [ IsHomalgModuleElement, IsHomalgModuleElement ] );

DeclareOperation( "GreaterThanOrEqual",
         [ IsHomalgModuleElement, IsHomalgModuleElement ] );

DeclareOperation( "HomalgElementToInteger",
         [ IsHomalgModuleElement ] );

DeclareOperation( "HomalgElementToInteger",
         [ IsInt ] );

# basic operations:

DeclareOperation( "HomalgRing",
        [ IsHomalgModuleElement ] );

DeclareOperation( "UnderlyingListOfRingElements",
        [ IsHomalgModuleElement ] );

DeclareOperation( "UnderlyingListOfRingElementsInCurrentPresentation",
        [ IsHomalgModuleElement ] );

DeclareOperation( "\*",
        [ IsInt, IsHomalgModuleElement ] );

