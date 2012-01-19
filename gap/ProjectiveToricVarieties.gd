#############################################################################
##
##  ProjectiveToricVariety.gd         ToricVarieties package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  The Category of projective toric Varieties
##
#############################################################################

##  <#GAPDoc Label="IsProjectiveToricVariety">
##  <ManSection>
##    <Filt Type="Category" Arg="M" Name="IsProjectiveToricVariety"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of a projective toric variety.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsProjectiveToricVariety",
                 IsToricVariety );