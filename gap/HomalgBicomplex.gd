#############################################################################
##
##  HomalgBicomplex.gd          homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for homalg bicomplexes.
##
#############################################################################

####################################
#
# categories:
#
####################################

# a new GAP-category:

DeclareCategory( "IsHomalgBicomplex",
        IsHomalgObject );

####################################
#
# properties:
#
####################################

DeclareProperty( "IsBicomplex",
        IsHomalgBicomplex );

DeclareProperty( "IsBisequence",
        IsHomalgBicomplex );

DeclareProperty( "IsTransposedWRTTheAssociatedComplex",
        IsHomalgBicomplex );

####################################
#
# attributes:
#
####################################

DeclareAttribute( "TotalComplex",
        IsHomalgBicomplex );

DeclareAttribute( "SpectralSequence",
        IsHomalgBicomplex );

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareGlobalFunction( "HomalgBicomplex" );

DeclareOperation( "TransposedBicomplex",
        [ IsHomalgBicomplex ] );

# basic operations:

DeclareOperation( "UnderlyingComplex",
        [ IsHomalgBicomplex ] );

DeclareOperation( "homalgResetFilters",
        [ IsHomalgBicomplex ] );

DeclareOperation( "PositionOfTheDefaultSetOfRelations",
        [ IsHomalgBicomplex ] );			## provided to avoid branching in the code and always returns fail

DeclareOperation( "ObjectDegreesOfBicomplex",
        [ IsHomalgBicomplex ] );

DeclareOperation( "CertainObject",
        [ IsHomalgBicomplex, IsList ] );

DeclareOperation( "ObjectsOfBicomplex",
        [ IsHomalgBicomplex ] );

DeclareOperation( "LowestBidegreeInBicomplex",
        [ IsHomalgBicomplex ] );

DeclareOperation( "HighestBidegreeInBicomplex",
        [ IsHomalgBicomplex ] );

DeclareOperation( "LowestBidegreeObjectInBicomplex",
        [ IsHomalgBicomplex ] );

DeclareOperation( "HighestBidegreeObjectInBicomplex",
        [ IsHomalgBicomplex ] );

DeclareOperation( "CertainVerticalMorphism",
        [ IsHomalgBicomplex, IsList ] );

DeclareOperation( "CertainHorizontalMorphism",
        [ IsHomalgBicomplex, IsList ] );

DeclareOperation( "BidegreesOfObjectOfTotalComplex",
        [ IsHomalgBicomplex, IsInt ] );

DeclareOperation( "MorphismOfTotalComplex",
        [ IsHomalgBicomplex, IsInt ] );

