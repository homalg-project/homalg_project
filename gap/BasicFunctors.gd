#############################################################################
##
##  BasicFunctors.gd            homalg package
##
##  Copyright 2007-2008 Mohamed Barakat, RWTH Aachen
##
##  Declarations for basic functors.
##
#############################################################################

####################################
#
# global variables:
#
####################################

## Kernel
DeclareGlobalFunction( "_Functor_Kernel_OnObjects" );

DeclareGlobalVariable( "functor_Kernel" );

## DefectOfExactness
DeclareGlobalFunction( "_Functor_DefectOfExactness_OnObjects" );

DeclareGlobalVariable( "functor_DefectOfExactness" );

## Dualize
DeclareGlobalVariable( "Functor_Dualize" );

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
##      onto the <C>Cokernel</C><M>(</M><A>phi</A><M>)</M>.
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
##      onto the <C>Range</C><M>(</M><A>phi</A><M>)</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CokernelNaturalGeneralizedIsomorphism",
        IsHomalgMorphism );

##  <#GAPDoc Label="KernelEmb">
##  <ManSection>
##    <Attr Arg="phi" Name="KernelEmb" Label="for morphisms"/>
##    <Returns>a &homalg; morphism</Returns>
##    <Description>
##      The natural embedding of the <C>Kernel</C><M>(</M><A>phi</A><M>)</M>
##      into the <C>Source</C><M>(</M><A>phi</A><M>)</M>.
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
##      into the <C>Range</C><M>(</M><A>phi</A><M>)</M>.
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
##      onto the <C>ImageObject</C><M>(</M><A>phi</A><M>)</M>.
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
##      The natural evaluation morphism from the &homalg; object <A>M</A>
##      to its double dual <C>HomHom</C><M>(</M><A>M</A><M>)</M>.
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

DeclareOperation( "Ext",
        [ IsInt, IsHomalgObject, IsHomalgObject ] );

DeclareOperation( "Tor",
        [ IsInt, IsHomalgObject, IsHomalgObject ] );

DeclareOperation( "LeftDualizingFunctor",
        [ IsStructureObject, IsString ] );

DeclareOperation( "LeftDualizingFunctor",
        [ IsStructureObject ] );

DeclareOperation( "RightDualizingFunctor",
        [ IsStructureObject, IsString ] );

DeclareOperation( "RightDualizingFunctor",
        [ IsStructureObject ] );

DeclareOperation( "Dualize",
        [ IsStructureObjectOrObjectOrMorphism ] );

if IsOperation( TensorProduct ) then
    
    ## GAP 4.4 style
    DeclareOperation( "TensorProduct",
            [ IsHomalgObject, IsHomalgObject ] );
    
else
        ## GAP 4.5 style
    DeclareOperation( "TensorProductOp",
	    [ IsList, IsStructureObjectOrObjectOrMorphism ] );
    
fi;

####################################
#
# synonyms:
#
####################################

DeclareSynonym( "DefectOfHoms",
        DefectOfExactness );

