#############################################################################
##
##  GeneratorsForHomalg.gd      homalg package               Mohamed Barakatxb

##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for a set of generators.
##
#############################################################################


####################################
#
# categories:
#
####################################

# A new category of objects:

DeclareCategory( "IsGeneratorsForHomalg",
        IsAttributeStoringRep );

####################################
#
# properties:
#
####################################

DeclareProperty( "IsReduced",
        IsGeneratorsForHomalg );

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

DeclareGlobalFunction( "CreateGeneratorsForLeftModule" );
DeclareGlobalFunction( "CreateGeneratorsForRightModule" );

# basic operations:

DeclareOperation( "MatrixOfGenerators",
        [ IsGeneratorsForHomalg ] );

DeclareOperation( "HomalgRing",
        [ IsGeneratorsForHomalg ] );

DeclareOperation( "MatrixOfRelations",
        [ IsGeneratorsForHomalg ] );

DeclareOperation( "NrGenerators",
        [ IsGeneratorsForHomalg ] );

DeclareOperation( "DecideZero",
        [ IsGeneratorsForHomalg ] );

