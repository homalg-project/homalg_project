#############################################################################
##
##  HomalgChainMap.gd           homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for homalg chain maps.
##
#############################################################################

####################################
#
# categories:
#
####################################

# two new categories:

DeclareCategory( "IsHomalgChainMap",
        IsHomalgMorphism );

DeclareCategory( "IsHomalgChainSelfMap",	## it is extremely important to let this filter be a GAP-category and NOT a representation or a property,
        IsHomalgChainMap			## since chain self maps should be multiplicative elements from the beginning!!
        and IsMultiplicativeElementWithInverse );

####################################
#
# properties:
#
####################################

DeclareProperty( "IsMorphism",
        IsHomalgChainMap );

####################################
#
# attributes:
#
####################################

DeclareAttribute( "Source",
        IsHomalgChainMap );

DeclareAttribute( "Target",
        IsHomalgChainMap );

DeclareAttribute( "DegreeOfChainMap",
        IsHomalgChainMap );

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "homalgResetFiltersOfChainMap" );

# constructor methods:

DeclareGlobalFunction( "HomalgChainMap" );

# basic operations:

DeclareOperation( "HomalgRing",
        [ IsHomalgChainMap ] );

DeclareOperation( "DegreesOfChainMap",
        [ IsHomalgChainMap ] );

DeclareOperation( "ObjectDegreesOfComplex",	## this is not a mistake
        [ IsHomalgChainMap ] );

DeclareOperation( "MorphismDegreesOfComplex",	## this is not a mistake
        [ IsHomalgChainMap ] );

DeclareOperation( "CertainMorphism",
        [ IsHomalgChainMap, IsInt ] );

DeclareOperation( "MorphismsOfChainMap",
        [ IsHomalgChainMap ] );

DeclareOperation( "CertainModuleOfChainMap",
        [ IsHomalgChainMap, IsInt ] );

DeclareOperation( "LowestDegreeInChainMap",
        [ IsHomalgChainMap ] );

DeclareOperation( "HighestDegreeInChainMap",
        [ IsHomalgChainMap ] );

DeclareOperation( "LowestDegreeMorphismInChainMap",
        [ IsHomalgChainMap ] );

DeclareOperation( "HighestDegreeMorphismInChainMap",
        [ IsHomalgChainMap ] );

DeclareOperation( "SupportOfChainMap",
        [ IsHomalgChainMap ] );

DeclareOperation( "Add",
        [ IsHomalgChainMap, IsHomalgMorphism ] );

DeclareOperation( "Add",
        [ IsHomalgChainMap, IsHomalgMatrix ] );

DeclareOperation( "OnLessGenerators",
        [ IsHomalgChainMap ] );

