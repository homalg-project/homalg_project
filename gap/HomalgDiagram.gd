#############################################################################
##
##  HomalgDiagram.gd            homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for a diagram.
##
#############################################################################

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

##
DeclareCategory( "IsHomalgBettiDiagram",
        IsHomalgDiagram );

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

DeclareGlobalFunction( "HomalgBettiDiagram" );

# basic operations:

DeclareOperation( "MatrixOfDiagram",
        [ IsHomalgDiagram ] );

DeclareOperation( "RowDegreesOfBettiDiagram",
        [ IsHomalgDiagram ] );

DeclareOperation( "ColumnDegreesOfBettiDiagram",
        [ IsHomalgDiagram ] );

DeclareOperation( "homalgCreateDisplayString",
        [ IsHomalgDiagram ] );

