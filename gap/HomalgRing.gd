#############################################################################
##
##  HomalgRing.gd               MatricesForHomalg package    Mohamed Barakat
##
##  Copyright 2007-2009 Mohamed Barakat, RWTH Aachen
##
##  Declaration stuff for homalg rings.
##
#############################################################################

####################################
#
# categories:
#
####################################

# three new GAP-categories:

##  <#GAPDoc Label="IsHomalgRing">
##  <ManSection>
##    <Filt Type="Category" Arg="R" Name="IsHomalgRing"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of &homalg; rings. <P/>
##      (It is a subcategory of the &GAP; categories <C>IsStructureObject</C>
##       and <C>IsHomalgRingOrModule</C>.)
##    <Listing Type="Code"><![CDATA[
DeclareCategory( "IsHomalgRing",
        IsStructureObject and
        IsRingWithOne and
        IsHomalgRingOrModule );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsPreHomalgRing">
##  <ManSection>
##    <Filt Type="Category" Arg="R" Name="IsPreHomalgRing"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of pre &homalg; rings. <P/>
##      (It is a subcategory of the &GAP; category <C>IsHomalgRing</C>.) <Br/><Br/>
##      These are rings with an incomplete <C>homalgTable</C>.
##      They provide flexibility for developers to support a wider class of rings,
##      as was necessary for the development of the &LocalizeRingForHomalg; package.
##      They are not suited for direct usage.
##    <Listing Type="Code"><![CDATA[
DeclareCategory( "IsPreHomalgRing",
        IsHomalgRing );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsHomalgRingElement">
##  <ManSection>
##    <Filt Type="Category" Arg="r" Name="IsHomalgRingElement"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of elements of &homalg; rings which are not GAP4 built-in.
##    <Listing Type="Code"><![CDATA[
DeclareCategory( "IsHomalgRingElement",
        IsExtAElement and
        IsExtLElement and
        IsExtRElement and
        IsAdditiveElementWithInverse and
        IsMultiplicativeElementWithInverse and
        IsAssociativeElement and
        IsAdditivelyCommutativeElement and
        ## all the above guarantees IsHomalgRingElement => IsRingElement (in GAP4)
        IsAttributeStoringRep );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

####################################
#
# properties:
#
####################################

## properties listed alphabetically (ignoring left/right):

##  <#GAPDoc Label="IsZero:rings">
##  <ManSection>
##    <Prop Arg="R" Name="IsZero" Label="for rings"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the ring <A>R</A> is a zero, i.e., if <C>One</C><M>(</M><A>R</A><M>)=</M><C>Zero</C><M>(</M><A>R</A><M>)</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsZero",
        IsHomalgRing );

##  <#GAPDoc Label="ContainsAField">
##  <ManSection>
##    <Prop Arg="R" Name="ContainsAField"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "ContainsAField",
        IsHomalgRing );

##  <#GAPDoc Label="IsRationalsForHomalg">
##  <ManSection>
##    <Prop Arg="R" Name="IsRationalsForHomalg"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsRationalsForHomalg",
        IsHomalgRing );

##  <#GAPDoc Label="IsFieldForHomalg">
##  <ManSection>
##    <Prop Arg="R" Name="IsFieldForHomalg"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsFieldForHomalg",
        IsHomalgRing );

##  <#GAPDoc Label="IsDivisionRingForHomalg">
##  <ManSection>
##    <Prop Arg="R" Name="IsDivisionRingForHomalg"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsDivisionRingForHomalg",
        IsHomalgRing );

##  <#GAPDoc Label="IsIntegersForHomalg">
##  <ManSection>
##    <Prop Arg="R" Name="IsIntegersForHomalg"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsIntegersForHomalg",
        IsHomalgRing );

##  <#GAPDoc Label="IsResidueClassRingOfTheIntegers">
##  <ManSection>
##    <Prop Arg="R" Name="IsResidueClassRingOfTheIntegers"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsResidueClassRingOfTheIntegers",
        IsHomalgRing );

