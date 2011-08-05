#############################################################################
##
##  BasicFunctors.gi            Graded Modules package
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Implementation stuff for some graded tool functors.
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
InstallGlobalFunction( _Functor_Cokernel_OnGradedModules,	### defines: Cokernel(Epi)
  function( phi )
    local S, R, p, p2, U_phi, coker_U_phi, epi, coker, gen_iso, img_emb, emb;
    
    if HasCokernelEpi( phi ) then
      return Range( CokernelEpi( phi ) );
    fi;
    
    S := HomalgRing( phi );
    R := UnderlyingNonGradedRing( S );

    U_phi := UnderlyingMorphism( phi ) ;
    p2 := PositionOfTheDefaultPresentation( Range( U_phi ) );
    SetPositionOfTheDefaultPresentation( Range( U_phi ), 1 );
    
    coker_U_phi := Cokernel( U_phi );
    
    # The cokernel get the same degrees as the range of phi,
    # since the epimorphism on the cokernel is induced by the indentity matrix.
    # By choice of the first presentation we ensure, that we can use this trick.
    p := PositionOfTheDefaultPresentation( coker_U_phi );
    SetPositionOfTheDefaultPresentation( coker_U_phi, 1 );
    
    epi := CokernelEpi( U_phi );
    epi := GradedMap( epi, Range( phi ), DegreesOfGenerators( Range( phi ) ), HomalgRing( phi ) );
    
    if HasIsMorphism( phi ) and IsMorphism( phi ) then
        Assert( 2, IsMorphism( epi ) );
        SetIsMorphism( epi, true );
    fi;
    
    SetPositionOfTheDefaultPresentation( coker_U_phi, p );
    SetPositionOfTheDefaultPresentation( Range( U_phi ), p2 );
    
    ## set the attribute CokernelEpi (specific for Cokernel):
    SetCokernelEpi( phi, epi );

    coker := Range( epi );
    
    ## the generalized inverse of the natural epimorphism
    ## (cf. [Bar, Cor. 4.8])
    gen_iso := GradedMap( GeneralizedInverse( UnderlyingMorphism( epi ) ), coker, Range( phi ), S );
    
    ## set the morphism aid map
    SetMorphismAid( gen_iso, phi );
    
    ## set the generalized inverse of the natural epimorphism
    SetGeneralizedInverse( epi, gen_iso );
    
    ## we cannot check this assertion, since
    ## checking it would cause an infinite loop
    SetIsGeneralizedIsomorphism( gen_iso, true );
    
    if HasIsMonomorphism( phi ) and IsMonomorphism( phi ) and
       HasIsModuleOfGlobalSections( Source( phi ) ) and IsModuleOfGlobalSections( Source( phi ) ) and
       HasIsModuleOfGlobalSections( Range( phi ) ) and IsModuleOfGlobalSections( Range( phi ) ) then
        SetTrivialArtinianSubmodule( coker, true );
    fi;
    
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
    emb := GradedMap( NaturalGeneralizedEmbedding( UnderlyingModule( coker ) ), coker, Range( phi ) );
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
InstallValue( functor_Cokernel_ForGradedModules,
        CreateHomalgFunctor(
                [ "name", "Cokernel" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "Cokernel" ],
                [ "natural_transformation", "CokernelEpi" ],
                [ "special", true ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant" ],
                        [ IsMapOfGradedModulesRep,
                          [ IsHomalgChainMorphism, IsImageSquare ] ] ] ],
                [ "OnObjects", _Functor_Cokernel_OnGradedModules ]
                )
        );
##  ]]></Listing>
##  <#/GAPDoc>

functor_Cokernel_ForGradedModules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

##
## ImageObject
##

InstallGlobalFunction( _Functor_ImageObject_OnGradedModules,	### defines: ImageObject(Emb)
  function( phi )
    local S, emb, img, coker_epi, img_submodule;
    
    S := HomalgRing( phi );
    
    if HasImageObjectEmb( phi ) then
        return Source( ImageObjectEmb( phi ) );
    fi;
    
    emb := GradedMap( ImageObjectEmb( UnderlyingMorphism( phi ) ), "create", Range( phi ), HomalgRing( phi ) );
    
    if HasIsMorphism( phi ) and IsMorphism( phi ) then
        Assert( 2, IsMorphism( emb ) );
        SetIsMorphism( emb, true );
    fi;
    
    ## set the attribute ImageObjectEmb (specific for ImageObject):
    ## (since ImageObjectEmb is listed below as a natural transformation
    ##  for the functor ImageObject, a method will be automatically installed
    ##  by InstallFunctor to fetch it by first invoking the main operation ImageObject)
    SetImageObjectEmb( phi, emb );
    
    if HasIsEpimorphism( phi ) and IsEpimorphism( phi ) then
        SetIsIsomorphism( emb, true );
        UpdateObjectsByMorphism( emb );
    else
        SetIsMonomorphism( emb, true );
    fi;

    ## get the image module from its embedding
    img := Source( emb );
    
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
    
    MatchPropertiesAndAttributesOfSubobjectAndUnderlyingObject( img_submodule, img );
    
    ## save the natural embedding in the image (thanks GAP):
    img!.NaturalGeneralizedEmbedding := emb;
    
    return img;
    
end );

