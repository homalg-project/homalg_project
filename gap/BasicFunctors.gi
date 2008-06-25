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
## additive functors [HS. Prop. II.9.5] preserves chain complexes [HS. p. 118]
## half exact functors are additive [HS. p. 132 & Ex. IV.5.8]
## a right adjoint functor is left exact [W. Thm. 2.6.1]
## a left adjoint functor is right exact [W. Thm. 2.6.1]
##

##
## Cokernel
##

InstallGlobalFunction( _Functor_Cokernel_OnObjects,	### defines: Cokernel(Epi)
  function( phi )
    local R, T, p, gen, rel, coker, id, epi, emb;
    
    if HasCokernelEpi( phi ) then
        return Range( CokernelEpi( phi ) );
    fi;
    
    R := HomalgRing( phi );
    
    T := Range( phi );
    
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
    epi := HomalgMap( id, [ T, p ], [ coker, 1 ] );
    
    SetIsEpimorphism( epi, true );
    
    ## set the attribute CokernelEpi (specific for Cokernel):
    SetCokernelEpi( phi, epi );
    
    if HasIsMonomorphism( phi ) and IsMonomorphism( phi ) then
        SetKernelEmb( epi, phi );
    fi;
    
    ## this is in general NOT a morphism,
    ## BUT it is one modulo the image of phi in T, and then even a monomorphism:
    ## this is enough for us since we will always view it this way (cf. [BR, 3.1.1,(2), 3.1.2] )
    emb := HomalgMap( id, [ coker, 1 ], [ T, p ] );
    SetMonomorphismModuloImage( emb, phi );
    
    ## save the natural embedding in the cokernel (thanks GAP):
    coker!.NaturalEmbedding := emb;
    
    return coker;
    
end );

