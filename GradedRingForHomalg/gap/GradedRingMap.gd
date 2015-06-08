#############################################################################
##
##  GradedRingMap.gd        GradedRingForHomalg package      Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##  Copyright 2010, Mohamed Barakat, University of Kaiserslautern
##           Markus Lange-Hegermann, RWTH-Aachen University
##
##  Declarations of procedures for graded rings.
##
#############################################################################

####################################
#
# categories:
#
####################################

# two new GAP-categories:

##  <#GAPDoc Label="IsHomalgGradedRingMap">
##  <ManSection>
##    <Filt Type="Category" Arg="phi" Name="IsHomalgGradedRingMap"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of ring maps.
##    <Listing Type="Code"><![CDATA[
DeclareCategory( "IsHomalgGradedRingMap",
        IsHomalgRingMap );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##

##  <#GAPDoc Label="IsHomalgGradedRingSelfMap">
##  <ManSection>
##    <Filt Type="Category" Arg="phi" Name="IsHomalgGradedRingSelfMap"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of ring self-maps.
##    <Listing Type="Code"><![CDATA[
DeclareCategory( "IsHomalgGradedRingSelfMap",
        IsHomalgRingSelfMap and
        IsHomalgGradedRingMap );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##

