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
    local S, p, ker, emb;
    
    S := SourceOfMorphism( phi );
    
    p := PositionOfTheDefaultSetOfRelations( S ); ## avoid future possible side effects by the following command(s)
    
    ker := SyzygiesGenerators( phi ) / S;
    
    emb := MatrixOfGenerators( ker, 1 );
    
    ## emb is the matrix of the embedding morphism
    ## w.r.t. the first set of relations of ker and the p-th set of relations of S
    ker!.NaturalEmbedding := HomalgMorphism( emb, [ ker, 1 ], [ S, p ] );
    
    return ker;
    
end );

InstallGlobalFunction( _Functor_Hom_OnObjects,
  function( M, N )
    local R, l0, l1, _l0, matM, matN, HP0N, HP1N, alpha, idN, hom;
    
    R := HomalgRing( M );
    
    if not IsIdenticalObj( R, HomalgRing( N ) ) then
        Error( "the rings of the source and target modules are not identical\n" );
    fi;
    
    l0 := NrGenerators( M );
    l1 := NrRelations( M );
    
    _l0 := NrGenerators( N );
    
    matM := MatrixOfRelations( M );
    matN := MatrixOfRelations( N );
    
    HP0N := DiagMat( ListWithIdenticalEntries( l0, Involution( matN ) ) );
    HP1N := DiagMat( ListWithIdenticalEntries( l1, Involution( matN ) ) );
    
    idN := HomalgIdentityMatrix( _l0, R );
    
    alpha := KroneckerMat( matM, idN );
    
    if IsLeftModule( M ) then
        HP0N := RightPresentation( HP0N );
        HP1N := RightPresentation( HP1N );
    else
        HP0N := LeftPresentation( HP0N );
        HP1N := LeftPresentation( HP1N );
    fi;
    
    alpha := HomalgMorphism( alpha, HP0N, HP1N );
    
    hom := Kernel( alpha );
    
    return hom;
    
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

InstallValue( Functor_Hom,
        CreateHomalgFunctor(
                [ "name", "Hom" ],
                [ "OnObjects", _Functor_Hom_OnObjects ]
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

##
InstallMethod( Hom,
        "for homalg morphisms",
        [ IsFinitelyPresentedModuleRep, IsFinitelyPresentedModuleRep ],
        
  function( M, N )
    local functor, hom;
    
    functor := Functor_Hom;
    
    hom := functor!.OnObjects( M, N );
    
    return hom;
    
end );

##
InstallMethod( Hom,
        "for two homalg modules",
        [ IsFinitelyPresentedModuleRep, IsHomalgRing ],
        
  function( M, R )
    local functor, N, hom;
    
    functor := Functor_Hom;
    
    if IsLeftModule( M ) then
        N := HomalgFreeLeftModule( 1, R );
    else
        N := HomalgFreeRightModule( 1, R );
    fi;
    
    hom := functor!.OnObjects( M, N );
    
    return hom;
    
end );

##
InstallMethod( Hom,
        "for two homalg modules",
        [ IsHomalgRing, IsFinitelyPresentedModuleRep ],
        
  function( R, N )
    local functor, M, hom;
    
    functor := Functor_Hom;
    
    if IsLeftModule( N ) then
        M := HomalgFreeLeftModule( 1, R );
    else
        M := HomalgFreeRightModule( 1, R );
    fi;
    
    hom := functor!.OnObjects( M, N );
    
    return hom;
    
end );

##
InstallMethod( Hom,
        "for two homalg modules",
        [ IsHomalgRing, IsHomalgRing ],
        
  function( R1, R2 )
    local functor, M, N, hom;
    
    functor := Functor_Hom;
    
    M := HomalgFreeLeftModule( 1, R1 );
    N := HomalgFreeRightModule( 1, R2 );
    
    hom := functor!.OnObjects( M, N );
    
    return hom;
    
end );

