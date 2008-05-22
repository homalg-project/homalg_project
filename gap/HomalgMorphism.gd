#############################################################################
##
##  HomalgMorphism.gd           homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for homalg morphisms.
##
#############################################################################

####################################
#
# categories:
#
####################################

# four new category of objects:

DeclareCategory( "IsHomalgMorphism",
        IsAdditiveElementWithInverse
        and IsExtLElement
        and IsAttributeStoringRep ); ## CAUTION: never let homalg morphisms (which are not endomorphisms) be multiplicative elements!!

DeclareCategory( "IsHomalgEndomorphism", ## it is extremely important to let this filter be a category and NOT a representation or a property,
        IsHomalgMorphism                 ## since endomorphisms should be multiplicative elements from the beginning!!
        and IsMultiplicativeElementWithInverse );

DeclareCategory( "IsHomalgMorphismOfLeftModules",
        IsHomalgMorphism );

DeclareCategory( "IsHomalgMorphismOfRightModules",
        IsHomalgMorphism );

####################################
#
# properties:
#
####################################

DeclareProperty( "IsMorphism",
        IsHomalgMorphism );

DeclareProperty( "IsIdentityMorphism",
        IsHomalgMorphism );

DeclareProperty( "IsMonomorphism",
        IsHomalgMorphism );

DeclareProperty( "IsEpimorphism",
        IsHomalgMorphism );

DeclareProperty( "IsSplitMonomorphism",
        IsHomalgMorphism );

DeclareProperty( "IsSplitEpimorphism",
        IsHomalgMorphism );

DeclareProperty( "IsIsomorphism",
        IsHomalgMorphism );

DeclareProperty( "IsAutomorphism",
        IsHomalgMorphism );

DeclareProperty( "IsTobBeViewedAsAMonomorphism",
        IsHomalgMorphism );

####################################
#
# attributes:
#
####################################

DeclareAttribute( "Source",
        IsHomalgMorphism );

DeclareAttribute( "Target",
        IsHomalgMorphism );

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
        [ IsHomalgMorphism ] );

DeclareOperation( "IsLeft",
        [ IsHomalgMorphism ] );

DeclareOperation( "PairOfPositionsOfTheDefaultSetOfRelations",
        [ IsHomalgMorphism ] );

DeclareOperation( "MatrixOfMorphism",
        [ IsHomalgMorphism, IsPosInt, IsPosInt ] );

DeclareOperation( "MatrixOfMorphism",
        [ IsHomalgMorphism, IsPosInt ] );

DeclareOperation( "MatrixOfMorphism",
        [ IsHomalgMorphism ] );

DeclareOperation( "AreComparableMorphisms",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "AreComposableMorphisms",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "LeftInverse",
        [ IsHomalgMorphism ] );

DeclareOperation( "RightInverse",
        [ IsHomalgMorphism ] );

DeclareOperation( "*",					## this must remain, since an element in IsHomalgMorphism
        [ IsHomalgMorphism, IsHomalgMorphism ] );	## is not a priori IsMultiplicativeElement

DeclareOperation( "POW",				## this must remain, since an element in IsHomalgMorphism
        [ IsHomalgMorphism, IsInt ] );			## is not a priori IsMultiplicativeElement

DeclareOperation( "OnLessGenerators",
        [ IsHomalgMorphism ] );

DeclareOperation( "BasisOfModule",
        [ IsHomalgMorphism ] );

DeclareOperation( "DecideZero",
        [ IsHomalgMorphism, IsHomalgRelations ] );

DeclareOperation( "DecideZero",
        [ IsHomalgMorphism ] );

DeclareOperation( "UnionOfRelations",
        [ IsHomalgMorphism ] );

DeclareOperation( "SyzygiesGenerators",
        [ IsHomalgMorphism ] );

DeclareOperation( "PostDivide",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "CompleteImSq",
        [ IsHomalgMorphism, IsHomalgMorphism, IsHomalgMorphism ] );
