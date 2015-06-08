#############################################################################
##
##  HomalgChainMorphism.gd                                    homalg package
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declarations for homalg chain morphisms.
##
#############################################################################

####################################
#
# categories:
#
####################################

# two new categories:

##  <#GAPDoc Label="IsHomalgChainMorphism">
##  <ManSection>
##    <Filt Type="Category" Arg="cm" Name="IsHomalgChainMorphism"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of &homalg; (co)chain morphisms. <P/>
##      (It is a subcategory of the &GAP; category <C>IsHomalgMorphism</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgChainMorphism",
        IsHomalgMorphism );

##  <#GAPDoc Label="IsHomalgChainEndomorphism">
##  <ManSection>
##    <Filt Type="Category" Arg="cm" Name="IsHomalgChainEndomorphism"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of &homalg; (co)chain endomorphisms. <P/>
##      (It is a subcategory of the &GAP; categories
##       <C>IsHomalgChainMorphism</C> and <C>IsHomalgEndomorphism</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgChainEndomorphism",
        IsHomalgChainMorphism and
        IsHomalgEndomorphism );

####################################
#
# properties:
#
####################################

## further properties are declared in HomalgMorphism.gd for the bigger category IsHomalgMorphism

##  <#GAPDoc Label="IsMorphism:chainmorphism">
##  <ManSection>
##    <Prop Arg="cm" Name="IsMorphism" Label="for chain morphisms"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if <A>cm</A> is a well-defined chain morphism, i.e. independent of all involved presentations.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsGeneralizedMorphism:chainmorphism">
##  <ManSection>
##    <Prop Arg="cm" Name="IsGeneralizedMorphism" Label="for chain morphisms"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if <A>cm</A> is a generalized morphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>m

##  <#GAPDoc Label="IsGeneralizedEpimorphism:chainmorphism">
##  <ManSection>
##    <Prop Arg="cm" Name="IsGeneralizedEpimorphism" Label="for chain morphisms"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if <A>cm</A> is a generalized epimorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsGeneralizedMonomorphism:chainmorphism">
##  <ManSection>
##    <Prop Arg="cm" Name="IsGeneralizedMonomorphism" Label="for chain morphisms"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if <A>cm</A> is a generalized monomorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsGeneralizedIsomorphism:chainmorphism">
##  <ManSection>
##    <Prop Arg="cm" Name="IsGeneralizedIsomorphism" Label="for chain morphisms"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if <A>cm</A> is a generalized isomorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsOne:chainmorphism">
##  <ManSection>
##    <Prop Arg="cm" Name="IsOne" Label="for chain morphisms"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; chain morphism <A>cm</A> is the identity chain morphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsMonomorphism:chainmorphism">
##  <ManSection>
##    <Prop Arg="cm" Name="IsMonomorphism" Label="for chain morphisms"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; chain morphism <A>cm</A> is a monomorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsEpimorphism:chainmorphism">
##  <ManSection>
##    <Prop Arg="cm" Name="IsEpimorphism" Label="for chain morphisms"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; chain morphism <A>cm</A> is an epimorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsSplitMonomorphism:chainmorphism">
##  <ManSection>
##    <Prop Arg="cm" Name="IsSplitMonomorphism" Label="for chain morphisms"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; chain morphism <A>cm</A> is a split monomorphism. <Br/>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsSplitEpimorphism:chainmorphism">
##  <ManSection>
##    <Prop Arg="cm" Name="IsSplitEpimorphism" Label="for chain morphisms"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; chain morphism <A>cm</A> is a split epimorphism. <Br/>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsIsomorphism:chainmorphism">
##  <ManSection>
##    <Prop Arg="cm" Name="IsIsomorphism" Label="for chain morphisms"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; chain morphism <A>cm</A> is an isomorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsAutomorphism:chainmorphism">
##  <ManSection>
##    <Prop Arg="cm" Name="IsAutomorphism" Label="for chain morphisms"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; chain morphism <A>cm</A> is an automorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsGradedMorphism">
##  <ManSection>
##    <Prop Arg="cm" Name="IsGradedMorphism" Label="for chain morphisms"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the source and target complex of the &homalg; chain morphism <A>cm</A> are graded objects, i.e. if all their morphisms vanish.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsGradedMorphism",
        IsHomalgChainMorphism );

