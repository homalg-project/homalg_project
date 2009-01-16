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

# A new GAP-category:

##  <#GAPDoc Label="IsHomalgDiagram">
##  <ManSection>
##    <Filt Type="Category" Arg="filt" Name="IsHomalgDiagram"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; category of &homalg; diagrams.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgDiagram",
        IsAttributeStoringRep );

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

