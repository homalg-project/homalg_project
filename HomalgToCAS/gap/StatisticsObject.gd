# SPDX-License-Identifier: GPL-2.0-or-later
# HomalgToCAS: A window to the outer world
#
# Declarations
#

##  Declaration for statistics objects.

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

