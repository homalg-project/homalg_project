#############################################################################
##
##  HomalgRing.gd               homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for homalg rings.
##
#############################################################################

####################################
#
# categories:
#
####################################

# a new GAP-category:

DeclareCategory( "IsHomalgRing",
        IsHomalgRingOrModule );

DeclareCategory( "IsHomalgExternalRingElement",
        IsExtAElement
        and IsExtLElement
        and IsExtRElement
        and IsAdditiveElementWithInverse
        and IsMultiplicativeElementWithInverse
        and IsAssociativeElement
        and IsAdditivelyCommutativeElement
        and IshomalgExternalObject );

####################################
#
# properties:
#
####################################

## properties listed alphabetically (ignoring left/right):

##  <#GAPDoc Label="ContainsAField">
##  <ManSection>
##    <Prop Arg="R" Name="ContainsAField"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "ContainsAField",
        IsHomalgRing );

##  <#GAPDoc Label="IsRationalsForHomalg">
##  <ManSection>
##    <Prop Arg="R" Name="IsRationalsForHomalg"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsRationalsForHomalg",
        IsHomalgRing );

##  <#GAPDoc Label="IsFieldForHomalg">
##  <ManSection>
##    <Prop Arg="R" Name="IsFieldForHomalg"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsFieldForHomalg",
        IsHomalgRing );

##  <#GAPDoc Label="IsDivisionRingForHomalg">
##  <ManSection>
##    <Prop Arg="R" Name="IsDivisionRingForHomalg"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsDivisionRingForHomalg",
        IsHomalgRing );

##  <#GAPDoc Label="IsIntegersForHomalg">
##  <ManSection>
##    <Prop Arg="R" Name="IsIntegersForHomalg"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsIntegersForHomalg",
        IsHomalgRing );

##  <#GAPDoc Label="IsResidueClassRingOfTheIntegers">
##  <ManSection>
##    <Prop Arg="R" Name="IsResidueClassRingOfTheIntegers"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsResidueClassRingOfTheIntegers",
        IsHomalgRing );

##  <#GAPDoc Label="IsBezoutRing">
##  <ManSection>
##    <Prop Arg="R" Name="IsBezoutRing"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsBezoutRing",
        IsHomalgRing );

##  <#GAPDoc Label="IsIntegrallyClosedDomain">
##  <ManSection>
##    <Prop Arg="R" Name="IsIntegrallyClosedDomain"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsIntegrallyClosedDomain",
        IsHomalgRing );

##  <#GAPDoc Label="IsUniqueFactorizationDomain">
##  <ManSection>
##    <Prop Arg="R" Name="IsUniqueFactorizationDomain"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsUniqueFactorizationDomain",
        IsHomalgRing );

##  <#GAPDoc Label="IsKaplanskyHermite">
##  <ManSection>
##    <Prop Arg="R" Name="IsKaplanskyHermite"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsKaplanskyHermite",
        IsHomalgRing );

##  <#GAPDoc Label="IsDedekindDomain">
##  <ManSection>
##    <Prop Arg="R" Name="IsDedekindDomain"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsDedekindDomain",
        IsHomalgRing );

##  <#GAPDoc Label="IsDiscreteValuationRing">
##  <ManSection>
##    <Prop Arg="R" Name="IsDiscreteValuationRing"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsDiscreteValuationRing",
        IsHomalgRing );

##  <#GAPDoc Label="IsFreePolynomialRing">
##  <ManSection>
##    <Prop Arg="R" Name="IsFreePolynomialRing"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsFreePolynomialRing",
        IsHomalgRing );

##  <#GAPDoc Label="IsWeylRing">
##  <ManSection>
##    <Prop Arg="R" Name="IsWeylRing"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsWeylRing",
        IsHomalgRing );

##  <#GAPDoc Label="IsGlobalDimensionFinite">
##  <ManSection>
##    <Prop Arg="R" Name="IsGlobalDimensionFinite"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsGlobalDimensionFinite",
        IsHomalgRing );

##  <#GAPDoc Label="IsLeftGlobalDimensionFinite">
##  <ManSection>
##    <Prop Arg="R" Name="IsLeftGlobalDimensionFinite"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsLeftGlobalDimensionFinite",
        IsHomalgRing );

##  <#GAPDoc Label="IsRightGlobalDimensionFinite">
##  <ManSection>
##    <Prop Arg="R" Name="IsRightGlobalDimensionFinite"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsRightGlobalDimensionFinite",
        IsHomalgRing );

