#############################################################################
##
##  HomalgMap.gd                homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for homalg maps ( = module homomorphisms ).
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
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; category of &homalg; maps. <Br/><Br/>
##      (It is a subcategory of the &GAP; category <C>IsHomalgMorphism</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgMap",
        IsHomalgMorphism );

##  <#GAPDoc Label="IsHomalgSelfMap">
##  <ManSection>
##    <Filt Type="Category" Arg="phi" Name="IsHomalgSelfMap"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; category of &homalg; self-maps. <Br/><Br/>
##      (It is a subcategory of the &GAP; categories
##       <C>IsHomalgMap</C> and <C>IsHomalgEndomorphism</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgSelfMap",
        IsHomalgMap and
        IsHomalgEndomorphism );

####################################
#
# properties:
#
####################################

## all properties are declared in homalg.gd for the bigger category IsHomalgMorphism

##  <#GAPDoc Label="IsMorphism:map">
##  <ManSection>
##    <Prop Arg="phi" Name="IsMorphism" Label="for maps"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if <A>phi</A> is a well-defined map, i.e. independent of all involved presentations.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsGeneralizedMorphism:map">
##  <ManSection>
##    <Prop Arg="phi" Name="IsGeneralizedMorphism" Label="for maps"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if <A>phi</A> is a generalized morphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsGeneralizedEpimorphism:map">
##  <ManSection>
##    <Prop Arg="phi" Name="IsGeneralizedEpimorphism" Label="for maps"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if <A>phi</A> is a generalized epimorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsGeneralizedMonomorphism:map">
##  <ManSection>
##    <Prop Arg="phi" Name="IsGeneralizedMonomorphism" Label="for maps"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if <A>phi</A> is a generalized monomorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsGeneralizedIsomorphism:map">
##  <ManSection>
##    <Prop Arg="phi" Name="IsGeneralizedIsomorphism" Label="for maps"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if <A>phi</A> is a generalized isomorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsIdentityMorphism:map">
##  <ManSection>
##    <Prop Arg="phi" Name="IsIdentityMorphism" Label="for maps"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; map <A>phi</A> is the identity morphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsMonomorphism:map">
##  <ManSection>
##    <Prop Arg="phi" Name="IsMonomorphism" Label="for maps"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; map <A>phi</A> is a monomorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsEpimorphism:map">
##  <ManSection>
##    <Prop Arg="phi" Name="IsEpimorphism" Label="for maps"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; map <A>phi</A> is an epimorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsSplitMonomorphism:map">
##  <ManSection>
##    <Prop Arg="phi" Name="IsSplitMonomorphism" Label="for maps"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; map <A>phi</A> is a split monomorphism. <Br/>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsSplitEpimorphism:map">
##  <ManSection>
##    <Prop Arg="phi" Name="IsSplitEpimorphism" Label="for maps"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; map <A>phi</A> is a split epimorphism. <Br/>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsIsomorphism:map">
##  <ManSection>
##    <Prop Arg="phi" Name="IsIsomorphism" Label="for maps"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; map <A>phi</A> is an isomorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsAutomorphism:map">
##  <ManSection>
##    <Prop Arg="phi" Name="IsAutomorphism" Label="for maps"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; map <A>phi</A> is an automorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

####################################
#
# attributes:
#
####################################

## some attributes are already declared in homalg.gd for the bigger category IsHomalgMorphism

##  <#GAPDoc Label="Source:map">
##  <ManSection>
##    <Attr Arg="phi" Name="Source" Label="for maps"/>
##    <Returns>a &homalg; module</Returns>
##    <Description>
##      The source of the &homalg; map <A>phi</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="Range:map">
##  <ManSection>
##    <Attr Arg="phi" Name="Range" Label="for maps"/>
##    <Returns>a &homalg; module</Returns>
##    <Description>
##      The target (range) of the &homalg; map <A>phi</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="DegreeOfMorphism:map">
##  <ManSection>
##    <Attr Arg="phi" Name="DegreeOfMorphism" Label="for maps"/>
##    <Returns>an integer</Returns>
##    <Description>
##      The degree of the morphism <A>phi</A> of graded modules. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="DegreeOfMorphism:map">
##  <ManSection>
##    <Attr Arg="phi" Name="DegreeOfMorphism" Label="for maps"/>
##    <Returns>an integer</Returns>
##    <Description>
##      The degree of the morphism <A>phi</A> of graded modules. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="MorphismAidMap:map">
##  <ManSection>
##    <Attr Arg="phi" Name="MorphismAidMap" Label="for maps"/>
##    <Returns>a &homalg; map</Returns>
##    <Description>
##      The morphism aid map of a true generalized map. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "MorphismAidMap",
        IsHomalgMap );

##  <#GAPDoc Label="ImageSubmodule">
##  <ManSection>
##    <Attr Arg="phi" Name="ImageSubmodule" Label="for maps"/>
##    <Returns>a &homalg; submodule</Returns>
##    <Description>
##      This constructor returns the finitely generated image of the &homalg; map <A>phi</A>
##      as a submodule of the &homalg; module <C>Range</C>(<A>phi</A>) with generators given by <A>phi</A>
##      applied to the generators of its source module.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "ImageSubmodule",
        IsHomalgMap );

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareGlobalFunction( "HomalgMap" );

DeclareGlobalFunction( "HomalgZeroMap" );

DeclareGlobalFunction( "HomalgIdentityMap" );

DeclareOperation( "OnAFreeSource",
        [ IsHomalgMap ] );

DeclareOperation( "RemoveMorphismAidMap",
        [ IsHomalgMap ] );

DeclareOperation( "GeneralizedMap",
        [ IsHomalgMap, IsObject ] );

DeclareOperation( "AddToMorphismAidMap",
        [ IsHomalgMap, IsObject ] );

DeclareOperation( "AssociatedMap",
        [ IsHomalgMap ] );

DeclareOperation( "Subobject",
        [ IsHomalgMap ] );

# basic operations:

DeclareOperation( "homalgResetFilters",
        [ IsHomalgMap ] );

DeclareOperation( "PositionOfTheDefaultSetOfRelations",
        [ IsHomalgMap ] );	## provided to avoid branching in the code and always returns fail

DeclareOperation( "PairOfPositionsOfTheDefaultSetOfRelations",
        [ IsHomalgMap ] );

DeclareOperation( "MatrixOfMap",
        [ IsHomalgMap, IsPosInt, IsPosInt ] );

DeclareOperation( "MatrixOfMap",
        [ IsHomalgMap, IsPosInt ] );

DeclareOperation( "MatrixOfMap",
        [ IsHomalgMap ] );

DeclareOperation( "DecideZero",
        [ IsHomalgMap, IsHomalgRelations ] );

DeclareOperation( "UnionOfRelations",
        [ IsHomalgMap ] );

DeclareOperation( "SyzygiesGenerators",
        [ IsHomalgMap ] );

DeclareOperation( "ReducedSyzygiesGenerators",
        [ IsHomalgMap ] );

DeclareOperation( "PreCompose",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "PreInverse",
        [ IsHomalgMap ] );

DeclareOperation( "PostInverse",
        [ IsHomalgMap ] );

DeclareOperation( "CompleteImageSquare",
        [ IsHomalgMap, IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "UpdateModulesByMap",
        [ IsHomalgMap ] );

