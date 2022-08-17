# SPDX-License-Identifier: GPL-2.0-or-later
# homalg: A homological algebra meta-package for computable Abelian categories
#
# Declarations
#

##  Declaration stuff for homalg.

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
        IsStructureObjectOrObjectOrMorphism );
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
        [ IsStructureObject ] );

DeclareOperation( "AsRightObject",
        [ IsStructureObject ] );

DeclareOperation( "CheckIfTheyLieInTheSameCategory",
        [ IsStructureObjectOrObjectOrMorphism, IsStructureObjectOrObjectOrMorphism ] );

