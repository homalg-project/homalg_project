#############################################################################
##
##  ToricMorphisms.gd         ToricVarieties package
##
##  Copyright 2011- 2016, Sebastian Gutsche, TU Kaiserslautern
##                        Martin Bies,       ITP Heidelberg
##
#! @Chapter Toric morphisms
##
#############################################################################

#############################
##
#! @Section The GAP category
##
#############################

#! @Description
#! The <A>GAP</A> category of toric morphisms. A toric morphism is defined by a grid
#! homomorphism, which is compatible with the fan structure of the two varieties.
#! @Returns true or false
#! @Arguments M
DeclareCategory( "IsToricMorphism",
                 IsObject );

###############################
##
#! @Section Properties
##
###############################

#! @Description
#! Checks if the grid morphism <A>morph</A> respects the fan structure.
#! @Returns true or false
#! @Arguments morph
DeclareProperty( "IsMorphism",
                 IsToricMorphism );

#! @Description
#! Checks if the defined morphism <A>morph</A> is proper.
#! @Returns true or false
#! @Arguments morph
DeclareProperty( "IsProper",
                 IsToricMorphism );

###############################
##
#! @Section Attributes
##
###############################

#! @Description
#! Returns the source object of the morphism <A>morph</A>. This attribute is a must have.
#! @Returns a variety
#! @Arguments morph
DeclareAttribute( "SourceObject",
                  IsToricMorphism );

#! @Description
#! Returns the grid map which defines <A>morph</A>.
#! @Returns a map
#! @Arguments morph
DeclareAttribute( "UnderlyingGridMorphism",
                  IsToricMorphism );

#! @Description
#! Returns the variety which is created by the fan which is the image of the fan of the source of <A>morph</A>.
#! This is not an image in the usual sense, but a toric image.
#! @Returns a variety
#! @Arguments morph
DeclareAttribute( "ToricImageObject",
                  IsToricMorphism );

#! @Description
#! Returns the range of the morphism <A>morph</A>. If no range is given
#! (yes, this is possible), the method returns the image.
#! @Returns a variety
#! @Arguments morph
DeclareAttribute( "RangeObject",
                  IsToricMorphism );

#! @Description
#! Returns the associated morphism between the divisor group of the range of <A>morph</A>
#! and the divisor group of the source.
#! @Returns a morphism
#! @Arguments morph
DeclareAttribute( "MorphismOnWeilDivisorGroup",
                  IsToricMorphism );

#! @Description
#! Returns the associated morphism between the class groups of source and range of the morphism <A>morph</A>
#! @Returns a morphism
#! @Arguments morph
DeclareAttribute( "ClassGroup",
                  IsToricMorphism );

#! @Description
#! Returns the associated morphism between the Cartier divisor groups
#! of source and range of the morphism <A>morph</A>
#! @Returns a morphism
#! @Arguments morph
DeclareAttribute( "MorphismOnCartierDivisorGroup",
                  IsToricMorphism );

#! @Description
#! Returns the associated morphism between the Picard groups
#! of source and range of the morphism <A>morph</A>
#! @Returns a morphism
#! @Arguments morph
DeclareAttribute( "PicardGroup",
                  IsToricMorphism );

#! @Description
#! Return the source of the toric morphism <A>morph</A>.
#! @Returns a variety
#! @Arguments morph
DeclareAttribute( "Source",
                  IsToricMorphism );

#! @Description
#! Returns the range of the toric morphism <A>morph</A> if specified.
#! @Returns a variety
#! @Arguments morph
DeclareAttribute( "Range",
                  IsToricMorphism );

#! @Description
#! METHOD NOT IMPLEMENTED YET, JUST DECLARED
#! FIX ME FIX ME FIX ME FIX ME
DeclareAttribute( "MorphismOnIthFactor",
                  IsToricMorphism );

###############################
##
#! @Section Methods
##
###############################

#! @Description
#! Returns a list of list which represents the grid homomorphism.
#! @Returns a list
#! @Arguments morph
DeclareOperation( "UnderlyingListList",
                  [ IsToricMorphism ] );

###############################
##
#! @Section Constructors
##
###############################

#! @Description
#! Returns the toric morphism with source <A>vari</A> which is represented by the matrix <A>lis</A>.
#! The range is set to the image.
#! @Returns a morphism
#! @Arguments vari,lis
DeclareOperation( "ToricMorphism",
                  [ IsToricVariety, IsList ] );

#! @Description
#! Returns the toric morphism with source <A>vari</A> and range <A>vari2</A> which is represented by the 
#! matrix <A>lis</A>.
#! @Returns a morphism
#! @Arguments vari,lis,vari2
DeclareOperation( "ToricMorphism",
                  [ IsToricVariety, IsList, IsToricVariety ] );
