#############################################################################
##
##  FunctorsTorVar.gd     ToricVarieties       Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
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
