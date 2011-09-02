#############################################################################
##
##  ToolFunctors.gi             homalg package
##
##  Copyright 2007-2008 Mohamed Barakat, RWTH Aachen
##
##  Implementations for some tool functors.
##
#############################################################################

####################################
#
# install global functions/variables:
#
####################################

##
## AsATwoSequence
##

InstallGlobalFunction( _Functor_AsATwoSequence_OnObjects,	### defines: AsATwoSequence
  function( phi, psi )
    local pre, post, C;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) and IsHomalgLeftObjectOrMorphismOfLeftObjects( psi ) then
        pre := phi;
        post := psi;
        if not AreComposableMorphisms( pre, post ) then
            Error( "the two morphisms are not composable, ",
                   "since the target of the left one and ",
                   "the source of right one are not \033[01midentical\033[0m\n" );
        fi;
    elif IsHomalgRightObjectOrMorphismOfRightObjects( phi ) and IsHomalgRightObjectOrMorphismOfRightObjects( psi ) then
        pre := psi;
        post := phi;
        if not AreComposableMorphisms( post, pre ) then
            Error( "the two morphisms are not composable, ",
                   "since the source of the left one and ",
                   "the target of the right one are not \033[01midentical\033[0m\n" );
        fi;
    else
        Error( "the two morphisms must either be both left or both right morphisms\n" );
    fi;
    
    C := HomalgComplex( post, 0 );
    Add( C, pre );
    
    if HasIsMorphism( pre ) and IsMorphism( pre ) and
       HasIsMorphism( post ) and IsMorphism( post ) then
        SetIsSequence( C, true );
    fi;
    
    SetIsATwoSequence( C, true );
    
    return C;
    
end );

InstallValue( functor_AsATwoSequence,
        CreateHomalgFunctor(
                [ "name", "AsATwoSequence" ],
                [ "category", HOMALG.category ],
                [ "operation", "AsATwoSequence" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsStaticMorphismOfFinitelyGeneratedObjectsRep ] ] ],
                [ "2", [ [ "covariant" ], [ IsStaticMorphismOfFinitelyGeneratedObjectsRep ] ] ],
                [ "OnObjects", _Functor_AsATwoSequence_OnObjects ]
                )
        );

functor_AsATwoSequence!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

##
InstallMethod( AsATwoSequence,
        "for complexes",
        [ IsComplexOfFinitelyPresentedObjectsRep and
          IsHomalgLeftObjectOrMorphismOfLeftObjects and
          IsATwoSequence ],
        
  function( C )
    
    return AsATwoSequence( HighestDegreeMorphism( C ), LowestDegreeMorphism( C ) );
    
end );

##
InstallMethod( AsATwoSequence,
        "for complexes",
        [ IsCocomplexOfFinitelyPresentedObjectsRep and
          IsHomalgRightObjectOrMorphismOfRightObjects and
          IsATwoSequence ],
        
  function( C )
    
    return AsATwoSequence( HighestDegreeMorphism( C ), LowestDegreeMorphism( C ) );
    
end );

##
InstallMethod( AsATwoSequence,
        "for complexes",
        [ IsCocomplexOfFinitelyPresentedObjectsRep and
          IsHomalgLeftObjectOrMorphismOfLeftObjects and
          IsATwoSequence ],
        
  function( C )
    
    return AsATwoSequence( LowestDegreeMorphism( C ), HighestDegreeMorphism( C ) );
    
end );

##
InstallMethod( AsATwoSequence,
        "for complexes",
        [ IsComplexOfFinitelyPresentedObjectsRep and
          IsHomalgRightObjectOrMorphismOfRightObjects and
          IsATwoSequence ],
        
  function( C )
    
    return AsATwoSequence( LowestDegreeMorphism( C ), HighestDegreeMorphism( C ) );
    
end );

##
## PreCompose
##

##
InstallMethod( \*,
        "for homalg composable morphisms",
        [ IsHomalgMorphism and IsHomalgLeftObjectOrMorphismOfLeftObjects,
          IsHomalgMorphism ], 1001,	## this must be ranked higher than multiplication with a ring element, which could be an endomorphism
        
  function( pre, post )
    
    return PreCompose( pre, post );
    
end );