##  <#GAPDoc Label="IsBezoutRing">
##  <ManSection>
##    <Prop Arg="R" Name="IsBezoutRing"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsBezoutRing",
        IsHomalgRing );

##  <#GAPDoc Label="IsIntegrallyClosedDomain">
##  <ManSection>
##    <Prop Arg="R" Name="IsIntegrallyClosedDomain"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsIntegrallyClosedDomain",
        IsHomalgRing );

##  <#GAPDoc Label="IsUniqueFactorizationDomain">
##  <ManSection>
##    <Prop Arg="R" Name="IsUniqueFactorizationDomain"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsUniqueFactorizationDomain",
        IsHomalgRing );

##  <#GAPDoc Label="IsKaplanskyHermite">
##  <ManSection>
##    <Prop Arg="R" Name="IsKaplanskyHermite"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsKaplanskyHermite",
        IsHomalgRing );

##  <#GAPDoc Label="IsDedekindDomain">
##  <ManSection>
##    <Prop Arg="R" Name="IsDedekindDomain"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsDedekindDomain",
        IsHomalgRing );

##  <#GAPDoc Label="IsDiscreteValuationRing">
##  <ManSection>
##    <Prop Arg="R" Name="IsDiscreteValuationRing"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsDiscreteValuationRing",
        IsHomalgRing );

##  <#GAPDoc Label="IsFreePolynomialRing">
##  <ManSection>
##    <Prop Arg="R" Name="IsFreePolynomialRing"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsFreePolynomialRing",
        IsHomalgRing );

##  <#GAPDoc Label="IsWeylRing">
##  <ManSection>
##    <Prop Arg="R" Name="IsWeylRing"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsWeylRing",
        IsHomalgRing );

##  <#GAPDoc Label="IsLocalizedWeylRing">
##  <ManSection>
##    <Prop Arg="R" Name="IsLocalizedWeylRing"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsLocalizedWeylRing",
        IsHomalgRing );

##  <#GAPDoc Label="IsExteriorRing">
##  <ManSection>
##    <Prop Arg="R" Name="IsExteriroRing"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsExteriorRing",
        IsHomalgRing );

##  <#GAPDoc Label="IsGlobalDimensionFinite">
##  <ManSection>
##    <Prop Arg="R" Name="IsGlobalDimensionFinite"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsGlobalDimensionFinite",
        IsHomalgRing );

##  <#GAPDoc Label="IsLeftGlobalDimensionFinite">
##  <ManSection>
##    <Prop Arg="R" Name="IsLeftGlobalDimensionFinite"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsLeftGlobalDimensionFinite",
        IsHomalgRing );

##  <#GAPDoc Label="IsRightGlobalDimensionFinite">
##  <ManSection>
##    <Prop Arg="R" Name="IsRightGlobalDimensionFinite"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsRightGlobalDimensionFinite",
        IsHomalgRing );

##  <#GAPDoc Label="HasInvariantBasisProperty">
##  <ManSection>
##    <Prop Arg="R" Name="HasInvariantBasisProperty"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "HasInvariantBasisProperty",
        IsHomalgRing );

##  <#GAPDoc Label="HasLeftInvariantBasisProperty">
##  <ManSection>
##    <Prop Arg="R" Name="HasLeftInvariantBasisProperty"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "HasLeftInvariantBasisProperty",
        IsHomalgRing );

##  <#GAPDoc Label="HasRightInvariantBasisProperty">
##  <ManSection>
##    <Prop Arg="R" Name="HasRightInvariantBasisProperty"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "HasRightInvariantBasisProperty",
        IsHomalgRing );

##  <#GAPDoc Label="IsLocal">
##  <ManSection>
##    <Prop Arg="R" Name="IsLocal"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsLocal",
        IsHomalgRing );