##  <#GAPDoc Label="functor_ImageObject:code">
##      <Listing Type="Code"><![CDATA[
InstallValue( functor_ImageObject_ForGradedModules,
        CreateHomalgFunctor(
                [ "name", "ImageObject" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "ImageObject" ],
                [ "natural_transformation", "ImageObjectEmb" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant" ],
                        [ IsMapOfGradedModulesRep ] ] ],
                [ "OnObjects", _Functor_ImageObject_OnGradedModules ]
                )
        );
##  ]]></Listing>
##  <#/GAPDoc>

functor_ImageObject_ForGradedModules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

##
## Kernel
##

# not needed, homalg calls KernelSubobject, which is implemented in LIGrHOM

##
## GradedHom
##

InstallGlobalFunction( _Functor_GradedHom_OnGradedModules,		### defines: GradedHom (object part)
  function( M, N )
    local S, hom, emb, degHP0N, p, HP0N;
    
    S := HomalgRing( M );
    
    CheckIfTheyLieInTheSameCategory( M, N );
    
    hom := Hom( UnderlyingModule( M ), UnderlyingModule( N ) );
    hom := UnderlyingSubobject( hom );
    emb := EmbeddingInSuperObject( hom );
    ## This highly depends on the internal structure of _Functor_Hom_OnModules and is not intrinsic
    ## HP0N is the source of alpha (the map of which hom is the kernel)
    degHP0N := Concatenation( List( DegreesOfGenerators( M ), m -> -m + DegreesOfGenerators( N ) ) );
    
    p := PositionOfTheDefaultPresentation( Range( emb ) );
    SetPositionOfTheDefaultPresentation( Range( emb ), 1 );
    
    HP0N := GradedModule( Range( emb ), degHP0N, S );
    
    SetPositionOfTheDefaultPresentation( HP0N, p );
    
    emb := GradedMap( emb, "create", HP0N, S );
    
    Assert( 2, IsMorphism( emb ) );
    SetIsMorphism( emb, true );
    
    hom := Source( emb );
    Assert( 4, IsIdenticalObj( Hom( UnderlyingModule( M ), UnderlyingModule( N ) ), UnderlyingModule( hom ) ) );
    
    hom!.NaturalGeneralizedEmbedding := emb;
    
    # we can not set ModuleOfGlobalSections, because negative degrees would have to be truncated
    
    return hom;
    
end );

##
InstallGlobalFunction( _Functor_GradedHom_OnGradedMaps,     ### defines: GradedHom (morphism part)
  function( F_source, F_target, arg_before_pos, phi, arg_behind_pos )
    local psi;

    if arg_before_pos = [ ] and Length( arg_behind_pos ) = 1 then
        
        psi := GradedMap( Hom( UnderlyingMorphism( phi ), UnderlyingModule( arg_behind_pos[1] ) ), F_source, F_target );
        
    elif Length( arg_before_pos ) = 1 and arg_behind_pos = [ ] then
        
        psi := GradedMap( Hom( UnderlyingModule( arg_before_pos[1] ), UnderlyingMorphism( phi ) ), F_source, F_target );
        
    else
        Error( "wrong input\n" );
    fi;
    
    if HasIsMorphism( phi ) and IsMorphism( phi ) then
        Assert( 2, IsMorphism( psi ) );
        SetIsMorphism( psi, true );
    fi;
    
    return psi;
     
end );