##  <#GAPDoc Label="IsQuasiIsomorphism">
##  <ManSection>
##    <Prop Arg="cm" Name="IsQuasiIsomorphism" Label="for chain morphisms"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; chain morphism <A>cm</A> is a quasi-isomorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsQuasiIsomorphism",
        IsHomalgChainMorphism );

DeclareProperty( "IsImageSquare",
        IsHomalgChainMorphism );

DeclareProperty( "IsKernelSquare",
        IsHomalgChainMorphism );

DeclareProperty( "IsLambekPairOfSquares",
        IsHomalgChainMorphism );

DeclareProperty( "IsChainMorphismForPullback",
        IsHomalgChainMorphism );

DeclareProperty( "IsChainMorphismForPushout",
        IsHomalgChainMorphism );

####################################
#
# attributes:
#
####################################

## some attributes are already declared in HomalgMorphism.gd for the bigger category IsHomalgMorphism

##  <#GAPDoc Label="Source:chainmorphism">
##  <ManSection>
##    <Attr Arg="cm" Name="Source" Label="for chain morphisms"/>
##    <Returns>a &homalg; complex</Returns>
##    <Description>
##      The source of the &homalg; chain morphism <A>cm</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="Range:chainmorphism">
##  <ManSection>
##    <Attr Arg="cm" Name="Range" Label="for chain morphisms"/>
##    <Returns>a &homalg; complex</Returns>
##    <Description>
##      The target (range) of the &homalg; chain morphism <A>cm</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareGlobalFunction( "HomalgChainMorphism" );

# basic operations:

DeclareOperation( "SourceOfSpecialChainMorphism",
        [ IsHomalgChainMorphism ] );

DeclareOperation( "RangeOfSpecialChainMorphism",
        [ IsHomalgChainMorphism ] );

DeclareOperation( "CertainMorphismOfSpecialChainMorphism",
        [ IsHomalgChainMorphism ] );

DeclareOperation( "DegreesOfChainMorphism",
        [ IsHomalgChainMorphism ] );

DeclareOperation( "ObjectDegreesOfComplex",	## this is not a mistake
        [ IsHomalgChainMorphism ] );

DeclareOperation( "MorphismDegreesOfComplex",	## this is not a mistake
        [ IsHomalgChainMorphism ] );

DeclareOperation( "CertainMorphism",
        [ IsHomalgChainMorphism, IsInt ] );

DeclareOperation( "MorphismsOfChainMorphism",
        [ IsHomalgChainMorphism ] );

DeclareOperation( "CertainObjectOfChainMorphism",
        [ IsHomalgChainMorphism, IsInt ] );

DeclareOperation( "LowestDegree",
        [ IsHomalgChainMorphism ] );

DeclareOperation( "HighestDegree",
        [ IsHomalgChainMorphism ] );

DeclareOperation( "LowestDegreeMorphism",
        [ IsHomalgChainMorphism ] );

DeclareOperation( "HighestDegreeMorphism",
        [ IsHomalgChainMorphism ] );

DeclareOperation( "SupportOfChainMorphism",
        [ IsHomalgChainMorphism ] );

DeclareOperation( "Add",
        [ IsHomalgChainMorphism, IsHomalgMorphism ] );

DeclareOperation( "Add",
        [ IsHomalgMorphism, IsHomalgChainMorphism ] );

DeclareOperation( "CertainMorphismAsKernelSquare",
        [ IsHomalgChainMorphism, IsInt ] );

DeclareOperation( "CertainMorphismAsImageSquare",
        [ IsHomalgChainMorphism, IsInt ] );

DeclareOperation( "CertainMorphismAsLambekPairOfSquares",
        [ IsHomalgChainMorphism, IsInt ] );

DeclareOperation( "CompleteImageSquare",
        [ IsHomalgChainMorphism ] );

DeclareOperation( "SubChainMorphism",
        [ IsHomalgChainMorphism, IsInt, IsInt ] );