##  <#GAPDoc Label="IsSemiLocalRing">
##  <ManSection>
##    <Prop Arg="R" Name="IsSemiLocalRing"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsSemiLocalRing",
        IsHomalgRing );

##  <#GAPDoc Label="IsIntegralDomain">
##  <ManSection>
##    <Prop Arg="R" Name="IsIntegralDomain"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsIntegralDomain",
        IsHomalgRing );

##  <#GAPDoc Label="IsHereditary">
##  <ManSection>
##    <Prop Arg="R" Name="IsHereditary"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsHereditary",
        IsHomalgRing );

##  <#GAPDoc Label="IsLeftHereditary">
##  <ManSection>
##    <Prop Arg="R" Name="IsLeftHereditary"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsLeftHereditary",
        IsHomalgRing );

##  <#GAPDoc Label="IsRightHereditary">
##  <ManSection>
##    <Prop Arg="R" Name="IsRightHereditary"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsRightHereditary",
        IsHomalgRing );

##  <#GAPDoc Label="IsHermite">
##  <ManSection>
##    <Prop Arg="R" Name="IsHermite"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsHermite",
        IsHomalgRing );

##  <#GAPDoc Label="IsLeftHermite">
##  <ManSection>
##    <Prop Arg="R" Name="IsLeftHermite"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsLeftHermite",
        IsHomalgRing );

##  <#GAPDoc Label="IsRightHermite">
##  <ManSection>
##    <Prop Arg="R" Name="IsRightHermite"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsRightHermite",
        IsHomalgRing );

##  <#GAPDoc Label="IsNoetherian">
##  <ManSection>
##    <Prop Arg="R" Name="IsNoetherian"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsNoetherian",
        IsHomalgRing );

##  <#GAPDoc Label="IsLeftNoetherian">
##  <ManSection>
##    <Prop Arg="R" Name="IsLeftNoetherian"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsLeftNoetherian",
        IsHomalgRing );

##  <#GAPDoc Label="IsRightNoetherian">
##  <ManSection>
##    <Prop Arg="R" Name="IsRightNoetherian"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsRightNoetherian",
        IsHomalgRing );

##  <#GAPDoc Label="IsCohenMacaulay">
##  <ManSection>
##    <Prop Arg="R" Name="IsCohenMacaulay"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsCohenMacaulay",
        IsHomalgRing );

##  <#GAPDoc Label="IsGorenstein">
##  <ManSection>
##    <Prop Arg="R" Name="IsGorenstein"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsGorenstein",
        IsHomalgRing );

##  <#GAPDoc Label="IsKoszul">
##  <ManSection>
##    <Prop Arg="R" Name="IsKoszul"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsKoszul",
        IsHomalgRing );

##  <#GAPDoc Label="IsArtinian">
##  <ManSection>
##    <Prop Arg="R" Name="IsArtinian" Label="for rings"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsArtinian",
        IsHomalgRing );

##  <#GAPDoc Label="IsLeftArtinian">
##  <ManSection>
##    <Prop Arg="R" Name="IsLeftArtinian"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsLeftArtinian",
        IsHomalgRing );

##  <#GAPDoc Label="IsRightArtinian">
##  <ManSection>
##    <Prop Arg="R" Name="IsRightArtinian"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsRightArtinian",
        IsHomalgRing );

##  <#GAPDoc Label="IsOreDomain">
##  <ManSection>
##    <Prop Arg="R" Name="IsOreDomain"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsOreDomain",
        IsHomalgRing );

##  <#GAPDoc Label="IsLeftOreDomain">
##  <ManSection>
##    <Prop Arg="R" Name="IsLeftOreDomain"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsLeftOreDomain",
        IsHomalgRing );

##  <#GAPDoc Label="IsRightOreDomain">
##  <ManSection>
##    <Prop Arg="R" Name="IsRightOreDomain"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsRightOreDomain",
        IsHomalgRing );

