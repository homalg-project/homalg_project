#############################################################################
##
##  homalg.gd                   homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for homalg.
##
#############################################################################


# our info classes:
DeclareInfoClass( "InfoHomalg" );
SetInfoLevel( InfoHomalg, 1 );

# a central place for configurations:
DeclareGlobalVariable( "HOMALG" );

####################################
#
# categories:
#
####################################

##  <#GAPDoc Label="IsHomalgObjectOrMorphism">
##  <ManSection>
##    <Filt Type="Category" Arg="F" Name="IsHomalgObjectOrMorphism"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      This is the super &GAP;-category which will include the &GAP;-categories
##      <Ref Filt="IsHomalgObject"/> and <Ref Filt="IsHomalgMorphism"/>.
##      With this GAP-category we can have a common declaration for things like
##      <C>OnLessGenerators</C>, <C>BasisOfModule</C>, <C>DecideZero</C>.
##    <Listing Type="Code"><![CDATA[
DeclareCategory( "IsHomalgObjectOrMorphism",
        IsExtLElement and
        IsHomalgRingOrObjectOrMorphism );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsHomalgStaticObjectOrMorphism">
##  <ManSection>
##    <Filt Type="Category" Arg="F" Name="IsHomalgStaticObjectOrMorphism"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      This is the super &GAP;-category which will include the &GAP;-categories
##      <Ref Filt="IsHomalgStaticObject"/> and <Ref Filt="IsHomalgStaticMorphism"/>.
##    <Listing Type="Code"><![CDATA[
DeclareCategory( "IsHomalgStaticObjectOrMorphism",
        IsHomalgObjectOrMorphism );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareCategory( "IsHomalgLeftObjectOrMorphismOfLeftObjects",
        IsHomalgObjectOrMorphism );

DeclareCategory( "IsHomalgRightObjectOrMorphismOfRightObjects",
        IsHomalgObjectOrMorphism );

####################################
#
# attributes:
#
####################################

DeclareAttribute( "AsCokernel",
        IsHomalgObjectOrMorphism );

DeclareAttribute( "AsKernel",
        IsHomalgObjectOrMorphism );

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "LogicalImplicationsForTwoHomalgObjects" );

DeclareGlobalFunction( "InstallLogicalImplicationsForHomalgObjects" );

DeclareGlobalFunction( "LogicalImplicationsForHomalgSubobjects" );

DeclareGlobalFunction( "InstallLogicalImplicationsForHomalgSubobjects" );

# basic operations:

DeclareOperation( "homalgResetFilters",
        [ IsHomalgObjectOrMorphism ] );

DeclareOperation( "AsLeftObject",
        [ IsHomalgRing ] );

DeclareOperation( "AsRightObject",
        [ IsHomalgRing ] );

DeclareOperation( "CheckIfTheyLieInTheSameCategory",
        [ IsHomalgObjectOrMorphism, IsHomalgObjectOrMorphism ] );

