#############################################################################
##
##  BasicFunctors.gi            Modules package              Mohamed Barakat
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
## Cokernel
##

##
InstallGlobalFunction( _Functor_Cokernel_OnModules,	### defines: Cokernel(Epi)
  function( phi )
    local R, T, p, rel, gen, coker, id, epi, gen_iso, img_emb, emb;
    
    if HasCokernelEpi( phi ) then
        return Range( CokernelEpi( phi ) );
    fi;
    
    R := HomalgRing( phi );
    
    T := Range( phi );
    
    ## this is probably obsolete but clarifies our idea:
    p := PositionOfTheDefaultSetOfGenerators( T );  ## avoid future possible side effects of the following command(s)
    
    rel := UnionOfRelations( phi );
    
    gen := GeneratorsOfModule( T );
    
    gen := UnionOfRelations( gen, rel * gen );
    
    coker := Presentation( gen, rel );
    
    ## the identity matrix is the matrix of the natural epimorphism
    ## w.r.t. the p-th set of relations of T and the first set of relations of coker:
    id := HomalgIdentityMatrix( NrGenerators( gen ), R );
    
    ## the natural epimorphism:
    epi := HomalgMap( id, [ T, p ], [ coker, 1 ] );
    
    ## we cannot check this assertion, since
    ## checking it would cause an infinite loop
    SetIsEpimorphism( epi, true );
    
    ## set the attribute CokernelEpi (specific for Cokernel):
    SetCokernelEpi( phi, epi );
    
    ## the generalized inverse of the natural epimorphism
    ## (cf. [Bar, Cor. 4.8])
    gen_iso := HomalgMap( id, [ coker, 1 ], [ T, p ] );
    
    ## set the morphism aid map
    SetMorphismAid( gen_iso, phi );
    
    ## set the generalized inverse of the natural epimorphism
    SetGeneralizedInverse( epi, gen_iso );
    
    ## we cannot check this assertion, since
    ## checking it would cause an infinite loop
    SetIsGeneralizedIsomorphism( gen_iso, true );
    
    #=====# end of the core procedure #=====#
    
    ## abelian category: [HS, Prop. II.9.6]
    if HasImageObjectEmb( phi ) then
        img_emb := ImageObjectEmb( phi );
        SetKernelEmb( epi, img_emb );
        if not HasCokernelEpi( img_emb ) then
            SetCokernelEpi( img_emb, epi );
        fi;
    elif HasIsMonomorphism( phi ) and IsMonomorphism( phi ) then
        SetKernelEmb( epi, phi );
    fi;
    
    ## this is in general NOT a morphism,
    ## BUT it is one modulo the image of phi in T, and then even a monomorphism:
    ## this is enough for us since we will always view it this way (cf. [BR08, 3.1.1,(2), 3.1.2] )
    emb := HomalgMap( id, [ coker, 1 ], [ T, p ] );
    SetMorphismAid( emb, phi );
    
    ## we cannot check this assertion, since
    ## checking it would cause an infinite loop
    SetIsGeneralizedIsomorphism( emb, true );
    
    ## save the natural embedding in the cokernel (thanks GAP):
    coker!.NaturalGeneralizedEmbedding := emb;
    
    return coker;
    
end );

##  <#GAPDoc Label="functor_Cokernel:code">
##      <Listing Type="Code"><![CDATA[
InstallValue( functor_Cokernel_for_fp_modules,
        CreateHomalgFunctor(
                [ "name", "Cokernel" ],
                [ "category", HOMALG_MODULES.category ],
                [ "operation", "Cokernel" ],
                [ "natural_transformation", "CokernelEpi" ],
                [ "special", true ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant" ],
                        [ IsMapOfFinitelyGeneratedModulesRep,
                          [ IsHomalgChainMap, IsImageSquare ] ] ] ],
                [ "OnObjects", _Functor_Cokernel_OnModules ]
                )
        );
##  ]]></Listing>
##  <#/GAPDoc>

functor_Cokernel_for_fp_modules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

##
## ImageObject
##

InstallGlobalFunction( _Functor_ImageObject_OnModules,	### defines: ImageObject(Emb)
  function( phi )
    local T, p, img, emb, coker_epi, img_submodule;
    
    if HasImageObjectEmb( phi ) then
        return Source( ImageObjectEmb( phi ) );
    fi;
    
    T := Range( phi );
    
    ## this is probably obsolete but clarifies our idea:
    p := PositionOfTheDefaultSetOfGenerators( T );  ## avoid future possible side effects of the following command(s)
    
    ## the image module
    img := MatrixOfMap( phi ) / T;
    
    ## emb is the matrix of the natural embedding
    ## w.r.t. the first set of relations of img and the p-th set of relations of T
    emb := MatrixOfGenerators( img, 1 );
    
    emb := HomalgMap( emb, [ img, 1 ], [ T, p ] );
    
    ## check assertion
    Assert( 3, IsMonomorphism( emb ) );
    
    if HasIsEpimorphism( phi ) and IsEpimorphism( phi ) then
        SetIsIsomorphism( emb, true );
    else
        SetIsMonomorphism( emb, true );
    fi;
    
    ## set the attribute ImageObjectEmb (specific for ImageObject):
    ## (since ImageObjectEmb is listed below as a natural transformation
    ##  for the functor ImageObject, a method will be automatically installed
    ##  by InstallFunctor to fetch it by first invoking the main operation ImageObject)
    SetImageObjectEmb( phi, emb );
    
    #=====# end of the core procedure #=====#
    
    ## abelian category: [HS, Prop. II.9.6]
    if HasCokernelEpi( phi ) then
        coker_epi := CokernelEpi( phi );
        SetCokernelEpi( emb, coker_epi );
        if not HasKernelEmb( coker_epi ) then
            SetKernelEmb( coker_epi, emb );
        fi;
    fi;
    
    ## at last define the image submodule
    img_submodule := ImageSubobject( phi );
    
    SetUnderlyingSubobject( img, img_submodule );
    SetEmbeddingInSuperObject( img_submodule, emb );
    
    ## save the natural embedding in the image (thanks GAP):
    img!.NaturalGeneralizedEmbedding := emb;
    
    return img;
    
end );

