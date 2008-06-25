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

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareGlobalFunction( "CreateHomalgFunctor" );

# basic operations:

DeclareOperation( "NameOfFunctor",
        [ IsHomalgFunctor ] );

DeclareOperation( "MultiplicityOfFunctor",
        [ IsHomalgFunctor ] );

DeclareOperation( "IsCovariantFunctor",
        [ IsHomalgFunctor, IsInt ] );

DeclareOperation( "IsCovariantFunctor",
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

DeclareOperation( "RightSatelliteOfCofunctor",
        [ IsHomalgFunctor, IsInt, IsString ] );

DeclareOperation( "LeftSatelliteOfFunctor",
        [ IsHomalgFunctor, IsInt, IsString ] );

DeclareOperation( "RightDerivedCofunctor",
        [ IsHomalgFunctor, IsInt, IsString ] );

DeclareOperation( "LeftDerivedFunctor",
        [ IsHomalgFunctor, IsInt, IsString ] );

DeclareOperation( "InstallFunctorOnObjects",
        [ IsHomalgFunctor ] );

DeclareOperation( "InstallFunctorOnMorphisms",
        [ IsHomalgFunctor ] );

DeclareOperation( "InstallFunctorOnComplexes",
        [ IsHomalgFunctor ] );

DeclareOperation( "InstallFunctorOnChainMaps",
        [ IsHomalgFunctor ] );

DeclareOperation( "InstallFunctor",
        [ IsHomalgFunctor ] );

DeclareGlobalFunction( "HelperToInstallUnivariateFunctorOnComplexes" );

DeclareGlobalFunction( "HelperToInstallFirstArgumentOfBivariateFunctorOnComplexes" );

DeclareGlobalFunction( "HelperToInstallSecondArgumentOfBivariateFunctorOnComplexes" );

DeclareGlobalFunction( "HelperToInstallUnivariateFunctorOnChainMaps" );

DeclareGlobalFunction( "HelperToInstallFirstArgumentOfBivariateFunctorOnChainMaps" );

DeclareGlobalFunction( "HelperToInstallSecondArgumentOfBivariateFunctorOnChainMaps" );

