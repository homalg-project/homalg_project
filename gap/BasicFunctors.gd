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

## ImageObject
DeclareGlobalFunction( "_Functor_ImageObject_OnObjects" );

DeclareGlobalVariable( "functor_ImageObject" );

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

## BaseChange
DeclareGlobalFunction( "_functor_BaseChange_OnObjects" );

DeclareGlobalVariable( "functor_BaseChange" );

####################################
#
# attributes:
#
####################################

##  <#GAPDoc Label="CokernelEpi">
##  <ManSection>
##    <Attr Arg="phi" Name="CokernelEpi" Label="for morphisms"/>
##    <Returns>a &homalg; morphism</Returns>
##    <Description>
##      The natural epimorphism from the <C>Range</C><M>(</M><A>phi</A><M>)</M>
##      onto the <C>Cokernel</C><M>(</M><A>phi</A><M>)</M> (cf. <Ref Oper="Cokernel"/>).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CokernelEpi",
        IsHomalgMorphism );

##  <#GAPDoc Label="CokernelNaturalGeneralizedIsomorphism">
##  <ManSection>
##    <Attr Arg="phi" Name="CokernelNaturalGeneralizedIsomorphism" Label="for morphisms"/>
##    <Returns>a &homalg; morphism</Returns>
##    <Description>
##      The natural generalized isomorphism from the <C>Cokernel</C><M>(</M><A>phi</A><M>)</M>
##      onto the <C>Range</C><M>(</M><A>phi</A><M>)</M> (cf. <Ref Oper="Cokernel"/>).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CokernelNaturalGeneralizedIsomorphism",
        IsHomalgMorphism );

##  <#GAPDoc Label="KernelEmb:map">
##  <ManSection>
##    <Attr Arg="phi" Name="KernelEmb" Label="for morphisms"/>
##    <Returns>a &homalg; morphism</Returns>
##    <Description>
##      The natural embedding of the <C>Kernel</C><M>(</M><A>phi</A><M>)</M>
##      into the <C>Source</C><M>(</M><A>phi</A><M>)</M> (cf. <Ref Oper="Kernel" Label="for maps"/>).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "KernelEmb",
        IsHomalgMorphism );

##  <#GAPDoc Label="ImageObjectEmb">
##  <ManSection>
##    <Attr Arg="phi" Name="ImageObjectEmb" Label="for morphisms"/>
##    <Returns>a &homalg; morphism</Returns>
##    <Description>
##      The natural embedding of the <C>ImageObject</C><M>(</M><A>phi</A><M>)</M>
##      into the <C>Range</C><M>(</M><A>phi</A><M>)</M> (cf. <Ref Oper="ImageObject"/>).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ImageObjectEmb",
        IsHomalgMorphism );

##  <#GAPDoc Label="ImageObjectEpi">
##  <ManSection>
##    <Attr Arg="phi" Name="ImageObjectEpi" Label="for morphisms"/>
##    <Returns>a &homalg; morphism</Returns>
##    <Description>
##      The natural epimorphism from the <C>Source</C><M>(</M><A>phi</A><M>)</M>
##      onto the <C>ImageObject</C><M>(</M><A>phi</A><M>)</M> (cf. <Ref Oper="ImageObject"/>).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ImageObjectEpi",
        IsHomalgMorphism );

##  <#GAPDoc Label="NatTrIdToHomHom_R">
##  <ManSection>
##    <Attr Arg="M" Name="NatTrIdToHomHom_R" Label="for morphisms"/>
##    <Returns>a &homalg; morphism</Returns>
##    <Description>
##      The natural evaluation map from the &homalg; module <A>M</A>
##      to its double dual <C>HomHom</C><M>(</M><A>M</A><M>)</M> (cf. <Ref Oper="Functor_HomHom"/>).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "NatTrIdToHomHom_R",
        IsHomalgObject );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "Cokernel",
        [ IsHomalgMorphism ] );

DeclareOperation( "ImageObject",	## Image is unfortunately declared in the GAP library as a global function :(
        [ IsHomalgMorphism ] );

## Kernel is already declared in the GAP library via DeclareOperation("Kernel",[IsObject]); (why so general?)

DeclareOperation( "DefectOfExactness",
        [ IsHomalgComplex ] );

DeclareOperation( "DefectOfExactness",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "Hom",
        [ IsHomalgObject, IsHomalgObject ] );

DeclareOperation( "LeftDualizingFunctor",
        [ IsHomalgRing, IsString ] );

DeclareOperation( "LeftDualizingFunctor",
        [ IsHomalgRing ] );

DeclareOperation( "RightDualizingFunctor",
        [ IsHomalgRing, IsString ] );

DeclareOperation( "RightDualizingFunctor",
        [ IsHomalgRing ] );

if IsOperation( TensorProduct ) then
    
    ## GAP 4.4 style
    DeclareOperation( "TensorProduct",
            [ IsHomalgObject, IsHomalgObject ] );
    
else
        ## GAP 4.5 style
    DeclareOperation( "TensorProductOp",
	    [ IsList, IsHomalgRingOrObjectOrMorphism ] );
    
fi;

DeclareOperation( "BaseChange",
        [ IsHomalgRing, IsHomalgModule ] );

####################################
#
# synonyms:
#
####################################

DeclareSynonym( "DefectOfHoms",
        DefectOfExactness );

