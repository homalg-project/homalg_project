# SPDX-License-Identifier: GPL-2.0-or-later
# homalg: A homological algebra meta-package for computable Abelian categories
#
# Declarations
#

##  Declarations for categories.

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
