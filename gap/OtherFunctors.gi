#############################################################################
##
##  OtherFunctors.gi            homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for some other functors.
##
#############################################################################

####################################
#
# install global functions/variables:
#
####################################

##
## TorsionSubmodule
##

InstallGlobalFunction( _Functor_TorsionSubmodule_OnObjects,
  function( M )
    local par, emb, tor;
    
    if HasTorsionSubmoduleEmb( M ) then
        return SourceOfMorphism( TorsionSubmoduleEmb( M ) );
    fi;
    
    par := ParametrizeModule( M );
    
    emb := KernelEmb( par );
    
    ## set the attribute TorsionSubmoduleEmb (specific for TorsionSubmodule):
    SetTorsionSubmoduleEmb( M, emb );
    
    tor := SourceOfMorphism( emb );
    
    SetIsTorsionModule( tor, true );
    
    ## save the natural embedding in the kernel (thanks GAP):
    tor!.NaturalEmbedding := emb;
    
    return tor;
    
end );

InstallValue( Functor_TorsionSubmodule,
        CreateHomalgFunctor(
                [ "name", "TorsionSubmodule" ],
                [ "natural_transformation", "TorsionSubmoduleEmb" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ "covariant", IsFinitelyPresentedModuleRep, IsHomalgRing ] ],
                [ "OnObjects", _Functor_TorsionSubmodule_OnObjects ]
                )
);

####################################
#
# methods for operations & attributes:
#
####################################

##
## TorsionSubmodule( M )
##

InstallFunctorOnObjects( Functor_TorsionSubmodule );

InstallFunctorOnMorphisms( Functor_TorsionSubmodule );

