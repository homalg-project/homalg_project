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

DeclareCategory( "IsHomalgChainSelfMap",
        IsHomalgChainMap and
        IsHomalgEndomorphism );

####################################
#
# properties:
#
####################################

DeclareProperty( "IsQuasiIsomorphism",
        IsHomalgChainMap );

DeclareProperty( "IsImageSquare",
        IsHomalgChainMap );

DeclareProperty( "IsKernelSquare",
        IsHomalgChainMap );

DeclareProperty( "IsLambekPairOfSquares",
        IsHomalgChainMap );

DeclareProperty( "IsChainMapForPullback",
        IsHomalgChainMap );

DeclareProperty( "IsChainMapForPushout",
        IsHomalgChainMap );

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareGlobalFunction( "HomalgChainMap" );

# basic operations:

DeclareOperation( "homalgResetFilters",
        [ IsHomalgChainMap ] );

DeclareOperation( "PositionOfTheDefaultSetOfRelations",
        [ IsHomalgChainMap ] );	## provided to avoid branching in the code and always returns fail

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

DeclareOperation( "CertainMorphismAsKernelSquare",
        [ IsHomalgChainMap, IsInt ] );

DeclareOperation( "CertainMorphismAsImageSquare",
        [ IsHomalgChainMap, IsInt ] );

DeclareOperation( "CertainMorphismAsLambekPairOfSquares",
        [ IsHomalgChainMap, IsInt ] );

