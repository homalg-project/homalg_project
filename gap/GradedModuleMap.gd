#############################################################################
##
##  GradedModuleMap.gd                Graded Modules package
##
##  Copyright 2010,      Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Declaration stuff for graded module homomorphisms .
##
#############################################################################

####################################
#
# categories:
#
####################################

# two new categories:

##  <#GAPDoc Label="IsHomalgMap">
##  <ManSection>
##    <Filt Type="Category" Arg="phi" Name="IsHomalgMap"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of graded &homalg; maps. <P/>
##      (It is a subcategory of the &GAP; category
##      <C>IsHomalgMap</C>.)
##    <Listing Type="Code"><![CDATA[
DeclareCategory( "IsHomalgGradedMap",
        IsHomalgMap );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsHomalgSelfMap">
##  <ManSection>
##    <Filt Type="Category" Arg="phi" Name="IsHomalgSelfMap"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of graded &homalg; self-maps. <P/>
##      (It is a subcategory of the &GAP; categories
##       <C>IsHomalgGradedMap</C>, <C>IsHomalgEndomorphism</C> and <C>IsHomalgSelfMap</C>.)
##    <Listing Type="Code"><![CDATA[
DeclareCategory( "IsHomalgGradedSelfMap",
        IsHomalgGradedMap and
        IsHomalgEndomorphism and
        IsHomalgSelfMap );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

####################################
#
# properties:
#
####################################

##
DeclareAttribute( "CastelnuovoMumfordRegularity",
         IsHomalgGradedMap  );

DeclareAttribute( "MaximalIdealAsLeftMorphism",
        IsHomalgGradedRing );

DeclareAttribute( "MaximalIdealAsRightMorphism",
        IsHomalgGradedRing );

DeclareAttribute( "UnderlyingMorphism",
        IsHomalgGradedMap );

####################################
#
# global functions and operations:
#
####################################

DeclareOperation( "GradedVersionOfMorphismAid",
                 [ IsHomalgMap, IsHomalgGradedModule ] );

DeclareOperation( "NormalizeGradedMorphism",
                 [ IsHomalgGradedMap ] );

DeclareOperation( "GradedMap" ,
                 [ IsHomalgMatrix, IsObject, IsObject ] );
DeclareOperation( "GradedMap" ,
                 [ IsHomalgMatrix, IsObject, IsObject, IsString ] );
DeclareOperation( "GradedMap" ,
                 [ IsHomalgMatrix, IsObject, IsObject, IsHomalgRing ] );
DeclareOperation( "GradedMap" ,
                 [ IsHomalgMatrix, IsObject, IsObject, IsString, IsHomalgRing ] );
DeclareOperation( "GradedMap" ,
                 [ IsHomalgMap, IsHomalgRing ] );
DeclareOperation( "GradedMap" ,
                 [ IsHomalgMap, IsObject, IsObject ] );
DeclareOperation( "GradedMap" ,
                 [ IsHomalgMap, IsObject, IsObject, IsHomalgRing ] );
DeclareOperation( "GradedZeroMap" ,
                 [ IsHomalgGradedModule, IsHomalgGradedModule ] );

# constructors:

# basic operations