##  <#GAPDoc Label="Functor_Hom:code">
##      <Listing Type="Code"><![CDATA[
InstallValue( Functor_GradedHom_ForGradedModules,
        CreateHomalgFunctor(
                [ "name", "GradedHom" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "GradedHom" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "contravariant", "right adjoint", "distinguished" ], HOMALG_GRADED_MODULES.FunctorOn ] ],
                [ "2", [ [ "covariant", "left exact" ], HOMALG_GRADED_MODULES.FunctorOn ] ],
                [ "OnObjects", _Functor_GradedHom_OnGradedModules ],
                [ "OnMorphisms", _Functor_GradedHom_OnGradedMaps ],
                [ "MorphismConstructor", HOMALG_GRADED_MODULES.category.MorphismConstructor ]
                )
        );
##  ]]></Listing>
##  <#/GAPDoc>

Functor_GradedHom_ForGradedModules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_GradedHom_ForGradedModules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

##
InstallMethod( NatTrIdToHomHom_R,
        "for homalg modules",
        [ IsGradedModuleRep ],
        
  function( M )
    local HHM, nat, epsilon;
    
    HHM := GradedHom( GradedHom( M ) );
    
    nat := NatTrIdToHomHom_R( UnderlyingModule( M ) );
    
    epsilon := GradedMap( nat, M, HHM );
    
    Assert( 2, IsMorphism( epsilon ) );
    SetIsMorphism( epsilon, true );
    
    SetPropertiesIfKernelIsTorsionObject( epsilon );
    
    return epsilon;
    
end );

##
InstallMethod( LeftDualizingFunctor,
        "for homalg graded rings",
        [ IsHomalgGradedRing, IsString ],
        
  function( S, name )
    
    return InsertObjectInMultiFunctor( Functor_GradedHom_ForGradedModules, 2, 1 * S, name );
    
end );

##
InstallMethod( LeftDualizingFunctor,
        "for homalg graded rings",
        [ IsHomalgGradedRing ],
        
  function( S )
    
    if not IsBound( S!.Functor_R_Hom ) then
        if IsBound( S!.creation_number ) then
            S!.Functor_R_Hom := LeftDualizingFunctor( S, Concatenation( "Graded_R", String( S!.creation_number ), "_GradedHom" ) );
        else
            Error( "the homalg ring doesn't have a creation number\n" );
        fi;
    fi;
    
    return S!.Functor_R_Hom;
    
end );

##
InstallMethod( RightDualizingFunctor,
        "for homalg graded rings",
        [ IsHomalgGradedRing, IsString ],
        
  function( S, name )
    
    return InsertObjectInMultiFunctor( Functor_GradedHom_ForGradedModules, 2, S * 1, name );
    
end );

##
InstallMethod( RightDualizingFunctor,
        "for homalg graded rings",
        [ IsHomalgGradedRing ],
        
  function( S )
    
    if not IsBound( S!.Functor_Hom_R ) then
        if IsBound( S!.creation_number ) then
            S!.Functor_Hom_R := RightDualizingFunctor( S, Concatenation( "Graded_GradedHom_R", String( S!.creation_number ) ) );
        else
            Error( "the homalg ring doesn't have a creation number\n" );
        fi;
    fi;
    
    return S!.Functor_Hom_R;
    
end );

##
InstallMethod( Dualize,
        "for graded modules or graded submodules",
        [ IsGradedModuleOrGradedSubmoduleRep ],
        
  GradedHom );

##
InstallMethod( Dualize,
        "for graded module maps",
        [ IsMapOfGradedModulesRep ],
        
  GradedHom );

RightDerivedCofunctor( Functor_GradedHom_ForGradedModules );

##
## TensorProduct
##

InstallGlobalFunction( _Functor_TensorProduct_OnGradedModules,		### defines: TensorProduct (object part)
  function( M, N )
    local S, degM, degN, degMN, T, alpha, p;
    
    S := HomalgRing( M );
    
    ## do not use CheckIfTheyLieInTheSameCategory here
    if not IsIdenticalObj( S, HomalgRing( N ) ) then
        Error( "the rings of the source and target modules are not identical\n" );
    fi;
    
    degM := DegreesOfGenerators( M );
    degN := DegreesOfGenerators( N );
    degMN := Concatenation( List( degM, m -> m + degN ) );
    
    T := TensorProduct( UnderlyingModule( M ), UnderlyingModule( N ) );
    
    alpha := NaturalGeneralizedEmbedding( T );
    
    p := PositionOfTheDefaultPresentation( T );
    SetPositionOfTheDefaultPresentation( T, 1 );
    
    alpha := GradedMap( alpha, "create", degMN, S );
    
    Assert( 2, IsMorphism( alpha ) );
    SetIsMorphism( alpha, true );
    
    T := Source( alpha );
    
    SetPositionOfTheDefaultPresentation( T, p );
    
    T!.NaturalGeneralizedEmbedding := alpha;
    
    if HasIsModuleOfGlobalSections( M ) and IsModuleOfGlobalSections( M ) and
       HasIsModuleOfGlobalSections( N ) and IsModuleOfGlobalSections( N ) then
        SetIsModuleOfGlobalSections( T, true );
    fi;
    
    return T;
    
end );