##  <#GAPDoc Label="HasInvariantBasisProperty">
##  <ManSection>
##    <Prop Arg="R" Name="HasInvariantBasisProperty"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "HasInvariantBasisProperty",
        IsHomalgRing );

##  <#GAPDoc Label="HasLeftInvariantBasisProperty">
##  <ManSection>
##    <Prop Arg="R" Name="HasLeftInvariantBasisProperty"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "HasLeftInvariantBasisProperty",
        IsHomalgRing );

##  <#GAPDoc Label="HasRightInvariantBasisProperty">
##  <ManSection>
##    <Prop Arg="R" Name="HasRightInvariantBasisProperty"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "HasRightInvariantBasisProperty",
        IsHomalgRing );

##  <#GAPDoc Label="IsLocalRing">
##  <ManSection>
##    <Prop Arg="R" Name="IsLocalRing"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsLocalRing",
        IsHomalgRing );

##  <#GAPDoc Label="IsSemiLocalRing">
##  <ManSection>
##    <Prop Arg="R" Name="IsSemiLocalRing"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsSemiLocalRing",
        IsHomalgRing );

##  <#GAPDoc Label="IsIntegralDomain">
##  <ManSection>
##    <Prop Arg="R" Name="IsIntegralDomain"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsIntegralDomain",
        IsHomalgRing );

##  <#GAPDoc Label="IsHereditary">
##  <ManSection>
##    <Prop Arg="R" Name="IsHereditary"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsHereditary",
        IsHomalgRing );

##  <#GAPDoc Label="IsLeftHereditary">
##  <ManSection>
##    <Prop Arg="R" Name="IsLeftHereditary"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsLeftHereditary",
        IsHomalgRing );

##  <#GAPDoc Label="IsRightHereditary">
##  <ManSection>
##    <Prop Arg="R" Name="IsRightHereditary"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsRightHereditary",
        IsHomalgRing );

##  <#GAPDoc Label="IsHermite">
##  <ManSection>
##    <Prop Arg="R" Name="IsHermite"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsHermite",
        IsHomalgRing );

##  <#GAPDoc Label="IsLeftHermite">
##  <ManSection>
##    <Prop Arg="R" Name="IsLeftHermite"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsLeftHermite",
        IsHomalgRing );

##  <#GAPDoc Label="IsRightHermite">
##  <ManSection>
##    <Prop Arg="R" Name="IsRightHermite"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsRightHermite",
        IsHomalgRing );

##  <#GAPDoc Label="IsNoetherian">
##  <ManSection>
##    <Prop Arg="R" Name="IsNoetherian"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsNoetherian",
        IsHomalgRing );

##  <#GAPDoc Label="IsLeftNoetherian">
##  <ManSection>
##    <Prop Arg="R" Name="IsLeftNoetherian"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsLeftNoetherian",
        IsHomalgRing );

##  <#GAPDoc Label="IsRightNoetherian">
##  <ManSection>
##    <Prop Arg="R" Name="IsRightNoetherian"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsRightNoetherian",
        IsHomalgRing );

##  <#GAPDoc Label="IsOreDomain">
##  <ManSection>
##    <Prop Arg="R" Name="IsOreDomain"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsOreDomain",
        IsHomalgRing );

##  <#GAPDoc Label="IsLeftOreDomain">
##  <ManSection>
##    <Prop Arg="R" Name="IsLeftOreDomain"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsLeftOreDomain",
        IsHomalgRing );

##  <#GAPDoc Label="IsRightOreDomain">
##  <ManSection>
##    <Prop Arg="R" Name="IsRightOreDomain"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsRightOreDomain",
        IsHomalgRing );

##  <#GAPDoc Label="IsPrincipalIdealRing">
##  <ManSection>
##    <Prop Arg="R" Name="IsPrincipalIdealRing"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsPrincipalIdealRing",
        IsHomalgRing );

##  <#GAPDoc Label="IsLeftPrincipalIdealRing">
##  <ManSection>
##    <Prop Arg="R" Name="IsLeftPrincipalIdealRing"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsLeftPrincipalIdealRing",
        IsHomalgRing );

##  <#GAPDoc Label="IsRightPrincipalIdealRing">
##  <ManSection>
##    <Prop Arg="R" Name="IsRightPrincipalIdealRing"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsRightPrincipalIdealRing",
        IsHomalgRing );

##  <#GAPDoc Label="IsRegular">
##  <ManSection>
##    <Prop Arg="R" Name="IsRegular"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsRegular",
        IsHomalgRing );

