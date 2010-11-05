#############################################################################
##
##  OtherFunctors.gd            Graded Modules package
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Declaration stuff for some other graded functors.
##
#############################################################################

####################################
#
# global variables:
#
####################################

## DirectSum
DeclareGlobalFunction( "_Functor_DirectSum_OnGradedModules" );

DeclareGlobalFunction( "_Functor_DirectSum_OnGradedMaps" );

DeclareGlobalVariable( "Functor_DirectSum_for_graded_modules" );

## LinearPart

DeclareOperation( "LinearPart",
        [ IsHomalgMorphism ] );

DeclareGlobalFunction( "_Functor_LinearPart_OnGradedModules" );

DeclareGlobalFunction( "_Functor_LinearPart_OnGradedMaps" );

DeclareGlobalVariable( "Functor_LinearPart_ForGradedModules" );

## StandardModule

DeclareOperation( "StandardModule",
        [ IsHomalgGradedMap ] );

DeclareOperation( "StandardModule",
        [ IsHomalgGradedModule ] );

DeclareGlobalFunction( "_Functor_StandardModule_OnGradedModules" );

DeclareGlobalFunction( "_Functor_StandardModule_OnGradedMaps" );

DeclareGlobalVariable( "Functor_StandardModule_ForGradedModules" );

####################################
#
# temporary
#
####################################

# DeclareGlobalFunction( "_UCT_Homology" );	## FIXME: generalize
# 
# DeclareGlobalFunction( "_UCT_Cohomology" );	## FIXME: generalize