InstallValue( Functor_Cokernel,
        CreateHomalgFunctor(
                [ "name", "Cokernel" ],
                [ "natural_transformation", "CokernelEpi" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
                [ "OnObjects", _Functor_Cokernel_OnObjects ]
                )
        );

Functor_Cokernel!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

##
## Kernel
##

InstallGlobalFunction( _Functor_Kernel_OnObjects,	### defines: Kernel(Emb)
  function( psi )
    local S, p, ker, emb;
    
    if HasKernelEmb( psi ) then
        return Source( KernelEmb( psi ) );
    fi;
    
    S := Source( psi );
    
    ## this is probably obsolete but clarifies our idea:
    p := PositionOfTheDefaultSetOfGenerators( S ); ## avoid future possible side effects of the following command(s)
    
    ker := SyzygiesGenerators( psi ) / S;
    
    ## emb is the matrix of the natural embedding
    ## w.r.t. the first set of relations of ker and the p-th set of relations of S
    emb := MatrixOfGenerators( ker, 1 );
    
    emb := HomalgMap( emb, [ ker, 1 ], [ S, p ] );
    
    SetIsMonomorphism( emb, true );
    
    ## set the attribute KernelEmb (specific for Kernel):
    SetKernelEmb( psi, emb );
    
    if HasIsEpimorphism( psi ) and IsEpimorphism( psi ) then
        SetCokernelEpi( emb, psi );
    fi;
    
    ## save the natural embedding in the kernel (thanks GAP):
    ker!.NaturalEmbedding := emb;
    
    return ker;
    
end );

InstallValue( Functor_Kernel,
        CreateHomalgFunctor(
                [ "name", "Kernel" ],
                [ "natural_transformation", "KernelEmb" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
                [ "OnObjects", _Functor_Kernel_OnObjects ]
                )
        );

Functor_Kernel!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

## install KernelEmb for kernel squares (this should be installed automatically in the future)
InstallOtherMethod( KernelEmb,
        "for homalg kernel squares",
        [ IsHomalgChainMap and IsKernelSquare ],
  function( sq )
    local d, dS, dT, phi, muS, muT, kappa;
    
    d := DegreesOfChainMap( sq )[1];
    
    dS := LowestDegreeMorphismInComplex( Source( sq ) );
    dT := LowestDegreeMorphismInComplex( Range( sq ) );
    
    phi := CertainMorphism( sq, d );
    
    muS := KernelEmb( dS );
    muT := KernelEmb( dT );
    
    kappa := CompleteImageSquare( muS, phi, muT );
    
    if IsComplexOfFinitelyPresentedObjectsRep( Source( sq ) ) then
        muS := HomalgComplex( muS, d + 1 );
        muT := HomalgComplex( muT, d + 1 );
        kappa := HomalgChainMap( kappa, muS, muT, d + 1 );
    else
        muS := HomalgCocomplex( muS, d - 1 );
        muT := HomalgCocomplex( muT, d - 1 );
        kappa := HomalgChainMap( kappa, muS, muT, d - 1 );
    fi;
    
    return kappa;
    
end );

## install Kernel for kernel squares (this should be installed automatically in the future)
InstallOtherMethod( Kernel,
        "for homalg kernel squares",
        [ IsHomalgChainMap and IsKernelSquare ],
  function( sq )
    local d, dS, dT, phi, muS, muT;
    
    d := DegreesOfChainMap( sq )[1];
    
    dS := LowestDegreeMorphismInComplex( Source( sq ) );
    dT := LowestDegreeMorphismInComplex( Range( sq ) );
    
    phi := CertainMorphism( sq, d );
    
    muS := KernelEmb( dS );
    muT := KernelEmb( dT );
    
    return CompleteImageSquare( muS, phi, muT );
    
end );

##
## DefectOfExactness
##

InstallGlobalFunction( _Functor_DefectOfExactness_OnObjects,	### defines: DefectOfExactness (DefectOfHoms)
  function( cpx_post_pre )
    local pre, post, M, p, gen, rel, coker, ker, emb;
    
    if not ( IsHomalgComplex( cpx_post_pre ) and Length( ObjectDegreesOfComplex( cpx_post_pre ) ) = 3 ) then
        Error( "expecting a complex containing two morphisms\n" );
    fi;
    
    pre := HighestDegreeMorphismInComplex( cpx_post_pre );
    post := LowestDegreeMorphismInComplex( cpx_post_pre );
    
    M := Range( pre );
    
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
    ## this is enough for us since we will always view it this way (cf. [BR, 3.1.1,(2), 3.1.2] )
    emb := HomalgMap( emb, [ ker, 1 ], [ M, p ] );
    SetMonomorphismModuloImage( emb, pre );
    
    ## save the natural embedding in the defect (thanks GAP):
    ker!.NaturalEmbedding := emb;
    
    return ker;
    
end );

InstallValue( Functor_DefectOfExactness,
        CreateHomalgFunctor(
                [ "name", "DefectOfExactness" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant" ], [ IsHomalgComplex and IsComplexForDefectOfExactness ] ] ],
                [ "OnObjects", _Functor_DefectOfExactness_OnObjects ]
                )
        );

Functor_DefectOfExactness!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_DefectOfExactness!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

## for convenience
InstallMethod( DefectOfExactness,
        "for homalg composable maps",
        [ IsMapOfFinitelyGeneratedModulesRep, IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi, psi )
    
    return DefectOfExactness( AsATwoSequence( phi, psi ) );
    
end );

##
## Hom
##

InstallGlobalFunction( _Functor_Hom_OnObjects,		### defines: Hom (object part)
  function( M, N )
    local R, s, t, l0, l1, _l0, matM, matN, HP0N, HP1N, r, c, idN, alpha, hom,
          gen, proc_to_readjust_generators, proc_to_normalize_generators, p;
    
    R := HomalgRing( M );
    
    if not IsIdenticalObj( R, HomalgRing( N ) ) then
        Error( "the rings of the source and target modules are not identical\n" );
    fi;
    
    if not ( IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) and IsHomalgLeftObjectOrMorphismOfLeftObjects( N ) ) and
       not ( IsHomalgRightObjectOrMorphismOfRightObjects( M ) and IsHomalgRightObjectOrMorphismOfRightObjects( N ) ) then
        Error( "the two modules must either be both left or both right modules\n" );
    fi;
    
    s := PositionOfTheDefaultSetOfGenerators( M );
    t := PositionOfTheDefaultSetOfGenerators( N );
    
    #=====# begin of the core procedure #=====#
    
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
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        r := l0;
        c := _l0;
        
        proc_to_normalize_generators :=
          function( mat, M_with_s, N_with_t )
            local M, s, N, t, mor, mat_old;
            
            ## for better readability of the code:
            M := M_with_s[1];
            s := M_with_s[2];
            
            N := N_with_t[1];
            t := N_with_t[2];
            
            ## we assume mat to be a matrix of a morphism
            ## w.r.t. the CURRENT generators of source and target:
            mor := HomalgMap( mat, M, N );
            
            mat_old := MatrixOfMap( mor, s, t );
            
            return ConvertMatrixToColumn( mat_old );
        end;
        
        proc_to_readjust_generators :=
          function( gen, M_with_s, N_with_t )
            local c, r, mat_old, mor;
            
            ## M_with_s = [ M, s ]
            ## N_with_t = [ N, t ]
            
            r := CallFuncList( NrGenerators, M_with_s );
            c := CallFuncList( NrGenerators, N_with_t );
            
            mat_old := ConvertColumnToMatrix( gen, r, c );
            
            mor := HomalgMap( mat_old, M_with_s, N_with_t );
            
            ## return the matrix of the morphism
            ## w.r.t. the CURRENT generators of source and target:
            return MatrixOfMap( mor );
        end;
        
        HP0N := RightPresentation( HP0N );
        HP1N := RightPresentation( HP1N );
    else
        r := _l0;
        c := l0;
        
        proc_to_normalize_generators :=
          function( mat, M_with_s, N_with_t )
            local M, s, N, t, mor, mat_old;
            
            ## for better readability of the code:
            M := M_with_s[1];
            s := M_with_s[2];
            
            N := N_with_t[1];
            t := N_with_t[2];
            
            ## we assume mat to be a matrix of a morphism
            ## w.r.t. the CURRENT generators of source and target:
            mor := HomalgMap( mat, M, N );
            
            mat_old := MatrixOfMap( mor, s, t );
            
            return ConvertMatrixToRow( mat_old );
        end;
        
        proc_to_readjust_generators :=
          function( gen, M_with_s, N_with_t )
            local c, r, mat_old, mor;
            
            ## M_with_s = [ M, s ]
            ## N_with_t = [ N, t ]
            
            c := CallFuncList( NrGenerators, M_with_s );
            r := CallFuncList( NrGenerators, N_with_t );
            
            mat_old := ConvertRowToMatrix( gen, r, c );
            
            mor := HomalgMap( mat_old, M_with_s, N_with_t );
            
            ## return the matrix of the morphism
            ## w.r.t. the CURRENT generators of source and target:
            return MatrixOfMap( mor );
        end;
        
        HP0N := LeftPresentation( HP0N );
        HP1N := LeftPresentation( HP1N );
    fi;
    
    idN := HomalgIdentityMatrix( _l0, R );
    
    alpha := KroneckerMat( matM, idN );
    
    alpha := HomalgMap( alpha, HP0N, HP1N );
    
    hom := Kernel( alpha );
    
    #=====# end of the core procedure #=====#
    
    gen := GeneratorsOfModule( hom );
    
    SetProcedureToNormalizeGenerators( gen, [ proc_to_normalize_generators, [ M, s ], [ N, t ] ] );
    SetProcedureToReadjustGenerators( gen, [ proc_to_readjust_generators, [ M, s, ], [ N, t ] ] );
    
    return hom;
    
end );

InstallGlobalFunction( _Functor_Hom_OnMorphisms,	### defines: Hom (morphism part)
  function( M_or_mor, N_or_mor )
    local phi, L, R, idL;
    
    R := HomalgRing( M_or_mor );
    
    if not IsIdenticalObj( R, HomalgRing( N_or_mor ) ) then
        Error( "the module and the morphism are not defined over identically the same ring\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    if IsMapOfFinitelyGeneratedModulesRep( M_or_mor )
       and IsFinitelyPresentedModuleRep( N_or_mor ) then
        
        phi := M_or_mor;
        L := N_or_mor;
        
        if not ( IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) and IsHomalgLeftObjectOrMorphismOfLeftObjects( L ) ) and
           not ( IsHomalgRightObjectOrMorphismOfRightObjects( phi ) and IsHomalgRightObjectOrMorphismOfRightObjects( L ) ) then
            Error( "the morphism and the module must either be both left or both right\n" );
        fi;
        
        idL := HomalgIdentityMatrix( NrGenerators( L ), R );
        
        return KroneckerMat( MatrixOfMap( phi ), idL );
        
    elif IsMapOfFinitelyGeneratedModulesRep( N_or_mor )
      and IsFinitelyPresentedModuleRep( M_or_mor ) then
        
        phi := N_or_mor;
        L := M_or_mor;
        
        if not ( IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) and IsHomalgLeftObjectOrMorphismOfLeftObjects( L ) ) and
           not ( IsHomalgRightObjectOrMorphismOfRightObjects( phi ) and IsHomalgRightObjectOrMorphismOfRightObjects( L ) ) then
            Error( "the morphism and the module must either be both left or both right\n" );
        fi;
        
        idL := HomalgIdentityMatrix( NrGenerators( L ), R );
        
        return Involution( KroneckerMat( idL, MatrixOfMap( phi ) ) );
        
    fi;
    
    Error( "one of the arguments must be a module and the other a morphism\n" );
    
end );

InstallValue( Functor_Hom,
        CreateHomalgFunctor(
                [ "name", "Hom" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "contravariant", "right adjoint", "distinguished" ] ] ],
                [ "2", [ [ "covariant", "left exact" ] ] ],
                [ "OnObjects", _Functor_Hom_OnObjects ],
                [ "OnMorphisms", _Functor_Hom_OnMorphisms ]
                )
        );