##  <#GAPDoc Label="functor_ImageObject:code">
##      <Listing Type="Code"><![CDATA[
InstallValue( functor_ImageObject_for_fp_modules,
        CreateHomalgFunctor(
                [ "name", "ImageObject for modules" ],
                [ "category", HOMALG_MODULES.category ],
                [ "operation", "ImageObject" ],
                [ "natural_transformation", "ImageObjectEmb" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant" ],
                        [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
                [ "OnObjects", _Functor_ImageObject_OnModules ]
                )
        );
##  ]]></Listing>
##  <#/GAPDoc>

functor_ImageObject_for_fp_modules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

##
## Hom
##

InstallGlobalFunction( _Functor_Hom_OnModules,		### defines: Hom (object part)
  function( M, N )
    local s, t, dM, dN, P1, l0, l1, _l0, matM, matN, R, HP0N, HP1N,
          degM, degN, degP1, degHP0N, degHP1N, r, c, idN, alpha, hom, gen,
          proc_to_readjust_generators, proc_to_normalize_generators, p;
    
    CheckIfTheyLieInTheSameCategory( M, N );
    
    s := PositionOfTheDefaultSetOfGenerators( M );
    t := PositionOfTheDefaultSetOfGenerators( N );
    
    dM := PresentationMorphism( M );
    dN := PresentationMorphism( N );
    
    P1 := Source( dM );
    
    l0 := NrGenerators( M );
    l1 := NrGenerators( P1 );
    
    _l0 := NrGenerators( N );
    
    matM := MatrixOfMap( dM );
    matN := MatrixOfMap( dN );
    
    R := HomalgRing( M );
    
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
    
    ## take care of graded modules
    if IsList( DegreesOfGenerators( M ) ) and
       IsList( DegreesOfGenerators( N ) ) and
       IsList( DegreesOfGenerators( P1 ) ) then
        degM := DegreesOfGenerators( M );
        degN := DegreesOfGenerators( N );
        degP1 := DegreesOfGenerators( P1 );
        if degM = [ ] then
            degHP0N := [ ];
        elif degN = [ ] then
            degHP0N := [ ];
        else
            degHP0N := Concatenation( List( degM, m -> -m + degN ) );
        fi;
        if degP1 = [ ] then
            degHP1N := [ ];
        elif degN = [ ] then
            degHP1N := [ ];
        else
            degHP1N := Concatenation( List( degP1, m -> -m + degN ) );
        fi;
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
        
        if IsBound( degHP0N ) then
            HP0N := RightPresentationWithDegrees( HP0N, degHP0N );
        else
            HP0N := RightPresentation( HP0N );
        fi;
        if IsBound( degHP1N ) then
            HP1N := RightPresentationWithDegrees( HP1N, degHP1N );
        else
            HP1N := RightPresentation( HP1N );
        fi;
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
        
        if IsBound( degHP0N ) then
            HP0N := LeftPresentationWithDegrees( HP0N, degHP0N );
        else
            HP0N := LeftPresentation( HP0N );
        fi;
        if IsBound( degHP1N ) then
            HP1N := LeftPresentationWithDegrees( HP1N, degHP1N );
        else
            HP1N := LeftPresentation( HP1N );
        fi;
    fi;
    
    idN := HomalgIdentityMatrix( _l0, R );
    
    alpha := KroneckerMat( matM, idN );
    
    alpha := HomalgMap( alpha, HP0N, HP1N );
    
    SetIsMorphism( alpha, true );
    
    hom := Kernel( alpha );
    
    #=====# end of the core procedure #=====#
    
    gen := GeneratorsOfModule( hom );
    
    SetProcedureToNormalizeGenerators( gen, [ proc_to_normalize_generators, [ M, s ], [ N, t ] ] );
    SetProcedureToReadjustGenerators( gen, [ proc_to_readjust_generators, [ M, s, ], [ N, t ] ] );
    
    return hom;
    
end );

##
InstallGlobalFunction( _Functor_Hom_OnMaps,	### defines: Hom (morphism part)
  function( M_or_mor, N_or_mor )
    local R, phi, L, idL;
    
    CheckIfTheyLieInTheSameCategory( M_or_mor, N_or_mor );
    
    R := HomalgRing( M_or_mor );
    
    if IsMapOfFinitelyGeneratedModulesRep( M_or_mor )
       and IsFinitelyPresentedModuleRep( N_or_mor ) then
        
        phi := M_or_mor;
        L := N_or_mor;
        
        idL := HomalgIdentityMatrix( NrGenerators( L ), R );
        
        return KroneckerMat( MatrixOfMap( phi ), idL );
        
    elif IsMapOfFinitelyGeneratedModulesRep( N_or_mor )
      and IsFinitelyPresentedModuleRep( M_or_mor ) then
        
        phi := N_or_mor;
        L := M_or_mor;
        
        idL := HomalgIdentityMatrix( NrGenerators( L ), R );
        
        return Involution( KroneckerMat( idL, MatrixOfMap( phi ) ) );
        
    fi;
    
    Error( "one of the arguments must be a module and the other a morphism\n" );
    
end );

##  <#GAPDoc Label="Functor_Hom:code">
##      <Listing Type="Code"><![CDATA[
InstallValue( Functor_Hom_for_fp_modules,
        CreateHomalgFunctor(
                [ "name", "Hom" ],
                [ "category", HOMALG_MODULES.category ],
                [ "operation", "Hom" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "contravariant", "right adjoint", "distinguished" ] ] ],
                [ "2", [ [ "covariant", "left exact" ] ] ],
                [ "OnObjects", _Functor_Hom_OnModules ],
                [ "OnMorphisms", _Functor_Hom_OnMaps ],
                [ "MorphismConstructor", HOMALG_MODULES.category.MorphismConstructor ]
                )
        );
##  ]]></Listing>
##  <#/GAPDoc>

Functor_Hom_for_fp_modules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_Hom_for_fp_modules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

##
InstallMethod( NatTrIdToHomHom_R,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local HM, iota, HHM, bas, epsilon;
    
    HM := Hom( M );
    
    iota := MatrixOfGenerators( HM );
    
    HHM := Hom( HM );
    
    bas := MatrixOfGenerators( HHM );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        epsilon := RightDivide( iota, bas );
    else
        epsilon := LeftDivide( iota, bas );
    fi;
    
    epsilon := HomalgMap( epsilon, M, HHM );
    
    SetPropertiesIfKernelIsTorsionObject( epsilon );
    
    return epsilon;
    
end );

##
InstallMethod( LeftDualizingFunctor,
        "for homalg rings",
        [ IsHomalgRing, IsString ],
        
  function( R, name )
    
    return InsertObjectInMultiFunctor( Functor_Hom_for_fp_modules, 2, 1 * R, name );
    
end );

##
InstallMethod( LeftDualizingFunctor,
        "for homalg rings",
        [ IsHomalgRing ],
        
  function( R )
    
    if not IsBound( R!.Functor_R_Hom ) then
        if IsBound( R!.creation_number ) then
            R!.Functor_R_Hom := LeftDualizingFunctor( R, Concatenation( "R", String( R!.creation_number ), "_Hom" ) );
        else
            Error( "the homalg ring doesn't have a creation number\n" );
        fi;
    fi;
    
    return R!.Functor_R_Hom;
    
end );

##
InstallMethod( RightDualizingFunctor,
        "for homalg rings",
        [ IsHomalgRing, IsString ],
        
  function( R, name )
    
    return InsertObjectInMultiFunctor( Functor_Hom_for_fp_modules, 2, R * 1, name );
    
end );

##
InstallMethod( RightDualizingFunctor,
        "for homalg rings",
        [ IsHomalgRing ],
        
  function( R )
    
    if not IsBound( R!.Functor_Hom_R ) then
        if IsBound( R!.creation_number ) then
            R!.Functor_Hom_R := RightDualizingFunctor( R, Concatenation( "Hom_R", String( R!.creation_number ) ) );
        else
            Error( "the homalg ring doesn't have a creation number\n" );
        fi;
    fi;
    
    return R!.Functor_Hom_R;
    
end );

##
## TensorProduct
##

InstallGlobalFunction( _Functor_TensorProduct_OnModules,		### defines: TensorProduct (object part)
  function( M, N )
    local R, rl, l0, _l0, matM, matN, idM, idN, degM, degN, degMN, MN,
          F, gen, proc_to_readjust_generators, proc_to_normalize_generators, p;
    
    R := HomalgRing( M );
    
    ## do not use CheckIfTheyLieInTheSameCategory here
    if not IsIdenticalObj( R, HomalgRing( N ) ) then
        Error( "the rings of the source and target modules are not identical\n" );
    fi;
    
    if IsHomalgRightObjectOrMorphismOfRightObjects( M ) then
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( N ) then
            rl := [ true, true ];
        else
            rl := [ true, false ];
        fi;
    else
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( N ) then
            rl := [ false, true ];
        else
            rl := [ false, false ];
        fi;
    fi;
    
    l0 := NrGenerators( M );
    _l0 := NrGenerators( N );
    
    matM := MatrixOfMap( PresentationMorphism( M ) );
    matN := MatrixOfMap( PresentationMorphism( N ) );
    
    if rl = [ true, true ] or rl = [ false, false ] then
        matM := Involution( matM );	## the first module follows the second
    fi;
    
    idM := HomalgIdentityMatrix( l0, R );
    idN := HomalgIdentityMatrix( _l0, R );
    
    matM := KroneckerMat( matM, idN );
    matN := KroneckerMat( idM, matN );
    
    ## take care of graded modules
    if IsList( DegreesOfGenerators( M ) ) and
       IsList( DegreesOfGenerators( N ) ) then
        degM := DegreesOfGenerators( M );
        degN := DegreesOfGenerators( N );
        if degM = [ ] then
            degMN := degN;
        elif degN = [ ] then
            degMN := degM;
        else
            degMN := Concatenation( List( degM, m -> m + degN ) );
        fi;
    fi;
    
    ## the result has the parity of the second module
    if rl[2] then
        MN := UnionOfRows( matM, matN );
        if IsBound( degMN ) then
            F := HomalgFreeLeftModuleWithDegrees( R, degMN );
        else
            F := HomalgFreeLeftModule( NrGenerators( M ) * NrGenerators( N ), R );
        fi;
    else
        MN := UnionOfColumns( matM, matN );
        if IsBound( degMN ) then
            F := HomalgFreeRightModuleWithDegrees( R, degMN );
        else
            F := HomalgFreeRightModule( NrGenerators( M ) * NrGenerators( N ), R );
        fi;
    fi;
    
    MN := HomalgMap( MN, "free", F );
    
    return Cokernel( MN );
    
end );

