#############################################################################
##
##  HomalgCategory.gi                                         homalg package
##
##  Copyright 2012 Mohamed Barakat, University of Kaiserslautern
##
##  Implementations for categories.
##
#############################################################################

####################################
#
# representations:
#
####################################

##  <#GAPDoc Label="IsHomalgCategoryOfLeftObjectsRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="BC" Name="IsHomalgCategoryOfLeftObjectsRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of categories of left objects. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgCategory"/>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsHomalgCategoryOfLeftObjectsRep",
        IsHomalgCategory,
        [  ] );

##  <#GAPDoc Label="IsHomalgCategoryOfRightObjectsRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="BC" Name="IsHomalgCategoryOfRightObjectsRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of categories of left objects. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgCategory"/>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsHomalgCategoryOfRightObjectsRep",
        IsHomalgCategory,
        [  ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgCategories",
        NewFamily( "TheFamilyOfHomalgCategories" ) );
