#############################################################################
##
##  ToolFunctors.gi             Modules package              Mohamed Barakat
##
##  Copyright 2007-2010 Mohamed Barakat, RWTH Aachen
##
##  Implementation stuff for some tool functors.
##
#############################################################################

####################################
#
# install global functions/variables:
#
####################################

##
## TheZeroMorphism
##

InstallGlobalFunction( _Functor_TheZeroMorphism_OnModules,	### defines: TheZeroMorphism
  function( M, N )
    
    return HomalgZeroMap( M, N );
    
end );

InstallValue( functor_TheZeroMorphism_ForModules,
        CreateHomalgFunctor(
                [ "name", "TheZeroMorphism for modules" ],
                [ "operation", "TheZeroMorphism" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "contravariant" ] ] ],
                [ "2", [ [ "covariant" ] ] ],
                [ "OnObjects", _Functor_TheZeroMorphism_OnModules ]
                )
        );

functor_TheZeroMorphism_ForModules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

####################################
#
# methods for operations & attributes:
#
####################################

##
## TheZeroMorphism( M, N )
##

InstallFunctorOnObjects( functor_TheZeroMorphism_ForModules );