##
InstallGlobalFunction( _Functor_TensorProduct_OnMaps,	### defines: TensorProduct (morphism part)
  function( M_or_mor, N_or_mor )
    local R, rl, phi, L, idL;
    
    R := HomalgRing( M_or_mor );
    
    ## do not use CheckIfTheyLieInTheSameCategory here
    if not IsIdenticalObj( R, HomalgRing( N_or_mor ) ) then
        Error( "the module and the morphism are not defined over identically the same ring\n" );
    fi;
    
    if IsHomalgRightObjectOrMorphismOfRightObjects( M_or_mor ) then
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( N_or_mor ) then
            rl := [ true, true ];
        else
            rl := [ true, false ];
        fi;
    else
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( N_or_mor ) then
            rl := [ false, true ];
        else
            rl := [ false, false ];
        fi;
    fi;
    
    if IsMapOfFinitelyGeneratedModulesRep( M_or_mor )
       and IsFinitelyPresentedModuleRep( N_or_mor ) then
        
        phi := M_or_mor;
        L := N_or_mor;
        
        idL := HomalgIdentityMatrix( NrGenerators( L ), R );
        
        if rl = [ true, true ] or rl = [ false, false ] then
            phi := Involution( MatrixOfMap( phi ) );	## the first module follows the second
        else
            phi := MatrixOfMap( phi );
        fi;
        
        return KroneckerMat( phi, idL );
        
    elif IsMapOfFinitelyGeneratedModulesRep( N_or_mor )
      and IsFinitelyPresentedModuleRep( M_or_mor ) then
        
        phi := N_or_mor;
        L := M_or_mor;
        
        idL := HomalgIdentityMatrix( NrGenerators( L ), R );
        
        return KroneckerMat( idL, MatrixOfMap( phi ) );
        
    fi;
    
    Error( "one of the arguments must be a module and the other a morphism\n" );
    
end );

if IsOperation( TensorProduct ) then
    
    ## GAP 4.4 style
    InstallValue( Functor_TensorProduct_for_fp_modules,
            CreateHomalgFunctor(
                    [ "name", "TensorProduct" ],
                    [ "category", HOMALG_MODULES.category ],
                    [ "operation", "TensorProduct" ],
                    [ "number_of_arguments", 2 ],
                    [ "1", [ [ "covariant", "left adjoint", "distinguished" ] ] ],
                    [ "2", [ [ "covariant", "left adjoint" ] ] ],
                    [ "OnObjects", _Functor_TensorProduct_OnModules ],
                    [ "OnMorphisms", _Functor_TensorProduct_OnMaps ],
                    [ "MorphismConstructor", HOMALG_MODULES.category.MorphismConstructor ]
                    )
            );
    
else
    
    ## GAP 4.5 style
    ##  <#GAPDoc Label="Functor_TensorProduct:code">
    ##      <Listing Type="Code"><![CDATA[
    InstallValue( Functor_TensorProduct_for_fp_modules,
            CreateHomalgFunctor(
                    [ "name", "TensorProduct" ],
                    [ "category", HOMALG_MODULES.category ],
                    [ "operation", "TensorProductOp" ],
                    [ "number_of_arguments", 2 ],
                    [ "1", [ [ "covariant", "left adjoint", "distinguished" ] ] ],
                    [ "2", [ [ "covariant", "left adjoint" ] ] ],
                    [ "OnObjects", _Functor_TensorProduct_OnModules ],
                    [ "OnMorphisms", _Functor_TensorProduct_OnMaps ],
                    [ "MorphismConstructor", HOMALG_MODULES.category.MorphismConstructor ]
                    )
            );
    ##  ]]></Listing>
    ##  <#/GAPDoc>
    
fi;

Functor_TensorProduct_for_fp_modules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_TensorProduct_for_fp_modules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

##
## BaseChange
##

##
InstallGlobalFunction( _functor_BaseChange_OnModules,		### defines: BaseChange (object part)
  function( _R, M )
    local R, S, lift, mat, degrees, graded, left, distinguished, N;
    
    R := HomalgRing( _R );
    
    if IsIdenticalObj( HomalgRing( M ), R ) then
        TryNextMethod( );	## i.e. the tensor product with the ring
    fi;
    
    S := HomalgRing( M );
    
    lift := HasRingRelations( S ) and IsIdenticalObj( R, AmbientRing( S ) );
    
    mat := MatrixOfRelations( M );
    degrees := DegreesOfGenerators( M );
    
    graded := IsList( degrees ) and degrees <> [ ];
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( M );
    distinguished := IsBound( M!.distinguished ) and M!.distinguished = true;
    
    distinguished := distinguished and not lift;
    
    if not distinguished then
        if lift then
            if left then
                mat := UnionOfRows( mat );
            else
                mat := UnionOfColumns( mat );
            fi;
        else
            mat := R * mat;
            if HasRingRelations( R ) then
                if left then
                    mat := GetRidOfObsoleteRows( mat );
                else
                    mat := GetRidOfObsoleteColumns( mat );
                fi;
            fi;
        fi;
    fi;
    
    if graded then
        
        WeightsOfIndeterminates( R );	## this eventually sets R!.WeightsCompatibleWithBaseRing
        
        if HasBaseRing( R ) and IsIdenticalObj( BaseRing( R ), HomalgRing( M ) ) and
           IsBound( R!.WeightsCompatibleWithBaseRing ) and R!.WeightsCompatibleWithBaseRing = true then
            if ForAll( degrees, IsInt ) then
                degrees := List( degrees, d -> [ d, 0 ] );
            else
                degrees := List( degrees, d -> Concatenation( d, [ 0 ] ) );
            fi;
        fi;
        
        if left then
            if distinguished then
                if HasIsZero( M ) and IsZero( M ) then
                    N := 0 * R;
                else
                    N := ( 1 * R )^degrees;
                fi;
            else
                N := LeftPresentationWithDegrees( mat, degrees );
            fi;
        else
            if distinguished then
                if HasIsZero( M ) and IsZero( M ) then
                    N := R * 0;
                else
                    N := ( R * 1 )^degrees;
                fi;
            else
                N := RightPresentationWithDegrees( mat, degrees );
            fi;
        fi;
    else
        if left then
            if distinguished then
                if HasIsZero( M ) and IsZero( M ) then
                    N := 0 * R;
                else
                    N := 1 * R;
                fi;
            else
                N := LeftPresentation( mat );
            fi;
        else
            if distinguished then
                if HasIsZero( M ) and IsZero( M ) then
                    N := R * 0;
                else
                    N := R * 1;
                fi;
            else
                N := RightPresentation( mat );
            fi;
        fi;
    fi;
    
    return N;
    
end );

##
InstallOtherMethod( BaseChange,
        "for homalg maps",
        [ IsHomalgRing, IsMapOfFinitelyGeneratedModulesRep ], 1001,
        
  function( R, phi )
    
    return HomalgMap( R * MatrixOfMap( phi ), R * Source( phi ), R * Range( phi ) );
    
end );

##
InstallOtherMethod( BaseChange,
        "for homalg maps",
        [ IsHomalgModule, IsMapOfFinitelyGeneratedModulesRep ], 1001,
        
  function( _R, phi )
    local R;
    
    return BaseChange( HomalgRing( _R ), phi );
    
end );

InstallValue( functor_BaseChange_for_fp_modules,
        CreateHomalgFunctor(
                [ "name", "BaseChange" ],
                [ "category", HOMALG_MODULES.category ],
                [ "operation", "BaseChange" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ] ] ],
                [ "2", [ [ "covariant" ] ] ],
                [ "OnObjects", _functor_BaseChange_OnModules ]
                )
        );

functor_BaseChange_for_fp_modules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

#functor_BaseChange_for_fp_modules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
#  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

####################################
#
# methods for operations & attributes:
#
####################################

##
## Cokernel( phi ) and CokernelEpi( phi )
##

