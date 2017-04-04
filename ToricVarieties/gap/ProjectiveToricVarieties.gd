#############################################################################
##
##  ProjectiveToricVarieties.gd         ToricVarieties package
##
##  Copyright 2011- 2016, Sebastian Gutsche, TU Kaiserslautern
##                        Martin Bies,       ITP Heidelberg
##
#! @Chapter Projective toric varieties
##
#############################################################################

#############################
##
#! @Section The GAP category
##
#############################

#! @Description
#!  The <A>GAP</A> category of a projective toric variety.
#! @Returns true or false
#! @Arguments M
DeclareCategory( "IsProjectiveToricVariety",
                 IsToricVariety );

###################################
##
#! @Section Attribute
##
###################################

#! @Description
#!  Returns the polytope corresponding to the projective toric variety <A>vari</A>, if it exists.
#! @Returns a polytope
#! @Arguments vari
DeclareAttribute( "PolytopeOfVariety",
                  IsToricVariety );

#! @Description
#!  Returns the affine cone of the projective toric variety <A>vari</A>.
#! @Returns a cone
#! @Arguments vari
DeclareAttribute( "AffineCone",
                  IsToricVariety );

#! @Description
#!  Returns characters for a closed embedding in an projective space for the projective toric variety <A>vari</A>.
#! @Returns a list
#! @Arguments vari
DeclareAttribute( "ProjectiveEmbedding",
                  IsToricVariety );

###################################
##
#! @Section Properties
##
###################################

#! @Description
#!  Checks if the given toric variety <A>vari</A> is a projective space.
#! @Returns true or false
#! @Arguments vari
DeclareProperty( "IsProjectiveSpace",
                  IsToricVariety );

#! @Description
#!  Checks if the given toric variety <A>vari</A> is a direct product of projective spaces.
#! @Returns true or false
#! @Arguments vari
DeclareProperty( "IsDirectProductOfPNs",
                  IsToricVariety );

###################################
##
#! @Section Methods
##
###################################

#! @Description
#!  Returns the polytope of the variety <A>vari</A>. Another name for PolytopeOfVariety for compatibility and shortness.
#! @Returns a polytope
#! @Arguments vari
DeclareOperation( "Polytope",
                  [ IsToricVariety ] );

#! @Description
#!  Given a projective toric variety <A>vari</A> constructed from a polytope, this method computes the toric divisor 
#!  associated to this polytope. By general theory (see Cox-Schenk-Little) this divisor is known to be ample. 
#!  Thus this method computes an ample divisor on the given toric variety.
#! @Returns an ample divisor
#! @Arguments vari
DeclareOperation( "AmpleDivisor",
               [ IsToricVariety and HasPolytopeOfVariety ] );

###################################
##
#! @Section Constructors
##
###################################

#! The constructors are the same as for toric varieties. Calling them with a polytope will result in a projective variety.
