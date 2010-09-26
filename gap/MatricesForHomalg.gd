#############################################################################
##
##  MatricesForHomalg.gd        MatricesForHomalg package    Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for homalg.
##
#############################################################################


# our info classes:
DeclareInfoClass( "InfoMatricesForHomalg" );
SetInfoLevel( InfoMatricesForHomalg, 1 );

DeclareInfoClass( "InfoHomalgBasicOperations" );
SetInfoLevel( InfoHomalgBasicOperations, 1 );

# a central place for configurations:
DeclareGlobalVariable( "HOMALG_MATRICES" );

####################################
#
# categories:
#
####################################

# three new categories:

DeclareCategory( "IsHomalgRingOrObjectOrMorphism",	## this is the super super GAP-category which will include the GAP-categories IsHomalgRingOrObject and IsHomalgObjectOrMorphism:
        IsAttributeStoringRep );			## we need this GAP-category for convenience

DeclareCategory( "IsHomalgRingOrObject",	## this is the super GAP-category which will include the GAP-categories IsHomalgRing, IsHomalgModule, IsHomalgRingOrModule and IsHomalgComplex
        IsHomalgRingOrObjectOrMorphism );

DeclareCategory( "IsHomalgRingOrModule",	## this is the super GAP-category which will include the GAP-categories IsHomalgRing, IsHomalgModule:
        IsHomalgRingOrObject );			## we need this GAP-category to define things like Hom(M,R) as easy as Hom(M,N) without distinguishing between rings and modules

# a new GAP-category:

DeclareCategory( "IsContainerForWeakPointers",
        IsComponentObjectRep );

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "ContainerForWeakPointers" );

DeclareGlobalFunction( "homalgTimeToString" );

DeclareGlobalFunction( "homalgTotalRuntimes" );

DeclareGlobalFunction( "AddLeftRightLogicalImplicationsForHomalg" );

DeclareGlobalFunction( "LogicalImplicationsForOneHomalgObject" );

DeclareGlobalFunction( "LogicalImplicationsForTwoHomalgBasicObjects" );

DeclareGlobalFunction( "InstallLogicalImplicationsForHomalgBasicObjects" );

DeclareGlobalFunction( "LeftRightAttributesForHomalg" );

DeclareGlobalFunction( "InstallLeftRightAttributesForHomalg" );

DeclareGlobalFunction( "MatchPropertiesAndAttributes" );

DeclareGlobalFunction( "AddToAhomalgTable" );

DeclareGlobalFunction( "homalgNamesOfComponentsToIntLists" );

DeclareGlobalFunction( "homalgMode" );

DeclareGlobalFunction( "IncreaseExistingCounterInObject" );

DeclareGlobalFunction( "IncreaseCounterInObject" );

# basic operations:

DeclareOperation( "homalgLaTeX",
        [ IsObject ] );

DeclareOperation( "ExamplesForHomalg",
        [ ] );

DeclareOperation( "ExamplesForHomalg",
        [ IsInt ] );