Functor_Hom!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_Hom!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

##
## TensorProduct
##

InstallGlobalFunction( _Functor_TensorProduct_OnObjects,		### defines: TensorProduct (object part)
  function( M, N )
    local R, s, t, l0, _l0, matM, matN, idM, idN, MN,
          gen, proc_to_readjust_generators, proc_to_normalize_generators, p;
    
    R := HomalgRing( M );
    
    if not IsIdenticalObj( R, HomalgRing( N ) ) then
        Error( "the rings of the source and target modules are not identical\n" );
    fi;
    
    if not ( IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) and IsHomalgLeftObjectOrMorphismOfLeftObjects( N ) ) and
       not ( IsHomalgRightObjectOrMorphismOfRightObjects( M ) and IsHomalgRightObjectOrMorphismOfRightObjects( N ) ) then
        Error( "the two modules must either be both left or both right modules\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    l0 := NrGenerators( M );
    _l0 := NrGenerators( N );
    
    matM := MatrixOfRelations( M );
    matN := MatrixOfRelations( N );
    
    idM := HomalgIdentityMatrix( l0, R );
    idN := HomalgIdentityMatrix( _l0, R );
    
    matM := KroneckerMat( matM, idN );
    matN := KroneckerMat( idM, matN );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        MN := UnionOfRows( matM, matN );
        MN := HomalgMap( MN );
    else
        MN := UnionOfColumns( matM, matN );
        MN := HomalgMap( MN, "r" );
    fi;
    
    MN := Cokernel( MN );
    
    #=====# end of the core procedure #=====#
    
    return MN;
    
end );