##
InstallMethod( \*,
        "for homalg composable morphisms",
        [ IsHomalgMorphism and IsHomalgRightObjectOrMorphismOfRightObjects,
          IsHomalgMorphism ], 1001,	## this must be ranked higher than multiplication with a ring element, which it could be an endomorphism
        
  function( post, pre )
    
    return PreCompose( pre, post );
    
end );

##
## AsChainMorphismForPullback
##
#   ?  ----<?>-----> A
#   |                |
#  <?>             (phi)
#   |                |
#   v                v
#   B_ --(beta1)---> B

InstallGlobalFunction( _Functor_AsChainMorphismForPullback_OnObjects,	### defines: AsChainMorphismForPullback
  function( phi, beta1 )
    local S, T, c;
    
    S := HomalgComplex( Source( phi ), 0 );
    T := HomalgComplex( beta1 );
    
    c := HomalgChainMorphism( phi, S, T, 0 );
    
    if HasIsMorphism( phi ) and IsMorphism( phi ) and
       HasIsMorphism( beta1 ) and IsMorphism( beta1 ) then
        SetIsMorphism( c, true );
    elif HasIsGeneralizedMorphism( phi ) and IsGeneralizedMorphism( phi ) and
      HasIsGeneralizedMorphism( beta1 ) and IsGeneralizedMorphism( beta1 ) then
        SetIsGeneralizedMorphism( c, true );
    fi;
    
    SetIsChainMorphismForPullback( c, true );
    
    return c;
    
end );

InstallValue( functor_AsChainMorphismForPullback,
        CreateHomalgFunctor(
                [ "name", "AsChainMorphismForPullback" ],
                [ "category", HOMALG.category ],
                [ "operation", "AsChainMorphismForPullback" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsStaticMorphismOfFinitelyGeneratedObjectsRep ] ] ],
                [ "2", [ [ "covariant" ], [ IsStaticMorphismOfFinitelyGeneratedObjectsRep ] ] ],
                [ "OnObjects", _Functor_AsChainMorphismForPullback_OnObjects ]
                )
        );

functor_AsChainMorphismForPullback!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

##
## AsChainMorphismForPushout
##
#   A_ --(alpha1)--> A
#   |                |
# (psi)             <?>
#   |                |
#   v                v
#   B_ ----<?>-----> ?

InstallGlobalFunction( _Functor_AsChainMorphismForPushout_OnObjects,	### defines: AsChainMorphismForPushout
  function( alpha1, psi )
    local S, T, c;
    
    S := HomalgComplex( alpha1 );
    T := HomalgComplex( Range( psi ), 1 );
    
    c := HomalgChainMorphism( psi, S, T, 1 );
    
    if HasIsMorphism( psi ) and IsMorphism( psi ) and
       HasIsMorphism( alpha1 ) and IsMorphism( alpha1 ) then
        SetIsMorphism( c, true );
    elif HasIsGeneralizedMorphism( psi ) and IsGeneralizedMorphism( psi ) and
      HasIsGeneralizedMorphism( alpha1 ) and IsGeneralizedMorphism( alpha1 ) then
        SetIsGeneralizedMorphism( c, true );
    fi;
    
    SetIsChainMorphismForPushout( c, true );
    
    return c;
    
end );

InstallValue( functor_AsChainMorphismForPushout,
        CreateHomalgFunctor(
                [ "name", "AsChainMorphismForPushout" ],
                [ "category", HOMALG.category ],
                [ "operation", "AsChainMorphismForPushout" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsStaticMorphismOfFinitelyGeneratedObjectsRep ] ] ],
                [ "2", [ [ "covariant" ], [ IsStaticMorphismOfFinitelyGeneratedObjectsRep ] ] ],
                [ "OnObjects", _Functor_AsChainMorphismForPushout_OnObjects ]
                )
        );

functor_AsChainMorphismForPushout!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

#=======================================================================
# PostDivide
#
# M_ is free or beta is injective ( cf. [BR08, Subsection 3.1.1] )
#
#     M_
#     |   \
#  (psi=?)  \ (gamma)
#     |       \
#     v         v
#     N_ -(beta)-> N
#
#_______________________________________________________________________

##
## PostDivide
##

