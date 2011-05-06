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

InstallGlobalFunction( _Functor_PreCompose_OnObjects,        ### defines: PreCompose
  function( cpx_post_pre )
    local pre, post, S, T, phi;
    
    ## We realized that <C>PreCompose</C> has to be installed for each Abelian
    ## category depending on the two morphisms rather than on a single
    ## (<C>IsHomalgComplex</C> and <C>IsATwoSequence</C>);
    ## this is necessary for a clean and uncomplicated method selection.
    ## But in doing so, we lost the caching provided by the functor
    ## <C>AsATwoSequence</C> which is used in other places of the &homalg; code,
    ## and the number of external calls jumped due to unnecessary repeated
    ## computations:
    ## For that reason this high-level <C>PreCompose</C> functor was
    ## reintroduced here, which takes an <C>IsHomalgComplex and IsATwoSequence</C>
    ## as its single argument and then calls a low-level
    ## <C>PreComposeMorphisms</C> method. <C>PreComposeMorphisms</C> must be
    ## the name of the operation of the specific <C>PreCompose</C> functor
    ## in a package implementing a specific Abelian category.
    ## Besides, two <C>PreCompose</C> methods depending on two morphisms were
    ## installed below, which could be overloaded by each specific
    ## <C>PreCompose</C> functor if it uses <C>PreCompose</C>
    ## instead of <C>PreComposeMorphisms</C> as the name of its operation
    ## (and hence bypassing this high-level functor
    ##  and the <C>AsATwoSequence</C> functor).
    ## So by choosing between <C>PreComposeMorphisms</C> and <C>PreCompose</C>
    ## as operation name the authors of the specific packages
    ## have the freedom to choose if they would like to make use
    ## of the caching provided by <C>AsATwoSequence</C> or not.
    ## For this to work, only the two-argument methods for <C>PreCompose</C>
    ## may be called.
    
    if not ( IsHomalgComplex( cpx_post_pre ) and Length( ObjectDegreesOfComplex( cpx_post_pre ) ) = 3 ) then
        Error( "expecting a complex containing two morphisms\n" );
    fi;
    
    pre := HighestDegreeMorphism( cpx_post_pre );
    post := LowestDegreeMorphism( cpx_post_pre );
    
    return PreComposeMorphisms( pre, post );
    
end );

