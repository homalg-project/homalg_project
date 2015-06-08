#############################################################################
##
##  HomalgDiagram.gd                                          homalg package
##
##  Copyright 2007-2008, Mohamed Barakat, RWTH Aachen
##
##  Declarations for diagrams.
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

