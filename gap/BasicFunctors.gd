#############################################################################
##
##  BasicFunctors.gd            homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for basic functors.
##
#############################################################################

####################################
#
# global variables:
#
####################################

## Cokernel
DeclareGlobalFunction( "_Functor_Cokernel_OnObjects" );

DeclareGlobalVariable( "functor_Cokernel" );

## ImageModule
DeclareGlobalFunction( "_Functor_ImageModule_OnObjects" );

DeclareGlobalVariable( "functor_ImageModule" );

## Kernel
DeclareGlobalFunction( "_Functor_Kernel_OnObjects" );

DeclareGlobalVariable( "functor_Kernel" );

## DefectOfExactness
DeclareGlobalFunction( "_Functor_DefectOfExactness_OnObjects" );

DeclareGlobalVariable( "functor_DefectOfExactness" );

## Hom
DeclareGlobalFunction( "_Functor_Hom_OnObjects" );

DeclareGlobalFunction( "_Functor_Hom_OnMorphisms" );

DeclareGlobalVariable( "Functor_Hom" );

## TensorProduct
DeclareGlobalFunction( "_Functor_TensorProduct_OnObjects" );

DeclareGlobalFunction( "_Functor_TensorProduct_OnMorphisms" );

DeclareGlobalVariable( "Functor_TensorProduct" );

####################################
#
# attributes:
#
####################################

##  <#GAPDoc Label="CokernelEpi">
##  <ManSection>
##    <Attr Arg="phi" Name="CokernelEpi" Label="for maps"/>
##    <Returns>a &homalg; map</Returns>
##    <Description>
##      The natural epimorphism from the <C>Range</C><M>(</M><A>phi</A><M>)</M>
##      onto the <C>Cokernel</C><M>(</M><A>phi</A><M>)</M> (cf. <Ref Oper="Cokernel"/>).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CokernelEpi",
        IsHomalgMap );

##  <#GAPDoc Label="CokernelNaturalGeneralizedIsomorphism">
##  <ManSection>
##    <Attr Arg="phi" Name="CokernelNaturalGeneralizedIsomorphism" Label="for maps"/>
##    <Returns>a &homalg; map</Returns>
##    <Description>
##      The natural generalized isomorphism from the <C>Cokernel</C><M>(</M><A>phi</A><M>)</M>
##      onto the <C>Range</C><M>(</M><A>phi</A><M>)</M> (cf. <Ref Oper="Cokernel"/>).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CokernelNaturalGeneralizedIsomorphism",
        IsHomalgMap );

##  <#GAPDoc Label="KernelEmb:map">
##  <ManSection>
##    <Attr Arg="phi" Name="KernelEmb" Label="for maps"/>
##    <Returns>a &homalg; map</Returns>
##    <Description>
##      The natural embedding of the <C>Kernel</C><M>(</M><A>phi</A><M>)</M>
##      into the <C>Source</C><M>(</M><A>phi</A><M>)</M> (cf. <Ref Oper="Kernel" Label="for maps"/>).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "KernelEmb",
        IsHomalgMap );

##  <#GAPDoc Label="ImageModuleEmb">
##  <ManSection>
##    <Attr Arg="phi" Name="ImageModuleEmb" Label="for maps"/>
##    <Returns>a &homalg; map</Returns>
##    <Description>
##      The natural embedding of the <C>ImageModule</C><M>(</M><A>phi</A><M>)</M>
##      into the <C>Range</C><M>(</M><A>phi</A><M>)</M> (cf. <Ref Oper="ImageModule"/>).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ImageModuleEmb",
        IsHomalgMap );

##  <#GAPDoc Label="ImageModuleEpi">
##  <ManSection>
##    <Attr Arg="phi" Name="ImageModuleEpi" Label="for maps"/>
##    <Returns>a &homalg; map</Returns>
##    <Description>
##      The natural epimorphism from the <C>Source</C><M>(</M><A>phi</A><M>)</M>
##      onto the <C>ImageModule</C><M>(</M><A>phi</A><M>)</M> (cf. <Ref Oper="ImageModule"/>).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ImageModuleEpi",
        IsHomalgMap );

##  <#GAPDoc Label="NatTrIdToHomHom_R">
##  <ManSection>
##    <Attr Arg="M" Name="NatTrIdToHomHom_R" Label="for maps"/>
##    <Returns>a &homalg; map</Returns>
##    <Description>
##      The natural evaluation map from the &homalg; module <A>M</A>
##      to its double dual <C>HomHom</C><M>(</M><A>M</A><M>)</M> (cf. <Ref Oper="Functor_HomHom"/>).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "NatTrIdToHomHom_R",
        IsHomalgModule );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "Cokernel",
        [ IsHomalgMap ] );

DeclareOperation( "ImageModule",	## Image is unfortunately declared in the GAP library as a global function :(
        [ IsHomalgMap ] );

## Kernel is already declared in the GAP library via DeclareOperation("Kernel",[IsObject]); (why so general?)

DeclareOperation( "DefectOfExactness",
        [ IsHomalgComplex ] );

DeclareOperation( "DefectOfExactness",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "Hom",
        [ IsHomalgModule, IsHomalgModule ] );

DeclareOperation( "LeftDualizingFunctor",
        [ IsHomalgRing, IsString ] );

DeclareOperation( "LeftDualizingFunctor",
        [ IsHomalgRing ] );

DeclareOperation( "RightDualizingFunctor",
        [ IsHomalgRing, IsString ] );

DeclareOperation( "RightDualizingFunctor",
        [ IsHomalgRing ] );

DeclareOperation( "TensorProduct",
        [ IsHomalgModule, IsHomalgModule ] );

####################################
#
# synonyms:
#
####################################

DeclareSynonym( "DefectOfHoms",
        DefectOfExactness );

