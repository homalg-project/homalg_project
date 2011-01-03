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

##  <#GAPDoc Label="IsBettiDiagram">
##  <ManSection>
##    <Filt Type="Category" Arg="filt" Name="IsBettiDiagram"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of Betti diagrams.
##    <Listing Type="Code"><![CDATA[
DeclareCategory( "IsBettiDiagram",
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

DeclareGlobalFunction( "HomalgBettiDiagram" );

# basic operations:

DeclareOperation( "RowDegreesOfBettiDiagram",
        [ IsBettiDiagram ] );

DeclareOperation( "ColumnDegreesOfBettiDiagram",
        [ IsBettiDiagram ] );

