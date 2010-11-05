#############################################################################
##
##  GradedModule.gd             GradedModules package
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Declarations for graded homalg modules.
##
#############################################################################

# our info classes:
DeclareInfoClass( "InfoGradedModules" );
SetInfoLevel( InfoGradedModules, 1 );

# a central place for configurations:
DeclareGlobalVariable( "HOMALG_GRADED_MODULES" );

####################################
#
# categories:
#
####################################

##  <#GAPDoc Label="IsHomalgGradedModule">
##  <ManSection>
##    <Filt Type="Category" Arg="M" Name="IsHomalgGradedModule"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of &homalg; graded modules. <P/>
##      (It is a subcategory of the &GAP; categories
##      <C>IsHomalgModule</C></C>.)
##    <Listing Type="Code"><![CDATA[
DeclareCategory( "IsHomalgGradedModule",
        IsHomalgModule );
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
DeclareProperty( "Twitter",
        IsHomalgGradedModule );

####################################
#
# attributes:
#
####################################



##
## the attributes below are intrinsic:
##
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
## should all be added by hand to LIGrMOD.intrinsic_attributes
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



####################################
#
# global functions and operations:
#
####################################

# basic operations

DeclareOperation( "RandomMatrix",
        [ IsHomalgModule, IsHomalgModule ] );

DeclareOperation( "MonomialMap",
        [ IsInt, IsHomalgModule ] );

DeclareOperation( "BasisOfHomogeneousPart",
        [ IsInt, IsHomalgModule ] );

DeclareOperation( "RepresentationOfRingElement",
        [ IsRingElement, IsHomalgModule, IsInt ] );

DeclareOperation( "HomogeneousPartOverCoefficientsRing",
        [ IsInt, IsHomalgModule ] );

# constructors:

DeclareOperation( "GradedModule",
        [ IsHomalgModule, IsInt, IsHomalgGradedRing ] );

DeclareOperation( "GradedModule",
        [ IsHomalgModule, IsHomalgGradedRing ] );

DeclareOperation( "GradedModule",
        [ IsHomalgModule, IsList, IsHomalgGradedRing ] );

DeclareOperation( "LeftPresentationWithDegrees",
        [ IsHomalgMatrix, IsList, IsHomalgGradedRing ] );

DeclareOperation( "LeftPresentationWithDegrees",
        [ IsHomalgMatrix, IsInt, IsHomalgGradedRing ] );

DeclareOperation( "LeftPresentationWithDegrees",
        [ IsHomalgMatrix, IsHomalgGradedRing ] );

DeclareOperation( "RightPresentationWithDegrees",
        [ IsHomalgMatrix, IsList, IsHomalgGradedRing ] );

DeclareOperation( "RightPresentationWithDegrees",
        [ IsHomalgMatrix, IsInt, IsHomalgGradedRing ] );

DeclareOperation( "RightPresentationWithDegrees",
        [ IsHomalgMatrix, IsHomalgGradedRing ] );

DeclareOperation( "FreeLeftModuleWithDegrees",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "FreeLeftModuleWithDegrees",
        [ IsList, IsHomalgRing ] );

DeclareOperation( "FreeLeftModuleWithDegrees",
        [ IsInt, IsHomalgRing, IsInt ] );

DeclareOperation( "FreeLeftModuleWithDegrees",
        [ IsInt, IsHomalgRing ] );

DeclareOperation( "FreeRightModuleWithDegrees",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "FreeRightModuleWithDegrees",
        [ IsList, IsHomalgRing ] );

DeclareOperation( "FreeRightModuleWithDegrees",
        [ IsInt, IsHomalgRing, IsInt ] );

DeclareOperation( "FreeRightModuleWithDegrees",
        [ IsInt, IsHomalgRing ] );

DeclareOperation( "PresentationWithDegrees",
        [ IsHomalgGenerators, IsHomalgRelations, IsList, IsHomalgGradedRing] );

DeclareOperation( "PresentationWithDegrees",
        [ IsHomalgGenerators, IsHomalgRelations, IsInt, IsHomalgGradedRing] );

DeclareOperation( "PresentationWithDegrees",
        [ IsHomalgGenerators, IsHomalgRelations, IsHomalgGradedRing] );

#DeclareOperation( "POW",
#        [ IsHomalgModule, IsInt ] );

#DeclareOperation( "POW",
#        [ IsHomalgModule, IsList ] );

#DeclareOperation( "POW",
#        [ IsHomalgGradedRing, IsInt ] );

#DeclareOperation( "POW",
#        [ IsHomalgGradedRing, IsList ] );

# global functions:

# basic operations:

DeclareOperation( "UnderlyingModule",
          [ IsHomalgGradedModule ] );

DeclareOperation( "SetOfDegreesOfGenerators",
        [ IsHomalgGradedModule ] );

# DeclareOperation( "EpiOnRightFactor",
#           [ IsHomalgGradedModule ] );
# 
# DeclareOperation( "EpiOnLeftFactor",
#           [ IsHomalgGradedModule ] );
# 
# DeclareOperation( "MonoOfLeftSummand",
#           [ IsHomalgGradedModule ] );
# 
# DeclareOperation( "MonoOfRightSummand",
#           [ IsHomalgGradedModule ] );


#DeclareOperation( "DegreesOfGenerators",
#        [ IsHomalgGradedModule ] );

#DeclareOperation( "DegreesOfGenerators",
#        [ IsHomalgGradedModule, IsPosInt ] );

# attributes
####################################
#
# synonyms:
#
####################################
