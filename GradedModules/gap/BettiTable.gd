#############################################################################
##
##  HomalgDiagram.gd                                   GradedModules package
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Declarations for Betti diagrams.
##
#############################################################################

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