InstallGlobalFunction( _Functor_TensorProduct_OnMorphisms,	### defines: TensorProduct (morphism part)
  function( M_or_mor, N_or_mor )
    local phi, L, R, idL;
    
    R := HomalgRing( M_or_mor );
    
    if not IsIdenticalObj( R, HomalgRing( N_or_mor ) ) then
        Error( "the module and the morphism are not defined over identically the same ring\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    if IsMapOfFinitelyGeneratedModulesRep( M_or_mor )
       and IsFinitelyPresentedModuleRep( N_or_mor ) then
        
        phi := M_or_mor;
        L := N_or_mor;
        
        if not ( IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) and IsHomalgLeftObjectOrMorphismOfLeftObjects( L ) ) and
           not ( IsHomalgRightObjectOrMorphismOfRightObjects( phi ) and IsHomalgRightObjectOrMorphismOfRightObjects( L ) ) then
            Error( "the morphism and the module must either be both left or both right\n" );
        fi;
        
        idL := HomalgIdentityMatrix( NrGenerators( L ), R );
        
        return KroneckerMat( MatrixOfMap( phi ), idL );
        
    elif IsMapOfFinitelyGeneratedModulesRep( N_or_mor )
      and IsFinitelyPresentedModuleRep( M_or_mor ) then
        
        phi := N_or_mor;
        L := M_or_mor;
        
        if not ( IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) and IsHomalgLeftObjectOrMorphismOfLeftObjects( L ) ) and
           not ( IsHomalgRightObjectOrMorphismOfRightObjects( phi ) and IsHomalgRightObjectOrMorphismOfRightObjects( L ) ) then
            Error( "the morphism and the module must either be both left or both right\n" );
        fi;
        
        idL := HomalgIdentityMatrix( NrGenerators( L ), R );
        
        return KroneckerMat( idL, MatrixOfMap( phi ) );
        
    fi;
    
    Error( "one of the arguments must be a module and the other a morphism\n" );
    
