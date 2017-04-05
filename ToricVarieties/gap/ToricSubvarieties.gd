#############################################################################
##
##  ToricSubvarieties.gd         ToricVarieties package
##
##  Copyright 2011- 2016, Sebastian Gutsche, TU Kaiserslautern
##                        Martin Bies,       ITP Heidelberg
##
#! @Chapter Toric subvarieties
##
#############################################################################

###################################
##
#! @Section The GAP category
##
###################################

#! @Description
#!  The <A>GAP</A> category of a toric subvariety. Every toric subvariety is a toric variety,
#!  so every method applicable to toric varieties is also applicable to toric subvarieties.
#! @Returns true or false
#! @Arguments M
DeclareCategory( "IsToricSubvariety",
                 IsToricVariety );

#################################
##
#! @Section Properties
##
#################################

#! @Description
#!  Checks if the subvariety <A>vari</A> is a closed subset of its ambient variety.
#! @Returns true or false
#! @Arguments vari
DeclareProperty( "IsClosedSubvariety",
                 IsToricSubvariety );

# DeclareOperation( "IsClosed",
#                  [ IsToricSubvariety ] );
# 
# DeclareOperation( "HasIsClosed",
#                   [ IsToricSubvariety ] );
# 
# DeclareOperation( "SetIsClosed",
#                   [ IsToricSubvariety, IsBool ] );

#! @Description
#!  Checks if a subvariety is a closed subset.
#! @Returns true or false
#! @Arguments vari
DeclareProperty( "IsOpen",
                 IsToricSubvariety );

#! @Description
#!  Returns true if the subvariety <A>vari</A> is the whole variety.
#! @Returns true or false
#! @Arguments vari
DeclareProperty( "IsWholeVariety",
                 IsToricSubvariety );

################################
##
#! @Section Attributes
##
################################

#! @Description
#!  Returns the toric variety which is represented by <A>vari</A>. This
#!  method implements the forgetful functor subvarieties -> varieties.
#! @Returns a variety
#! @Arguments vari
DeclareAttribute( "UnderlyingToricVariety",
                  IsToricSubvariety );

#! @Description
#!  If the variety <A>vari</A> is an open subvariety, this method returns
#!  the inclusion morphism in its ambient variety. If not, it will fail.
#! @Returns a morphism
#! @Arguments vari
DeclareAttribute( "InclusionMorphism",
                  IsToricSubvariety );

#! @Description
#!  Returns the ambient toric variety of the subvariety <A>vari</A>
#! @Returns a variety
#! @Arguments vari
DeclareAttribute( "AmbientToricVariety",
                  IsToricSubvariety );

################################
##
#! @Section Methods
##
################################

#! @Description
#!  The method returns the closure of the orbit of the torus contained in <A>vari</A> which corresponds 
#!  to the cone <A>cone</A> as a closed subvariety of <A>vari</A>.
#! @Returns a subvariety
#! @Arguments vari, cone
DeclareOperation( "ClosureOfTorusOrbitOfCone",
                  [ IsToricVariety, IsCone ] );

################################
##
#! @Section Constructors
##
################################

#! @Description
#!  The method returns the closure of the orbit of the torus contained in <A>vari</A> which corresponds 
#!  to the cone <A>cone</A> as a closed subvariety of <A>vari</A>.
#! @Returns a subvariety
#! @Arguments vari, ambvari
DeclareOperation( "ToricSubvariety",
                  [ IsToricVariety, IsToricVariety ] );
