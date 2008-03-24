#############################################################################
##
##  HomalgMorphism.gd           homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for homalg morphism.
##
#############################################################################

####################################
#
# categories:
#
####################################

# three new category of objects:

DeclareCategory( "IsHomalgMorphism",
        IsAdditiveElementWithInverse
        and IsExtLElement
        and IsAttributeStoringRep ); ## CAUTION: never let homalg morphisms be multiplicative elements!!

DeclareCategory( "IsHomalgMorphismOfLeftModules",
        IsHomalgMorphism );

DeclareCategory( "IsHomalgMorphismOfRightModules",
        IsHomalgMorphism );

####################################
#
# properties:
#
####################################

DeclareProperty( "IsZeroMorphism",
        IsHomalgMorphism );

DeclareProperty( "IsIdentityMorphism",
        IsHomalgMorphism );

DeclareProperty( "IsMonomorphism",
        IsHomalgMorphism );

DeclareProperty( "IsEpimorphism",
        IsHomalgMorphism );

DeclareProperty( "IsLeftInvertibleMorphism",
        IsHomalgMorphism );

DeclareProperty( "IsRightInvertibleMorphism",
        IsHomalgMorphism );

DeclareProperty( "IsIsomorphism",
        IsHomalgMorphism );

DeclareProperty( "IsAutomorphism",
        IsHomalgMorphism );

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareGlobalFunction( "HomalgMorphism" );

# basic operations:

DeclareOperation( "HomalgRing",
        [ IsHomalgMorphism ] );

DeclareOperation( "MatrixOfMorphism",
        [ IsHomalgMorphism ] );

DeclareOperation( "AnyMatrixOfMorphism",
        [ IsHomalgMorphism ] );

DeclareOperation( "AnyIndicesOfTwoComparableMorphisms",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "AnyIndicesOfTwoComposableMorphisms",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "AreComparableMorphisms",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "LeftInverse",
        [ IsHomalgMorphism ] );

DeclareOperation( "RightInverse",
        [ IsHomalgMorphism ] );

DeclareOperation( "*",					## this must remain, since an element in IsHomalgMorphism
        [ IsHomalgMorphism, IsHomalgMorphism ] );	## is not a priori IsMultiplicativeElement

