# SPDX-License-Identifier: GPL-2.0-or-later
# homalg: A homological algebra meta-package for computable Abelian categories
#
# Declarations
#

##  Declarations for diagrams.

####################################
#
# categories:
#
####################################

##  <#GAPDoc Label="IsHomalgDiagram">
##  <ManSection>
##    <Filt Type="Category" Arg="filt" Name="IsHomalgDiagram"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of &homalg; diagrams.
##    <Listing Type="Code"><![CDATA[
DeclareCategory( "IsHomalgDiagram",
        IsAttributeStoringRep );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

####################################
#
# properties:
#
####################################

####################################
#
# global functions and operations:
#
####################################

# constructors:

# basic operations:

DeclareOperation( "MatrixOfDiagram",
        [ IsHomalgDiagram ] );

DeclareOperation( "homalgCreateDisplayString",
        [ IsHomalgDiagram ] );

