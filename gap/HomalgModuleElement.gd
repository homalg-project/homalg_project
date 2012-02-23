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

#DeclareOperation( "LT",
#        [ IsHomalgModuleElement, IsHomalgModuleElement ] );

#DeclareOperation( "LT",
#        [ IsInt, IsHomalgModuleElement ] );

#DeclareOperation( "LT",
#        [ IsHomalgModuleElement, IsInt ] );

DeclareOperation( "LessThan",
         [ IsHomalgElement, IsHomalgElement ] );

DeclareOperation( "LessThanOrEqual",
         [ IsHomalgElement, IsHomalgElement ] );

DeclareOperation( "GreaterThan",
         [ IsHomalgElement, IsHomalgElement ] );

DeclareOperation( "GreaterThanOrEqual",
         [ IsHomalgElement, IsHomalgElement ] );

DeclareOperation( "HomalgElementToInteger",
         [ IsHomalgElement ] );

# basic operations:

DeclareOperation( "HomalgRing",
        [ IsHomalgModuleElement ] );

DeclareOperation( "UnderlyingListOfRingElements",
        [ IsHomalgModuleElement ] );

DeclareOperation( "UnderlyingListOfRingElementsInCurrentPresentation",
        [ IsHomalgModuleElement ] );

DeclareOperation( "\*",
        [ IsInt, IsHomalgModuleElement ] );

