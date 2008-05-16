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

##
## Cokernel
##

InstallGlobalFunction( _Functor_Cokernel_OnObjects,
  function( phi )
    local R, T, p, gen, rel, coker, id, epi, emb;
    
    R := HomalgRing( phi );
    
    T := TargetOfMorphism( phi );
    
    ## this is probably obsolete but clarifies our idea:
    p := PositionOfTheDefaultSetOfGenerators( T );  ## avoid future possible side effects by the following command(s)
    
    gen := GeneratorsOfModule( T );
    
    rel := UnionOfRelations( phi );
    
    gen := UnionOfRelations( gen, rel * MatrixOfGenerators( gen ) );
    
    coker := Presentation( gen, rel );
    
    ## the identity matrix is the matrix of the natural epimorphism
    ## w.r.t. p-th set of relations of T and the first set of relations of coker:
    id := HomalgIdentityMatrix( NrGenerators( gen ), R );
    
    ## the natural epimorphism:
    epi := HomalgMorphism( id, [ T, p ], [ coker, 1 ] );
    
    SetIsEpimorphism( epi, true );
    
    ## this is in general NOT a morphism,
    ## BUT it is one modulo the image of phi in T (and this is enough for us!)
    emb := HomalgMorphism( id, [ coker, 1 ], [ T, p ] );
    
    coker!.NaturalEmbedding := emb;
    
    return epi;
    
end );

InstallValue( Functor_Cokernel,
        CreateHomalgFunctor(
                [ "name", "Cokernel" ],
                [ "number_of_arguments", 1 ],
                [ "1", "covariant" ],
                [ "OnObjects", _Functor_Cokernel_OnObjects ]
                )
);

##
## Kernel
##

InstallGlobalFunction( _Functor_Kernel_OnObjects,
  function( phi )
    local S, p, ker, emb;
    
    S := SourceOfMorphism( phi );
    
    ## this is probably obsolete but clarifies our idea:
    p := PositionOfTheDefaultSetOfGenerators( S ); ## avoid future possible side effects by the following command(s)
    
    ker := SyzygiesGenerators( phi ) / S;
    
    ## emb is the matrix of the natural embedding
    ## w.r.t. the first set of relations of ker and the p-th set of relations of S
    emb := MatrixOfGenerators( ker, 1 );
    
    emb := HomalgMorphism( emb, [ ker, 1 ], [ S, p ] );
    
    SetIsMonomorphism( emb, true );
    
    ker!.NaturalEmbedding := emb;
    
    return emb;
    
end );

InstallValue( Functor_Kernel,
        CreateHomalgFunctor(
                [ "name", "Kernel" ],
                [ "number_of_arguments", 1 ],
                [ "1", "covariant" ],
                [ "OnObjects", _Functor_Kernel_OnObjects ]
                )
);

##
## Hom
##

