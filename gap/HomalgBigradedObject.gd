#############################################################################
##
##  HomalgBigradedObject.gd     homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for homalg bigraded objects.
##
#############################################################################

####################################
#
# categories:
#
####################################

# a new GAP-category:

DeclareCategory( "IsHomalgBigradedObject",
        IsHomalgObject );

# three new GAP-subcategories:

DeclareCategory( "IsHomalgBigradedObjectAssociatedToAnExactCouple",
        IsHomalgBigradedObject );

DeclareCategory( "IsHomalgBigradedObjectAssociatedToAFilteredComplex",	## the 0-th spectral sheet E0 stemming from a filtration is a bigraded (differential) object,
        IsHomalgBigradedObject );					## which, in general, does not stem from an exact couple (although E1, E2, ... do)

DeclareCategory( "IsHomalgBigradedObjectAssociatedToABicomplex",
        IsHomalgBigradedObjectAssociatedToAFilteredComplex );

####################################
#
# properties:
#
####################################

DeclareProperty( "IsEndowedWithDifferential",
        IsHomalgBigradedObject );

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareOperation( "HomalgBigradedObject",
        [ IsHomalgBicomplex ] );

DeclareOperation( "HomalgBigradedObject",
        [ IsHomalgBicomplex, IsInt ] );

DeclareOperation( "AsDifferentialObject",
        [ IsHomalgBigradedObject ] );

DeclareOperation( "DefectOfExactness",
        [ IsHomalgBigradedObject ] );

# basic operations:

DeclareOperation( "homalgResetFilters",
        [ IsHomalgBigradedObject ] );

DeclareOperation( "PositionOfTheDefaultSetOfRelations",
        [ IsHomalgBigradedObject ] );			## provided to avoid branching in the code and always returns fail

DeclareOperation( "ObjectDegreesOfBigradedObject",
        [ IsHomalgBigradedObject ] );

DeclareOperation( "CertainObject",
        [ IsHomalgBigradedObject, IsList ] );

DeclareOperation( "ObjectsOfBigradedObject",
        [ IsHomalgBigradedObject ] );

DeclareOperation( "LowestBidegreeInBigradedObject",
        [ IsHomalgBigradedObject ] );

DeclareOperation( "HighestBidegreeInBigradedObject",
        [ IsHomalgBigradedObject ] );

DeclareOperation( "LowestBidegreeObjectInBigradedObject",
        [ IsHomalgBigradedObject ] );

DeclareOperation( "HighestBidegreeObjectInBigradedObject",
        [ IsHomalgBigradedObject ] );

DeclareOperation( "CertainMorphism",
        [ IsHomalgBigradedObject, IsList ] );

DeclareOperation( "UnderlyingBicomplex",
        [ IsHomalgBigradedObjectAssociatedToABicomplex ] );

DeclareOperation( "BidegreeOfDifferential",
        [ IsHomalgBigradedObject ] );

DeclareOperation( "LevelOfBigradedObject",
        [ IsHomalgBigradedObject ] );