##  <#GAPDoc Label="IsFiniteFreePresentationRing">
##  <ManSection>
##    <Prop Arg="R" Name="IsFiniteFreePresentationRing"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsFiniteFreePresentationRing",
        IsHomalgRing );

##  <#GAPDoc Label="IsLeftFiniteFreePresentationRing">
##  <ManSection>
##    <Prop Arg="R" Name="IsLeftFiniteFreePresentationRing"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsLeftFiniteFreePresentationRing",
        IsHomalgRing );

##  <#GAPDoc Label="IsRightFiniteFreePresentationRing">
##  <ManSection>
##    <Prop Arg="R" Name="IsRightFiniteFreePresentationRing"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsRightFiniteFreePresentationRing",
        IsHomalgRing );

##  <#GAPDoc Label="IsSimpleRing">
##  <ManSection>
##    <Prop Arg="R" Name="IsSimpleRing"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsSimpleRing",
        IsHomalgRing );

##  <#GAPDoc Label="IsSemiSimpleRing">
##  <ManSection>
##    <Prop Arg="R" Name="IsSemiSimpleRing"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsSemiSimpleRing",
        IsHomalgRing );

##  <#GAPDoc Label="BasisAlgorithmRespectsPrincipalIdeals">
##  <ManSection>
##    <Prop Arg="R" Name="BasisAlgorithmRespectsPrincipalIdeals"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "BasisAlgorithmRespectsPrincipalIdeals",
        IsHomalgRing );

####################################
#
# attributes:
#
####################################

##  <#GAPDoc Label="homalgTable">
##  <ManSection>
##    <Attr Arg="R" Name="homalgTable"/>
##    <Returns>the &homalg; translation table of the &homalg; ring <A>R</A></Returns>
##    <Description>
##      The &homalg; table is a &homalg; <Alt Only="LaTeX"><M>\leftrightarrow</M></Alt><Alt Not="LaTeX">&lt;--&gt;</Alt> ring dictionary,
##      i.e. the translator between &homalg; and the (specific implementation of the) ring. <P/>
##      Every &homalg; ring has a &homalg; table.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "homalgTable",
        IsHomalgRing, "mutable" );

##  <#GAPDoc Label="RingRelations">
##  <ManSection>
##    <Attr Arg="R" Name="RingRelations"/>
##    <Returns>a set of &homalg; relations on one generator</Returns>
##    <Description>
##      In case <A>R</A> was constructed as a residue class ring <M>S/I</M>, and only in this case,
##      the generators of the ideal of relations <M>I</M> are returned as a
##      set of &homalg; relations on one generator. It assumed that the ring is commutative, or that
##      specified <C>Involution</C> in the <C>homalgTable</C> fixed the ideal <M>I</M>.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "RingRelations",
        IsHomalgRing );

##  <#GAPDoc Label="Zero">
##  <ManSection>
##    <Attr Arg="R" Name="Zero"/>
##    <Returns>the zero of the &homalg; ring <A>R</A></Returns>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "Zero",
        IsHomalgRing );

##  <#GAPDoc Label="One">
##  <ManSection>
##    <Attr Arg="R" Name="One"/>
##    <Returns>the one of the &homalg; ring <A>R</A></Returns>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "One",
        IsHomalgRing );

##  <#GAPDoc Label="MinusOne">
##  <ManSection>
##    <Attr Arg="R" Name="MinusOne"/>
##    <Returns>the minus one of the &homalg; ring <A>R</A></Returns>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "MinusOne",
        IsHomalgRing );

##  <#GAPDoc Label="IndeterminateCoordinatesOfRingOfDerivations">
##  <ManSection>
##    <Attr Arg="R" Name="IndeterminateCoordinatesOfRingOfDerivations"/>
##    <Returns>a list of elements of the &homalg; ring <A>R</A></Returns>
##    <Description>The list of indeterminate coordinates of the &homalg; Weyl ring <A>R</A>.</Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "IndeterminateCoordinatesOfRingOfDerivations",
        IsHomalgRing );

##  <#GAPDoc Label="IndeterminateDerivationsOfRingOfDerivations">
##  <ManSection>
##    <Attr Arg="R" Name="IndeterminateDerivationsOfRingOfDerivations"/>
##    <Returns>a list of elements of the &homalg; ring <A>R</A></Returns>
##    <Description>The list of indeterminate derivations of the &homalg; Weyl ring <A>R</A>.</Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "IndeterminateDerivationsOfRingOfDerivations",
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
DeclareAttribute( "AmbientRing",
        IsHomalgRing );

