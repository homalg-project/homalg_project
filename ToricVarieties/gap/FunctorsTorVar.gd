#############################################################################
##
##  FunctorsTorVar.gd     ToricVarieties       Sebastian Gutsche
##
##  Copyright 2011- 2016, Sebastian Gutsche, TU Kaiserslautern
##                        Martin Bies,       ITP Heidelberg
##
##  Functors for toric varieties.
##
#############################################################################

########################
##
## PicardGroup
##
########################

DeclareGlobalVariable( "functor_PicardGroup_for_toric_varieties" );

DeclareGlobalFunction( "_Functor_PicardGroup_OnToricVarieties" );
DeclareGlobalFunction( "_Functor_PicardGroup_OnToricMorphisms" );

########################
##
## ClassGroup
##
########################

DeclareGlobalVariable( "functor_ClassGroup_for_toric_varieties" );

DeclareGlobalFunction( "_Functor_ClassGroup_OnToricVarieties" );
DeclareGlobalFunction( "_Functor_ClassGroup_OnToricMorphisms" );
