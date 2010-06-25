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
# attributes:
#
####################################

##  <#GAPDoc Label="EmbeddingInSuperObject">
##  <ManSection>
##    <Attr Arg="N" Name="EmbeddingInSuperObject"/>
##    <Returns>a &homalg; map</Returns>
##    <Description>
##      In case <A>N</A> was defined as a submodule of some module <M>L</M> the embedding of <A>N</A> in <M>L</M> is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "EmbeddingInSuperObject",
        IsHomalgObject );

##  <#GAPDoc Label="FactorObject">
##  <ManSection>
##    <Attr Arg="N" Name="FactorObject"/>
##    <Returns>a &homalg; module</Returns>
##    <Description>
##      In case <A>N</A> was defined as a submodule of some module <M>L</M> the factor module <M>L/</M><A>N</A> is returned.
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