InstallMethod( PostDivide,  ### defines: PostDivide for generalized morphisms
  [ IsHomalgMorphism and HasMorphismAid, IsHomalgMorphism ], 1000,
  function( gamma, beta )
    local category, aid, Cepi, gamma2, beta2, psi, new_aid;
    
    if HasMorphismAid( beta ) then
        TryNextMethod( );
    fi;
    
    # If the category allows trying to compute the lift without the aids
    # (e.g. Modules, GradedModules, Sheaves)
    # then remove the morphism aid and try to compute the lift without aid.
    # This is a purely heuristical approach.
    # It might (and will) fail even for the allowed categories in many cases.
    category := HomalgCategory( gamma );
    if category <> fail and IsBound( category.TryPostDivideWithoutAids ) and category.TryPostDivideWithoutAids then
        psi := PostDivide( RemoveMorphismAid( gamma ), beta );
    else
        psi := false;
    fi;
    
    aid := MorphismAid( gamma );
    
    Cepi := CokernelEpi( aid );
    
    beta2 := PreCompose( beta, Cepi );
    
    if IsBool( psi ) then
        
        gamma2 := PreCompose( RemoveMorphismAid( gamma ), Cepi );
        
        if HasIsGeneralizedMorphism( gamma ) and IsGeneralizedMorphism( gamma ) then
            SetIsMorphism( gamma2, true );
        fi;
        
        if HasIsGeneralizedMonomorphism( gamma ) and IsGeneralizedMonomorphism( gamma ) then
            SetIsMonomorphism( gamma2, true );
        fi;
        
        psi := PostDivide( gamma2, beta2 );
    
    else
        
        # The aid we need to compute for psi is the kernel of beta2.
        # we compute this lazy by just storing [ beta2 ] and
        # GetMorphismAid( psi ) will compute the correct aid
        # as kernel of beta2.
        psi := GeneralizedMorphism( psi, [ beta2 ] );
        
    fi;
    
    return psi;
    
end );

InstallMethod( PostDivide,  ### defines: PostDivide for generalized morphisms
  [ IsHomalgMorphism, IsHomalgMorphism and HasMorphismAid ], 100000,
  function( gamma, beta )
    local aid, Cepi, gamma2, beta2, psi, beta3;
    
    aid := MorphismAid( beta );
    
    Cepi := CokernelEpi( aid );
    
    # we can remove the aid of beta, since it will be zero after the composition anyway
    beta2 := PreCompose( RemoveMorphismAid( beta ), Cepi );
    
    gamma2 := PreCompose( gamma, Cepi );
    
    if HasIsGeneralizedMorphism( beta ) and IsGeneralizedMorphism( beta ) then
        SetIsMorphism( beta2, true );
    fi;
    
    if HasIsGeneralizedMonomorphism( beta ) and IsGeneralizedMonomorphism( beta ) then
        SetIsMonomorphism( beta2, true );
    fi;
    
    if HasIsGeneralizedEpimorphism( beta ) and IsGeneralizedEpimorphism( beta ) then
        SetIsEpimorphism( beta2, true );
    fi;
    
    # compute PostDivide in the specific category
    psi := PostDivide( gamma2, beta2 );
    
    # this is used when we call beta^(-1)
    if HasIsOne( gamma ) and IsOne( gamma ) and HasIsGeneralizedIsomorphism( beta ) and IsGeneralizedIsomorphism( beta ) then
        
        # we know the kernel of psi, it is the image of the aids
        # the ImageObjectEmb should be computed lazy
        SetKernelEmb( psi, ImageObjectEmb( aid ) );
        
        Assert( 2, IsMorphism( psi ) );
        SetIsMorphism( psi, true );
        
    fi;
    
    return psi;

end );

## for convenience
InstallMethod( \/,
        "for homalg morphisms with the same target",
        [ IsMorphismOfFinitelyGeneratedObjectsRep, IsMorphismOfFinitelyGeneratedObjectsRep ],
        
  function( gamma, beta )
    local psi;
    
    if not IsIdenticalObj( Range( gamma ), Range( beta ) ) then
        Error( "the target objects of the two morphisms are not identical\n" );
    fi;
    
    psi := PostDivide( gamma, beta );
    
    if IsBool( psi ) then
        Error( "PostDivide failed. The image of the first argument is not contained in the image of the second argument!\n" );
    fi;
    
    return psi;
    
end );