InstallGlobalFunction( _Functor_Hom_OnObjects,
  function( M, N )
    local R, s, t, l0, l1, _l0, matM, matN, HP0N, HP1N, r, c, alpha, idN, hom,
          gen, proc_to_readjust_generators, proc_to_normalize_generators;
    
    R := HomalgRing( M );
    
    if not IsIdenticalObj( R, HomalgRing( N ) ) then
        Error( "the rings of the source and target modules are not identical\n" );
    fi;
    
    if not ( IsLeftModule( M ) and IsLeftModule( N ) )
       and not ( IsRightModule( M ) and IsRightModule( N ) ) then
        Error( "the two modules must either be both left or both right modules\n" );
    fi;
    
    s := PositionOfTheDefaultSetOfGenerators( M );
    t := PositionOfTheDefaultSetOfGenerators( N );
    
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
        r := l0;
        c := _l0;
        
        proc_to_normalize_generators :=
          function( mat, M, N, s, t )
            local mor, mat_old;
            
            ## we expect mat to be a matrix of a morphism
            ## w.r.t. the CURRENT generators of source and target:
            mor := HomalgMorphism( mat, M, N );
            
            mat_old := MatrixOfMorphism( mor, s, t );
            
            return ConvertMatrixToColumn( mat_old );
        end;
        
        proc_to_readjust_generators :=
          function( gen, M, N, s, t )
            local r, c, mat_old, mor;
            
            r := NrGenerators( M, s );
            c := NrGenerators( N, t );
            
            mat_old := ConvertColumnToMatrix( gen, r, c );
            
            mor := HomalgMorphism( mat_old, [ M, s ], [ N, t ] );
            
            ## return the matrix of the morphism
            ## w.r.t. the CURRENT generators of source and target:
            return MatrixOfMorphism( mor );
        end;
        
        HP0N := RightPresentation( HP0N );
        HP1N := RightPresentation( HP1N );
    else
        r := _l0;
        c := l0;
        
        proc_to_normalize_generators :=
          function( mat, M, N, s, t )
            local mor, mat_old;
            
            ## we expect mat to be a matrix of a morphism w.r.t. the CURRENT generators of source and target!
            mor := HomalgMorphism( mat, M, N );
            
            mat_old := MatrixOfMorphism( mor, s, t );
            
            return ConvertMatrixToRow( mat_old );
        end;
        
        proc_to_readjust_generators :=
          function( gen, M, N, s, t )
            local c, r, mat_old, mor;
            
            c := NrGenerators( M, s );
            r := NrGenerators( N, t );
            
            mat_old := ConvertRowToMatrix( gen, r, c );
            
            mor := HomalgMorphism( mat_old, [ M, s ], [ N, t ] );
            
            ## return the matrix of the morphism
            ## w.r.t. the CURRENT generators of source and target:
            return MatrixOfMorphism( mor );
        end;
        
        HP0N := LeftPresentation( HP0N );
        HP1N := LeftPresentation( HP1N );
    fi;
    
    alpha := HomalgMorphism( alpha, HP0N, HP1N );
    
    hom := Kernel( alpha );
    
    gen := GeneratorsOfModule( hom );
    
    SetProcedureToNormalizeGenerators( gen, [ proc_to_normalize_generators, M, N, s, t ] );
    SetProcedureToReadjustGenerators( gen, [ proc_to_readjust_generators, M, N, s, t ] );
    
    return hom;
    
end );

InstallGlobalFunction( _Functor_Hom_OnMorphisms,
  function( M_or_mor, N_or_mor )
    local phi, L, R, idL;
    
    R := HomalgRing( M_or_mor );
    
    if not IsIdenticalObj( R, HomalgRing( N_or_mor ) ) then
        Error( "the module and the morphism are not defined over identically the same ring\n" );
    fi;
    
    if IsMorphismOfFinitelyGeneratedModulesRep( M_or_mor )
       and IsFinitelyPresentedModuleRep( N_or_mor ) then
        
        phi := M_or_mor;
        L := N_or_mor;
        
        if not ( IsHomalgMorphismOfLeftModules( phi ) and IsLeftModule( L ) )
           and not ( IsHomalgMorphismOfRightModules( phi ) and IsRightModule( L ) ) then
            Error( "the morphism and the module must either be both left or both right\n" );
        fi;
        
        idL := HomalgIdentityMatrix( NrGenerators( L ), R );
        
        return KroneckerMat( MatrixOfMorphism( phi ), idL );
        
    elif IsMorphismOfFinitelyGeneratedModulesRep( N_or_mor )
      and IsFinitelyPresentedModuleRep( M_or_mor ) then
        
        phi := N_or_mor;
        L := M_or_mor;
        
        if not ( IsHomalgMorphismOfLeftModules( phi ) and IsLeftModule( L ) )
           and not ( IsHomalgMorphismOfRightModules( phi ) and IsRightModule( L ) ) then
            Error( "the morphism and the module must either be both left or both right\n" );
        fi;
        
        idL := HomalgIdentityMatrix( NrGenerators( L ), R );
        
        return Involution( KroneckerMat( idL, MatrixOfMorphism( phi ) ) );
        
    fi;
    
    Error( "one of the arguments must be a module and the other a morphism\n" );
    
end );

