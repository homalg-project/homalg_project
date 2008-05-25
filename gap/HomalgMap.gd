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
        IsHomalgMorphism
        and IsAttributeStoringRep );

DeclareCategory( "IsHomalgSelfMap",	## it is extremely important to let this filter be a GAP-category and NOT a representation or a property,
        IsHomalgMap				## since endomorphisms should be multiplicative elements from the beginning!!
        and IsMultiplicativeElementWithInverse );

####################################
#
# properties:
#
####################################

DeclareProperty( "IsMorphism",
        IsHomalgMap );

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
# attributes:
#
####################################

DeclareAttribute( "Source",
        IsHomalgMap );

DeclareAttribute( "Target",
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

DeclareOperation( "HomalgRing",
        [ IsHomalgMap ] );

DeclareOperation( "PairOfPositionsOfTheDefaultSetOfRelations",
        [ IsHomalgMap ] );

DeclareOperation( "MatrixOfMorphism",
        [ IsHomalgMap, IsPosInt, IsPosInt ] );

DeclareOperation( "MatrixOfMorphism",
        [ IsHomalgMap, IsPosInt ] );

DeclareOperation( "MatrixOfMorphism",
        [ IsHomalgMap ] );

DeclareOperation( "AreComparableMorphisms",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "AreComposableMorphisms",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "LeftInverse",
        [ IsHomalgMap ] );

DeclareOperation( "RightInverse",
        [ IsHomalgMap ] );

DeclareOperation( "*",					## this must remain, since an element in IsHomalgMap
        [ IsHomalgMap, IsHomalgMap ] );	## is not a priori IsMultiplicativeElement

DeclareOperation( "POW",				## this must remain, since an element in IsHomalgMap
        [ IsHomalgMap, IsInt ] );			## is not a priori IsMultiplicativeElement

DeclareOperation( "OnLessGenerators",
        [ IsHomalgMap ] );

DeclareOperation( "BasisOfModule",
        [ IsHomalgMap ] );

DeclareOperation( "DecideZero",
        [ IsHomalgMap, IsHomalgRelations ] );

DeclareOperation( "DecideZero",
        [ IsHomalgMap ] );

DeclareOperation( "UnionOfRelations",
        [ IsHomalgMap ] );

DeclareOperation( "SyzygiesGenerators",
        [ IsHomalgMap ] );

DeclareOperation( "PostDivide",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "CompleteImSq",
        [ IsHomalgMap, IsHomalgMap, IsHomalgMap ] );

