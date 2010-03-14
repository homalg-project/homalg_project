#############################################################################
##
##  homalg.gd                   homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for homalg.
##
#############################################################################


# our info classes:
DeclareInfoClass( "InfoHomalg" );
SetInfoLevel( InfoHomalg, 1 );

# a central place for configurations:
DeclareGlobalVariable( "HOMALG" );

####################################
#
# categories:
#
####################################

# four new categories:

DeclareCategory( "IsHomalgObjectOrMorphism",	## this is the super GAP-category which will include the GAP-categories IsHomalgModule, IsHomalgMap, IsHomalgComplex and IsHomalgChainMap:
        IsExtLElement and			## with this GAP-category we can have a common declaration for things like OnLessGenerators, BasisOfModule, DecideZero
        IsHomalgRingOrObjectOrMorphism );

DeclareCategory( "IsHomalgObject",		## this is the super GAP-category which will include the GAP-categories IsHomalgModule and IsHomalgComplex:
        IsHomalgObjectOrMorphism and		## we need this GAP-category to be able to build complexes with *objects* being modules or again complexes!
        IsHomalgRingOrObject and
        IsAdditiveElementWithZero );

DeclareCategory( "IsHomalgMorphism",		## this is the super GAP-category which will include the GAP-categories IsHomalgMap and IsHomalgChainMap:
        IsHomalgObjectOrMorphism and		## we need this GAP-category to be able to build chain maps with *morphisms* being homomorphisms or again chain maps!
        IsAdditiveElementWithInverse );		## CAUTION: never let homalg morphisms (which are not endomorphisms) be multiplicative elements!!

DeclareCategory( "IsHomalgEndomorphism",	## this is the super GAP-category which will include the GAP-categories IsHomalgSelfMap and IsHomalgChainSelfMap
        IsHomalgMorphism and
        IsMultiplicativeElementWithInverse );

DeclareCategory( "IsHomalgLeftObjectOrMorphismOfLeftObjects",
        IsHomalgObjectOrMorphism );

DeclareCategory( "IsHomalgRightObjectOrMorphismOfRightObjects",
        IsHomalgObjectOrMorphism );

####################################
#
# properties:
#
####################################

DeclareProperty( "IsMorphism",
        IsHomalgMorphism );

DeclareProperty( "IsGeneralizedMorphism",
        IsHomalgMorphism );

DeclareProperty( "IsGeneralizedEpimorphism",
        IsHomalgMorphism );

DeclareProperty( "IsGeneralizedMonomorphism",
        IsHomalgMorphism );

DeclareProperty( "IsGeneralizedIsomorphism",
        IsHomalgMorphism );

DeclareProperty( "IsIdentityMorphism",
        IsHomalgMorphism );

DeclareProperty( "IsMonomorphism",
        IsHomalgMorphism );

DeclareProperty( "IsEpimorphism",
        IsHomalgMorphism );

DeclareProperty( "IsSplitMonomorphism",
        IsHomalgMorphism );

DeclareProperty( "IsSplitEpimorphism",
        IsHomalgMorphism );

DeclareProperty( "IsIsomorphism",
        IsHomalgMorphism );

DeclareProperty( "IsAutomorphism",	## do not make an ``and''-filter out of this property (I hope the other GAP packages respect this)
        IsHomalgMorphism );

####################################
#
# attributes:
#
####################################

DeclareAttribute( "Source",
        IsHomalgMorphism );

DeclareAttribute( "Range",
        IsHomalgMorphism );

DeclareAttribute( "LeftInverse",
        IsHomalgMorphism );

DeclareAttribute( "RightInverse",
        IsHomalgMorphism );

DeclareAttribute( "DegreeOfMorphism",
        IsHomalgMorphism );

DeclareAttribute( "AsCokernel",
        IsHomalgObjectOrMorphism );

DeclareAttribute( "AsKernel",
        IsHomalgObjectOrMorphism );

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "LogicalImplicationsForTwoHomalgObjects" );

DeclareGlobalFunction( "InstallLogicalImplicationsForHomalgObjects" );

DeclareGlobalFunction( "LogicalImplicationsForHomalgSubobjects" );

DeclareGlobalFunction( "InstallLogicalImplicationsForHomalgSubobjects" );

# basic operations:

DeclareOperation( "HomalgRing",
        [ IsHomalgObjectOrMorphism ] );

DeclareOperation( "AsLeftObject",
        [ IsHomalgRing ] );

DeclareOperation( "AsRightObject",
        [ IsHomalgRing ] );

DeclareOperation( "AreComparableMorphisms",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "AreComposableMorphisms",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "*",					## this must remain, since an element in IsHomalgMorphism
        [ IsHomalgMorphism, IsHomalgMorphism ] );	## is not a priori IsMultiplicativeElement

DeclareOperation( "POW",				## this must remain, since an element in IsHomalgMorphism
        [ IsHomalgMorphism, IsInt ] );			## is not a priori IsMultiplicativeElement

DeclareOperation( "BasisOfModule",
        [ IsHomalgObjectOrMorphism ] );

DeclareOperation( "DecideZero",
        [ IsHomalgObjectOrMorphism ] );

DeclareOperation( "OnLessGenerators",
        [ IsHomalgObjectOrMorphism ] );

DeclareOperation( "ByASmallerPresentation",
        [ IsHomalgObjectOrMorphism ] );

