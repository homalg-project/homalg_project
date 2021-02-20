# SPDX-License-Identifier: GPL-2.0-or-later
# GradedRingForHomalg: Endow Commutative Rings with an Abelian Grading
#
# Declarations
#

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

