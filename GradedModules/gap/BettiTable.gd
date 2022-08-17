# SPDX-License-Identifier: GPL-2.0-or-later
# GradedModules: A homalg based package for the Abelian category of finitely presented graded modules over computable graded rings
#
# Declarations
#

##  Declarations for Betti diagrams.

####################################
#
# categories:
#
####################################

##  <#GAPDoc Label="IsBettiTable">
##  <ManSection>
##    <Filt Type="Category" Arg="filt" Name="IsBettiTable"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of Betti diagrams.
##    <Listing Type="Code"><![CDATA[
DeclareCategory( "IsBettiTable",
        IsHomalgDiagram );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareGlobalFunction( "HomalgBettiTable" );

# basic operations:

DeclareOperation( "RowDegreesOfBettiTable",
        [ IsBettiTable ] );

DeclareOperation( "ColumnDegreesOfBettiTable",
        [ IsBettiTable ] );