##  <#GAPDoc Label="functor_Cokernel">
##  <ManSection>
##    <Var Name="functor_Cokernel"/>
##    <Description>
##      The functor that associates to a map its cokernel.
##      <#Include Label="functor_Cokernel:code">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="Cokernel">
##  <ManSection>
##    <Oper Arg="phi" Name="Cokernel"/>
##    <Description>
##      The following example also makes use of the natural transformation <C>CokernelEpi</C>.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> M := HomalgMatrix( "[ 2, 3, 4,   5, 6, 7 ]", 2, 3, ZZ );;
##  gap> M := LeftPresentation( M );
##  <A non-torsion left module presented by 2 relations for 3 generators>
##  gap> N := HomalgMatrix( "[ 2, 3, 4, 5,   6, 7, 8, 9 ]", 2, 4, ZZ );;
##  gap> N := LeftPresentation( N );
##  <A non-torsion left module presented by 2 relations for 4 generators>
##  gap> mat := HomalgMatrix( "[ \
##  > 1, 0, -3, -6, \
##  > 0, 1,  6, 11, \
##  > 1, 0, -3, -6  \
##  > ]", 3, 4, ZZ );;
##  gap> phi := HomalgMap( mat, M, N );;
##  gap> IsMorphism( phi );
##  true
##  gap> phi;
##  <A homomorphism of left modules>
##  gap> coker := Cokernel( phi );
##  <A left module presented by 5 relations for 4 generators>
##  gap> ByASmallerPresentation( coker );
##  <A rank 1 left module presented by 1 relation for 2 generators>
##  gap> Display( coker );
##  Z/< 8 > + Z^(1 x 1)
##  gap> nu := CokernelEpi( phi );
##  <An epimorphism of left modules>
##  gap> Display( nu );
##  [ [  -5,   0 ],
##    [  -6,   1 ],
##    [   1,  -2 ],
##    [   0,   1 ] ]
##  
##  the map is currently represented by the above 4 x 2 matrix
##  gap> DefectOfExactness( phi, nu );
##  <A zero left module>
##  gap> ByASmallerPresentation( nu );
##  <An epimorphism of left modules>
##  gap> Display( nu );
##  [ [   2,   0 ],
##    [   1,  -2 ],
##    [   0,   1 ] ]
##  
##  the map is currently represented by the above 3 x 2 matrix
##  gap> PreInverse( nu );
##  false
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallFunctor( functor_Cokernel_for_fp_modules );

##
## ImageObject( phi ) and ImageObjectEmb( phi )
##

##  <#GAPDoc Label="functor_ImageObject">
##  <ManSection>
##    <Var Name="functor_ImageObject"/>
##    <Description>
##      The functor that associates to a map its image.
##      <#Include Label="functor_ImageObject:code">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="ImageObject">
##  <ManSection>
##    <Oper Arg="phi" Name="ImageObject"/>
##    <Description>
##      The following example also makes use of the natural transformations <C>ImageObjectEpi</C>
##      and <C>ImageObjectEmb</C>.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> M := HomalgMatrix( "[ 2, 3, 4,   5, 6, 7 ]", 2, 3, ZZ );;
##  gap> M := LeftPresentation( M );
##  <A non-torsion left module presented by 2 relations for 3 generators>
##  gap> N := HomalgMatrix( "[ 2, 3, 4, 5,   6, 7, 8, 9 ]", 2, 4, ZZ );;
##  gap> N := LeftPresentation( N );
##  <A non-torsion left module presented by 2 relations for 4 generators>
##  gap> mat := HomalgMatrix( "[ \
##  > 1, 0, -3, -6, \
##  > 0, 1,  6, 11, \
##  > 1, 0, -3, -6  \
##  > ]", 3, 4, ZZ );;
##  gap> phi := HomalgMap( mat, M, N );;
##  gap> IsMorphism( phi );
##  true
##  gap> phi;
##  <A homomorphism of left modules>
##  gap> im := ImageObject( phi );
##  <A left module presented by yet unknown relations for 3 generators>
##  gap> ByASmallerPresentation( im );
##  <A free left module of rank 1 on a free generator>
##  gap> pi := ImageObjectEpi( phi );
##  <A split epimorphism of left modules>
##  gap> epsilon := ImageObjectEmb( phi );
##  <A monomorphism of left modules>
##  gap> phi = pi * epsilon;
##  true
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallFunctorOnObjects( functor_ImageObject_for_fp_modules );

##
## Kernel( phi ) and KernelEmb( phi )
##

##  <#GAPDoc Label="Kernel:map">
##  <ManSection>
##    <Oper Arg="phi" Name="Kernel" Label="for maps"/>
##    <Description>
##      The following example also makes use of the natural transformation <C>KernelEmb</C>.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> M := HomalgMatrix( "[ 2, 3, 4,   5, 6, 7 ]", 2, 3, ZZ );;
##  gap> M := LeftPresentation( M );
##  <A non-torsion left module presented by 2 relations for 3 generators>
##  gap> N := HomalgMatrix( "[ 2, 3, 4, 5,   6, 7, 8, 9 ]", 2, 4, ZZ );;
##  gap> N := LeftPresentation( N );
##  <A non-torsion left module presented by 2 relations for 4 generators>
##  gap> mat := HomalgMatrix( "[ \
##  > 1, 0, -3, -6, \
##  > 0, 1,  6, 11, \
##  > 1, 0, -3, -6  \
##  > ]", 3, 4, ZZ );;
##  gap> phi := HomalgMap( mat, M, N );;
##  gap> IsMorphism( phi );
##  true
##  gap> phi;
##  <A homomorphism of left modules>
##  gap> ker := Kernel( phi );
##  <A cyclic left module presented by yet unknown relations for a cyclic generato\
##  r>
##  gap> Display( ker );
##  Z/< -3 >
##  gap> ByASmallerPresentation( last );
##  <A cyclic torsion left module presented by 1 relation for a cyclic generator>
##  gap> Display( ker );
##  Z/< 3 >
##  gap> iota := KernelEmb( phi );
##  <A monomorphism of left modules>
##  gap> Display( iota );
##  [ [  0,  2,  4 ] ]
##  
##  the map is currently represented by the above 1 x 3 matrix
##  gap> DefectOfExactness( iota, phi );
##  <A zero left module>
##  gap> ByASmallerPresentation( iota );
##  <A monomorphism of left modules>
##  gap> Display( iota );
##  [ [  2,  0 ] ]
##  
##  the map is currently represented by the above 1 x 2 matrix
##  gap> PostInverse( iota );
##  false
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##
## DefectOfExactness( cpx_post_pre )
##

##  <#GAPDoc Label="DefectOfExactness">
##  <ManSection>
##    <Oper Arg="phi, psi" Name="DefectOfExactness"/>
##    <Description>
##      We follow the associative convention for applying maps.
##      For left modules <A>phi</A> is applied first and from the right.
##      For right modules <A>psi</A> is applied first and from the left.
##      <P/>
##      The following example also makes use of the natural transformation <C>KernelEmb</C>.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> M := HomalgMatrix( "[ 2, 3, 4, 0,   5, 6, 7, 0 ]", 2, 4, ZZ );;
##  gap> M := LeftPresentation( M );
##  <A non-torsion left module presented by 2 relations for 4 generators>
##  gap> N := HomalgMatrix( "[ 2, 3, 4, 5,   6, 7, 8, 9 ]", 2, 4, ZZ );;
##  gap> N := LeftPresentation( N );
##  <A non-torsion left module presented by 2 relations for 4 generators>
##  gap> mat := HomalgMatrix( "[ \
##  > 1, 3,  3,  3, \
##  > 0, 3, 10, 17, \
##  > 1, 3,  3,  3, \
##  > 0, 0,  0,  0  \
##  > ]", 4, 4, ZZ );;
##  gap> phi := HomalgMap( mat, M, N );;
##  gap> IsMorphism( phi );
##  true
##  gap> phi;
##  <A homomorphism of left modules>
##  gap> iota := KernelEmb( phi );
##  <A monomorphism of left modules>
##  gap> DefectOfExactness( iota, phi );
##  <A zero left module>
##  gap> hom_iota := Hom( iota );	## a shorthand for Hom( iota, ZZ );
##  <A homomorphism of right modules>
##  gap> hom_phi := Hom( phi );	## a shorthand for Hom( phi, ZZ );
##  <A homomorphism of right modules>
##  gap> DefectOfExactness( hom_iota, hom_phi );
##  <A cyclic right module on a cyclic generator satisfying yet unknown relations>
##  gap> ByASmallerPresentation( last );
##  <A cyclic torsion right module on a cyclic generator satisfying 1 relation>
##  gap> Display( last );
##  Z/< 2 >
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##
## Hom( M, N )
##

