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
# properties:
#
####################################

DeclareProperty( "IsIdentityMorphism",
        IsHomalgMap );

DeclareProperty( "IsMonomorphism",
        IsHomalgMap );

DeclareProperty( "IsEpimorphism",
        IsHomalgMap );

DeclareProperty( "IsSplitMonomorphism",
        IsHomalgMap );

DeclareProperty( "IsSplitEpimorphism",
        IsHomalgMap );

DeclareProperty( "IsIsomorphism",
        IsHomalgMap );

DeclareProperty( "IsAutomorphism",	## do not make an ``and''-filter out of this property (I hope the other GAP packages respect this)
        IsHomalgMap );

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

DeclareOperation( "StackMaps",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "AugmentMaps",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "PreCompose",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "PostDivide",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "CompleteImageSquare",
        [ IsHomalgMap, IsHomalgMap, IsHomalgMap ] );

