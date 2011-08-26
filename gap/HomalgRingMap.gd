#############################################################################
##
##  HomalgRingMaps.gd           Modules package              Mohamed Barakat
##
##  Copyright 2009, Mohamed Barakat, Universität des Saarlandes
##
##  Declarations of procedures for homalg ring maps.
##
#############################################################################

####################################
#
# properties:
#
####################################

####################################
#
# attributes:
#
####################################

##  <#GAPDoc Label="KernelSubobject:ringmap">
##  <ManSection>
##    <Attr Arg="phi" Name="KernelSubobject" Label="for ring maps"/>
##    <Returns>a &homalg; submodule</Returns>
##    <Description>
##      The kernel ideal of the ring map <A>phi</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "KernelSubobject",
        IsHomalgRingMap );

##  <#GAPDoc Label="KernelEmb:ringmap">
##  <ManSection>
##    <Attr Arg="phi" Name="KernelEmb" Label="for ring maps"/>
##    <Returns>a &homalg; map</Returns>
##    <Description>
##      The embedding of the kernel ideal <C>Kernel</C><M>(</M><A>phi</A><M>)</M> into the <C>Source</C><M>(</M><A>phi</A><M>)</M>,
##      both viewed as modules over the ring <M>R := </M><C>Source</C><M>(</M><A>phi</A><M>)</M>
##      (cf. <Ref Oper="Kernel" Label="for ring maps"/>).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "KernelEmb",
        IsHomalgRingMap );

## intrinsic attributes:
##
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
## should all be added by hand to LIMAP.intrinsic_attributes
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

####################################
#
# global functions and operations:
#
####################################