end );

InstallValue( Functor_TensorProduct,
        CreateHomalgFunctor(
                [ "name", "TensorProduct" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant", "left adjoint", "distinguished" ] ] ],
                [ "2", [ [ "covariant", "left adjoint" ] ] ],
                [ "OnObjects", _Functor_TensorProduct_OnObjects ],
                [ "OnMorphisms", _Functor_TensorProduct_OnMorphisms ]
                )
        );

Functor_TensorProduct!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_TensorProduct!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

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
## DefectOfExactness( cpx_post_pre )
##

InstallFunctorOnObjects( Functor_DefectOfExactness );

##
## Hom( M, N )
##

InstallFunctor( Functor_Hom );

##
## TensorProduct( M, N )	( M * N )
##

InstallFunctor( Functor_TensorProduct );

## for convenience
InstallOtherMethod( \*,
        "for homalg modules",
        [ IsHomalgRingOrObjectOrMorphism, IsFinitelyPresentedModuleRep ],
        
  function( M, N )
    
    return TensorProduct( M, N );
    
end );

## for convenience
InstallOtherMethod( \*,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep, IsHomalgRingOrObjectOrMorphism ],
        
  function( M, N )
    
    return TensorProduct( M, N );
    
end );

##
## Ext( c, M, N )
##

RightSatelliteOfCofunctor( Functor_Hom, 1, "Ext" );

##
## Tor( c, M, N )
##

LeftSatelliteOfFunctor( Functor_TensorProduct, 1, "Tor" );

##
## RHom( c, M, N )
##

RightDerivedCofunctor( Functor_Hom, 1, "RHom" );

##
## LTensorProduct( c, M, N )
##

LeftDerivedFunctor( Functor_TensorProduct, 1, "LTensorProduct" );