##  <#GAPDoc Label="IsPrincipalIdealRing">
##  <ManSection>
##    <Prop Arg="R" Name="IsPrincipalIdealRing"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsPrincipalIdealRing",
        IsHomalgRing );

##  <#GAPDoc Label="IsLeftPrincipalIdealRing">
##  <ManSection>
##    <Prop Arg="R" Name="IsLeftPrincipalIdealRing"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsLeftPrincipalIdealRing",
        IsHomalgRing );

##  <#GAPDoc Label="IsRightPrincipalIdealRing">
##  <ManSection>
##    <Prop Arg="R" Name="IsRightPrincipalIdealRing"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsRightPrincipalIdealRing",
        IsHomalgRing );

##  <#GAPDoc Label="IsRegular">
##  <ManSection>
##    <Prop Arg="R" Name="IsRegular"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsRegular",
        IsHomalgRing );

##  <#GAPDoc Label="IsFiniteFreePresentationRing">
##  <ManSection>
##    <Prop Arg="R" Name="IsFiniteFreePresentationRing"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsFiniteFreePresentationRing",
        IsHomalgRing );

##  <#GAPDoc Label="IsLeftFiniteFreePresentationRing">
##  <ManSection>
##    <Prop Arg="R" Name="IsLeftFiniteFreePresentationRing"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsLeftFiniteFreePresentationRing",
        IsHomalgRing );

##  <#GAPDoc Label="IsRightFiniteFreePresentationRing">
##  <ManSection>
##    <Prop Arg="R" Name="IsRightFiniteFreePresentationRing"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsRightFiniteFreePresentationRing",
        IsHomalgRing );

##  <#GAPDoc Label="IsSimpleRing">
##  <ManSection>
##    <Prop Arg="R" Name="IsSimpleRing"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsSimpleRing",
        IsHomalgRing );

##  <#GAPDoc Label="IsSemiSimpleRing">
##  <ManSection>
##    <Prop Arg="R" Name="IsSemiSimpleRing"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsSemiSimpleRing",
        IsHomalgRing );

##  <#GAPDoc Label="IsSuperCommutative">
##  <ManSection>
##    <Prop Arg="R" Name="IsSuperCommutative"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsSuperCommutative",
        IsHomalgRing );

##  <#GAPDoc Label="BasisAlgorithmRespectsPrincipalIdeals">
##  <ManSection>
##    <Prop Arg="R" Name="BasisAlgorithmRespectsPrincipalIdeals"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "BasisAlgorithmRespectsPrincipalIdeals",
        IsHomalgRing );

##  <#GAPDoc Label="AreUnitsCentral">
##  <ManSection>
##    <Prop Arg="R" Name="AreUnitsCentral"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>R</A> is a ring for &homalg;.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "AreUnitsCentral",
        IsHomalgRing );

##  <#GAPDoc Label="IsMinusOne">
##  <ManSection>
##    <Prop Arg="r" Name="IsMinusOne"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the ring element <A>r</A> is the additive inverse of one.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsMinusOne",
        IsRingElement );

##  <#GAPDoc Label="IsMonic:ringelement">
##  <ManSection>
##    <Prop Arg="r" Name="IsMonic" Label="for homalg ring elements"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; ring element <A>r</A> is monic.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsMonic",
        IsHomalgRingElement );

##  <#GAPDoc Label="IsLeftRegular:ringelement">
##  <ManSection>
##    <Prop Arg="r" Name="IsLeftRegular" Label="for homalg ring elements"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; ring element <A>r</A> is left regular.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsLeftRegular",
        IsHomalgRingElement );

##  <#GAPDoc Label="IsRightRegular:ringelement">
##  <ManSection>
##    <Prop Arg="r" Name="IsRightRegular" Label="for homalg ring elements"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; ring element <A>r</A> is right regular.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsRightRegular",
        IsHomalgRingElement );

