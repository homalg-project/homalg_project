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

##
DeclareProperty( "TrivialArtinianSubmodule",
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

## what was that again ;)
DeclareAttribute( "ZerothRegularity",
          IsHomalgGradedModule );

##  <#GAPDoc Label="BettiDiagram:module">
##  <ManSection>
##    <Attr Arg="M" Name="BettiDiagram" Label="for modules"/>
##    <Returns>a &homalg; diagram</Returns>
##    <Description>
##      The Betti diagram of the &homalg; graded module <A>M</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "BettiDiagram",
        IsHomalgGradedModule );

##  <#GAPDoc Label="CastelnuovoMumfordRegularity">
##  <ManSection>
##    <Attr Arg="M" Name="CastelnuovoMumfordRegularity"/>
##    <Returns>a non-negative integer</Returns>
##    <Description>
##      The Castelnuovo-Mumford regularity of the &homalg; graded module <A>M</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CastelnuovoMumfordRegularity",
        IsHomalgGradedModule );

##  <#GAPDoc Label="CastelnuovoMumfordRegularityOfSheafification">
##  <ManSection>
##    <Attr Arg="M" Name="CastelnuovoMumfordRegularityOfSheafification"/>
##    <Returns>a non-negative integer</Returns>
##    <Description>
##      The Castelnuovo-Mumford regularity of the sheafification of &homalg; graded module <A>M</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CastelnuovoMumfordRegularityOfSheafification",
        IsHomalgGradedModule );

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

DeclareOperation( "DegreesOfGenerators",
        [ IsHomalgModule ] );

DeclareOperation( "DegreesOfGenerators",
        [ IsHomalgModule, IsPosInt ] );

DeclareOperation( "CompleteComplexByLinearResolution",
        [ IsInt, IsHomalgComplex ] );

# constructors:

DeclareOperation( "GradedModule",
        [ IsHomalgModule, IsInt, IsHomalgGradedRing ] );

DeclareOperation( "GradedModule",
        [ IsHomalgModule, IsHomalgElement, IsHomalgGradedRing ] );

DeclareOperation( "GradedModule",
        [ IsHomalgModule, IsHomalgGradedRing ] );

DeclareOperation( "GradedModule",
        [ IsHomalgModule, IsList, IsHomalgGradedRing ] );

DeclareOperation( "LeftPresentationWithDegrees",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "LeftPresentationWithDegrees",
        [ IsHomalgMatrix, IsInt ] );

DeclareOperation( "LeftPresentationWithDegrees",
        [ IsHomalgMatrix, IsHomalgElement ] );

DeclareOperation( "LeftPresentationWithDegrees",
        [ IsHomalgMatrix ] );

DeclareOperation( "RightPresentationWithDegrees",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "RightPresentationWithDegrees",
        [ IsHomalgMatrix, IsInt ] );

DeclareOperation( "RightPresentationWithDegrees",
        [ IsHomalgMatrix, IsHomalgElement ] );

DeclareOperation( "RightPresentationWithDegrees",
        [ IsHomalgMatrix ] );

DeclareOperation( "LeftPresentationWithDegrees",
        [ IsHomalgMatrix, IsList, IsHomalgGradedRing ] );

DeclareOperation( "LeftPresentationWithDegrees",
        [ IsHomalgMatrix, IsInt, IsHomalgGradedRing ] );

DeclareOperation( "LeftPresentationWithDegrees",
        [ IsHomalgMatrix, IsHomalgElement, IsHomalgGradedRing ] );

DeclareOperation( "LeftPresentationWithDegrees",
        [ IsHomalgMatrix, IsHomalgGradedRing ] );

DeclareOperation( "RightPresentationWithDegrees",
        [ IsHomalgMatrix, IsList, IsHomalgGradedRing ] );

DeclareOperation( "RightPresentationWithDegrees",
        [ IsHomalgMatrix, IsInt, IsHomalgGradedRing ] );

DeclareOperation( "RightPresentationWithDegrees",
        [ IsHomalgMatrix, IsHomalgElement, IsHomalgGradedRing ] );

DeclareOperation( "RightPresentationWithDegrees",
        [ IsHomalgMatrix, IsHomalgGradedRing ] );

DeclareOperation( "FreeLeftModuleWithDegrees",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "FreeLeftModuleWithDegrees",
        [ IsList, IsHomalgRing ] );

DeclareOperation( "FreeLeftModuleWithDegrees",
        [ IsInt, IsHomalgRing, IsInt ] );

DeclareOperation( "FreeLeftModuleWithDegrees",
        [ IsInt, IsHomalgRing, IsHomalgElement ] );

DeclareOperation( "FreeLeftModuleWithDegrees",
        [ IsInt, IsHomalgRing ] );

DeclareOperation( "FreeRightModuleWithDegrees",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "FreeRightModuleWithDegrees",
        [ IsList, IsHomalgRing ] );

DeclareOperation( "FreeRightModuleWithDegrees",
        [ IsInt, IsHomalgRing, IsInt ] );

DeclareOperation( "FreeRightModuleWithDegrees",
        [ IsInt, IsHomalgRing, IsHomalgElement ] );

DeclareOperation( "FreeRightModuleWithDegrees",
        [ IsInt, IsHomalgRing ] );

DeclareOperation( "PresentationWithDegrees",
        [ IsHomalgGenerators, IsHomalgRelations, IsList, IsHomalgGradedRing] );

DeclareOperation( "PresentationWithDegrees",
        [ IsHomalgGenerators, IsHomalgRelations, IsInt, IsHomalgGradedRing] );

DeclareOperation( "PresentationWithDegrees",
        [ IsHomalgGenerators, IsHomalgRelations, IsHomalgElement, IsHomalgGradedRing] );

DeclareOperation( "PresentationWithDegrees",
        [ IsHomalgGenerators, IsHomalgRelations, IsHomalgGradedRing] );

DeclareOperation( "POW",
        [ IsHomalgModule, IsInt ] );

DeclareOperation( "POW",
        [ IsHomalgModule, IsList ] );

DeclareOperation( "POW",
        [ IsHomalgModule, IsHomalgElement ] );

DeclareOperation( "POW",
        [ IsHomalgRing, IsInt ] );

DeclareOperation( "POW",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "POW",
        [ IsHomalgRing, IsHomalgElement ] );

# global functions:

DeclareGlobalFunction( "HilbertPoincareSeries_ViaBettiDiagramOfMinimalFreeResolution" );

DeclareGlobalFunction( "CoefficientsOfNumeratorOfHilbertPoincareSeries_ViaBettiDiagramOfMinimalFreeResolution" );

DeclareGlobalFunction( "HilbertPolynomial_ViaBettiDiagramOfMinimalFreeResolution" );

# basic operations:

DeclareOperation( "SetOfDegreesOfGenerators",
        [ IsHomalgGradedModule ] );


# attributes

DeclareAttribute( "UnderlyingModule",
          IsHomalgGradedModule );


####################################
#
# synonyms:
#
####################################
