#############################################################################
##
##  HomalgSubobject.gd          homalg package               Mohamed Barakat
##
##  Copyright 2007-2010 Mohamed Barakat, RWTH Aachen
##
##  Declarations for subobjects of objects of (Abelian) categories.
##
#############################################################################

####################################
#
# properties:
#
####################################

##  <#GAPDoc Label="ConstructedAsAnIdeal">
##  <ManSection>
##    <Prop Arg="J" Name="ConstructedAsAnIdeal"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; subobject <A>J</A> was constructed as an ideal. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "ConstructedAsAnIdeal",
        IsHomalgObject );

####################################
#
# attributes:
#
####################################

##  <#GAPDoc Label="EmbeddingInSuperObject">
##  <ManSection>
##    <Attr Arg="N" Name="EmbeddingInSuperObject"/>
##    <Returns>a &homalg; map</Returns>
##    <Description>
##      In case <A>N</A> was defined as a subobject of some object <M>L</M> the embedding of <A>N</A> in <M>L</M> is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "EmbeddingInSuperObject",
        IsHomalgObject );

##  <#GAPDoc Label="FactorObject">
##  <ManSection>
##    <Attr Arg="N" Name="FactorObject"/>
##    <Returns>a &homalg; object</Returns>
##    <Description>
##      In case <A>N</A> was defined as a subobject of some object <M>L</M> the factor object <M>L/</M><A>N</A> is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "FactorObject",
        IsHomalgObject );

####################################
#
# global functions and operations:
#
####################################

# constructors:

# global functions:

# basic operations:

DeclareOperation( "MapHavingSubobjectAsItsImage",
        [ IsHomalgObject ] );

DeclareOperation( "MatrixOfSubobjectGenerators",
        [ IsHomalgObject ] );

DeclareOperation( "SuperObject",
        [ IsHomalgObject ] );

DeclareOperation( "UnderlyingObject",
        [ IsHomalgObject ] );

DeclareOperation( "IsSubset",
        [ IsHomalgObject, IsHomalgObject ] );