#=======================================================================
# PreDivide
#
# epsilon is surjective ( cf. [BLH, 2.5,(13): colift] )
# eta( KernelEmb( epsilon ) ) is zero
#
#     L
#     ^  ^
#     |     \ (eta)
#  (eta0=?)    \
#     |           \
#     C <-(epsilon)- N
#
#
# (left objects): eta0 := epsilon^(-1) * eta
# (right objects): eta0 := eta * epsilon^(-1)
#_______________________________________________________________________

##
## PreDivide
##

InstallGlobalFunction( _Functor_PreDivide_OnMorphisms,	### defines: PreDivide
  function( epsilon, eta )
    local gen_iso, eta0;
    
    if not IsIdenticalObj( Source( epsilon ), Source( eta ) ) then
        Error( "the source objects of the two morphisms are not identical\n" );
    elif not ( HasIsEpimorphism( epsilon ) and IsEpimorphism( epsilon ) ) then
        Error( "the first morphism is either not an epimorphism or not yet known to be one\n" );
    fi;
    
    Assert( 2, IsZero( PreCompose( KernelEmb( epsilon ), eta ) ) );
    
    ## this is in general not a morphism;
    ## it would be a generalized isomorphism if we would
    ## add the appropriate morphism aid, but we don't need this here
    gen_iso := GeneralizedInverse( epsilon );
    
    ## make a copy without the morphism aid map
    gen_iso := RemoveMorphismAid( gen_iso );
    
    eta0 := PreCompose( gen_iso, eta );
    
    ## check assertion
    Assert( 2, IsMorphism( eta0 ) );
    
    SetIsMorphism( eta0, true );
    
    return eta0;
    
end );

InstallValue( functor_PreDivide,
        CreateHomalgFunctor(
                [ "name", "PreDivide" ],
                [ "category", HOMALG.category ],
                [ "operation", "PreDivide" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsStaticMorphismOfFinitelyGeneratedObjectsRep ] ] ], ## FIXME: covariant?
                [ "2", [ [ "covariant" ], [ IsStaticMorphismOfFinitelyGeneratedObjectsRep ] ] ],
                [ "OnObjects", _Functor_PreDivide_OnMorphisms ]
                )
        );

functor_PreDivide!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

####################################
#
# methods for operations & attributes:
#
####################################

##
## AsATwoSequence( phi, psi )
##

InstallFunctorOnObjects( functor_AsATwoSequence );

##
## AsChainMorphismForPullback( phi, beta1 )
##

InstallFunctorOnObjects( functor_AsChainMorphismForPullback );

##
## AsChainMorphismForPushout( alpha1, psi )
##

InstallFunctorOnObjects( functor_AsChainMorphismForPushout );

##
## PreDivide( gamma, beta )
##

InstallFunctorOnObjects( functor_PreDivide );

##
## SetProperties
##

##
InstallMethod( SetPropertiesOfMulMorphism,
        "for a ring element and two homalg static morphisms",
        [ IsRingElement,
          IsStaticMorphismOfFinitelyGeneratedObjectsRep,
          IsStaticMorphismOfFinitelyGeneratedObjectsRep ],
        
  function( a, phi, a_phi )
    
    ## FIXME: only true if IsCentralElement!!!
    
    if IsUnit( StructureObject( phi ), a ) then
        
        if HasIsIsomorphism( phi ) then
            SetIsIsomorphism( a_phi, IsIsomorphism( phi ) );
            if IsIsomorphism( a_phi ) then
                return a_phi;
            fi;
        fi;
        
        if HasIsSplitMonomorphism( phi ) then
            SetIsSplitMonomorphism( a_phi, IsSplitMonomorphism( phi ) );
        elif HasIsMonomorphism( phi ) then
            SetIsMonomorphism( a_phi, IsMonomorphism( phi ) );
        elif HasIsGeneralizedMonomorphism( phi ) then
            SetIsGeneralizedMonomorphism( a_phi, IsGeneralizedMonomorphism( phi ) );
        fi;
        
        if HasIsSplitEpimorphism( phi ) then
            SetIsSplitEpimorphism( a_phi, IsSplitEpimorphism( phi ) );
        elif HasIsEpimorphism( phi ) then
            SetIsEpimorphism( a_phi, IsEpimorphism( phi )  );
        elif HasIsGeneralizedEpimorphism( phi ) then
            SetIsGeneralizedEpimorphism( a_phi, IsGeneralizedEpimorphism( phi )  );
        fi;
        
        if HasIsMorphism( phi ) then
            SetIsMorphism( a_phi, IsMorphism( phi ) );
        elif HasIsGeneralizedMorphism( phi ) then
            SetIsGeneralizedMorphism( a_phi, IsGeneralizedMorphism( phi ) );
        fi;
        
    elif HasIsMorphism( phi ) and IsMorphism( phi ) then
        
        SetIsMorphism( a_phi, true );
        
    elif HasIsGeneralizedMorphism( phi ) and IsGeneralizedMorphism( phi ) then
        
        SetIsGeneralizedMorphism( a_phi, true );
        
    fi;
    
    return a_phi;
    
end );

