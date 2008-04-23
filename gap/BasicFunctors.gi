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
    local R, T, gen, rel, coker;
    
    R := HomalgRing( phi );
    
    T := TargetOfMorphism( phi );
    
    gen := GeneratorsOfModule( T );
    
    rel := UnionOfRelations( phi );
    
    coker := Presentation( gen, rel );
    
    ## the identity matrix is the identity morphism (w.r.t. the first set of relations of coker)
    coker!.NaturalEmbedding := HomalgIdentityMorphism( [ coker, 1 ] );
    
    return coker;
    
end );

InstallGlobalFunction( _Functor_Kernel_OnObjects,
  function( phi )
    local S, gen, p, emb, ker;
    
    S := SourceOfMorphism( phi );
    
    gen := GeneratorsOfModule( S );
    
    emb := SyzygiesGenerators( phi );
    
    p := PositionOfTheDefaultSetOfRelations( S ); ## avoid future possible side effects by the following command(s)
    
    ker := emb / S;
    
    ## emb is the matrix of the embedding morphism
    ## w.r.t. the first set of relations of ker and the p-th set of relations of S
    ker!.NaturalEmbedding := HomalgMorphism( emb, [ ker, 1 ], [ S, p ] );
    
    return ker;
    
end );

InstallValue( Functor_Cokernel,
        CreateHomalgFunctor(
                [ "name", "Cokernel" ],
                [ "covariant", true ],
                [ "OnObjects", _Functor_Cokernel_OnObjects ]
                )
);

InstallValue( Functor_Kernel,
        CreateHomalgFunctor(
                [ "name", "Kernel" ],
                [ "covariant", true ],
                [ "OnObjects", _Functor_Kernel_OnObjects ]
                )
);

####################################
#
# methods for operations:
#
####################################

##
## Cokernel could've been treated as an attribute of phi,
## but since Kernel was defined as an operation in the GAP library
## we are forced to mimic attributes.
##
InstallMethod( Cokernel,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    local functor, coker;
    
    if IsBound(phi!.Cokernel) then
        return phi!.Cokernel;
    fi;
    
    functor := Functor_Cokernel;
    
    coker := functor!.OnObjects( phi );
    
    phi!.Cokernel := coker; ## here we mimic an attribute (specific for Cokernel)
    
    return coker;
    
end );

##
## Kernel could've been treated as an attribute of phi,
## but since Kernel was defined as an operation in the GAP library
## we are forced to mimic attributes.
##
InstallMethod( Kernel,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    local functor, ker;
    
    if IsBound(phi!.Kernel) then
        return phi!.Kernel;
    fi;
    
    functor := Functor_Kernel;
    
    ker := functor!.OnObjects( phi );
    
    phi!.Kernel := ker; ## here we mimic an attribute (specific for Kernel)
    
    return ker;
    
end );

