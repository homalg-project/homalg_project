#############################################################################
##
##  AffineToricVarieties.gd         ToricVarieties package
##
##  Copyright 2011-2016, Sebastian Gutsche, TU Kaiserslautern
##                       Martin Bies,       ITP Heidelberg
##
#! @Chapter Affine toric varieties
##
#############################################################################

#############################
##
#! @Section The GAP category
##
#############################

#! @Description
#!  The <A>GAP</A> category of an affine toric variety. All affine toric varieties are toric varieties,
#!  so everything applicable to toric varieties is applicable to affine toric varieties.
#! @Returns true or false
#! @Arguments M
DeclareCategory( "IsAffineToricVariety",
                 IsToricVariety );

#############################
##
#! @Section Properties
##
#############################


#############################
##
#! @Section Attributes
##
#############################

#! @Description
#!  Returns the coordinate ring of the affine toric variety <A>vari</A>.
#! @Returns a ring
#! @Arguments vari
DeclareAttribute( "CoordinateRing",
                  IsAffineToricVariety );

#! @Description
#!  Returns a list containing the variables of the CoordinateRing of the variety <A>vari</A>.
#! @Returns a list
#! @Arguments vari
DeclareAttribute( "ListOfVariablesOfCoordinateRing",
                  IsAffineToricVariety );

#! @Description
#!  Returns the morphism between the coordinate ring of the variety <A>vari</A> and the coordinate ring of its torus.
#!  This defines the embedding of the torus in the variety.
#! @Returns a morphism
#! @Arguments vari
DeclareAttribute( "MorphismFromCoordinateRingToCoordinateRingOfTorus",
                  IsToricVariety );

#! @Description
#!  Returns the cone of the affine toric variety <A>vari</A>.
#! @Returns a cone
#! @Arguments vari
DeclareAttribute( "ConeOfVariety",
                  IsToricVariety );

#############################
##
#! @Section Methods
##
#############################

#! @Description
#!  Computes the coordinate ring of the affine toric variety <A>vari</A> with indeterminates <A>indet</A>.
#! @Returns a ring
#! @Arguments vari, indet
DeclareOperation( "CoordinateRing",
                  [ IsToricVariety, IsList ] );

#! @Description
#!  Returns the cone of the variety <A>vari</A>. Another name for ConeOfVariety for compatibility and shortness.
#! @Returns a cone
#! @Arguments vari
DeclareOperation( "Cone",
                  [ IsToricVariety ] );

#############################
##
#! @Section Constructors
##
#############################

#! The constructors are the same as for toric varieties. Calling them with a cone will result in an affine variety.