##  <#GAPDoc Label="IsRegular:ringelement">
##  <ManSection>
##    <Prop Arg="r" Name="IsRegular" Label="for homalg ring elements"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; ring element <A>r</A> is regular, i.e. left and right regular.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsRegular",
        IsHomalgRingElement );

##  <#GAPDoc Label="IsIrreducibleHomalgRingElement:ringelement">
##  <ManSection>
##    <Prop Arg="r" Name="IsIrreducibleHomalgRingElement" Label="for homalg ring elements"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; ring element <A>r</A> is irreducible.
##      The short operation name is <C>IsIrreducible</C>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsIrreducibleHomalgRingElement",
        IsHomalgRingElement );

####################################
#
# attributes:
#
####################################

##  <#GAPDoc Label="Inverse:ring_element">
##  <ManSection>
##    <Attr Arg="r" Name="Inverse" Label="for homalg ring elements"/>
##    <Returns>a &homalg; ring element or fail</Returns>
##    <Description>
##    The inverse of the &homalg; ring element <A>r</A>.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> R := ZZ / 2^8;
##  Z/( 256 )
##  gap> r := (1/3*One(R)+1/5)+3/7;
##  |[ 157 ]|
##  gap> 1 / r;	## = r^-1;
##  |[ 181 ]|
##  gap> s := (1/3*One(R)+2/5)+3/7;
##  |[ 106 ]|
##  gap> 1 / s;
##  fail
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##
DeclareOperation( "MinusOneMutable",
        [ IsHomalgRingElement ] );

##
DeclareAttribute( "EvalRingElement",
        IsHomalgRingElement );

DeclareAttribute( "CoefficientsOfUnivariatePolynomial",
        IsHomalgRingElement );

##  <#GAPDoc Label="Zero:ring">
##  <ManSection>
##    <Attr Arg="R" Name="Zero" Label="for homalg rings"/>
##    <Returns>a &homalg; ring element</Returns>
##    <Description>
##      The zero of the &homalg; ring <A>R</A>.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
#DeclareAttribute( "Zero",
#        IsHomalgRing );

##  <#GAPDoc Label="One:ring">
##  <ManSection>
##    <Attr Arg="R" Name="One" Label="for homalg rings"/>
##    <Returns>a &homalg; ring element</Returns>
##    <Description>
##      The one of the &homalg; ring <A>R</A>.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
#DeclareAttribute( "One",
#        IsHomalgRing );

##  <#GAPDoc Label="MinusOne">
##  <ManSection>
##    <Attr Arg="R" Name="MinusOne"/>
##    <Returns>a &homalg; ring element</Returns>
##    <Description>
##      The minus one of the &homalg; ring <A>R</A>.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "MinusOne",
        IsHomalgRing );

##  <#GAPDoc Label="ProductOfIndeterminates">
##  <ManSection>
##    <Attr Arg="R" Name="ProductOfIndeterminates"/>
##    <Returns>a &homalg; ring element</Returns>
##    <Description>
##      The product of indeterminates of the &homalg; ring <A>R</A>.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ProductOfIndeterminates",
        IsHomalgRing );

##  <#GAPDoc Label="homalgTable">
##  <ManSection>
##    <Attr Arg="R" Name="homalgTable"/>
##    <Returns>a &homalg; table</Returns>
##    <Description>
##      The &homalg; table of <A>R</A> is a ring dictionary, i.e. the translator between &homalg;
##      and the (specific implementation of the) ring. <P/>
##      Every &homalg; ring has a &homalg; table.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "homalgTable",
        IsHomalgRing );

##  <#GAPDoc Label="RingElementConstructor">
##  <ManSection>
##    <Attr Arg="R" Name="RingElementConstructor"/>
##    <Returns>a function</Returns>
##    <Description>
##      The constructor of ring elements in the &homalg; ring <A>R</A>.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "RingElementConstructor",
        IsHomalgRing );

