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

DeclareProperty( "IsAutomorphism",
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

DeclareOperation( "PostDivide",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "CompleteImageSquare",
        [ IsHomalgMap, IsHomalgMap, IsHomalgMap ] );

