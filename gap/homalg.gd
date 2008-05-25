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

DeclareInfoClass( "InfoHomalgBasicOperations" );
SetInfoLevel( InfoHomalgBasicOperations, 1 );

# a central place for configurations:
DeclareGlobalVariable( "HOMALG" );

####################################
#
# categories:
#
####################################

# six new categories:

DeclareCategory( "IsHomalgRingOrObject",	## this is the super GAP-category which will include the GAP-categories IsHomalgRing, IsHomalgModule and IsHomalgComplex:
        IsAttributeStoringRep );		## we need this GAP-category to define things like Hom(M,R) as easy as Hom(M,N) without distinguishing between rings and modules

DeclareCategory( "IsHomalgObjectOrMorphism",
        IsExtLElement
        and IsAttributeStoringRep );

DeclareCategory( "IsHomalgObject",		## this is the super GAP-category which will include the GAP-categories IsHomalgModule and IsHomalgComplex:
        IsHomalgObjectOrMorphism		## and to be able to build complexes with *objects* being modules or again complexes!
        and IsHomalgRingOrObject
        and IsAdditiveElementWithZero
        and IsAttributeStoringRep );

DeclareCategory( "IsHomalgMorphism",		## this is the super GAP-category which will include the GAP-categories IsHomalgMorphism and IsHomalgChainMap:
        IsHomalgObjectOrMorphism		## we need this GAP-category to be able to build chain maps with *morphisms* being homomorphisms or again chain maps!
        and IsAdditiveElementWithInverse
        and IsAttributeStoringRep );		## CAUTION: never let homalg morphisms (which are not endomorphisms) be multiplicative elements!!

DeclareCategory( "IsHomalgLeftObjectOrMorphismOfLeftObjects",
        IsHomalgObjectOrMorphism );

DeclareCategory( "IsHomalgRightObjectOrMorphismOfRightObjects",
        IsHomalgObjectOrMorphism );

# a new GAP-category:

DeclareCategory( "IsContainerForWeakPointers",
        IsComponentObjectRep );

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "ContainerForWeakPointers" );

DeclareGlobalFunction( "homalgTotalRuntimes" );

DeclareGlobalFunction( "LogicalImplicationsForHomalg" );

DeclareGlobalFunction( "InstallLogicalImplicationsForHomalg" );

DeclareGlobalFunction( "homalgNamesOfComponentsToIntLists" );

# basic operations:

DeclareOperation( "homalgLaTeX",
        [ IsObject ] ); 