##
InstallGlobalFunction( _Functor_TensorProduct_OnGradedMaps,	### defines: TensorProduct (morphism part)
  function( F_source, F_target, arg_before_pos, phi, arg_behind_pos )
    local psi;
    
    if arg_before_pos = [ ] and Length( arg_behind_pos ) = 1 then
        
        psi := GradedMap( TensorProduct( UnderlyingMorphism( phi ), UnderlyingModule( arg_behind_pos[1] ) ), F_source, F_target );
        
    elif Length( arg_before_pos ) = 1 and arg_behind_pos = [ ] then
        
        psi := GradedMap( TensorProduct( UnderlyingModule( arg_before_pos[1] ), UnderlyingMorphism( phi ) ), F_source, F_target );
        
    else
        Error( "wrong input\n" );
    fi;
    
    if HasIsMorphism( phi ) and IsMorphism( phi ) then
        Assert( 2, IsMorphism( psi ) );
        SetIsMorphism( psi, true );
    fi;
    
    return psi;
    
end );

if IsOperation( TensorProduct ) then
    
    ## GAP 4.4 style
    InstallValue( Functor_TensorProduct_ForGradedModules,
            CreateHomalgFunctor(
                    [ "name", "TensorProduct" ],
                    [ "category", HOMALG_GRADED_MODULES.category ],
                    [ "operation", "TensorProduct" ],
                    [ "number_of_arguments", 2 ],
                    [ "1", [ [ "covariant", "left adjoint", "distinguished" ], HOMALG_GRADED_MODULES.FunctorOn ] ],
                    [ "2", [ [ "covariant", "left adjoint" ], HOMALG_GRADED_MODULES.FunctorOn ] ],
                    [ "OnObjects", _Functor_TensorProduct_OnGradedModules ],
                    [ "OnMorphisms", _Functor_TensorProduct_OnGradedMaps ],
                    [ "MorphismConstructor", HOMALG_GRADED_MODULES.category.MorphismConstructor ]
                    )
            );
    
else
    
    ## GAP 4.5 style
    ##  <#GAPDoc Label="Functor_TensorProduct:code">
    ##      <Listing Type="Code"><![CDATA[
    InstallValue( Functor_TensorProduct_ForGradedModules,
            CreateHomalgFunctor(
                    [ "name", "TensorProduct" ],
                    [ "category", HOMALG_GRADED_MODULES.category ],
                    [ "operation", "TensorProductOp" ],
                    [ "number_of_arguments", 2 ],
                    [ "1", [ [ "covariant", "left adjoint", "distinguished" ], HOMALG_GRADED_MODULES.FunctorOn ] ],
                    [ "2", [ [ "covariant", "left adjoint" ], HOMALG_GRADED_MODULES.FunctorOn ] ],
                    [ "OnObjects", _Functor_TensorProduct_OnGradedModules ],
                    [ "OnMorphisms", _Functor_TensorProduct_OnGradedMaps ],
                    [ "MorphismConstructor", HOMALG_GRADED_MODULES.category.MorphismConstructor ]
                    )
            );
    ##  ]]></Listing>
    ##  <#/GAPDoc>
    
fi;

Functor_TensorProduct_ForGradedModules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_TensorProduct_ForGradedModules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

## TensorProduct might have been defined elsewhere
if not IsBound( TensorProduct ) then
    
    DeclareGlobalFunction( "TensorProduct" );
    
    ##
    InstallGlobalFunction( TensorProduct,
      function ( arg )
        local  d;
        if Length( arg ) = 0  then
            Error( "<arg> must be nonempty" );
        elif Length( arg ) = 1 and IsList( arg[1] )  then
            if IsEmpty( arg[1] )  then
                Error( "<arg>[1] must be nonempty" );
            fi;
            arg := arg[1];
        fi;
        d := TensorProductOp( arg, arg[1] );
        if ForAll( arg, HasSize )  then
            if ForAll( arg, IsFinite )  then
                SetSize( d, Product( List( arg, Size ) ) );
            else
                SetSize( d, infinity );
            fi;
        fi;
        return d;
    end );
fi;

##
## BaseChange
##

