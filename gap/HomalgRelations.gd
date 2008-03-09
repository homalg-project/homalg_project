#############################################################################
##
##  HomalgRelations.gd       homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for a set of relations.
##
#############################################################################

####################################
#
# categories:
#
####################################

# A new category of objects:

DeclareCategory( "IsHomalgRelations",
        IsAttributeStoringRep );

####################################
#
# properties:
#
####################################

DeclareProperty( "CanBeUsedToEffectivelyDecideZero",
        IsHomalgRelations );

DeclareProperty( "IsReducedSetOfRelations",
        IsHomalgRelations );

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

DeclareGlobalFunction( "HomalgRelationsForLeftModule" );
DeclareGlobalFunction( "HomalgRelationsForRightModule" );

# basic operations:

DeclareOperation( "MatrixOfRelations",
        [ IsHomalgRelations ] );

DeclareOperation( "HomalgRing",
        [ IsHomalgRelations ] );

DeclareOperation( "NrGenerators",
        [ IsHomalgRelations ] );

DeclareOperation( "NrRelations",
        [ IsHomalgRelations ] );

DeclareOperation( "BasisOfModule",
        [ IsHomalgRelations ] );

DeclareOperation( "DecideZero",
        [ IsHomalgMatrix, IsHomalgRelations ] );

DeclareOperation( "DecideZero",
        [ IsHomalgRelations, IsHomalgRelations ] );

DeclareOperation( "BasisCoeff",
        [ IsHomalgRelations ] );

DeclareOperation( "EffectivelyDecideZero",
        [ IsHomalgMatrix, IsHomalgRelations ] );

DeclareOperation( "SyzygiesGenerators",
        [ IsHomalgRelations, IsHomalgRelations ] );

DeclareOperation( "SyzygiesGenerators",
        [ IsHomalgRelations, IsList ] );

DeclareOperation( "NonZeroGenerators",
        [ IsHomalgRelations ] );

DeclareOperation( "GetRidOfTrivialRelations",
        [ IsHomalgRelations ] );

####################################
#
# synonyms:
#
####################################

DeclareSynonym ( "Reduce",
        DecideZero );

DeclareSynonym ( "ReduceCoeff",
        EffectivelyDecideZero );

DeclareSynonym ( "DecideZeroCoeff",
        EffectivelyDecideZero );

DeclareSynonym ( "BetterBasis",
        GetRidOfTrivialRelations );

