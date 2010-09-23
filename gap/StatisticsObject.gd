#############################################################################
##
##  StatisticsObject.gd       HomalgToCAS package            Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Declaration for statistics objects.
##
#############################################################################

####################################
#
# categories:
#
####################################

##  <#GAPDoc Label="IsStatisticsObject">
##  <ManSection>
##    <Filt Type="Category" Arg="filt" Name="IsStatisticsObject"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of &homalg; diagrams.
##    <Listing Type="Code"><![CDATA[
DeclareCategory( "IsStatisticsObject",
        IsComponentObjectRep );
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

DeclareGlobalFunction( "NewStatisticsObject" );

# basic operations:

DeclareGlobalFunction( "IncreaseExistingCounterInStatisticsObject" );

DeclareGlobalFunction( "IncreaseCounterInStatisticsObject" );