##  <#GAPDoc Label="TypeOfHomalgMatrix">
##  <ManSection>
##    <Attr Arg="R" Name="TypeOfHomalgMatrix"/>
##    <Returns>a type</Returns>
##    <Description>
##      The &GAP4;-type of &homalg; matrices over the &homalg; ring <A>R</A>.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "TypeOfHomalgMatrix",
        IsHomalgRing );

##  <#GAPDoc Label="ConstructorForHomalgMatrices">
##  <ManSection>
##    <Attr Arg="R" Name="ConstructorForHomalgMatrices"/>
##    <Returns>a type</Returns>
##    <Description>
##      The constructor for &homalg; matrices over the &homalg; ring <A>R</A>.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ConstructorForHomalgMatrices",
        IsHomalgRing );

##  <#GAPDoc Label="RationalParameters">
##  <ManSection>
##    <Attr Arg="R" Name="RationalParameters"/>
##    <Returns>a list of &homalg; ring elements</Returns>
##    <Description>
##      The list of rational parameters of the &homalg; ring <A>R</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "RationalParameters",
        IsHomalgRing );

##  <#GAPDoc Label="IndeterminatesOfPolynomialRing">
##  <ManSection>
##    <Attr Arg="R" Name="IndeterminatesOfPolynomialRing"/>
##    <Returns>a list of &homalg; ring elements</Returns>
##    <Description>
##      The list of indeterminates of the &homalg; polynomial ring <A>R</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "IndeterminatesOfPolynomialRing",
        IsHomalgRing );

##  <#GAPDoc Label="RelativeIndeterminatesOfPolynomialRing">
##  <ManSection>
##    <Attr Arg="R" Name="RelativeIndeterminatesOfPolynomialRing"/>
##    <Returns>a list of &homalg; ring elements</Returns>
##    <Description>
##      The list of relative indeterminates of the &homalg; polynomial ring <A>R</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "RelativeIndeterminatesOfPolynomialRing",
        IsHomalgRing );

##  <#GAPDoc Label="IndeterminateCoordinatesOfRingOfDerivations">
##  <ManSection>
##    <Attr Arg="R" Name="IndeterminateCoordinatesOfRingOfDerivations"/>
##    <Returns>a list of &homalg; ring elements</Returns>
##    <Description>
##      The list of indeterminate coordinates of the &homalg; Weyl ring <A>R</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "IndeterminateCoordinatesOfRingOfDerivations",
        IsHomalgRing );

##  <#GAPDoc Label="RelativeIndeterminateCoordinatesOfRingOfDerivations">
##  <ManSection>
##    <Attr Arg="R" Name="RelativeIndeterminateCoordinatesOfRingOfDerivations"/>
##    <Returns>a list of &homalg; ring elements</Returns>
##    <Description>
##      The list of relative indeterminate coordinates of the &homalg; Weyl ring <A>R</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "RelativeIndeterminateCoordinatesOfRingOfDerivations",
        IsHomalgRing );

##  <#GAPDoc Label="IndeterminateDerivationsOfRingOfDerivations">
##  <ManSection>
##    <Attr Arg="R" Name="IndeterminateDerivationsOfRingOfDerivations"/>
##    <Returns>a list of &homalg; ring elements</Returns>
##    <Description>
##      The list of indeterminate derivations of the &homalg; Weyl ring <A>R</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "IndeterminateDerivationsOfRingOfDerivations",
        IsHomalgRing );

##  <#GAPDoc Label="RelativeIndeterminateDerivationsOfRingOfDerivations">
##  <ManSection>
##    <Attr Arg="R" Name="RelativeIndeterminateDerivationsOfRingOfDerivations"/>
##    <Returns>a list of &homalg; ring elements</Returns>
##    <Description>
##      The list of relative indeterminate derivations of the &homalg; Weyl ring <A>R</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "RelativeIndeterminateDerivationsOfRingOfDerivations",
        IsHomalgRing );

