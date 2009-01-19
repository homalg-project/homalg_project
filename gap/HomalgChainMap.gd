#############################################################################
##
##  HomalgChainMap.gd           homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for homalg chain maps.
##
#############################################################################

####################################
#
# categories:
#
####################################

# two new categories:

##  <#GAPDoc Label="IsHomalgChainMap">
##  <ManSection>
##    <Filt Type="Category" Arg="cm" Name="IsHomalgChainMap"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; category of &homalg; (co)chain maps. <Br/><Br/>
##      (It is a subcategory of the &GAP; category <C>IsHomalgMorphism</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgChainMap",
        IsHomalgMorphism );

##  <#GAPDoc Label="IsHomalgChainSelfMap">
##  <ManSection>
##    <Filt Type="Category" Arg="cm" Name="IsHomalgChainSelfMap"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; category of &homalg; (co)chain self-maps. <Br/><Br/>
##      (It is a subcategory of the &GAP; categories
##       <C>IsHomalgChainMap</C> and <C>IsHomalgEndomorphism</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgChainSelfMap",
        IsHomalgChainMap and
        IsHomalgEndomorphism );

####################################
#
# properties:
#
####################################

## further properties are declared in homalg.gd for the bigger category IsHomalgMorphism

##  <#GAPDoc Label="IsMorphism:chainmap">
##  <ManSection>
##    <Prop Arg="cm" Name="IsMorphism" Label="for chain maps"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if <A>cm</A> is a well-defined chain map, i.e. independent of all involved presentations.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsGeneralizedMorphism:chainmap">
##  <ManSection>
##    <Prop Arg="cm" Name="IsGeneralizedMorphism" Label="for chain maps"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if <A>cm</A> is a generalized morphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>m

##  <#GAPDoc Label="IsGeneralizedEpimorphism:chainmap">
##  <ManSection>
##    <Prop Arg="cm" Name="IsGeneralizedEpimorphism" Label="for chain maps"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if <A>cm</A> is a generalized epimorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsGeneralizedMonomorphism:chainmap">
##  <ManSection>
##    <Prop Arg="cm" Name="IsGeneralizedMonomorphism" Label="for chain maps"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if <A>cm</A> is a generalized monomorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsGeneralizedIsomorphism:chainmap">
##  <ManSection>
##    <Prop Arg="cm" Name="IsGeneralizedIsomorphism" Label="for chain maps"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if <A>cm</A> is a generalized isomorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsIdentityMorphism:chainmap">
##  <ManSection>
##    <Prop Arg="cm" Name="IsIdentityMorphism" Label="for chain maps"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; chain map <A>cm</A> is the identity chain map.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsMonomorphism:chainmap">
##  <ManSection>
##    <Prop Arg="cm" Name="IsMonomorphism" Label="for chain maps"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; chain map <A>cm</A> is a monomorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsEpimorphism:chainmap">
##  <ManSection>
##    <Prop Arg="cm" Name="IsEpimorphism" Label="for chain maps"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; chain map <A>cm</A> is an epimorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsSplitMonomorphism:chainmap">
##  <ManSection>
##    <Prop Arg="cm" Name="IsSplitMonomorphism" Label="for chain maps"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; chain map <A>cm</A> is a split monomorphism. <Br/>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsSplitEpimorphism:chainmap">
##  <ManSection>
##    <Prop Arg="cm" Name="IsSplitEpimorphism" Label="for chain maps"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; chain map <A>cm</A> is a split epimorphism. <Br/>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsIsomorphism:chainmap">
##  <ManSection>
##    <Prop Arg="cm" Name="IsIsomorphism" Label="for chain maps"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; chain map <A>cm</A> is an isomorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsAutomorphism:chainmap">
##  <ManSection>
##    <Prop Arg="cm" Name="IsAutomorphism" Label="for chain maps"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; chain map <A>cm</A> is an automorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsGradedMorphism">
##  <ManSection>
##    <Prop Arg="cm" Name="IsGradedMorphism" Label="for chain maps"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the source and target complex of the &homalg; chain map <A>cm</A> are graded objects, i.e. if all their morphisms vanish.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsGradedMorphism",
        IsHomalgChainMap );