##
InstallGlobalFunction( _functor_BaseChange_OnGradedModules,		### defines: BaseChange (object part)
  function( _R, M )
    local R, S, N, p;
    
    R := HomalgRing( _R );
    
    if IsIdenticalObj( HomalgRing( M ), R ) then
        TryNextMethod( ); ## i.e. the tensor product with the ring
    fi;
    
    if IsHomalgGradedRingRep( R ) then
    
        N := UnderlyingNonGradedRing( R ) * UnderlyingModule( M );
        
        p := PositionOfTheDefaultPresentation( N );
        SetPositionOfTheDefaultPresentation( N, 1 );
        
        N := GradedModule( N, DegreesOfGenerators( M ), R );
        
        SetPositionOfTheDefaultPresentation( N, p );
        
        return N;
      
    else
    
        return R * UnderlyingModule( M );
    
    fi;
    
end );

##
InstallOtherMethod( BaseChange,
        "for homalg graded maps",
        [ IsHomalgRing, IsMapOfGradedModulesRep ], 1001,
        
  function( R, phi )
    local psi;
    if IsHomalgGradedRingRep( R ) then
      psi := GradedMap( UnderlyingNonGradedRing( R ) * UnderlyingMorphism( phi ), R * Source( phi ), R * Range( phi ) );
    else
      psi := HomalgMap( R * MatrixOfMap( UnderlyingMorphism( phi ) ), R * Source( phi ), R * Range( phi ) );
    fi;
    
    if HasIsMorphism( phi ) and IsMorphism( phi ) then
        Assert( 2, IsMorphism( psi ) );
        SetIsMorphism( psi, true );
    fi;
    
    return psi;
    
end );

##
InstallOtherMethod( BaseChange,
        "for homalg graded maps",
        [ IsHomalgModule, IsMapOfGradedModulesRep ], 1001,
        
  function( _R, phi )
    
    return BaseChange( HomalgRing( _R ), phi );
    
end );

InstallValue( functor_BaseChange_ForGradedModules,
        CreateHomalgFunctor(
                [ "name", "BaseChange" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "BaseChange" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ] ] ],
                [ "2", [ [ "covariant" ], HOMALG_GRADED_MODULES.FunctorOn ] ],
                [ "OnObjects", _functor_BaseChange_OnGradedModules ]
                )
        );

functor_BaseChange_ForGradedModules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

functor_BaseChange_ForGradedModules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
 ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

####################################
#
# methods for operations & attributes:
#
####################################

##
InstallFunctor( functor_Cokernel_ForGradedModules );

##
InstallFunctorOnObjects( functor_ImageObject_ForGradedModules );

##
InstallFunctor( Functor_GradedHom_ForGradedModules );

##
InstallFunctor( Functor_TensorProduct_ForGradedModules );

if not IsOperation( TensorProduct ) then
    
    ## GAP 4.5 style
    ##
    InstallMethod( TensorProductOp,
            "for homalg objects",
            [ IsList, IsStructureObjectOrObjectOrMorphism ],
            
      function( L, M )
        
        return Iterated( L, TensorProductOp );
        
    end );
    
fi;

## for convenience
InstallOtherMethod( \*,
        "for homalg modules",
        [ IsStructureObjectOrObjectOrMorphism, IsGradedModuleRep ],
        
  function( M, N )
    
    return TensorProduct( M, N );
    
end );

## for convenience
InstallOtherMethod( \*,
        "for homalg modules",
        [ IsGradedModuleRep, IsStructureObjectOrObjectOrMorphism ],
        
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

InstallFunctor( functor_BaseChange_ForGradedModules );

##
## GradedExt
##

##
RightSatelliteOfCofunctor( Functor_GradedHom_ForGradedModules, "GradedExt" );

##
## Hom
##

ComposeFunctors( Functor_HomogeneousPartOfDegreeZeroOverCoefficientsRing_ForGradedModules, 1, Functor_GradedHom_ForGradedModules, "Hom", "Hom" );

SetProcedureToReadjustGenerators(
        Functor_Hom_for_fp_graded_modules,
        function( arg )
          local mor;
          
          mor := CallFuncList( GradedMap, arg );
          
          ## check assertion
          Assert( 1, IsMorphism( mor ) );
          
          SetIsMorphism( mor, true );
          
          return mor;
          
      end );

##
## Ext
##

##
RightSatelliteOfCofunctor( Functor_Hom_for_fp_graded_modules, "Ext" );

##
## Tor
##

##
LeftSatelliteOfFunctor( Functor_TensorProduct_ForGradedModules, "Tor" );