##  <#GAPDoc Label="IndeterminateAntiCommutingVariablesOfExteriorRing">
##  <ManSection>
##    <Attr Arg="R" Name="IndeterminateAntiCommutingVariablesOfExteriorRing"/>
##    <Returns>a list of &homalg; ring elements</Returns>
##    <Description>
##      The list of anti-commuting indeterminates of the &homalg; exterior ring <A>R</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "IndeterminateAntiCommutingVariablesOfExteriorRing",
        IsHomalgRing );

##  <#GAPDoc Label="RelativeIndeterminateAntiCommutingVariablesOfExteriorRing">
##  <ManSection>
##    <Attr Arg="R" Name="RelativeIndeterminateAntiCommutingVariablesOfExteriorRing"/>
##    <Returns>a list of &homalg; ring elements</Returns>
##    <Description>
##      The list of anti-commuting relative indeterminates of the &homalg; exterior ring <A>R</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "RelativeIndeterminateAntiCommutingVariablesOfExteriorRing",
        IsHomalgRing );

##  <#GAPDoc Label="IndeterminatesOfExteriorRing">
##  <ManSection>
##    <Attr Arg="R" Name="IndeterminatesOfExteriorRing"/>
##    <Returns>a list of &homalg; ring elements</Returns>
##    <Description>
##      The list of all indeterminates (commuting and anti-commuting) of the &homalg; exterior ring <A>R</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "IndeterminatesOfExteriorRing",
        IsHomalgRing );

##  <#GAPDoc Label="CoefficientsRing">
##  <ManSection>
##    <Attr Arg="R" Name="CoefficientsRing"/>
##    <Returns>a &homalg; ring</Returns>
##    <Description>
##      The ring of coefficients of the &homalg; ring <A>R</A>.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CoefficientsRing",
        IsHomalgRing );

##  <#GAPDoc Label="BaseRing">
##  <ManSection>
##    <Attr Arg="R" Name="BaseRing"/>
##    <Returns>a &homalg; ring</Returns>
##    <Description>
##      In case <A>R</A> was constructed as a polynomial or exterior ring over a base ring <M>T</M>,
##      and only in this case, the &homalg; ring <M>T</M> is returned.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "BaseRing",
        IsHomalgRing );

##  <#GAPDoc Label="KrullDimension">
##  <ManSection>
##    <Attr Arg="R" Name="KrullDimension"/>
##    <Returns>a non-negative integer</Returns>
##    <Description>
##      The Krull dimension of the commutative &homalg; ring <A>R</A>.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
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
##
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
##
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
##
DeclareAttribute( "GlobalDimension",
        IsHomalgRing );

##  <#GAPDoc Label="GeneralLinearRank">
##  <ManSection>
##    <Attr Arg="R" Name="GeneralLinearRank"/>
##    <Returns>a non-negative integer</Returns>
##    <Description>
##      The general linear rank of the &homalg; ring <A>R</A> (<Cite Key="McCRob"/>, 11.1.14).
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "GeneralLinearRank",
        IsHomalgRing );

##  <#GAPDoc Label="ElementaryRank">
##  <ManSection>
##    <Attr Arg="R" Name="ElementaryRank"/>
##    <Returns>a non-negative integer</Returns>
##    <Description>
##      The elementary rank of the &homalg; ring <A>R</A> (<Cite Key="McCRob"/>, 11.3.10).
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ElementaryRank",
        IsHomalgRing );

##  <#GAPDoc Label="StableRank">
##  <ManSection>
##    <Attr Arg="R" Name="StableRank"/>
##    <Returns>a non-negative integer</Returns>
##    <Description>
##      The stable rank of the &homalg; ring <A>R</A> (<Cite Key="McCRob"/>, 11.3.4).
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "StableRank",
        IsHomalgRing );

