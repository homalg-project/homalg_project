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

DeclareProperty( "IsTobBeViewedAsAMonomorphism",
        IsHomalgMap );

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareGlobalFunction( "HomalgMorphism" );

DeclareGlobalFunction( "HomalgZeroMorphism" );

DeclareGlobalFunction( "HomalgIdentityMorphism" );

# basic operations:

DeclareOperation( "PairOfPositionsOfTheDefaultSetOfRelations",
        [ IsHomalgMap ] );

DeclareOperation( "MatrixOfHomomorphism",
        [ IsHomalgMap, IsPosInt, IsPosInt ] );

DeclareOperation( "MatrixOfHomomorphism",
        [ IsHomalgMap, IsPosInt ] );

DeclareOperation( "MatrixOfHomomorphism",
        [ IsHomalgMap ] );

DeclareOperation( "DecideZero",
        [ IsHomalgMap, IsHomalgRelations ] );

DeclareOperation( "UnionOfRelations",
        [ IsHomalgMap ] );

DeclareOperation( "SyzygiesGenerators",
        [ IsHomalgMap ] );

DeclareOperation( "PostDivide",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "CompleteImSq",
        [ IsHomalgMap, IsHomalgMap, IsHomalgMap ] );

