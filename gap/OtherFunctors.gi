#############################################################################
##
##  OtherFunctors.gi            homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for some other functors.
##
#############################################################################

####################################
#
# install global functions/variables:
#
####################################

##
## TorsionSubmodule
##

InstallGlobalFunction( _Functor_TorsionSubmodule_OnObjects,	### defines: TorsionSubmodule(Emb)
  function( M )
    local par, emb, tor;
    
    if HasTorsionSubmoduleEmb( M ) then
        return Source( TorsionSubmoduleEmb( M ) );
    fi;
    
    par := ParametrizeModule( M, "ANY" );	## computing a "minimal parametrization" requires RankOfModule which would probably trigger Resolution
    
    emb := KernelEmb( par );
    
    ## set the attribute TorsionSubmoduleEmb (specific for TorsionSubmodule):
    SetTorsionSubmoduleEmb( M, emb );
    
    tor := Source( emb );
    
    SetIsTorsion( tor, true );
    
    return tor;
    
end );

InstallValue( Functor_TorsionSubmodule,
        CreateHomalgFunctor(
                [ "name", "TorsionSubmodule" ],
                [ "natural_transformation", "TorsionSubmoduleEmb" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant", "additive" ] ] ],
                [ "OnObjects", _Functor_TorsionSubmodule_OnObjects ]
                )
        );

Functor_TorsionSubmodule!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

##
## TorsionFreeFactor
##

InstallGlobalFunction( _Functor_TorsionFreeFactor_OnObjects,	### defines: TorsionFreeFactor(Epi)
  function( M )
    local emb, epi, M0, N0;
    
    if HasTorsionFreeFactorEpi( M ) then
        return Range( TorsionFreeFactorEpi( M ) );
    fi;
    
    emb := TorsionSubmoduleEmb( M );
    
    epi := CokernelEpi( emb );
    
    ## set the attribute TorsionFreeFactorEpi (specific for TorsionFreeFactor):
    SetTorsionFreeFactorEpi( M, epi );
    
    M0 := Range( epi );
    
    SetIsTorsionFree( M0, true );
    
    ## set things already known for M
    if HasRankOfModule( M ) then
        SetRankOfModule( M0, RankOfModule( M ) );
    fi;
    
    if HasPurityFiltration( M ) then
        N0 := CertainObject( PurityFiltration( M ), 0 );
        if HasCodegreeOfPurity( N0 ) then
            SetCodegreeOfPurity( M0, CodegreeOfPurity( N0 ) );
        fi;
    fi;
    
    return M0;
    
end );

InstallValue( Functor_TorsionFreeFactor,
        CreateHomalgFunctor(
                [ "name", "TorsionFreeFactor" ],
                [ "natural_transformation", "TorsionFreeFactorEpi" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant", "additive" ] ] ],
                [ "OnObjects", _Functor_TorsionFreeFactor_OnObjects ]
                )
        );

Functor_TorsionFreeFactor!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

##
## DirectSum
##

InstallGlobalFunction( _Functor_DirectSum_OnObjects,	### defines: DirectSum
  function( M, N )
    local R, matM, matN, sum, idM, idN, degMN, F, zeroMN, zeroNM,
          iotaM, iotaN, piM, piN;
    
    R := HomalgRing( M );
    
    if not IsIdenticalObj( R, HomalgRing( N ) ) then
        Error( "the rings of the source and target modules are not identical\n" );
    fi;
    
    if not ( IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) and IsHomalgLeftObjectOrMorphismOfLeftObjects( N ) )
       and not ( IsHomalgRightObjectOrMorphismOfRightObjects( M ) and IsHomalgRightObjectOrMorphismOfRightObjects( N ) ) then
        Error( "the two modules must either be both left or both right modules\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    matM := MatrixOfRelations( M );
    matN := MatrixOfRelations( N );
    
    sum := DiagMat( [ matM, matN ] );
    
    idM := HomalgIdentityMatrix( NrGenerators( M ), R );
    idN := HomalgIdentityMatrix( NrGenerators( N ), R );
    
    ## take care of graded modules
    if IsList( DegreesOfGenerators( M ) ) and
       IsList( DegreesOfGenerators( N ) ) then
        degMN := Concatenation( DegreesOfGenerators( M ), DegreesOfGenerators( N ) );
    fi;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        if IsBound( degMN ) then
            F := HomalgFreeLeftModuleWithDegrees( R, degMN );
        else
            F := HomalgFreeLeftModule( NrGenerators( M ) + NrGenerators( N ), R );
        fi;
        zeroMN := HomalgZeroMatrix( NrGenerators( M ), NrGenerators( N ), R );
        zeroNM := HomalgZeroMatrix( NrGenerators( N ), NrGenerators( M ), R );
        iotaM := UnionOfColumns( idM, zeroMN );
        iotaN := UnionOfColumns( zeroNM, idN );
        piM := UnionOfRows( idM, zeroNM );
        piN := UnionOfRows( zeroMN, idN );
    else
        if IsBound( degMN ) then
            F := HomalgFreeRightModuleWithDegrees( R, degMN );
        else
            F := HomalgFreeRightModule( NrGenerators( M ) + NrGenerators( N ), R );
        fi;
        zeroMN := HomalgZeroMatrix( NrGenerators( N ), NrGenerators( M ), R );
        zeroNM := HomalgZeroMatrix( NrGenerators( M ), NrGenerators( N ), R );
        iotaM := UnionOfRows( idM, zeroMN );
        iotaN := UnionOfRows( zeroNM, idN );
        piM := UnionOfColumns( idM, zeroNM );
        piN := UnionOfColumns( zeroMN, idN );
    fi;
    
    sum := HomalgMap( sum, "free", F );
    
    sum := Cokernel( sum );
    
    iotaM := HomalgMap( iotaM, M, sum );
    iotaN := HomalgMap( iotaN, N, sum );
    piM := HomalgMap( piM, sum, M );
    piN := HomalgMap( piN, sum, N );
    
    SetIsSplitMonomorphism( iotaM, true );
    SetIsSplitMonomorphism( iotaN, true );
    SetIsSplitEpimorphism( piM, true );
    SetIsSplitEpimorphism( piN, true );
    
    SetCokernelEpi( iotaM, piN );
    SetCokernelEpi( iotaN, piM );
    SetKernelEmb( piM, iotaN );
    SetKernelEmb( piN, iotaM );
    
    ## set the four attributes (specific for DirectSum):
    SetMonoOfLeftSummand( sum, iotaM );
    SetMonoOfRightSummand( sum, iotaN );
    SetEpiOnLeftFactor( sum, piM );
    SetEpiOnRightFactor( sum, piN );
    
    if ( HasIsZero( M ) and not IsZero( M ) ) or
       ( HasIsZero( N ) and not IsZero( N ) ) then
        SetIsZero( sum, false );
    fi;
    
    return sum;
    
end );

InstallGlobalFunction( _Functor_DirectSum_OnMorphisms,	### defines: DirectSum (morphism part)
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
        
        if not ( IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) and IsHomalgLeftObjectOrMorphismOfLeftObjects( L ) )
           and not ( IsHomalgRightObjectOrMorphismOfRightObjects( phi ) and IsHomalgRightObjectOrMorphismOfRightObjects( L ) ) then
            Error( "the morphism and the module must either be both left or both right\n" );
        fi;
        
        idL := HomalgIdentityMatrix( NrGenerators( L ), R );
        
        return DiagMat( [ MatrixOfMap( phi ), idL ] );
        
    elif IsMapOfFinitelyGeneratedModulesRep( N_or_mor )
      and IsFinitelyPresentedModuleRep( M_or_mor ) then
        
        phi := N_or_mor;
        L := M_or_mor;
        
        if not ( IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) and IsHomalgLeftObjectOrMorphismOfLeftObjects( L ) )
           and not ( IsHomalgRightObjectOrMorphismOfRightObjects( phi ) and IsHomalgRightObjectOrMorphismOfRightObjects( L ) ) then
            Error( "the morphism and the module must either be both left or both right\n" );
        fi;
        
        idL := HomalgIdentityMatrix( NrGenerators( L ), R );
        
        return DiagMat( [ idL, MatrixOfMap( phi ) ] );
        
    fi;
    
    Error( "one of the arguments must be a module and the other a morphism\n" );
    
end );