##  <#GAPDoc Label="KrullDimension">
##  <ManSection>
##    <Attr Arg="R" Name="KrullDimension"/>
##    <Returns>a non-negative integer</Returns>
##    <Description>
##      The Krull dimension of the &homalg; ring <A>R</A>.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "KrullDimension",
        IsHomalgRing );

##  <#GAPDoc Label="LeftGlobalDimension">
##  <ManSection>
##    <Attr Arg="R" Name="LeftGlobalDimension"/>
##    <Returns>a non-negative integer</Returns>
##    <Description>
##      The left global dimension of the &homalg; ring <A>R</A>.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "LeftGlobalDimension",
        IsHomalgRing );

##  <#GAPDoc Label="RightGlobalDimension">
##  <ManSection>
##    <Attr Arg="R" Name="RightGlobalDimension"/>
##    <Returns>a non-negative integer</Returns>
##    <Description>
##      The right global dimension of the &homalg; ring <A>R</A>.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "RightGlobalDimension",
        IsHomalgRing );

##  <#GAPDoc Label="GlobalDimension">
##  <ManSection>
##    <Attr Arg="R" Name="GlobalDimension"/>
##    <Returns>a non-negative integer</Returns>
##    <Description>
##      The global dimension of the &homalg; ring <A>R</A>.
##      The global dimension is defined, only if the left and right
##      global dimensions coincide.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "GlobalDimension",
        IsHomalgRing );

## [McCRob, 11.1.14]
DeclareAttribute( "GeneralLinearRank",
        IsHomalgRing );

## [McCRob, 11.3.10]
DeclareAttribute( "ElementaryRank",
        IsHomalgRing );

## [McCRob, 11.3.4]
DeclareAttribute( "StableRank",
        IsHomalgRing );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "HomalgRing",
        [ IsHomalgExternalRingElement ] );

DeclareOperation( "PositionOfTheDefaultSetOfRelations",
        [ IsRingElement ] );

DeclareOperation( "IsUnit",
        [ IsHomalgRing, IsRingElement ] );

DeclareOperation( "IsUnit",
        [ IsHomalgExternalRingElement ] );

DeclareOperation( "RingName",
        [ IsHomalgRing ] );

DeclareOperation( "DisplayRing",
        [ IsHomalgRing ] );

DeclareOperation( "homalgPointer",
        [ IsHomalgRing ] );

DeclareOperation( "homalgExternalCASystem",
        [ IsHomalgRing ] );

DeclareOperation( "homalgExternalCASystemVersion",
        [ IsHomalgRing ] );

DeclareOperation( "homalgStream",
        [ IsHomalgRing ] );

DeclareOperation( "homalgExternalCASystemPID",
        [ IsHomalgRing ] );

DeclareOperation( "homalgLastWarning",
        [ IsHomalgRing ] );

DeclareOperation( "homalgNrOfWarnings",
        [ IsHomalgRing ] );

DeclareOperation( "homalgRingStatistics",
        [ IsHomalgRing ] );

DeclareOperation( "IncreaseRingStatistics",
        [ IsHomalgRing, IsString ] );

DeclareOperation( "AsLeftModule",
        [ IsHomalgRing ] );

DeclareOperation( "AsRightModule",
        [ IsHomalgRing ] );

DeclareOperation( "*",
        [ IsInt, IsHomalgRing ] );

DeclareOperation( "*",
        [ IsHomalgRing, IsInt ] );

DeclareOperation( "SetRingProperties",
        [ IsHomalgRing, IsInt ] );

DeclareOperation( "SetRingProperties",
        [ IsHomalgRing, IsHomalgRing, IsList ] );

DeclareOperation( "PolynomialRing",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "RingOfDerivations",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "*",
        [ IsHomalgRing, IsString ] );

DeclareOperation( "homalgSetName",
        [ IsHomalgExternalRingElement, IsString ] );

DeclareOperation( "homalgSetName",
        [ IsHomalgExternalRingElement, IsString, IsHomalgRing ] );

# constructor methods:

DeclareGlobalFunction( "CreateHomalgRing" );

DeclareGlobalFunction( "HomalgRingOfIntegers" );

DeclareGlobalFunction( "HomalgFieldOfRationals" );

DeclareGlobalFunction( "HomalgExternalRingElement" );

DeclareGlobalFunction( "StringToElementStringList" );

DeclareGlobalFunction( "_CreateHomalgRingToTestProperties" );

DeclareOperation( "/",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "/",
        [ IsHomalgRing, IsRingElement ] );

