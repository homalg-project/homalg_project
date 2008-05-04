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
    local R, T, gen, rel, coker;
    
    R := HomalgRing( phi );
    
    T := TargetOfMorphism( phi );
    
    gen := GeneratorsOfModule( T );
    
    rel := UnionOfRelations( phi );
    
    gen := UnionOfRelations( gen, rel * MatrixOfGenerators( gen ) );
    
    coker := Presentation( gen, rel );
    
    ## the identity matrix of the identity morphism (w.r.t. the first set of relations of coker)
    coker!.NaturalEmbedding := HomalgIdentityMorphism( [ coker, 1 ] );
    
    return coker;
    
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
    
    p := PositionOfTheDefaultSetOfRelations( S ); ## avoid future possible side effects by the following command(s)
    
    ker := SyzygiesGenerators( phi ) / S;
    
    emb := MatrixOfGenerators( ker, 1 );
    
    ## emb is the matrix of the embedding morphism
    ## w.r.t. the first set of relations of ker and the p-th set of relations of S
    ker!.NaturalEmbedding := HomalgMorphism( emb, [ ker, 1 ], [ S, p ] );
    
    return ker;
    
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
        "for two homalg modules",
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
        "for two homalg modules",
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
        "for two homalg modules",
        [ IsHomalgRing, IsHomalgRing ],
        
  function( R1, R2 )
    local M, N;
    
    ## I personally prefer the row convention and hence left modules:
    M := AsLeftModule( R1 );
    N := AsLeftModule( R2 );
    
    return Hom( M, N );
    
end );