##  <#GAPDoc Label="Functor_Hom">
##  <ManSection>
##    <Var Name="Functor_Hom"/>
##    <Description>
##      The bifunctor <C>Hom</C>.
##      <#Include Label="Functor_Hom:code">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="Hom">
##  <ManSection>
##    <Oper Arg="o1,o2" Name="Hom"/>
##    <Description>
##      <A>o1</A> resp. <A>o2</A> could be a module, a map, a complex (of modules or of again of complexes),
##      or a chain map.
##      <P/>
##      Each generator of a module of homomorphisms is displayed as a matrix of appropriate dimensions.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> M := HomalgMatrix( "[ 2, 3, 4,   5, 6, 7 ]", 2, 3, ZZ );;
##  gap> M := LeftPresentation( M );
##  <A non-torsion left module presented by 2 relations for 3 generators>
##  gap> N := HomalgMatrix( "[ 2, 3, 4, 5,   6, 7, 8, 9 ]", 2, 4, ZZ );;
##  gap> N := LeftPresentation( N );
##  <A non-torsion left module presented by 2 relations for 4 generators>
##  gap> mat := HomalgMatrix( "[ \
##  > 1, 0, -3, -6, \
##  > 0, 1,  6, 11, \
##  > 1, 0, -3, -6  \
##  > ]", 3, 4, ZZ );;
##  gap> phi := HomalgMap( mat, M, N );;
##  gap> IsMorphism( phi );
##  true
##  gap> phi;
##  <A homomorphism of left modules>
##  gap> psi := Hom( phi, M );
##  <A homomorphism of right modules>
##  gap> ByASmallerPresentation( psi );
##  <A non-zero homomorphism of right modules>
##  gap> Display( psi );
##  [ [   1,   1,   0,   1 ],
##    [   2,   2,   0,   0 ],
##    [   0,   0,   6,  10 ] ]
##  
##  the map is currently represented by the above 3 x 4 matrix
##  gap> homNM := Source( psi );
##  <A non-torsion right module on 4 generators satisfying 2 relations>
##  gap> IsIdenticalObj( homNM, Hom( N, M ) );	## the caching at work
##  true
##  gap> homMM := Range( psi );
##  <A non-torsion right module on 3 generators satisfying 2 relations>
##  gap> IsIdenticalObj( homMM, Hom( M, M ) );	## the caching at work
##  true
##  gap> Display( homNM );
##  Z/< 3 > + Z/< 3 > + Z^(2 x 1)
##  gap> Display( homMM );
##  Z/< 3 > + Z/< 3 > + Z^(1 x 1)
##  gap> IsMonomorphism( psi );
##  false
##  gap> IsEpimorphism( psi );
##  false
##  gap> GeneratorsOfModule( homMM );
##  <A set of 3 generators of a homalg right module>
##  gap> Display( last );
##  [ [  0,  0,  0 ],
##    [  0,  1,  2 ],
##    [  0,  0,  0 ] ]
##  
##  [ [  0,  2,  4 ],
##    [  0,  0,  0 ],
##    [  0,  2,  4 ] ]
##  
##  [ [   0,   1,   3 ],
##    [   0,   0,  -2 ],
##    [   0,   1,   3 ] ]
##  
##  a set of 3 generators given by the the above matrices
##  gap> GeneratorsOfModule( homNM );
##  <A set of 4 generators of a homalg right module>
##  gap> Display( last );
##  [ [  0,  1,  2 ],
##    [  0,  1,  2 ],
##    [  0,  1,  2 ],
##    [  0,  0,  0 ] ]
##  
##  [ [  0,  1,  2 ],
##    [  0,  0,  0 ],
##    [  0,  0,  0 ],
##    [  0,  2,  4 ] ]
##  
##  [ [   0,   0,  -3 ],
##    [   0,   0,   7 ],
##    [   0,   0,  -5 ],
##    [   0,   0,   1 ] ]
##  
##  [ [   0,   1,  -3 ],
##    [   0,   0,  12 ],
##    [   0,   0,  -9 ],
##    [   0,   2,   6 ] ]
##  
##  a set of 4 generators given by the the above matrices
##  ]]></Example>
##      If for example the source <M>N</M> gets a new presentation, you will see the effect on the generators:
##      <Example><![CDATA[
##  gap> ByASmallerPresentation( N );
##  <A rank 2 left module presented by 1 relation for 3 generators>
##  gap> GeneratorsOfModule( homNM );
##  <A set of 4 generators of a homalg right module>
##  gap> Display( last );
##  [ [  0,  3,  6 ],
##    [  0,  1,  2 ],
##    [  0,  0,  0 ] ]
##  
##  [ [   0,   9,  18 ],
##    [   0,   0,   0 ],
##    [   0,   2,   4 ] ]
##  
##  [ [   0,   0,   0 ],
##    [   0,   0,  -5 ],
##    [   0,   0,   1 ] ]
##  
##  [ [   0,   9,  18 ],
##    [   0,   0,  -9 ],
##    [   0,   2,   6 ] ]
##  
##  a set of 4 generators given by the the above matrices
##  ]]></Example>
##      Now we compute a certain natural filtration on <C>Hom</C><M>(M,M)</M>:
##      <Example><![CDATA[
##  gap> dM := Resolution( M );
##  <A non-zero right acyclic complex containing a single morphism of left modules\
##   at degrees [ 0 .. 1 ]>
##  gap> hMM := Hom( dM, dM );
##  <A non-zero acyclic cocomplex containing a single morphism of right complexes \
##  at degrees [ 0 .. 1 ]>
##  gap> BMM := HomalgBicomplex( hMM );
##  <A non-zero bicocomplex containing right modules at bidegrees [ 0 .. 1 ]x
##  [ -1 .. 0 ]>
##  gap> II_E := SecondSpectralSequenceWithFiltration( BMM );
##  <A stable cohomological spectral sequence with sheets at levels 
##  [ 0 .. 2 ] each consisting of right modules at bidegrees [ -1 .. 0 ]x
##  [ 0 .. 1 ]>
##  gap> Display( II_E );
##  The associated transposed spectral sequence:
##  
##  a cohomological spectral sequence at bidegrees
##  [ [ 0 .. 1 ], [ -1 .. 0 ] ]
##  ---------
##  Level 0:
##  
##   * *
##   * *
##  ---------
##  Level 1:
##  
##   * *
##   . .
##  ---------
##  Level 2:
##  
##   s s
##   . .
##  
##  Now the spectral sequence of the bicomplex:
##  
##  a cohomological spectral sequence at bidegrees
##  [ [ -1 .. 0 ], [ 0 .. 1 ] ]
##  ---------
##  Level 0:
##  
##   * *
##   * *
##  ---------
##  Level 1:
##  
##   * *
##   * *
##  ---------
##  Level 2:
##  
##   s s
##   . s
##  gap> filt := FiltrationBySpectralSequence( II_E );
##  <A descending filtration with degrees [ -1 .. 0 ] and graded parts:
##    
##  -1:	<A non-zero cyclic right module on a cyclic generator satisfying yet unkno\
##  wn relations>
##     0:	<A rank 1 right module on 3 generators satisfying 2 relations>
##  of
##  <A right module on 4 generators satisfying yet unknown relations>>
##  gap> ByASmallerPresentation( filt );
##  <A descending filtration with degrees [ -1 .. 0 ] and graded parts:
##    
##  -1:	<A non-zero cyclic torsion right module on a cyclic generator satisfying 1\
##   relation>
##     0:	<A rank 1 right module on 2 generators satisfying 1 relation>
##  of
##  <A non-torsion right module on 3 generators satisfying 2 relations>>
##  gap> Display( filt );
##  Degree -1:
##  
##  Z/< 3 >
##  ----------
##  Degree 0:
##  
##  Z/< 3 > + Z^(1 x 1)
##  gap> Display( homMM );
##  Z/< 3 > + Z/< 3 > + Z^(1 x 1)
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallFunctor( Functor_Hom_for_fp_modules );

##
## TensorProduct( M, N )	( M * N )
##