##
InstallMethod( SetPropertiesOfSumMorphism,
        "for three homalg static morphisms",
        [ IsStaticMorphismOfFinitelyGeneratedObjectsRep,
          IsStaticMorphismOfFinitelyGeneratedObjectsRep,
          IsStaticMorphismOfFinitelyGeneratedObjectsRep ],
        
  function( phi1, phi2, phi )
    
    if HasIsMorphism( phi1 ) and IsMorphism( phi1 ) and
       HasIsMorphism( phi2 ) and IsMorphism( phi2 ) then
        SetIsMorphism( phi, true );
    fi;
    
    return phi;
    
end );

##
InstallMethod( SetPropertiesOfDifferenceMorphism,
        "for three homalg static morphisms",
        [ IsStaticMorphismOfFinitelyGeneratedObjectsRep,
          IsStaticMorphismOfFinitelyGeneratedObjectsRep,
          IsStaticMorphismOfFinitelyGeneratedObjectsRep ],
        
  function( phi1, phi2, phi )
    
    if HasIsMorphism( phi1 ) and IsMorphism( phi1 ) and
       HasIsMorphism( phi2 ) and IsMorphism( phi2 ) then
        SetIsMorphism( phi, true );
    fi;
    
    return phi;
    
end );

##
InstallMethod( SetPropertiesOfComposedMorphism,
        "for three homalg static morphisms",
        [ IsMorphismOfFinitelyGeneratedObjectsRep,
          IsMorphismOfFinitelyGeneratedObjectsRep,
          IsMorphismOfFinitelyGeneratedObjectsRep ],
        
  function( pre, post, phi )
    
    if HasIsSplitMonomorphism( pre ) and IsSplitMonomorphism( pre ) and
       HasIsSplitMonomorphism( post ) and IsSplitMonomorphism( post ) then
        SetIsSplitMonomorphism( phi, true );
    elif HasIsMonomorphism( pre ) and IsMonomorphism( pre ) and
      HasIsMonomorphism( post ) and IsMonomorphism( post ) then
        SetIsMonomorphism( phi, true );
    fi;
    
    ## cannot use elif here:
    if HasIsSplitEpimorphism( pre ) and IsSplitEpimorphism( pre ) and
       HasIsSplitEpimorphism( post ) and IsSplitEpimorphism( post ) then
        SetIsSplitEpimorphism( phi, true );
    elif HasIsEpimorphism( pre ) and IsEpimorphism( pre ) and
      HasIsEpimorphism( post ) and IsEpimorphism( post ) then
        SetIsEpimorphism( phi, true );
    elif HasIsMorphism( pre ) and IsMorphism( pre ) and
      HasIsMorphism( post ) and IsMorphism( post ) then
        SetIsMorphism( phi, true );
    fi;
    
    ## the following is crucial for spectral sequences:
    if HasMorphismAid( pre ) then
        
        if HasIsGeneralizedMonomorphism( pre ) and IsGeneralizedMonomorphism( pre ) and
           HasIsGeneralizedMonomorphism( post ) and IsGeneralizedMonomorphism( post ) then
            SetIsGeneralizedMonomorphism( phi, true );
        fi;
        
        ## cannot use elif here:
        if HasIsGeneralizedEpimorphism( pre ) and IsGeneralizedEpimorphism( pre ) and
           HasIsGeneralizedEpimorphism( post ) and IsGeneralizedEpimorphism( post ) then
            SetIsGeneralizedEpimorphism( phi, true );
        elif HasIsGeneralizedMorphism( pre ) and IsGeneralizedMorphism( pre ) and
          HasIsGeneralizedMorphism( post ) and IsGeneralizedMorphism( post ) then
            SetIsGeneralizedMorphism( phi, true );
        fi;
        
    elif HasMorphismAid( post ) then
        
        if HasIsGeneralizedMonomorphism( pre ) and IsGeneralizedMonomorphism( pre ) and
           HasIsGeneralizedMonomorphism( post ) and IsGeneralizedMonomorphism( post ) then
            SetIsGeneralizedMonomorphism( phi, true );
        fi;
        
        ## cannot use elif here:
        if HasIsGeneralizedEpimorphism( pre ) and IsGeneralizedEpimorphism( pre ) and
           HasIsGeneralizedEpimorphism( post ) and IsGeneralizedEpimorphism( post ) then
            SetIsGeneralizedEpimorphism( phi, true );
        elif HasIsGeneralizedMorphism( pre ) and IsGeneralizedMorphism( pre ) and
          HasIsGeneralizedMorphism( post ) and IsGeneralizedMorphism( post ) then
            SetIsGeneralizedMorphism( phi, true );
        fi;
        
    fi;
    
    return phi;
    
end );