InstallValue( Functor_DirectSum,
        CreateHomalgFunctor(
                [ "name", "DirectSum" ],
                [ "natural_transformation1", "EpiOnLeftFactor" ],
                [ "natural_transformation2", "EpiOnRightFactor" ],
                [ "natural_transformation3", "MonoOfLeftSummand" ],
                [ "natural_transformation4", "MonoOfRightSummand" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ] ] ],
                [ "2", [ [ "covariant" ] ] ],
                [ "OnObjects", _Functor_DirectSum_OnObjects ],
                [ "OnMorphisms", _Functor_DirectSum_OnMorphisms ]
                )
        );

Functor_DirectSum!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_DirectSum!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

##
## Pullback
##
#   ?  ----<?>-----> A
#   |                |
#  <?>             (phi)
#   |                |
#   v                v
#   B_ --(beta1)---> B

InstallGlobalFunction( _Functor_Pullback_OnObjects,	### defines: Pullback(PairOfMaps)
  function( chm_phi_beta1 )
    local phi, beta1, phi_beta1, ApB_, emb, pb, S, pair;
    
    phi := LowestDegreeMorphism( chm_phi_beta1 );
    beta1 := LowestDegreeMorphism( Range( chm_phi_beta1 ) );
    
    phi_beta1 := StackMaps( phi, -beta1 );
    
    emb := KernelEmb( phi_beta1 );
    
    pb := Source( emb );
    
    S := Source( phi_beta1 );
    
    pair := [ PreCompose( emb, EpiOnLeftFactor( S ) ), PreCompose( emb, EpiOnRightFactor( S ) ) ];
    
    ## set the attribute PullbackPairOfMaps (specific for Pullback):
    SetPullbackPairOfMaps( chm_phi_beta1, pair );
    
    return pb;
    
end );

