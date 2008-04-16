#############################################################################
##
##  BasicFunctors.gi            homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for basic functors.
##
#############################################################################

####################################
#
# install global functions/variables:
#
####################################

InstallGlobalFunction( _Functor_Cokernel_OnObjects,
  function( phi )
    local mat, rel;
    
    mat := MatrixOfMorphism( phi );
    rel := MatrixOfRelations( TargetOfMorphism( phi ) );
    
    if IsHomalgMorphismOfLeftModules( phi ) then
        rel := UnionOfRows( mat, rel );
        rel := HomalgRelationsForLeftModule( rel );
    else
        rel := UnionOfColumns( mat, rel );
        rel := HomalgRelationsForRightModule( rel );
    fi;
    
    return rel;
    
end );


InstallValue( Functor_Cokernel,
        CreateHomalgFunctor(
                [ "name", "Cokernel" ],
                [ "OnObjects", _Functor_Cokernel_OnObjects ]
                )
);

InstallValue( Functor_Kernel,
        CreateHomalgFunctor(
                [ "name", "Kernel" ],
                [ "OnObjects", _Functor_Kernel_OnObjects ]
                )
);

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( Cokernel,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    local functor, gen, rel;
    
    functor := Functor_Cokernel;
    
    gen := GeneratorsOfModule( TargetOfMorphism( phi ) );
    
    rel := functor!.OnObjects( phi );
    
    return Presentation( gen, rel );
    
end );

##
InstallMethod( Kernel,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    local functor;
    
    functor := Functor_Kernel;
    
    return functor!.OnObjects( phi );
    
end );