InstallValue( functor_PreCompose,
        CreateHomalgFunctor(
                [ "name", "PreCompose" ],
                [ "category", HOMALG.category ],
                [ "operation", "PreCompose" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant" ], [ IsHomalgComplex and IsATwoSequence ] ] ],
                [ "OnObjects", _Functor_PreCompose_OnObjects ]
                )
        );

functor_PreCompose!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

## for convenience

##
InstallMethod( PreCompose,
        "of two homalg morphisms",
        [ IsHomalgMorphism and IsHomalgLeftObjectOrMorphismOfLeftObjects,
          IsHomalgMorphism ],
        
  function( pre, post )
    
    return PreCompose( AsATwoSequence( pre, post ) );
    
end );

##
InstallMethod( PreCompose,
        "of two homalg morphisms",
        [ IsHomalgMorphism and IsHomalgRightObjectOrMorphismOfRightObjects,
          IsHomalgMorphism ],
        
  function( pre, post )
    
    return PreCompose( AsATwoSequence( post, pre ) );
    
end );

##
InstallMethod( \*,
        "for homalg composable morphisms",
        [ IsHomalgMorphism and IsHomalgLeftObjectOrMorphismOfLeftObjects,
          IsHomalgMorphism ], 1001,	## this must be ranked higher than multiplication with a ring element, which could be an endomorphism
        
  function( pre, post )
    
    ## don't use PreCompose( AsATwoSequence( pre, post ) ) here
    ## as a PreCompose functor for a specific Abelian category
    ## might install its two-argument methods for the operation
    ## PreCompose and not for PreComposeMorphisms causing the
    ## above high-level PreCompose functor to run into a
    ## no-method-found error
    
    return PreCompose( pre, post );
    
end );

##
InstallMethod( \*,
        "for homalg composable morphisms",
        [ IsHomalgMorphism and IsHomalgRightObjectOrMorphismOfRightObjects,
          IsHomalgMorphism ], 1001,	## this must be ranked higher than multiplication with a ring element, which it could be an endomorphism
        
  function( post, pre )
    
    ## don't use PreCompose( AsATwoSequence( post, pre ) ) here
    ## as a PreCompose functor for a specific Abelian category
    ## might install its two-argument methods for the operation
    ## PreCompose and not for PreComposeMorphisms causing the
    ## above high-level PreCompose functor to run into a
    ## no-method-found error
    
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

## for convenience
InstallMethod( \/,
        "for homalg morphisms with the same target",
        [ IsMorphismOfFinitelyGeneratedObjectsRep, IsMorphismOfFinitelyGeneratedObjectsRep ],
        
  function( gamma, beta )
    
    if not IsIdenticalObj( Range( gamma ), Range( beta ) ) then
        Error( "the target objects of the two morphisms are not identical\n" );
    fi;
    
    return PostDivide( gamma, beta );
    
end );

#=======================================================================
# PreDivide
#
# beta is surjective ( cf. [BLH, 2.5,(13): colift] )
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
## PreCompose( phi, psi )
##

InstallFunctorOnObjects( functor_PreCompose );

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
    
    if IsUnit( StructureObject( phi ), a ) then
        if HasIsIsomorphism( phi ) and IsIsomorphism( phi ) then
            SetIsIsomorphism( a_phi, true );
        else
            if HasIsSplitMonomorphism( phi ) and IsSplitMonomorphism( phi ) then
                SetIsSplitMonomorphism( a_phi, true );
            elif HasIsMonomorphism( phi ) and IsMonomorphism( phi ) then
                SetIsMonomorphism( a_phi, true );
            fi;
            
            if HasIsSplitEpimorphism( phi ) and IsSplitEpimorphism( phi ) then
                SetIsSplitEpimorphism( a_phi, true );
            elif HasIsEpimorphism( phi ) and IsEpimorphism( phi ) then
                SetIsEpimorphism( a_phi, true );
            elif HasIsMorphism( phi ) and IsMorphism( phi ) then
                SetIsMorphism( a_phi, true );
            fi;
        fi;
    elif HasIsMorphism( phi ) and IsMorphism( phi ) then
        SetIsMorphism( a_phi, true );
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
    local morphism_aid_pre;
    
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
        
        morphism_aid_pre := PreCompose( MorphismAid( pre ), RemoveMorphismAid( post ) );
        
        if HasMorphismAid( post ) then
            SetMorphismAid( phi, CoproductMorphism( MorphismAid( post ), morphism_aid_pre ) );
        else
            SetMorphismAid( phi, morphism_aid_pre );
        fi;
        
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
        
        SetMorphismAid( phi, MorphismAid( post ) );
        
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
    
    if HasMorphismAid( phi ) and HasMorphismAid( psi ) then
        SetMorphismAid( phi_psi, CoproductMorphism( MorphismAid( phi ), MorphismAid( psi ) ) );
    elif HasMorphismAid( phi ) then
        SetMorphismAid( phi_psi, MorphismAid( phi ) );
    elif HasMorphismAid( psi ) then
        SetMorphismAid( phi_psi, MorphismAid( psi ) );
    fi;
    
    if HasMorphismAid( phi_psi ) then
        Assert( 0, IsIdenticalObj( Range( MorphismAid( phi_psi ) ), Range( phi_psi ) ) );
    fi;
    
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
    
    if HasMorphismAid( phi ) and HasMorphismAid( psi ) then
        SetMorphismAid( phi_psi, ProductMorphism( MorphismAid( phi ), MorphismAid( psi ) ) );
    elif HasMorphismAid( phi ) then
        SetMorphismAid( phi_psi, ProductMorphism( MorphismAid( phi ), TheZeroMorphism( Range( psi ) ) ) );
    elif HasMorphismAid( psi ) then
        SetMorphismAid( phi_psi, ProductMorphism( TheZeroMorphism( Range( phi ) ), MorphismAid( psi ) ) );
    fi;
    
    if HasMorphismAid( phi_psi ) then
        Assert( 0, IsIdenticalObj( Range( MorphismAid( phi_psi ) ), Range( phi_psi ) ) );
    fi;
    
    return phi_psi;
    
end );