##  <#GAPDoc Label="AssociatedGradedRing">
##  <ManSection>
##    <Attr Arg="R" Name="AssociatedGradedRing"/>
##    <Returns>a homalg ring</Returns>
##    <Description>
##      The graded ring associated to the filtered ring <A>R</A>.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "AssociatedGradedRing",
        IsHomalgRing );

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareGlobalFunction( "CreateHomalgRing" );

DeclareGlobalFunction( "HomalgRingOfIntegers" );

DeclareGlobalFunction( "HomalgFieldOfRationals" );

DeclareGlobalFunction( "HomalgRingElement" );

DeclareOperation( "/",
        [ IsRingElement, IsHomalgRing ] );

DeclareOperation( "/",
        [ IsString, IsHomalgRing ] );

DeclareGlobalFunction( "StringToElementStringList" );

DeclareGlobalFunction( "_CreateHomalgRingToTestProperties" );

DeclareOperation( "ParseListOfIndeterminates",
        [ IsList ] );

#DeclareOperation( "PolynomialRing",
#        [ IsHomalgRing, IsList ] );

DeclareOperation( "*",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "RingOfDerivations",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "RingOfDerivations",
        [ IsHomalgRing, IsList, IsList ] );

DeclareOperation( "RingOfDerivations",
        [ IsHomalgRing ] );

DeclareOperation( "ExteriorRing",
        [ IsHomalgRing, IsHomalgRing, IsHomalgRing, IsList ] );

DeclareOperation( "ExteriorRing",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "KoszulDualRing",
        [ IsHomalgRing, IsHomalgRing, IsList ] );

DeclareOperation( "KoszulDualRing",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "KoszulDualRing",
        [ IsHomalgRing ] );

# basic operations:

DeclareOperation( "HomalgRing",
        [ IsHomalgRingElement ] );

DeclareOperation( "Factors",
        [ IsHomalgRingElement ] );

DeclareOperation( "Roots",
        [ IsHomalgRingElement ] );

DeclareOperation( "HomalgRing",	## returns itself
        [ IsHomalgRing ] );

#DeclareOperation( "Indeterminate",
#        [ IsHomalgRing, IsPosInt ] );

DeclareOperation( "Indeterminates",
        [ IsHomalgRing ] );

DeclareOperation( "ExportIndeterminates",
        [ IsHomalgRing ] );

DeclareOperation( "ExportRationalParameters",
        [ IsHomalgRing ] );

DeclareOperation( "ExportVariables",
        [ IsHomalgRing ] );

#DeclareOperation( "IsUnit",
#        [ IsHomalgRing, IsRingElement ] );

DeclareOperation( "IsUnit",
        [ IsHomalgRingElement ] );

DeclareOperation( "StandardBasisRowVectors",
        [ IsInt, IsHomalgRing ] );

DeclareOperation( "StandardBasisColumnVectors",
        [ IsInt, IsHomalgRing ] );

DeclareOperation( "RingName",
        [ IsHomalgRing ] );

DeclareOperation( "DisplayRing",
        [ IsHomalgRing ] );

DeclareOperation( "homalgRingStatistics",
        [ IsHomalgRing ] );

DeclareOperation( "IncreaseRingStatistics",
        [ IsHomalgRing, IsString ] );

DeclareOperation( "DecreaseRingStatistics",
        [ IsHomalgRing, IsString ] );

DeclareOperation( "SetRingProperties",
        [ IsHomalgRing, IsInt ] );

DeclareOperation( "SetRingProperties",
        [ IsHomalgRing, IsHomalgRing, IsList ] );

DeclareOperation( "SetRingProperties",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "SetRingProperties",
        [ IsHomalgRing ] );

DeclareOperation( "homalgSetName",
        [ IsHomalgRingElement, IsString ] );

DeclareOperation( "homalgSetName",
        [ IsHomalgRingElement, IsString, IsHomalgRing ] );

DeclareOperation( "Random",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "Random",
        [ IsHomalgRing, IsInt ] );

#DeclareOperation( "Random",
#        [ IsHomalgRing ] );
