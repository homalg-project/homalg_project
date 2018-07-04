#############################################################################
##
##  ResidueClassRing.gi         MatricesForHomalg package    Mohamed Barakat
##
##  Copyright 2007-2009 Mohamed Barakat, Universität des Saarlandes
##
##  Declaration stuff for homalg residue class rings.
##
#############################################################################

####################################
#
# properties:
#
####################################

##  <#GAPDoc Label="IsReducedModuloRingRelations">
##  <ManSection>
##    <Prop Arg="A" Name="IsReducedModuloRingRelations"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsReducedModuloRingRelations",
        IsHomalgMatrix );

####################################
#
# attributes:
#
####################################

##  <#GAPDoc Label="RingRelations">
##  <ManSection>
##    <Attr Arg="R" Name="RingRelations"/>
##    <Returns>a set of &homalg; relations on one generator</Returns>
##    <Description>
##      In case <A>R</A> was constructed as a residue class ring <M>S/I</M>, and only in this case,
##      the generators of the ideal of relations <M>I</M> are returned as a
##      set of &homalg; relations on one generator. It assumed that either <A>R</A> is commutative,
##      or that the specified <C>Involution</C> in the <C>homalgTable</C> of <A>R</A> fixes the ideal <M>I</M>.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "RingRelations",
        IsHomalgRing );

##  <#GAPDoc Label="DefiningIdeal">
##  <ManSection>
##    <Attr Arg="R" Name="DefiningIdeal"/>
##    <Returns>a set of &homalg; relations on one generator</Returns>
##    <Description>
##      In case <A>R</A> was constructed as a residue class ring <M>S/J</M>, and only in this case,
##      the ideal <M>J</M>. It assumed that either <A>R</A> is commutative, or that the specified
##      <C>Involution</C> in the <C>homalgTable</C> of <A>R</A> fixes the ideal <M>I</M>.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "DefiningIdeal",
        IsHomalgRing );

##  <#GAPDoc Label="AmbientRing">
##  <ManSection>
##    <Attr Arg="R" Name="AmbientRing"/>
##    <Returns>a &homalg; ring</Returns>
##    <Description>
##      In case <A>R</A> was constructed as a residue class ring <M>S/I</M>, and only in this case,
##      the &homalg; ring <M>S</M> is returned.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "AmbientRing",
        IsHomalgRing );

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareOperation( "CreateHomalgTableForResidueClassRings",
        [ IsHomalgRing ] );

DeclareOperation( "/",
        [ IsHomalgRing, IsHomalgRingRelations ] );

## also declares [ IsHomalgRing, IsHomalgMatrix ]
DeclareOperation( "/",
        [ IsHomalgRing, IsRingElement ] );

#DeclareOperation( "/",
#        [ IsHomalgRing, IsHomalgMatrix ] );

DeclareOperation( "/",
        [ IsHomalgRing, IsList ] );

DeclareGlobalFunction( "HomalgResidueClassRingElement" );

DeclareOperation( "BlindlyCopyMatrixPropertiesToResidueClassMatrix",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareGlobalFunction( "HomalgResidueClassMatrix" );

# basic operations:

DeclareOperation( "UnionOfRowsOp",
        [ IsHomalgMatrix, IsHomalgRingRelations ] );

DeclareOperation( "UnionOfRowsOp",
        [ IsHomalgMatrix ] );

DeclareOperation( "UnionOfColumns",
        [ IsHomalgMatrix, IsHomalgRingRelations ] );

DeclareOperation( "UnionOfColumns",
        [ IsHomalgMatrix ] );

DeclareOperation( "DecideZero",
        [ IsRingElement, IsHomalgRing ] );

DeclareOperation( "DecideZero",
        [ IsHomalgRingElement ] );