##
InstallMethod( GeneralizedComposedMorphism,
        "for three homalg static morphisms",
        [ IsMorphismOfFinitelyGeneratedObjectsRep,
          IsMorphismOfFinitelyGeneratedObjectsRep,
          IsMorphismOfFinitelyGeneratedObjectsRep ],
        
  function( pre, post, phi )
    local morphism_aid_pre;
    
    ## the following is crucial for spectral sequences:
    if HasMorphismAid( pre ) then
        
        morphism_aid_pre := PreCompose( MorphismAid( pre ), RemoveMorphismAid( post ) );
        
        if HasMorphismAid( post ) then
            phi := AddToMorphismAid( phi, CoproductMorphism( MorphismAid( post ), morphism_aid_pre ) );
        else
            phi := AddToMorphismAid( phi, morphism_aid_pre );
        fi;
        
    elif HasMorphismAid( post ) then
        
        phi := AddToMorphismAid( phi, MorphismAid( post ) );
        
    fi;
    
    SetPropertiesOfComposedMorphism( pre, post, phi );
    
    return phi;
    
end );

##
InstallMethod( SetPropertiesOfCoproductMorphism,
        "for three homalg static morphisms",
        [ IsStaticMorphismOfFinitelyGeneratedObjectsRep,
          IsStaticMorphismOfFinitelyGeneratedObjectsRep,
          IsStaticMorphismOfFinitelyGeneratedObjectsRep ],
        
  function( phi, psi, phi_psi )
    
    if HasIsEpimorphism( phi ) and IsEpimorphism( phi ) and
       HasIsMorphism( psi ) and IsMorphism( psi ) then
        SetIsEpimorphism( phi_psi, true );
    elif HasIsMorphism( phi ) and IsMorphism( phi ) and
      HasIsEpimorphism( psi ) and IsEpimorphism( psi ) then
        SetIsEpimorphism( phi_psi, true );
    elif HasIsMorphism( phi ) and IsMorphism( phi ) and
      HasIsMorphism( psi ) and IsMorphism( psi ) then
        SetIsMorphism( phi_psi, true );
    fi;
    
    return phi_psi;
    
end );

##
InstallMethod( GeneralizedCoproductMorphism,
        "for three homalg static morphisms",
        [ IsStaticMorphismOfFinitelyGeneratedObjectsRep,
          IsStaticMorphismOfFinitelyGeneratedObjectsRep,
          IsStaticMorphismOfFinitelyGeneratedObjectsRep ],
        
  function( phi, psi, phi_psi )
    
    if HasMorphismAid( phi ) and HasMorphismAid( psi ) then
        phi_psi := AddToMorphismAid( phi_psi, CoproductMorphism( MorphismAid( phi ), MorphismAid( psi ) ) );
    elif HasMorphismAid( phi ) then
        phi_psi := AddToMorphismAid( phi_psi, MorphismAid( phi ) );
    elif HasMorphismAid( psi ) then
        phi_psi := AddToMorphismAid( phi_psi, MorphismAid( psi ) );
    fi;
    
    SetPropertiesOfCoproductMorphism( phi, psi, phi_psi );
    
    return phi_psi;
    
end );

