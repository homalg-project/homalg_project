#############################################################################
##
##  HomalgMap.gd                homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for homalg maps ( = module homomorphisms ).
##
#############################################################################

####################################
#
# categories:
#
####################################

# two new categories:

DeclareCategory( "IsHomalgMap",
        IsHomalgMorphism );

DeclareCategory( "IsHomalgSelfMap",
        IsHomalgMap and
        IsHomalgEndomorphism );

####################################
#
# attributes:
#
####################################

DeclareAttribute( "MonomorphismModuloImage",
        IsHomalgMap );

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareGlobalFunction( "HomalgMap" );

DeclareGlobalFunction( "HomalgZeroMap" );

DeclareGlobalFunction( "HomalgIdentityMap" );

# basic operations:

DeclareOperation( "PositionOfTheDefaultSetOfRelations",
        [ IsHomalgMap ] );	## provided to avoid branching in the code and always returns fail

DeclareOperation( "PairOfPositionsOfTheDefaultSetOfRelations",
        [ IsHomalgMap ] );

DeclareOperation( "MatrixOfMap",
        [ IsHomalgMap, IsPosInt, IsPosInt ] );

DeclareOperation( "MatrixOfMap",
        [ IsHomalgMap, IsPosInt ] );

DeclareOperation( "MatrixOfMap",
        [ IsHomalgMap ] );

DeclareOperation( "DecideZero",
        [ IsHomalgMap, IsHomalgRelations ] );

DeclareOperation( "UnionOfRelations",
        [ IsHomalgMap ] );

DeclareOperation( "SyzygiesGenerators",
        [ IsHomalgMap ] );

DeclareOperation( "ReducedSyzygiesGenerators",
        [ IsHomalgMap ] );

DeclareOperation( "StackMaps",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "AugmentMaps",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "PreCompose",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "PreInverse",
        [ IsHomalgMap ] );

DeclareOperation( "PostInverse",
        [ IsHomalgMap ] );

DeclareOperation( "CompleteImageSquare",
        [ IsHomalgMap, IsHomalgMap, IsHomalgMap ] );

