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
    local S, R, p, U_phi, coker_U_phi, epi, coker, gen_iso, img_emb, emb;
    
    if HasCokernelEpi( phi ) then
      return Range( CokernelEpi( phi ) );
    fi;
    
    S := HomalgRing( phi );
    R := UnderlyingNonGradedRing( S );

    U_phi := UnderlyingMorphism( phi ) ;
    coker_U_phi := Cokernel( U_phi );
    
    # The cokernel get the same degrees as the range of phi,
    # since the epimorphism on the cokernel is induced by the indentity matrix.
    # By choice of the first presentation we ensure, that we can use this trick.
    p := PositionOfTheDefaultPresentation( coker_U_phi );
    SetPositionOfTheDefaultPresentation( coker_U_phi, 1 );

    epi := GradedMap( CokernelEpi( UnderlyingMorphism( phi ) ), Range( phi ), DegreesOfGenerators( Range( phi ) ), HomalgRing( phi ) );
    
    SetPositionOfTheDefaultPresentation( coker_U_phi, p );
    
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
                          [ IsHomalgChainMap, IsImageSquare ] ] ] ],
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
    
    ## set the attribute ImageObjectEmb (specific for ImageObject):
    ## (since ImageObjectEmb is listed below as a natural transformation
    ##  for the functor ImageObject, a method will be automatically installed
    ##  by InstallFunctor to fetch it by first invoking the main operation ImageObject)
    SetImageObjectEmb( phi, emb );
    
    if HasIsEpimorphism( phi ) and IsEpimorphism( phi ) then
        SetIsIsomorphism( emb, true );
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

# not needed, homalg calls KernelSubobject, which is implemented in LIGMOR

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
    hom := Source( emb );
    Assert( 4, IsIdenticalObj( Hom( UnderlyingModule( M ), UnderlyingModule( N ) ), UnderlyingModule( hom ) ) );
    
    hom!.NaturalGeneralizedEmbedding := emb;
    
    return hom;
    
end );

##
InstallGlobalFunction( _Functor_GradedHom_OnGradedMaps,     ### defines: GradedHom (morphism part)
  function( F_source, F_target, arg_before_pos, phi, arg_behind_pos )

    if arg_before_pos = [ ] and Length( arg_behind_pos ) = 1 then
        
        return GradedMap( Hom( UnderlyingMorphism( phi ), UnderlyingModule( arg_behind_pos[1] ) ), F_source, F_target );
        
    elif Length( arg_before_pos ) = 1 and arg_behind_pos = [ ] then
        
        return GradedMap( Hom( UnderlyingModule( arg_before_pos[1] ), UnderlyingMorphism( phi ) ), F_source, F_target );
        
    else
        Error( "wrong input\n" );
    fi;
     
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
    
    T := Source( alpha );
    
    SetPositionOfTheDefaultPresentation( T, p );
    
    T!.NaturalGeneralizedEmbedding := alpha;
    
    return T;
    
end );

##
InstallGlobalFunction( _Functor_TensorProduct_OnGradedMaps,	### defines: TensorProduct (morphism part)
  function( F_source, F_target, arg_before_pos, phi, arg_behind_pos )

    if arg_before_pos = [ ] and Length( arg_behind_pos ) = 1 then
        
        return GradedMap( TensorProduct( UnderlyingMorphism( phi ), UnderlyingModule( arg_behind_pos[1] ) ), F_source, F_target );
        
    elif Length( arg_before_pos ) = 1 and arg_behind_pos = [ ] then
        
        return GradedMap( TensorProduct( UnderlyingModule( arg_before_pos[1] ), UnderlyingMorphism( phi ) ), F_source, F_target );
        
    else
        Error( "wrong input\n" );
    fi;
    
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
                    [ "OnMorphismsHull", _Functor_TensorProduct_OnGradedMaps ],
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
    
    if IsHomalgGradedRingRep( R ) then
      return GradedMap( R * UnderlyingMorphism( phi ), R * Source( phi ), R * Range( phi ) );
    else
      return HomalgMap( R * MatrixOfMap( UnderlyingMorphism( phi ) ), R * Source( phi ), R * Range( phi ) );
    fi;
    
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
#                 [ "1", [ [ "covariant" ], HOMALG_GRADED_MODULES.FunctorOn ] ],
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
InstallFunctor( functor_Cokernel_ForGradedModules );

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
InstallFunctorOnObjects( functor_ImageObject_ForGradedModules );

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
##  -1:	<A non-zero cyclic torsion right module on a cyclic generator satisfying 
##  1 relation>
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
InstallFunctor( Functor_GradedHom_ForGradedModules );

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
##      The symbol <C>*</C> is a shorthand for several operations associated with the functor <C>Functor_TensorProduct</C>
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
##  <A homalg internal ring>
##  gap> Z4 := ZZ / 4;
##  <A homalg residue class ring>
##  gap> Display( Z4 );
##  Z/( 4 )
##  gap> M := HomalgDiagonalMatrix( [ 2 .. 4 ], ZZ );
##  <An unevaluated diagonal homalg internal 3 by 3 matrix>
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
##  <A homalg internal 2 by 3 matrix>
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
InstallFunctor( functor_BaseChange_ForGradedModules );

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
##    Below is the only <E>specific</E> line of code used to define <C>Functor_Ext</C>
##    and all the different operations <C>Ext</C> in &homalg;.
##      <Listing Type="Code"><![CDATA[
RightSatelliteOfCofunctor( Functor_GradedHom_ForGradedModules, "GradedExt" );
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
##    Below is the only <E>specific</E> line of code used to define <C>Functor_Tor</C>
##    and all the different operations <C>Tor</C> in &homalg;.
##      <Listing Type="Code"><![CDATA[
LeftSatelliteOfFunctor( Functor_TensorProduct_ForGradedModules, "Tor" );
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