##  <#GAPDoc Label="Functor_TensorProduct">
##  <ManSection>
##    <Var Name="Functor_TensorProduct"/>
##    <Description>
##      The tensor product bifunctor.
##      <#Include Label="Functor_TensorProduct:code">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="TensorProduct">
##  <ManSection>
##    <Oper Arg="o1,o2" Name="TensorProduct"/>
##    <Oper Arg="o1,o2" Name="\*" Label="TensorProduct"/>
##    <Description>
##      <A>o1</A> resp. <A>o2</A> could be a module, a map, a complex (of modules or of again of complexes),
##      or a chain map.
##      <P/>
##      The symbol <C>*</C> is a shorthand for several operations associated with the functor <C>Functor_TensorProduct_for_fp_modules</C>
##      installed under the name <C>TensorProduct</C>.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> M := HomalgMatrix( "[ 2, 3, 4,   5, 6, 7 ]", 2, 3, ZZ );;
##  gap> M := LeftPresentation( M );
##  <A non-torsion left module presented by 2 relations for 3 generators>
##  gap> N := HomalgMatrix( "[ 2, 3, 4, 5,   6, 7, 8, 9 ]", 2, 4, ZZ );;
##  gap> N := LeftPresentation( N );
##  <A non-torsion left module presented by 2 relations for 4 generators>
##  gap> mat := HomalgMatrix( "[ \
##  > 1, 0, -3, -6, \
##  > 0, 1,  6, 11, \
##  > 1, 0, -3, -6  \
##  > ]", 3, 4, ZZ );;
##  gap> phi := HomalgMap( mat, M, N );;
##  gap> IsMorphism( phi );
##  true
##  gap> phi;
##  <A homomorphism of left modules>
##  gap> L := Hom( ZZ, M );
##  <A rank 1 right module on 3 generators satisfying yet unknown relations>
##  gap> ByASmallerPresentation( L );
##  <A rank 1 right module on 2 generators satisfying 1 relation>
##  gap> Display( L );
##  Z/< 3 > + Z^(1 x 1)
##  gap> L;	## the display method found out further information about the module L
##  <A rank 1 right module on 2 generators satisfying 1 relation>
##  gap> psi := phi * L;
##  <A homomorphism of right modules>
##  gap> ByASmallerPresentation( psi );
##  <A non-zero homomorphism of right modules>
##  gap> Display( psi );
##  [ [   0,   0,   1,   1 ],
##    [   0,   0,   8,   1 ],
##    [   0,   0,   0,  -2 ],
##    [   0,   0,   0,   2 ] ]
##  
##  the map is currently represented by the above 4 x 4 matrix
##  
##  gap> ML := Source( psi );
##  <A non-torsion right module on 4 generators satisfying 3 relations>
##  gap> IsIdenticalObj( ML, M * L );	## the caching at work
##  true
##  gap> NL := Range( psi );
##  <A non-torsion right module on 4 generators satisfying 2 relations>
##  gap> IsIdenticalObj( NL, N * L );	## the caching at work
##  true
##  gap> Display( ML );
##  Z/< 3 > + Z/< 3 > + Z/< 3 > + Z^(1 x 1)
##  gap> Display( NL );
##  Z/< 3 > + Z/< 12 > + Z^(2 x 1)
##  ]]></Example>
##      Now we compute a certain natural filtration on the tensor product <M>M</M><C>*</C><M>L</M>:
##      <Example><![CDATA[
##  gap> P := Resolution( M );
##  <A non-zero right acyclic complex containing a single morphism of left modules\
##   at degrees [ 0 .. 1 ]>
##  gap> GP := Hom( P );
##  <A non-zero acyclic cocomplex containing a single morphism of right modules at\
##   degrees [ 0 .. 1 ]>
##  gap> CE := Resolution( GP );
##  <An acyclic cocomplex containing a single morphism of right complexes at degre\
##  es [ 0 .. 1 ]>
##  gap> FCE := Hom( CE, L );
##  <A non-zero acyclic complex containing a single morphism of left cocomplexes a\
##  t degrees [ 0 .. 1 ]>
##  gap> BC := HomalgBicomplex( FCE );
##  <A non-zero bicomplex containing left modules at bidegrees [ 0 .. 1 ]x
##  [ -1 .. 0 ]>
##  gap> II_E := SecondSpectralSequenceWithFiltration( BC );
##  <A stable homological spectral sequence with sheets at levels 
##  [ 0 .. 2 ] each consisting of left modules at bidegrees [ -1 .. 0 ]x
##  [ 0 .. 1 ]>
##  gap> Display( II_E );
##  The associated transposed spectral sequence:
##  
##  a homological spectral sequence at bidegrees
##  [ [ 0 .. 1 ], [ -1 .. 0 ] ]
##  ---------
##  Level 0:
##  
##   * *
##   * *
##  ---------
##  Level 1:
##  
##   * *
##   . .
##  ---------
##  Level 2:
##  
##   s s
##   . .
##  
##  Now the spectral sequence of the bicomplex:
##  
##  a homological spectral sequence at bidegrees
##  [ [ -1 .. 0 ], [ 0 .. 1 ] ]
##  ---------
##  Level 0:
##  
##   * *
##   * *
##  ---------
##  Level 1:
##  
##   * *
##   . s
##  ---------
##  Level 2:
##  
##   s s
##   . s
##  gap> filt := FiltrationBySpectralSequence( II_E );
##  <An ascending filtration with degrees [ -1 .. 0 ] and graded parts:
##     0:	<A non-torsion left module presented by 1 relation for 2 generators>
##    -1:	<A non-zero left module presented by 2 relations for 2 generators>
##  of
##  <A non-zero left module presented by 10 relations for 6 generators>>
##  gap> ByASmallerPresentation( filt );
##  <An ascending filtration with degrees [ -1 .. 0 ] and graded parts:
##     0:	<A rank 1 left module presented by 1 relation for 2 generators>
##    -1:	<A non-zero left module presented by 2 relations for 2 generators>
##  of
##  <A non-torsion left module presented by 3 relations for 4 generators>>
##  gap> Display( filt );
##  Degree 0:
##  
##  Z/< 3 > + Z^(1 x 1)
##  ----------
##  Degree -1:
##  
##  Z/< 3 > + Z/< 3 >
##  gap> Display( ML );
##  Z/< 3 > + Z/< 3 > + Z/< 3 > + Z^(1 x 1)
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallFunctor( Functor_TensorProduct_for_fp_modules );

## for convenience
InstallOtherMethod( \*,
        "for homalg modules",
        [ IsStructureObjectOrObjectOrMorphism, IsFinitelyPresentedModuleRep ],
        
  function( M, N )
    
    return TensorProduct( M, N );
    
end );

## for convenience
InstallOtherMethod( \*,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep, IsStructureObjectOrObjectOrMorphism ],
        
  function( M, N )
    
    return TensorProduct( M, N );
    
end );

## for convenience
InstallOtherMethod( \*,
        "for homalg modules",
        [ IsHomalgComplex, IsHomalgComplex ],
        
  function( M, N )
    
    return TensorProduct( M, N );
    
end );

