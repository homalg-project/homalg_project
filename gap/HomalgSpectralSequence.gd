#############################################################################
##
##  HomalgSpectralSequence.gd   homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for homalg spectral sequences.
##
#############################################################################

####################################
#
# categories:
#
####################################

# a new GAP-category:

DeclareCategory( "IsHomalgSpectralSequence",
        IsHomalgObject );

# three new GAP-subcategories:

DeclareCategory( "IsHomalgSpectralSequenceAssociatedToAnExactCouple",
        IsHomalgSpectralSequence );

DeclareCategory( "IsHomalgSpectralSequenceAssociatedToAFilteredComplex",	## the 0-th spectral sheet E0 stemming from a filtration is a bigraded (differential) object,
        IsHomalgSpectralSequence );						## which, in general, does not stem from an exact couple (although E1, E2, ... do)

DeclareCategory( "IsHomalgSpectralSequenceAssociatedToABicomplex",
        IsHomalgSpectralSequenceAssociatedToAFilteredComplex );

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

DeclareAttribute( "GeneralizedEmbeddingsInTotalObjects",
        IsHomalgSpectralSequence );

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareOperation( "HomalgSpectralSequence",
        [ IsInt, IsHomalgBicomplex, IsInt ] );

DeclareOperation( "HomalgSpectralSequence",
        [ IsInt, IsHomalgBicomplex ] );

DeclareOperation( "HomalgSpectralSequence",
        [ IsHomalgBicomplex, IsInt ] );

DeclareOperation( "HomalgSpectralSequence",
        [ IsHomalgBicomplex ] );

# basic operations:

DeclareOperation( "homalgResetFilters",
        [ IsHomalgSpectralSequence ] );

DeclareOperation( "PositionOfTheDefaultSetOfRelations",
        [ IsHomalgSpectralSequence ] );			## provided to avoid branching in the code and always returns fail

DeclareOperation( "LevelsOfSpectralSequence",
        [ IsHomalgSpectralSequence ] );

DeclareOperation( "CertainSheet",
        [ IsHomalgSpectralSequence, IsInt ] );

DeclareOperation( "LowestLevelInSpectralSequence",
        [ IsHomalgSpectralSequence ] );

DeclareOperation( "HighestLevelInSpectralSequence",
        [ IsHomalgSpectralSequence ] );

DeclareOperation( "SheetsOfSpectralSequence",
        [ IsHomalgSpectralSequence ] );

DeclareOperation( "LowestLevelSheetInSpectralSequence",
        [ IsHomalgSpectralSequence ] );

DeclareOperation( "HighestLevelSheetInSpectralSequence",
        [ IsHomalgSpectralSequence ] );

DeclareOperation( "ObjectDegreesOfSpectralSequence",
        [ IsHomalgSpectralSequence ] );

DeclareOperation( "CertainObject",
        [ IsHomalgSpectralSequence, IsList, IsInt ] );

DeclareOperation( "CertainObject",
        [ IsHomalgSpectralSequence, IsList ] );

DeclareOperation( "ObjectsOfSpectralSequence",
        [ IsHomalgSpectralSequence, IsInt ] );

DeclareOperation( "ObjectsOfSpectralSequence",
        [ IsHomalgSpectralSequence ] );

DeclareOperation( "LowestBidegreeInSpectralSequence",
        [ IsHomalgSpectralSequence ] );

DeclareOperation( "HighestBidegreeInSpectralSequence",
        [ IsHomalgSpectralSequence ] );

DeclareOperation( "LowestBidegreeObjectInSpectralSequence",
        [ IsHomalgSpectralSequence, IsInt ] );

DeclareOperation( "LowestBidegreeObjectInSpectralSequence",
        [ IsHomalgSpectralSequence ] );

DeclareOperation( "HighestBidegreeObjectInSpectralSequence",
        [ IsHomalgSpectralSequence, IsInt ] );

DeclareOperation( "HighestBidegreeObjectInSpectralSequence",
        [ IsHomalgSpectralSequence ] );

DeclareOperation( "CertainMorphism",
        [ IsHomalgSpectralSequence, IsList, IsInt ] );

DeclareOperation( "CertainMorphism",
        [ IsHomalgSpectralSequence, IsList ] );

DeclareOperation( "UnderlyingBicomplex",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex ] );

DeclareOperation( "AssociatedFirstSpectralSequence",
        [ IsHomalgSpectralSequence ] );

DeclareOperation( "FiltrationOfObjectInStableSecondSheetOfI_E",
        [ IsHomalgSpectralSequence, IsInt ] );

DeclareOperation( "FiltrationOfObjectInStableSecondSheetOfI_E",
        [ IsHomalgSpectralSequence ] );

