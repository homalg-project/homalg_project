#############################################################################
##
##  HomalgRelations.gd          homalg package               Mohamed Barakat
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

# A new GAP-category:

DeclareCategory( "IsHomalgRelations",
        IsAttributeStoringRep );

## CAUTION: in the code the following two categories are the only ones for sets of generators,
##          i.e. IsHomalgRelations and not IsHomalgRelationsOfLeftModule => IsHomalgRelationsOfRightModule

DeclareCategory( "IsHomalgRelationsOfLeftModule",
        IsHomalgRelations );

DeclareCategory( "IsHomalgRelationsOfRightModule",
        IsHomalgRelations );

####################################
#
# properties:
#
####################################

DeclareProperty( "CanBeUsedToDecideZeroEffectively",
        IsHomalgRelations );

DeclareProperty( "IsReducedSetOfRelations",
        IsHomalgRelations );

DeclareProperty( "IsInjectivePresentation",
        IsHomalgRelations );

####################################
#
# attributes:
#
####################################

DeclareAttribute( "FreeResolution",
        IsHomalgRelations );

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareGlobalFunction( "HomalgRelationsForLeftModule" );
DeclareGlobalFunction( "HomalgRelationsForRightModule" );

DeclareOperation( "/",
        [ IsHomalgRing, IsHomalgRelations ] );

# basic operations:

DeclareOperation( "MatrixOfRelations",
        [ IsHomalgRelations ] );

DeclareOperation( "HomalgRing",
        [ IsHomalgRelations ] );

DeclareOperation( "HasNrGenerators",
        [ IsHomalgRelations ] );

DeclareOperation( "NrGenerators",
        [ IsHomalgRelations ] );

DeclareOperation( "HasNrRelations",
        [ IsHomalgRelations ] );

DeclareOperation( "NrRelations",
        [ IsHomalgRelations ] );

DeclareOperation( "CertainRelations",
        [ IsHomalgRelations, IsList ] );

DeclareOperation( "UnionOfRelations",
        [ IsHomalgRelations, IsHomalgRelations ] );

DeclareOperation( "UnionOfRelations",
        [ IsHomalgMatrix, IsHomalgRelations ] );

DeclareOperation( "UnionOfRelations",
        [ IsHomalgRelations, IsHomalgMatrix ] );

DeclareOperation( "BasisOfModule",
        [ IsHomalgRelations ] );

DeclareOperation( "DecideZero",
        [ IsHomalgMatrix, IsHomalgRelations ] );

DeclareOperation( "DecideZero",
        [ IsHomalgRelations, IsHomalgRelations ] );

DeclareOperation( "BasisCoeff",
        [ IsHomalgRelations ] );

DeclareOperation( "DecideZeroEffectively",
        [ IsHomalgMatrix, IsHomalgRelations ] );

DeclareOperation( "SyzygiesGenerators",
        [ IsHomalgRelations ] );

DeclareOperation( "SyzygiesGenerators",
        [ IsHomalgMatrix, IsHomalgRelations ] );

DeclareOperation( "ReducedSyzygiesGenerators",
        [ IsHomalgRelations ] );

DeclareOperation( "ReducedSyzygiesGenerators",
        [ IsHomalgMatrix, IsHomalgRelations ] );

DeclareOperation( "NonZeroGenerators",
        [ IsHomalgRelations ] );

DeclareOperation( "GetRidOfObsoleteRelations",
        [ IsHomalgRelations ] );

DeclareOperation( "GetIndependentUnitPositions",
        [ IsHomalgRelations, IsHomogeneousList ] );

DeclareOperation( "GetIndependentUnitPositions",
        [ IsHomalgRelations ] );

DeclareOperation( "*",
        [ IsHomalgRelations, IsHomalgMatrix ] );

####################################
#
# synonyms:
#
####################################

DeclareSynonym ( "Reduce",
        DecideZero );

DeclareSynonym ( "ReduceCoeff",
        DecideZeroEffectively );

DeclareSynonym ( "BetterBasis",
        GetRidOfObsoleteRelations );