##  <#GAPDoc Label="\*:ModuleBaseChange">
##  <ManSection>
##    <Oper Arg="R, M" Name="\*" Label="transfer a module over a different ring"/>
##    <Oper Arg="M, R" Name="\*" Label="transfer a module over a different ring (right)"/>
##    <Returns>a &homalg; module</Returns>
##    <Description>
##      Transfers the <M>S</M>-module <A>M</A> over the &homalg; ring <A>R</A>. This works only in three cases:
##      <Enum>
##        <Item><M>S</M> is a subring of <A>R</A>.</Item>
##        <Item><A>R</A> is a residue class ring of <M>S</M> constructed using <C>/</C>.</Item>
##        <Item><A>R</A> is a subring of <M>S</M> and the entries of the current matrix of <M>S</M>-relations of <A>M</A>
##          lie in <A>R</A>.</Item>
##      </Enum>
##      CAUTION: So it is not suited for general base change.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );
##  <An internal ring>
##  gap> Z4 := ZZ / 4;
##  <A residue class ring>
##  gap> Display( Z4 );
##  Z/( 4 )
##  gap> M := HomalgDiagonalMatrix( [ 2 .. 4 ], ZZ );
##  <An unevaluated diagonal 3 x 3 matrix over an internal ring>
##  gap> M := LeftPresentation( M );
##  <A left module presented by 3 relations for 3 generators>
##  gap> Display( M );
##  Z/< 2 > + Z/< 3 > + Z/< 4 >
##  gap> M;
##  <A torsion left module presented by 3 relations for 3 generators>
##  gap> N := Z4 * M; ## or N := M * Z4;
##  <A non-torsion left module presented by 2 relations for 3 generators>
##  gap> ByASmallerPresentation( N );
##  <A non-torsion left module presented by 1 relation for 2 generators>
##  gap> Display( N );
##  Z/( 4 )/< |[ 2 ]| > + Z/( 4 )^(1 x 1)
##  gap> N;
##  <A non-torsion left module presented by 1 relation for 2 generators>
##  ]]></Example>
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> M := HomalgMatrix( "[ \
##  > 2, 3, 4, \
##  > 5, 6, 7  \
##  > ]", 2, 3, ZZ );
##  <A 2 x 3 matrix over an internal ring>
##  gap> M := LeftPresentation( M );
##  <A non-torsion left module presented by 2 relations for 3 generators>
##  gap> Z4 := ZZ / 4;;
##  gap> Display( Z4 );
##  Z/( 4 )
##  gap> M4 := Z4 * M;
##  <A non-torsion left module presented by 2 relations for 3 generators>
##  gap> Display( M4 );
##  [ [  2,  3,  4 ],
##    [  5,  6,  7 ] ]
##  
##  modulo [ 4 ]
##  
##  Cokernel of the map
##  
##  Z/( 4 )^(1x2) --> Z/( 4 )^(1x3),
##  
##  currently represented by the above matrix
##  gap> d := Resolution( 2, M4 );
##  <A right acyclic complex containing 2 morphisms of left modules at degrees 
##  [ 0 .. 2 ]>
##  gap> Hom( d, Z4 );
##  <A cocomplex containing 2 morphisms of right modules at degrees [ 0 .. 2 ]>
##  gap> dd := Hom( d, Z4 );
##  <A cocomplex containing 2 morphisms of right modules at degrees [ 0 .. 2 ]>
##  gap> DD := Resolution( 2, dd );
##  <A cocomplex containing 2 morphisms of right complexes at degrees [ 0 .. 2 ]>
##  gap> D := Hom( DD, Z4 );
##  <A complex containing 2 morphisms of left cocomplexes at degrees [ 0 .. 2 ]>
##  gap> C := ZZ * D;
##  <A "complex" containing 2 morphisms of left cocomplexes at degrees [ 0 .. 2 ]>
##  gap> LowestDegreeObject( C );
##  <A "cocomplex" containing 2 morphisms of left modules at degrees [ 0 .. 2 ]>
##  gap> Display( last );
##  -------------------------
##  at cohomology degree: 2
##  0
##  ------------^------------
##  (an empty 1 x 0 matrix)
##  
##  the map is currently represented by the above 1 x 0 matrix
##  -------------------------
##  at cohomology degree: 1
##  Z/< 4 > 
##  ------------^------------
##  [ [  3 ],
##    [  1 ],
##    [  2 ],
##    [  1 ] ]
##  
##  the map is currently represented by the above 4 x 1 matrix
##  -------------------------
##  at cohomology degree: 0
##  Z/< 4 > + Z/< 4 > + Z/< 4 > + Z/< 4 > 
##  -------------------------
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallFunctor( functor_BaseChange_for_fp_modules );

##
## Ext( c, M, N )
##

##  <#GAPDoc Label="Functor_Ext">
##  <ManSection>
##    <Var Name="Functor_Ext"/>
##    <Description>
##      The bifunctor <C>Ext</C>.
##      <P/>
##      <#Include Label="Functor_Ext:code">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="Functor_Ext:code">
##    Below is the only <E>specific</E> line of code used to define <C>Functor_Ext_for_fp_modules</C>
##    and all the different operations <C>Ext</C> in &homalg;.
##      <Listing Type="Code"><![CDATA[
RightSatelliteOfCofunctor( Functor_Hom_for_fp_modules, "Ext" );
##  ]]></Listing>
##  <#/GAPDoc>

##  <#GAPDoc Label="RightSatelliteOfCofunctor:example">
##    <#Include Label="Functor_Ext:code">
##  <#/GAPDoc>

##  <#GAPDoc Label="Ext">
##  <ManSection>
##    <Oper Arg="[c,]o1,o2[,str]" Name="Ext"/>
##    <Description>
##      Compute the <A>c</A>-th extension object of <A>o1</A> with <A>o2</A> where <A>c</A> is a nonnegative integer
##      and <A>o1</A> resp. <A>o2</A> could be a module, a map, a complex (of modules or of again of complexes),
##      or a chain map. If <A>str</A>=<Q>a</Q> then the (cohomologically) graded object
##      <M>Ext^i(</M><A>o1</A>,<A>o2</A><M>)</M> for <M>0 \leq i \leq</M><A>c</A> is computed.
##      If neither <A>c</A> nor <A>str</A> is specified then the cohomologically graded object
##      <M>Ext^i(</M><A>o1</A>,<A>o2</A><M>)</M> for <M>0 \leq i \leq d</M> is computed,
##      where <M>d</M> is the length of the internally computed free resolution of <A>o1</A>.
##      <P/>
##      Each generator of a module of extensions is displayed as a matrix of appropriate dimensions.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> M := HomalgMatrix( "[ 2, 3, 4,   5, 6, 7 ]", 2, 3, ZZ );;
##  gap> M := LeftPresentation( M );
##  <A non-torsion left module presented by 2 relations for 3 generators>
##  gap> N := TorsionObject( M );
##  <A cyclic torsion left module presented by yet unknown relations for a cyclic \
##  generator>
##  gap> iota := TorsionObjectEmb( M );
##  <A monomorphism of left modules>
##  gap> psi := Ext( 1, iota, N );
##  <A homomorphism of right modules>
##  gap> ByASmallerPresentation( psi );
##  <A non-zero homomorphism of right modules>
##  gap> Display( psi );
##  [ [  2 ] ]
##  
##  the map is currently represented by the above 1 x 1 matrix
##  gap> extNN := Range( psi );
##  <A cyclic torsion right module on a cyclic generator satisfying 1 relation>
##  gap> IsIdenticalObj( extNN, Ext( 1, N, N ) );	## the caching at work
##  true
##  gap> extMN := Source( psi );
##  <A cyclic torsion right module on a cyclic generator satisfying 1 relation>
##  gap> IsIdenticalObj( extMN, Ext( 1, M, N ) );	## the caching at work
##  true
##  gap> Display( extNN );
##  Z/< 3 >
##  gap> Display( extMN );
##  Z/< 3 >
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##

##
## Tor( c, M, N )
##

##  <#GAPDoc Label="Functor_Tor">
##  <ManSection>
##    <Var Name="Functor_Tor"/>
##    <Description>
##      The bifunctor <C>Tor</C>.
##      <P/>
##      <#Include Label="Functor_Tor:code">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="Functor_Tor:code">
##    Below is the only <E>specific</E> line of code used to define <C>Functor_Tor_for_fp_modules</C>
##    and all the different operations <C>Tor</C> in &homalg;.
##      <Listing Type="Code"><![CDATA[
LeftSatelliteOfFunctor( Functor_TensorProduct_for_fp_modules, "Tor" );
##  ]]></Listing>
##  <#/GAPDoc>

##  <#GAPDoc Label="LeftSatelliteOfFunctor:example">
##    <#Include Label="Functor_Tor:code">
##  <#/GAPDoc>

