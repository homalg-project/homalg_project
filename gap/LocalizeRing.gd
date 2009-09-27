#############################################################################
##
##  LocalizeRing.gd LocalizeRingForHomalg package            Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##  Copyright 2009, Mohamed Barakat, Universität des Saarlandes
##           Markus Lange-Hegermann, RWTH-Aachen University
##
##  Declarations of procedures for localized rings.
##
#############################################################################

####################################
#
# attributes:
#
####################################

##  <#GAPDoc Label="GeneratorsOfMaximalLeftIdeal">
##  <ManSection>
##    <Attr Arg="R" Name="GeneratorsOfMaximalLeftIdeal"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Returns the generators of the maximal ideal, at which R was created. The generators are given as a column over the associated global ring.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "GeneratorsOfMaximalLeftIdeal",
        IsHomalgRing );

##  <#GAPDoc Label="GeneratorsOfMaximalRightIdeal">
##  <ManSection>
##    <Attr Arg="R" Name="GeneratorsOfMaximalRightIdeal"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Returns the generators of the maximal ideal, at which R was created. The generators are given as a row over the associated global ring.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "GeneratorsOfMaximalRightIdeal",
        IsHomalgRing );

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareOperation( "CreateHomalgTableForLocalizedRings",
        [ IsHomalgRing ] );

DeclareOperation( "CreateHomalgTableForLocalizedRingsWithMora",
        [ IsHomalgRing ] );

DeclareGlobalFunction( "CreateHomalgLocalizedRing" );

DeclareOperation( "LocalizeAt",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "LocalizeAtZero",
        [ IsHomalgRing ] );

DeclareGlobalFunction( "HomalgLocalRingElement" );

DeclareOperation( "BlindlyCopyMatrixPropertiesToLocalMatrix",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "HomalgLocalMatrix",
        [ IsHomalgMatrix, IsRingElement, IsHomalgRing ] );

DeclareOperation( "HomalgLocalMatrix",
        [ IsHomalgMatrix, IsHomalgRing ] );

# basic operations:

DeclareOperation( "AssociatedComputationRing",
        [ IsHomalgRing ] );

DeclareOperation( "AssociatedComputationRing",
        [ IsHomalgRingElement ] );

DeclareOperation( "AssociatedComputationRing",
        [ IsHomalgMatrix ] );

DeclareOperation( "AssociatedGlobalRing",
        [ IsHomalgRing ] );

DeclareOperation( "AssociatedGlobalRing",
        [ IsHomalgRingElement ] );

DeclareOperation( "AssociatedGlobalRing",
        [ IsHomalgMatrix ] );

DeclareOperation( "Numerator",
        [ IsHomalgRingElement ] );

DeclareOperation( "Denominator",
        [ IsHomalgRingElement ] );

DeclareOperation( "Numerator",
        [ IsHomalgMatrix ] );

DeclareOperation( "Denominator",
        [ IsHomalgMatrix ] );

DeclareOperation( "Cancel",
        [ IsRingElement, IsRingElement ] );

DeclareOperation( "/",
        [ IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation ( "LocalizePolynomialRingAtZero",
        [ IsHomalgRing ] );
