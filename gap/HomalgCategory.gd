#############################################################################
##
##  HomalgCategory.gd                                         homalg package
##
##  Copyright 2012 Mohamed Barakat, University of Kaiserslautern
##
##  Declarations for categories.
##
#############################################################################

####################################
#
# categories:
#
####################################

# a new GAP-category:

##  <#GAPDoc Label="IsHomalgCategory">
##  <ManSection>
##    <Filt Type="Category" Arg="M" Name="IsHomalgCategory"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of object elements.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgCategory",
        IsAttributeStoringRep );

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareOperation( "HomalgCategory",
        [ IsStructureObject, IsString ] );
