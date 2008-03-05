#############################################################################
##
##  RelationsForHomalg.gd       homalg package               Mohamed Barakat
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

DeclareCategory( "IsRelationsForHomalg",
        IsAttributeStoringRep );

####################################
#
# properties:
#
####################################

DeclareProperty( "CanBeUsedToEffectivelyDecideZero",
        IsRelationsForHomalg );

DeclareProperty( "IsReducedSetOfRelations",
        IsRelationsForHomalg );

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

DeclareGlobalFunction( "CreateRelationsForLeftModule" );
DeclareGlobalFunction( "CreateRelationsForRightModule" );

# basic operations:

DeclareOperation( "MatrixOfRelations",
        [ IsRelationsForHomalg ] );

DeclareOperation( "HomalgRing",
        [ IsRelationsForHomalg ] );

DeclareOperation( "NrGenerators",
        [ IsRelationsForHomalg ] );

DeclareOperation( "NrRelations",
        [ IsRelationsForHomalg ] );

DeclareOperation( "BasisOfModule",
        [ IsRelationsForHomalg ] );

DeclareOperation( "DecideZero",
        [ IsHomalgMatrix, IsRelationsForHomalg ] );

DeclareOperation( "DecideZero",
        [ IsRelationsForHomalg, IsRelationsForHomalg ] );

DeclareOperation( "BasisCoeff",
        [ IsRelationsForHomalg ] );

DeclareOperation( "EffectivelyDecideZero",
        [ IsHomalgMatrix, IsRelationsForHomalg ] );

DeclareOperation( "SyzygiesGenerators",
        [ IsRelationsForHomalg, IsRelationsForHomalg ] );

DeclareOperation( "SyzygiesGenerators",
        [ IsRelationsForHomalg, IsList ] );

DeclareOperation( "NonZeroGenerators",
        [ IsRelationsForHomalg ] );

DeclareOperation( "GetRidOfTrivialRelations",
        [ IsRelationsForHomalg ] );

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