##
InstallMethod( SetPropertiesOfProductMorphism,
        "for three homalg static morphisms",
        [ IsStaticMorphismOfFinitelyGeneratedObjectsRep,
          IsStaticMorphismOfFinitelyGeneratedObjectsRep,
          IsStaticMorphismOfFinitelyGeneratedObjectsRep ],
        
  function( phi, psi, phi_psi )
    
    if HasIsMonomorphism( phi ) and IsMonomorphism( phi ) and
       HasIsMorphism( psi ) and IsMorphism( psi ) then
        SetIsMonomorphism( phi_psi, true );
    elif HasIsMorphism( phi ) and IsMorphism( phi ) and
       HasIsMonomorphism( psi ) and IsMonomorphism( psi ) then
        SetIsMonomorphism( phi_psi, true );
    elif HasIsMorphism( phi ) and IsMorphism( phi ) and
       HasIsMorphism( psi ) and IsMorphism( psi ) then
        SetIsMorphism( phi_psi, true );
    fi;
    
    return phi_psi;
    
end );

##
InstallMethod( GeneralizedProductMorphism,
        "for three homalg static morphisms",
        [ IsStaticMorphismOfFinitelyGeneratedObjectsRep,
          IsStaticMorphismOfFinitelyGeneratedObjectsRep,
          IsStaticMorphismOfFinitelyGeneratedObjectsRep ],
        
  function( phi, psi, phi_psi )
    local aid;
    
    if HasMorphismAid( phi ) and HasMorphismAid( psi ) then
        phi_psi := AddToMorphismAid( phi_psi, DirectSum( MorphismAid( phi ), MorphismAid( psi ) ) );
    elif HasMorphismAid( phi ) then
        aid := MorphismAid( phi );
        phi_psi := AddToMorphismAid( phi_psi, ProductMorphism( aid, TheZeroMorphism( Source( aid ), Range( psi ) ) ) );
    elif HasMorphismAid( psi ) then
        aid := MorphismAid( psi );
        phi_psi := AddToMorphismAid( phi_psi, ProductMorphism( TheZeroMorphism( Source( aid ), Range( phi ) ), aid ) );
    fi;
    
    SetPropertiesOfProductMorphism( phi, psi, phi_psi );
    
    return phi_psi;
    
end );

##
InstallMethod( SetPropertiesOfPostDivide,
        "for three homalg static morphisms",
        [ IsStaticMorphismOfFinitelyGeneratedObjectsRep,
          IsStaticMorphismOfFinitelyGeneratedObjectsRep,
          IsStaticMorphismOfFinitelyGeneratedObjectsRep ],
        
  function( gamma, beta, psi )
    
    if not ( HasIsMorphism( psi ) and IsMorphism( psi ) ) then
    
        if HasIsMorphism( gamma ) and IsMorphism( gamma ) and
            ( ( HasIsMonomorphism( beta ) and IsMonomorphism( beta ) ) or  ## [BR08, Subsection 3.1.1,(2)]
            ( HasIsGeneralizedMonomorphism( beta ) and IsGeneralizedMonomorphism( beta ) ) ) then  ## "generalizes" [BR08, Subsection 3.1.1,(2)]
            
            Assert( 2, IsMorphism( psi ) );
            
            SetIsMorphism( psi, true );
            
        else
            
            # GradedModules and Sheaves inherit the MorphismAid from Modules
            if not HasMorphismAid( psi ) and HasIsMorphism( gamma ) and HasIsMorphism( beta ) and IsMorphism( gamma ) and IsMorphism( beta ) then
                
                psi := GeneralizedMorphism( psi, [ beta ] );
                Assert( 2, IsGeneralizedMorphism( psi ) );
                SetIsGeneralizedMorphism( psi, true );
                
            fi;
            
        fi;
    
    fi;
    
    return psi;
    
end );

