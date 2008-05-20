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
    
    if HasCokernelEpi( phi ) then
        return TargetOfMorphism( CokernelEpi( phi ) );
    fi;
    
    R := HomalgRing( phi );
    
    T := TargetOfMorphism( phi );
    
    ## this is probably obsolete but clarifies our idea:
    p := PositionOfTheDefaultSetOfGenerators( T );  ## avoid future possible side effects of the following command(s)
    
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
    
    ## set the attribute CokernelEpi (specific for Cokernel):
    SetCokernelEpi( phi, epi );
    
    ## this is in general NOT a morphism,
    ## BUT it is one modulo the image of phi in T, and then even a monomorphism:
    ## this is enough for us since we will always view it this way (cf. [BR, 3.1.1.(2), 3.1.2] )
    emb := HomalgMorphism( id, [ coker, 1 ], [ T, p ] );
    SetIsTobBeViewedAsAMonomorphism( emb, true );
    
    ## save the natural embedding in the cokernel (thanks GAP):
    coker!.NaturalEmbedding := emb;
    
    return coker;
    
end );

InstallValue( Functor_Cokernel,
        CreateHomalgFunctor(
                [ "name", "Cokernel" ],
                [ "natural_transformation", "CokernelEpi" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ "covariant", IsMorphismOfFinitelyGeneratedModulesRep ] ],
                [ "OnObjects", _Functor_Cokernel_OnObjects ]
                )
);

##
## Kernel
##

InstallGlobalFunction( _Functor_Kernel_OnObjects,
  function( psi )
    local S, p, ker, emb;
    
    if HasKernelEmb( psi ) then
        return SourceOfMorphism( KernelEmb( psi ) );
    fi;
    
    S := SourceOfMorphism( psi );
    
    ## this is probably obsolete but clarifies our idea:
    p := PositionOfTheDefaultSetOfGenerators( S ); ## avoid future possible side effects of the following command(s)
    
    ker := SyzygiesGenerators( psi ) / S;
    
    ## emb is the matrix of the natural embedding
    ## w.r.t. the first set of relations of ker and the p-th set of relations of S
    emb := MatrixOfGenerators( ker, 1 );
    
    emb := HomalgMorphism( emb, [ ker, 1 ], [ S, p ] );
    
    SetIsMonomorphism( emb, true );
    
    ## set the attribute KernelEmb (specific for Kernel):
    SetKernelEmb( psi, emb );
    
    ## save the natural embedding in the kernel (thanks GAP):
    ker!.NaturalEmbedding := emb;
    
    return ker;
    
end );

InstallValue( Functor_Kernel,
        CreateHomalgFunctor(
                [ "name", "Kernel" ],
                [ "natural_transformation", "KernelEmb" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ "covariant", IsMorphismOfFinitelyGeneratedModulesRep ] ],
                [ "OnObjects", _Functor_Kernel_OnObjects ]
                )
);

##
## DefectOfHoms
##

InstallGlobalFunction( _Functor_DefectOfHoms_OnObjects,
  function( phi_psi )
    local phi, psi, R, pre, post, M, p, gen, rel, coker, ker, emb;
    
    if not ( IsList( phi_psi) and Length( phi_psi ) = 2 and ForAll( phi_psi, IsMorphismOfFinitelyGeneratedModulesRep ) ) then
        Error( "expecting a list containing two morphisms\n" );
    fi;
    
    phi := phi_psi[1];
    psi := phi_psi[2];
    
    R := HomalgRing( phi );
    
    if not IsIdenticalObj( R, HomalgRing( psi ) ) then
        Error( "the rings of the two morphisms are not identical\n" );
    fi;
    
    if IsHomalgMorphismOfLeftModules( phi ) and IsHomalgMorphismOfLeftModules( psi ) then
        if not AreComposableMorphisms( phi, psi ) then
            Error( "the two morphisms are not composable, since the target of the left one and the source of right one are not \033[01midentical\033[0m\n" );
        fi;
        
        pre := phi;
        post := psi;
        
    elif IsHomalgMorphismOfRightModules( phi ) and IsHomalgMorphismOfRightModules( psi ) then
        if not AreComposableMorphisms( phi, psi ) then
            Error( "the two morphisms are not composable, since the target of the right one and the target of the left one are not \033[01midentical\033[0m\n" );
        fi;
        
        pre := psi;
        post := phi;
        
    else
        Error( "the two morphisms must either be both left or both right morphisms\n" );
    fi;
    
    M := TargetOfMorphism( pre );
    
    ## this is probably obsolete but clarifies our idea:
    p := PositionOfTheDefaultSetOfGenerators( M );  ## avoid future possible side effects of the following command(s)
    
    gen := GeneratorsOfModule( M );
    
    rel := UnionOfRelations( pre );
    
    gen := UnionOfRelations( gen, rel * MatrixOfGenerators( gen ) );
    
    coker := Presentation( gen, rel );
    
    ker := SyzygiesGenerators( post ) / coker;
    
    ## emb is the matrix of the "natural embedding" (see below)
    ## w.r.t. the first set of relations of ker and the p-th set of relations of M
    emb := MatrixOfGenerators( ker, 1 );
    
    ## this is in general NOT a morphism,
    ## BUT it is one modulo the image of pre in M, and then even a monomorphism:
    ## this is enough for us since we will always view it this way (cf. [BR, 3.1.1.(2), 3.1.2] )
    emb := HomalgMorphism( emb, [ ker, 1 ], [ M, p ] );
    SetIsTobBeViewedAsAMonomorphism( emb, true );
    
    ## save the natural embedding in the defect (thanks GAP):
    ker!.NaturalEmbedding := emb;
    
    return ker;
    
end );

InstallValue( Functor_DefectOfHoms,
        CreateHomalgFunctor(
                [ "name", "DefectOfHoms" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ "covariant", IsHomogeneousList ] ],
                [ "OnObjects", _Functor_DefectOfHoms_OnObjects ]
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
    
    if l0 = 0 then
        HP0N := HomalgZeroMatrix( 0, 0, R );
    else
        HP0N := DiagMat( ListWithIdenticalEntries( l0, Involution( matN ) ) );
    fi;
    
    if l1 = 0 then
        HP1N := HomalgZeroMatrix( 0, 0, R );
    else
        HP1N := DiagMat( ListWithIdenticalEntries( l1, Involution( matN ) ) );
    fi;
    
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
                [ "1", [ "contravariant", IsHomalgRingOrFinitelyPresentedModuleRep, IsMorphismOfFinitelyGeneratedModulesRep,
                        [ IsComplexOfFinitelyPresentedModulesRep, IsCocomplexOfFinitelyPresentedModulesRep ] ] ],
                [ "2", [ "covariant", IsHomalgRingOrFinitelyPresentedModuleRep, IsMorphismOfFinitelyGeneratedModulesRep,
                        [ IsComplexOfFinitelyPresentedModulesRep, IsCocomplexOfFinitelyPresentedModulesRep ] ] ],
                [ "OnObjects", _Functor_Hom_OnObjects ],
                [ "OnMorphisms", _Functor_Hom_OnMorphisms ]
                )
);

####################################
#
# methods for operations & attributes:
#
####################################

##
## Cokernel( phi ) and CokernelEpi( phi )
##

InstallFunctorOnObjects( Functor_Cokernel );

##
## Kernel( phi ) and KernelEmb( phi )
##

InstallFunctorOnObjects( Functor_Kernel );

##
## DefectOfHoms( [ phi, psi ] )
##

InstallFunctorOnObjects( Functor_DefectOfHoms );

##
## Hom( M, N )
##

InstallFunctor( Functor_Hom );

