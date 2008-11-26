#############################################################################
##
##  HomalgFunctor.gd            homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for functors.
##
#############################################################################

####################################
#
# categories:
#
####################################

# A new GAP-category:

DeclareCategory( "IsHomalgFunctor",
        IsAttributeStoringRep );

####################################
#
# properties:
#
####################################

####################################
#
# attributes:
#
####################################

DeclareAttribute( "Genesis",
        IsHomalgFunctor );

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareGlobalFunction( "CreateHomalgFunctor" );

DeclareOperation( "ApplyFunctor",
        [ IsHomalgFunctor, IsInt, IsHomalgRingOrObjectOrMorphism, IsString ] );

DeclareOperation( "ComposeFunctors",
        [ IsHomalgFunctor, IsInt, IsHomalgFunctor, IsString ] );

DeclareOperation( "ComposeFunctors",
        [ IsHomalgFunctor, IsInt, IsHomalgFunctor ] );

DeclareOperation( "ComposeFunctors",
        [ IsHomalgFunctor, IsHomalgFunctor, IsString ] );

DeclareOperation( "ComposeFunctors",
        [ IsHomalgFunctor, IsHomalgFunctor ] );

DeclareOperation( "*",
        [ IsHomalgFunctor, IsHomalgFunctor ] );

DeclareOperation( "RightSatelliteOfCofunctor",
        [ IsHomalgFunctor, IsInt, IsString ] );

DeclareOperation( "RightSatelliteOfCofunctor",
        [ IsHomalgFunctor, IsInt ] );

DeclareOperation( "LeftSatelliteOfFunctor",
        [ IsHomalgFunctor, IsInt, IsString ] );

DeclareOperation( "LeftSatelliteOfFunctor",
        [ IsHomalgFunctor, IsInt ] );

DeclareOperation( "RightDerivedCofunctor",
        [ IsHomalgFunctor, IsInt, IsString ] );

DeclareOperation( "LeftDerivedFunctor",
        [ IsHomalgFunctor, IsInt, IsString ] );

DeclareOperation( "RightDerivedCofunctor",
        [ IsHomalgFunctor, IsInt ] );

DeclareOperation( "LeftDerivedFunctor",
        [ IsHomalgFunctor, IsInt ] );

# basic operations:

DeclareOperation( "NaturalGeneralizedEmbedding",
        [ IsHomalgModule ] );

DeclareOperation( "NameOfFunctor",
        [ IsHomalgFunctor ] );

DeclareOperation( "OperationOfFunctor",
        [ IsHomalgFunctor ] );

DeclareOperation( "IsSpecialFunctor",
        [ IsHomalgFunctor ] );

DeclareOperation( "MultiplicityOfFunctor",
        [ IsHomalgFunctor ] );

DeclareOperation( "IsCovariantFunctor",
        [ IsHomalgFunctor, IsInt ] );

DeclareOperation( "IsCovariantFunctor",
        [ IsHomalgFunctor ] );

DeclareOperation( "IsDistinguishedArgumentOfFunctor",
        [ IsHomalgFunctor, IsInt ] );

DeclareOperation( "IsDistinguishedFirstArgumentOfFunctor",
        [ IsHomalgFunctor ] );

DeclareOperation( "IsAdditiveFunctor",
        [ IsHomalgFunctor, IsInt ] );

DeclareOperation( "IsAdditiveFunctor",
        [ IsHomalgFunctor ] );

DeclareOperation( "FunctorObj",
        [ IsHomalgFunctor, IsList ] );

DeclareOperation( "FunctorMap",
        [ IsHomalgFunctor, IsHomalgMap, IsList ] );

DeclareOperation( "FunctorMap",
        [ IsHomalgFunctor, IsHomalgMap ] );

DeclareOperation( "InstallFunctorOnObjects",
        [ IsHomalgFunctor ] );

DeclareOperation( "InstallFunctorOnMorphisms",
        [ IsHomalgFunctor ] );

DeclareOperation( "InstallSpecialFunctorOnMorphisms",
        [ IsHomalgFunctor ] );

DeclareOperation( "InstallFunctorOnComplexes",
        [ IsHomalgFunctor ] );

DeclareOperation( "InstallFunctorOnChainMaps",
        [ IsHomalgFunctor ] );

DeclareOperation( "InstallFunctor",
        [ IsHomalgFunctor ] );

DeclareOperation( "InstallDeltaFunctor",
        [ IsHomalgFunctor ] );

DeclareGlobalFunction( "HelperToInstallUnivariateFunctorOnComplexes" );

DeclareGlobalFunction( "HelperToInstallFirstArgumentOfBivariateFunctorOnComplexes" );

DeclareGlobalFunction( "HelperToInstallSecondArgumentOfBivariateFunctorOnComplexes" );

DeclareGlobalFunction( "HelperToInstallFirstArgumentOfBivariateFunctorOnMorphismsAndSecondArgumentOnComplexes" );

DeclareGlobalFunction( "HelperToInstallFirstAndSecondArgumentOfBivariateFunctorOnComplexes" );

DeclareGlobalFunction( "HelperToInstallUnivariateFunctorOnChainMaps" );

DeclareGlobalFunction( "HelperToInstallFirstArgumentOfBivariateFunctorOnChainMaps" );

DeclareGlobalFunction( "HelperToInstallSecondArgumentOfBivariateFunctorOnChainMaps" );

DeclareGlobalFunction( "HelperToInstallUnivariateDeltaFunctor" );

DeclareGlobalFunction( "HelperToInstallFirstArgumentOfBivariateDeltaFunctor" );

DeclareGlobalFunction( "HelperToInstallSecondArgumentOfBivariateDeltaFunctor" );

DeclareGlobalFunction( "HelperToInstallFirstArgumentOfTrivariateDeltaFunctor" );

DeclareGlobalFunction( "HelperToInstallSecondArgumentOfTrivariateDeltaFunctor" );

DeclareGlobalFunction( "HelperToInstallThirdArgumentOfTrivariateDeltaFunctor" );