##  <#GAPDoc Label="IsQuasiIsomorphism">
##  <ManSection>
##    <Prop Arg="cm" Name="IsQuasiIsomorphism" Label="for chain maps"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; chain map <A>cm</A> is a quasi-isomorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsQuasiIsomorphism",
        IsHomalgChainMap );

DeclareProperty( "IsImageSquare",
        IsHomalgChainMap );

DeclareProperty( "IsKernelSquare",
        IsHomalgChainMap );

DeclareProperty( "IsLambekPairOfSquares",
        IsHomalgChainMap );

DeclareProperty( "IsChainMapForPullback",
        IsHomalgChainMap );

DeclareProperty( "IsChainMapForPushout",
        IsHomalgChainMap );

####################################
#
# attributes:
#
####################################

## some attributes are already declared in homalg.gd for the bigger category IsHomalgMorphism

##  <#GAPDoc Label="Source:chainmap">
##  <ManSection>
##    <Attr Arg="cm" Name="Source" Label="for chain maps"/>
##    <Returns>a &homalg; complex</Returns>
##    <Description>
##      The source of the &homalg; chain map <A>cm</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="Range:chainmap">
##  <ManSection>
##    <Attr Arg="cm" Name="Range" Label="for chain maps"/>
##    <Returns>a &homalg; complex</Returns>
##    <Description>
##      The target (range) of the &homalg; chain map <A>cm</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareGlobalFunction( "HomalgChainMap" );

# basic operations:

DeclareOperation( "homalgResetFilters",
        [ IsHomalgChainMap ] );

DeclareOperation( "SourceOfSpecialChainMap",
        [ IsHomalgChainMap ] );

DeclareOperation( "RangeOfSpecialChainMap",
        [ IsHomalgChainMap ] );

DeclareOperation( "CertainMorphismOfSpecialChainMap",
        [ IsHomalgChainMap ] );

DeclareOperation( "PositionOfTheDefaultSetOfRelations",
        [ IsHomalgChainMap ] );	## provided to avoid branching in the code and always returns fail

DeclareOperation( "DegreesOfChainMap",
        [ IsHomalgChainMap ] );

DeclareOperation( "ObjectDegreesOfComplex",	## this is not a mistake
        [ IsHomalgChainMap ] );

DeclareOperation( "MorphismDegreesOfComplex",	## this is not a mistake
        [ IsHomalgChainMap ] );

DeclareOperation( "CertainMorphism",
        [ IsHomalgChainMap, IsInt ] );

DeclareOperation( "MorphismsOfChainMap",
        [ IsHomalgChainMap ] );

DeclareOperation( "CertainModuleOfChainMap",
        [ IsHomalgChainMap, IsInt ] );

DeclareOperation( "LowestDegree",
        [ IsHomalgChainMap ] );

DeclareOperation( "HighestDegree",
        [ IsHomalgChainMap ] );

DeclareOperation( "LowestDegreeMorphism",
        [ IsHomalgChainMap ] );

DeclareOperation( "HighestDegreeMorphism",
        [ IsHomalgChainMap ] );

DeclareOperation( "SupportOfChainMap",
        [ IsHomalgChainMap ] );

DeclareOperation( "Add",
        [ IsHomalgChainMap, IsHomalgMorphism ] );

DeclareOperation( "Add",
        [ IsHomalgChainMap, IsHomalgMatrix ] );

DeclareOperation( "CertainMorphismAsKernelSquare",
        [ IsHomalgChainMap, IsInt ] );

DeclareOperation( "CertainMorphismAsImageSquare",
        [ IsHomalgChainMap, IsInt ] );

DeclareOperation( "CertainMorphismAsLambekPairOfSquares",
        [ IsHomalgChainMap, IsInt ] );