InstallValue( Functor_Hom,
        CreateHomalgFunctor(
                [ "name", "Hom" ],
                [ "number_of_arguments", 2 ],
                [ "1", "contravariant" ],
                [ "2", "covariant" ],
                [ "OnObjects", _Functor_Hom_OnObjects ],
                [ "OnMorphisms", _Functor_Hom_OnMorphisms ]
                )
);

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( CokernelEpi,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    local functor, cokernel_epi;
    
    if IsBound(phi!.CokernelEpi) then
        return phi!.CokernelEpi;
    fi;
    
    functor := Functor_Cokernel;
    
    cokernel_epi := functor!.OnObjects( phi );
    
    phi!.CokernelEpi := cokernel_epi;	## here we mimic an attribute (specific for Cokernel)
    
    return cokernel_epi;
    
end );

##
InstallMethod( Cokernel,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return TargetOfMorphism( CokernelEpi( phi ) );
    
end );

##
InstallMethod( KernelEmb,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    local functor, kernel_emb;
    
    if IsBound(phi!.KernelEmb) then
        return phi!.KernelEmb;
    fi;
    
    functor := Functor_Kernel;
    
    kernel_emb := functor!.OnObjects( phi );
    
    phi!.KernelEmb := kernel_emb;	## here we mimic an attribute (specific for Kernel)
    
    return kernel_emb;
    
end );

##
InstallMethod( Kernel,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return SourceOfMorphism( KernelEmb( phi ) );
    
end );

##
## Hom( M, N )
##

##
InstallMethod( Hom,
        "for homalg morphisms",
        [ IsFinitelyPresentedModuleRep, IsFinitelyPresentedModuleRep ],
        
  function( M, N )
    
    return Functor_Hom!.OnObjects( M, N );
    
end );

##
InstallMethod( Hom,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep, IsFinitelyPresentedModuleRep ],
        
  function( phi, L )
    
    return FunctorMap( Functor_Hom, phi, [ [ 2, L ] ] );
    
end );

##
InstallMethod( Hom,
        "for homalg morphisms",
        [ IsFinitelyPresentedModuleRep, IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( L, phi )
    
    return FunctorMap( Functor_Hom, phi, [ [ 1, L ] ] );
    
end );

##
## Hom( M, R )
##

##
InstallMethod( Hom,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep, IsHomalgRing ],
        
  function( M, R )
    local N;
    
    if IsLeftModule( M ) then
        N := AsLeftModule( R );
    else
        N := AsRightModule( R );
    fi;
    
    return Hom( M, N );
    
end );

InstallMethod( Hom,
        "for homalg modules",
        [ IsMorphismOfFinitelyGeneratedModulesRep, IsHomalgRing ],
        
  function( phi, R )
    local N;
    
    if IsHomalgMorphismOfLeftModules( phi ) then
        N := AsLeftModule( R );
    else
        N := AsRightModule( R );
    fi;
    
    return Hom( phi, N );
    
end );

##
## Hom( M ) := Hom( M, R )
##

##
InstallMethod( Hom,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return Hom( M, HomalgRing( M ) );
    
end );

InstallMethod( Hom,
        "for homalg modules",
        [ IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return Hom( phi, HomalgRing( phi ) );
    
end );

##
## Hom( R, N )
##

##
InstallMethod( Hom,
        "for two homalg modules",
        [ IsHomalgRing, IsFinitelyPresentedModuleRep ],
        
  function( R, N )
    local M;
    
    if IsLeftModule( N ) then
        M := AsLeftModule( R );
    else
        M := AsRightModule( R );
    fi;
    
    return Hom( M, N );
        
end );

##
## Hom( R, R )
##

##
InstallMethod( Hom,
        "for homalg rings",
        [ IsHomalgRing, IsHomalgRing ],
        
  function( R1, R2 )
    local M, N;
    
    ## I personally prefer the row convention and hence left modules:
    M := AsLeftModule( R1 );
    N := AsLeftModule( R2 );
    
    return Hom( M, N );
    
end );

