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
## TorsionObject
##

##
InstallMethod( TorsionObject,
        "LIMOR: for homalg modules",
        [ IsHomalgStaticObject ], 10001,
        
  function( psi )
    
    if HasTorsionObjectEmb( psi ) then
        return Source( TorsionObjectEmb( psi ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallGlobalFunction( _Functor_TorsionObject_OnObjects,	### defines: TorsionObject(Emb)
  function( M )
    local tor_subobject, tor, emb;
    
    tor_subobject := TorsionSubobject( M );
    
    ## in case of modules: this involves a second syzygies computation:
    ## (the number of generators of tor might be less than the number of generators of tor_subobject)
    tor := UnderlyingObject( tor_subobject );
    
    ## the natural embedding of tor in M:
    emb := EmbeddingInSuperObject( tor_subobject );
    
    ## set the attribute TorsionObjectEmb (specific for TorsionObject):
    SetTorsionObjectEmb( M, emb );
    
    return tor;
    
end );

InstallValue( Functor_TorsionObject,
        CreateHomalgFunctor(
                [ "name", "TorsionObject" ],
                [ "operation", "TorsionObject" ],
                [ "natural_transformation", "TorsionObjectEmb" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant", "additive" ] ] ],
                [ "OnObjects", _Functor_TorsionObject_OnObjects ]
                )
        );

Functor_TorsionObject!.ContainerForWeakPointersOnComputedBasicMorphisms :=
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
    
    emb := TorsionObjectEmb( M );
    
    epi := CokernelEpi( emb );
    
    ## set the attribute TorsionFreeFactorEpi (specific for TorsionFreeFactor):
    SetTorsionFreeFactorEpi( M, epi );
    
    M0 := Range( epi );
    
    SetIsTorsionFree( M0, true );
    
    ## set things already known for M
    if HasRankOfObject( M ) then
        SetRankOfObject( M0, RankOfObject( M ) );
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
                [ "operation", "TorsionFreeFactor" ],
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

##
InstallMethod( SetPropertiesOfDirectSum,
        "for a list, a homalg static object, and four homalg static morphism",
        [ IsList, IsStaticFinitelyPresentedObjectRep,
          IsStaticMorphismOfFinitelyGeneratedObjectsRep,
          IsStaticMorphismOfFinitelyGeneratedObjectsRep,
          IsStaticMorphismOfFinitelyGeneratedObjectsRep,
          IsStaticMorphismOfFinitelyGeneratedObjectsRep ],
        
  function( M_N, sum, iotaM, iotaN, piM, piN )
    local M, N;
    
    M := M_N[1];
    N := M_N[2];
    
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
    
    ## properties of the direct sum module
    
    ## IsZero
    if HasIsZero( M ) and HasIsZero( N ) then
        if IsZero( M ) and IsZero( N ) then
            SetIsZero( sum, true );
        else	## the converse is also true: trivial since we do not allow virtual modules
            SetIsZero( sum, false );
        fi;
    fi;
    
    ## IsPure
    if HasIsPure( M ) and HasIsPure( N ) then
        if IsPure( M ) and IsPure( N ) then
            if HasAbsoluteDepth( M ) and HasAbsoluteDepth( N ) then
                if AbsoluteDepth( M ) = AbsoluteDepth( N ) or
                   IsZero( M ) or IsZero( N ) then
                    SetIsPure( sum, true );
                else
                    SetIsPure( sum, false );
                fi;
            fi;
        else
            SetIsPure( sum, false );
        fi;
    fi;
    
    ## IsArtinian
    if HasIsArtinian( M ) and HasIsArtinian( N ) then
        if IsArtinian( M ) and IsArtinian( N ) then
            SetIsArtinian( sum, true );
        else	## the converse is also true: trivial
            SetIsArtinian( sum, false );
        fi;
    fi;
    
    ## IsTorsion (in the sense that the evaluation map is zero)
    if HasIsTorsion( M ) and HasIsTorsion( N ) then
        if IsTorsion( M ) and IsTorsion( N ) then
            SetIsTorsion( sum, true );
        else	## the converse is also true: Hom(-,R) commutes with finite direct sums
            SetIsTorsion( sum, false );
        fi;
    fi;
    
    ## IsTorsionFree (in the sense of torionless, i.e. the kernel of the evaluation map is trivial)!!!
    if HasIsTorsionFree( M ) and HasIsTorsionFree( N ) then
        if IsTorsionFree( M ) and IsTorsionFree( N ) then
            SetIsTorsionFree( sum, true );
        else	## the converse is also true: Hom(-,R) commutes with finite direct sums
            SetIsTorsionFree( sum, false );
        fi;
    fi;
    
    ## IsReflexive
    if HasIsReflexive( M ) and HasIsReflexive( N ) then
        if IsReflexive( M ) and IsReflexive( N ) then
            SetIsReflexive( sum, true );
        else	## the converse is also true: Hom(-,R) commutes with finite direct sums
            SetIsReflexive( sum, false );
        fi;
    fi;
    
    ## IsProjective
    if HasIsProjective( M ) and HasIsProjective( N ) then
        if IsProjective( M ) and IsProjective( N ) then
            SetIsProjective( sum, true );
        else	## the converse is also true:
                ## an argumentation valid for modules:
                ## a direct summand of a projective module is projective
                ## (sinse a projective module is a direct summand of a free)
            SetIsProjective( sum, false );
        fi;
    fi;
    
    ## IsFree
    if HasIsFree( M ) and HasIsFree( N ) then
        if IsFree( M ) and IsFree( N ) then
            SetIsFree( sum, true );
        fi;
    fi;
    
    ## attributes of the direct sum module
    
    ## AbsoluteDepth
    if HasAbsoluteDepth( M ) and HasAbsoluteDepth( N ) then
        SetAbsoluteDepth( sum, Minimum( AbsoluteDepth( M ), AbsoluteDepth( N ) ) );
    fi;
    
    return sum;
    
end );

## DirectSum might have been defined elsewhere
if not IsBound( DirectSum ) then
    
    DeclareGlobalFunction( "DirectSum" );
    
    ##
    InstallGlobalFunction( DirectSum,
      function( arg )
        local  d;
        if Length( arg ) = 0  then
            Error( "<arg> must be nonempty" );
        elif Length( arg ) = 1 and IsList( arg[1] )  then
            if IsEmpty( arg[1] )  then
                Error( "<arg>[1] must be nonempty" );
            fi;
            arg := arg[1];
        fi;
        d := DirectSumOp( arg, arg[1] );
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
    
    phi_beta1 := CoproductMorphism( phi, -beta1 );
    
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
                [ "operation", "Pullback" ],
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
        [ IsStaticMorphismOfFinitelyGeneratedObjectsRep, IsStaticMorphismOfFinitelyGeneratedObjectsRep ],
        
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
    
    alpha1_psi := ProductMorphism( alpha1, psi );
    
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
                [ "operation", "Pushout" ],
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
        [ IsStaticMorphismOfFinitelyGeneratedObjectsRep, IsStaticMorphismOfFinitelyGeneratedObjectsRep ],
        
  function( alpha1, psi )
    
    return Pushout( AsChainMapForPushout( alpha1, psi ) );
    
end );

##
## AuslanderDual
##

InstallGlobalFunction( _Functor_AuslanderDual_OnObjects,	### defines: AuslanderDual
  function( M )
    local d0;
    
    d0 := PresentationMorphism( M );
    
    return Cokernel( Hom( d0 ) );
    
end );

InstallValue( functor_AuslanderDual,
        CreateHomalgFunctor(
                [ "name", "AuslanderDual" ],
                [ "operation", "AuslanderDual" ],
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
## TorsionObject( M ) and TorsionObjectEmb( M )
##

InstallFunctor( Functor_TorsionObject );

##
## TorsionFreeFactor( M ) and TorsionFreeFactorEpi( M )
##

InstallFunctor( Functor_TorsionFreeFactor );

##
## DirectSum( M, N )		( M + N )
##

##
InstallMethod( DirectSumOp,
        "for homalg objects",
        [ IsList, IsHomalgRingOrObjectOrMorphism ],
        
  function( L, M )
    
    return Iterated( L, DirectSumOp );
    
end );

##
InstallMethod( \+,
        "for homalg modules",
        [ IsStaticFinitelyPresentedObjectRep, IsStaticFinitelyPresentedObjectRep ],
        
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