InstallValue( functor_Pullback,
        CreateHomalgFunctor(
                [ "name", "Pullback" ],
                [ "natural_transformation", "PullbackPairOfMaps" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant" ], [ IsHomalgChainMap and IsChainMapForPullback ] ] ],
                [ "OnObjects", _Functor_Pullback_OnObjects ]
                )
        );

functor_Pullback!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

## for convenience
InstallMethod( Pullback,
        "for homalg maps with identical target",
        [ IsMapOfFinitelyGeneratedModulesRep, IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi, beta1 )
    
    return Pullback( AsChainMapForPullback( phi, beta1 ) );
    
end );

##
## Pushout
##
#   A_ --(alpha1)--> A
#   |                |
# (psi)             <?>
#   |                |
#   v                v
#   B_ ----<?>-----> ?

InstallGlobalFunction( _Functor_Pushout_OnObjects,	### defines: Pushout(PairOfMaps)
  function( chm_alpha1_psi )
    local psi, alpha1, alpha1_psi, epi, po, T, pair;
    
    psi := HighestDegreeMorphism( chm_alpha1_psi );
    alpha1 := HighestDegreeMorphism( Source( chm_alpha1_psi ) );
    
    alpha1_psi := AugmentMaps( alpha1, psi );
    
    epi := CokernelEpi( alpha1_psi );
    
    po := Range( epi );
    
    T := Range( alpha1_psi );
    
    pair := [ PreCompose( MonoOfLeftSummand( T ), epi ), PreCompose( MonoOfRightSummand( T ), epi ) ];
    
    ## set the attribute PushoutPairOfMaps (specific for Pushout):
    SetPushoutPairOfMaps( chm_alpha1_psi, pair );
    
    return po;
    
end );

InstallValue( functor_Pushout,
        CreateHomalgFunctor(
                [ "name", "Pushout" ],
                [ "natural_transformation", "PushoutPairOfMaps" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant" ], [ IsHomalgChainMap and IsChainMapForPushout ] ] ],
                [ "OnObjects", _Functor_Pushout_OnObjects ]
                )
        );

functor_Pushout!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

## for convenience
InstallMethod( Pushout,
        "for homalg maps with identical source",
        [ IsMapOfFinitelyGeneratedModulesRep, IsMapOfFinitelyGeneratedModulesRep ],
        
  function( alpha1, psi )
    
    return Pushout( AsChainMapForPushout( alpha1, psi ) );
    
end );

##
## AuslanderDual
##

InstallGlobalFunction( _Functor_AuslanderDual_OnObjects,	### defines: AuslanderDual
  function( M )
    local rel, DM;
    
    rel := PresentationMap( M );
    
    rel := MatrixOfMap( rel );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        DM := RightPresentation( rel );
    else
        DM := LeftPresentation( rel );
    fi;
    
    return DM;
    
end );

InstallValue( functor_AuslanderDual,
        CreateHomalgFunctor(
                [ "name", "AuslanderDual" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "contravariant" ], [ IsHomalgModule ] ] ],
                [ "OnObjects", _Functor_AuslanderDual_OnObjects ]
                )
        );

functor_AuslanderDual!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

####################################
#
# methods for operations & attributes:
#
####################################

##
## TorsionSubmodule( M ) and TorsionSubmoduleEmb( M )
##

InstallFunctor( Functor_TorsionSubmodule );

##
## TorsionFreeFactor( M ) and TorsionFreeFactorEpi( M )
##

InstallFunctor( Functor_TorsionFreeFactor );

##
## DirectSum( M, N )		( M + N )
##

InstallFunctor( Functor_DirectSum );

##
InstallMethod( \+,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep, IsFinitelyPresentedModuleRep ],
        
  function( M, N )
    
    return DirectSum( M, N );
    
end );

##
## Pulback( chm_phi_beta1 ) = Pullback( phi, beta1 )
##

InstallFunctorOnObjects( functor_Pullback );

##
## Pushout( chm_alpha1_psi ) = Pushout( alpha1, psi )
##

InstallFunctorOnObjects( functor_Pushout );

##
## AuslanderDual( M )
##

InstallFunctorOnObjects( functor_AuslanderDual );

####################################
#
# temporary
#
####################################

## works only for principal ideal domains
InstallGlobalFunction( _UCT_Homology,
  function( H, G )
    local HG;
    
    HG := H * G + Tor( 1, Shift( H, -1 ), G );
    
    return ByASmallerPresentation( HG );
    
end );

## works only for principal ideal domains
InstallGlobalFunction( _UCT_Cohomology,
  function( H, G )
    local HG;
    
    HG := Hom( H, G ) + Ext( 1, Shift( H, -1 ), G );
    
    return ByASmallerPresentation( HG );
    
end );