##  <#GAPDoc Label="Tor">
##  <ManSection>
##    <Oper Arg="[c,]o1,o2[,str]" Name="Tor"/>
##    <Description>
##      Compute the <A>c</A>-th torsion object of <A>o1</A> with <A>o2</A> where <A>c</A> is a nonnegative integer
##      and <A>o1</A> resp. <A>o2</A> could be a module, a map, a complex (of modules or of again of complexes),
##      or a chain map. If <A>str</A>=<Q>a</Q> then the (cohomologically) graded object
##      <M>Tor_i(</M><A>o1</A>,<A>o2</A><M>)</M> for <M>0 \leq i \leq</M><A>c</A> is computed.
##      If neither <A>c</A> nor <A>str</A> is specified then the cohomologically graded object
##      <M>Tor_i(</M><A>o1</A>,<A>o2</A><M>)</M> for <M>0 \leq i \leq d</M> is computed,
##      where <M>d</M> is the length of the internally computed free resolution of <A>o1</A>.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> M := HomalgMatrix( "[ 2, 3, 4,   5, 6, 7 ]", 2, 3, ZZ );;
##  gap> M := LeftPresentation( M );
##  <A non-torsion left module presented by 2 relations for 3 generators>
##  gap> N := TorsionObject( M );
##  <A cyclic torsion left module presented by yet unknown relations for a cyclic \
##  generator>
##  gap> iota := TorsionObjectEmb( M );
##  <A monomorphism of left modules>
##  gap> psi := Tor( 1, iota, N );
##  <A homomorphism of left modules>
##  gap> ByASmallerPresentation( psi );
##  <A non-zero homomorphism of left modules>
##  gap> Display( psi );
##  [ [  1 ] ]
##  
##  the map is currently represented by the above 1 x 1 matrix
##  gap> torNN := Source( psi );
##  <A cyclic torsion left module presented by 1 relation for a cyclic generator>
##  gap> IsIdenticalObj( torNN, Tor( 1, N, N ) );	## the caching at work
##  true
##  gap> torMN := Range( psi );
##  <A cyclic torsion left module presented by 1 relation for a cyclic generator>
##  gap> IsIdenticalObj( torMN, Tor( 1, M, N ) );	## the caching at work
##  true
##  gap> Display( torNN );
##  Z/< 3 >
##  gap> Display( torMN );
##  Z/< 3 >
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##

##
## RHom( c, M, N )
##

##  <#GAPDoc Label="Functor_RHom">
##  <ManSection>
##    <Var Name="Functor_RHom"/>
##    <Description>
##      The bifunctor <C>RHom</C>.
##      <P/>
##      <#Include Label="Functor_RHom:code">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="Functor_RHom:code">
##    Below is the only <E>specific</E> line of code used to define <C>Functor_RHom_for_fp_modules</C>
##    and all the different operations <C>RHom</C> in &homalg;.
##      <Listing Type="Code"><![CDATA[
RightDerivedCofunctor( Functor_Hom_for_fp_modules );
##  ]]></Listing>
##  <#/GAPDoc>

##  <#GAPDoc Label="RightDerivedCofunctor:example">
##    <#Include Label="Functor_RHom:code">
##  <#/GAPDoc>

##  <#GAPDoc Label="RHom">
##  <ManSection>
##    <Oper Arg="[c,]o1,o2[,str]" Name="RHom"/>
##    <Description>
##      Compute the <A>c</A>-th extension object of <A>o1</A> with <A>o2</A> where <A>c</A> is a nonnegative integer
##      and <A>o1</A> resp. <A>o2</A> could be a module, a map, a complex (of modules or of again of complexes),
##      or a chain map. The string <A>str</A> may take different values:
##      <List>
##        <Item>If <A>str</A>=<Q>a</Q> then <M>R^i Hom(</M><A>o1</A>,<A>o2</A><M>)</M> for <M>0 \leq i \leq</M><A>c</A>
##          is computed.</Item>
##        <Item>If <A>str</A>=<Q>c</Q> then the <A>c</A>-th connecting homomorphism with respect to
##          the short exact sequence <A>o1</A> is computed.</Item>
##        <Item>If <A>str</A>=<Q>t</Q> then the exact triangle upto cohomological degree <A>c</A> with respect to
##          the short exact sequence <A>o1</A> is computed.</Item>
##      </List>
##      If neither <A>c</A> nor <A>str</A> is specified then the cohomologically graded object
##      <M>R^i Hom(</M><A>o1</A>,<A>o2</A><M>)</M> for <M>0 \leq i \leq d</M> is computed,
##      where <M>d</M> is the length of the internally computed free resolution of <A>o1</A>.
##      <P/>
##      Each generator of a module of derived homomorphisms is displayed as a matrix of appropriate dimensions.
##      <#Include Label="RHom_Z">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##

##
## LTensorProduct( c, M, N )
##

##  <#GAPDoc Label="Functor_LTensorProduct">
##  <ManSection>
##    <Var Name="Functor_LTensorProduct"/>
##    <Description>
##      The bifunctor <C>LTensorProduct</C>.
##      <P/>
##      <#Include Label="Functor_LTensorProduct:code">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="Functor_LTensorProduct:code">
##    Below is the only <E>specific</E> line of code used to define <C>Functor_LTensorProduct_for_fp_modules</C>
##    and all the different operations <C>LTensorProduct</C> in &homalg;.
##      <Listing Type="Code"><![CDATA[
LeftDerivedFunctor( Functor_TensorProduct_for_fp_modules );
##  ]]></Listing>
##  <#/GAPDoc>

##  <#GAPDoc Label="LeftDerivedFunctor:example">
##    <#Include Label="Functor_LTensorProduct:code">
##  <#/GAPDoc>

##  <#GAPDoc Label="LTensorProduct">
##  <ManSection>
##    <Oper Arg="[c,]o1,o2[,str]" Name="LTensorProduct"/>
##    <Description>
##      Compute the <A>c</A>-th torsion object of <A>o1</A> with <A>o2</A> where <A>c</A> is a nonnegative integer
##      and <A>o1</A> resp. <A>o2</A> could be a module, a map, a complex (of modules or of again of complexes),
##      or a chain map. The string <A>str</A> may take different values:
##      <List>
##        <Item>If <A>str</A>=<Q>a</Q> then <M>L_i TensorProduct(</M><A>o1</A>,<A>o2</A><M>)</M> for <M>0 \leq i \leq</M><A>c</A>
##          is computed.</Item>
##        <Item>If <A>str</A>=<Q>c</Q> then the <A>c</A>-th connecting homomorphism with respect to
##          the short exact sequence <A>o1</A> is computed.</Item>
##        <Item>If <A>str</A>=<Q>t</Q> then the exact triangle upto cohomological degree <A>c</A> with respect to
##          the short exact sequence <A>o1</A> is computed.</Item>
##      </List>
##      If neither <A>c</A> nor <A>str</A> is specified then the cohomologically graded object
##      <M>L_i TensorProduct(</M><A>o1</A>,<A>o2</A><M>)</M> for <M>0 \leq i \leq d</M> is computed,
##      where <M>d</M> is the length of the internally computed free resolution of <A>o1</A>.
##      <P/>
##      Each generator of a module of derived homomorphisms is displayed as a matrix of appropriate dimensions.
##      <#Include Label="LTensorProduct_Z">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##

##
## HomHom( M, K, N ) = Hom( Hom( M, K ), N )
##

##  <#GAPDoc Label="Functor_HomHom">
##  <ManSection>
##    <Var Name="Functor_HomHom"/>
##    <Description>
##      The bifunctor <C>HomHom</C>.
##      <P/>
##      <#Include Label="Functor_HomHom:code">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="Functor_HomHom:code">
##    Below is the only <E>specific</E> line of code used to define <C>Functor_HomHom_for_fp_modules</C>
##    and all the different operations <C>HomHom</C> in &homalg;.
##      <Listing Type="Code"><![CDATA[
Functor_Hom_for_fp_modules * Functor_Hom_for_fp_modules;
##  ]]></Listing>
##  <#/GAPDoc>

##  <#GAPDoc Label="ComposeFunctors:example">
##    <#Include Label="Functor_HomHom:code">
##  <#/GAPDoc>

##
## LHomHom( M, K, N ) = L(Hom( Hom( -, K ), N ))( M )
##

##  <#GAPDoc Label="Functor_LHomHom">
##  <ManSection>
##    <Var Name="Functor_LHomHom"/>
##    <Description>
##      The bifunctor <C>LHomHom</C>.
##      <P/>
##      <#Include Label="Functor_LHomHom:code">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="Functor_LHomHom:code">
##    Below is the only <E>specific</E> line of code used to define <C>Functor_LHomHom_for_fp_modules</C>
##    and all the different operations <C>LHomHom</C> in &homalg;.
##      <Listing Type="Code"><![CDATA[
LeftDerivedFunctor( Functor_HomHom_for_fp_modules );
##  ]]></Listing>
##  <#/GAPDoc>

##  <#GAPDoc Label="LeftDerivedFunctor:example2">
##    <#Include Label="Functor_LHomHom:code">
##  <#/GAPDoc>

