#############################################################################
##
##  ToolFunctors.gi             homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
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
## AsATwoSequence
##

InstallGlobalFunction( _Functor_AsATwoSequence_OnObjects,	### defines: AsATwoSequence
  function( phi, psi )
    local R, pre, post, C;
    
    R := HomalgRing( phi );
    
    if not IsIdenticalObj( R, HomalgRing( psi ) ) then
        Error( "the rings of the two morphisms are not identical\n" );
    fi;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) and IsHomalgLeftObjectOrMorphismOfLeftObjects( psi ) then
        pre := phi;
        post := psi;
    elif IsHomalgRightObjectOrMorphismOfRightObjects( phi ) and IsHomalgRightObjectOrMorphismOfRightObjects( psi ) then
        pre := psi;
        post := phi;
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
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsHomalgMap ] ] ],
                [ "2", [ [ "covariant" ], [ IsHomalgMap ] ] ],
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
    
    return AsATwoSequence( HighestDegreeMorphismInComplex( C ), LowestDegreeMorphismInComplex( C ) );
    
end );

##
InstallMethod( AsATwoSequence,
        "for complexes",
        [ IsCocomplexOfFinitelyPresentedObjectsRep and
          IsHomalgRightObjectOrMorphismOfRightObjects and
          IsATwoSequence ],
        
  function( C )
    
    return AsATwoSequence( HighestDegreeMorphismInComplex( C ), LowestDegreeMorphismInComplex( C ) );
    
end );

##
InstallMethod( AsATwoSequence,
        "for complexes",
        [ IsCocomplexOfFinitelyPresentedObjectsRep and
          IsHomalgLeftObjectOrMorphismOfLeftObjects and
          IsATwoSequence ],
        
  function( C )
    
    return AsATwoSequence( LowestDegreeMorphismInComplex( C ), HighestDegreeMorphismInComplex( C ) );
    
end );

##
InstallMethod( AsATwoSequence,
        "for complexes",
        [ IsComplexOfFinitelyPresentedObjectsRep and
          IsHomalgRightObjectOrMorphismOfRightObjects and
          IsATwoSequence ],
        
  function( C )
    
    return AsATwoSequence( LowestDegreeMorphismInComplex( C ), HighestDegreeMorphismInComplex( C ) );
    
end );

##
## Compose
##

InstallGlobalFunction( _Functor_Compose_OnObjects,	### defines: Compose
  function( cpx_post_pre )
    local pre, post, phi;
    
    if not ( IsHomalgComplex( cpx_post_pre ) and Length( ObjectDegreesOfComplex( cpx_post_pre ) ) = 3 ) then
        Error( "expecting a complex containing two morphisms\n" );
    fi;
    
    pre := HighestDegreeMorphismInComplex( cpx_post_pre );
    post := LowestDegreeMorphismInComplex( cpx_post_pre );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( pre ) then
        phi := HomalgMap( MatrixOfMap( pre ) * MatrixOfMap( post ), Source( pre ), Range( post ) );
    else
        phi := HomalgMap( MatrixOfMap( post ) * MatrixOfMap( pre ), Source( pre ), Range( post ) );
    fi;
    
    if HasIsMonomorphism( pre ) and IsMonomorphism( pre ) and
       HasIsMonomorphism( post ) and IsMonomorphism( post ) then
        SetIsMonomorphism( phi, true );
    elif HasIsEpimorphism( pre ) and IsEpimorphism( pre ) and
      HasIsEpimorphism( post ) and IsEpimorphism( post ) then
        SetIsEpimorphism( phi, true );
    elif HasIsMorphism( pre ) and IsMorphism( pre ) and
      HasIsMorphism( post ) and IsMorphism( post ) then
        SetIsMorphism( phi, true );
    fi;
    
    return phi;
    
end );

InstallValue( functor_Compose,
        CreateHomalgFunctor(
                [ "name", "Compose" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant" ], [ IsHomalgComplex and IsATwoSequence ] ] ],
                [ "OnObjects", _Functor_Compose_OnObjects ]
                )
        );

functor_Compose!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

## for convenience
InstallMethod( \*,
        "for homalg composable maps",
        [ IsMapOfFinitelyGeneratedModulesRep and IsHomalgLeftObjectOrMorphismOfLeftObjects,
          IsMapOfFinitelyGeneratedModulesRep ], 1001,	## this must be ranked higher than multiplication with a ring element, which could be an endomorphism
        
  function( phi1, phi2 )
    
    if not AreComposableMorphisms( phi1, phi2 ) then
        Error( "the two morphisms are not composable, since the target of the left one and the source of right one are not \033[01midentical\033[0m\n" );
    fi;
    
    return Compose( AsATwoSequence( phi1, phi2 ) );
    
end );

InstallMethod( \*,
        "for homalg composable maps",
        [ IsMapOfFinitelyGeneratedModulesRep and IsHomalgRightObjectOrMorphismOfRightObjects,
          IsMapOfFinitelyGeneratedModulesRep ], 1001,	## this must be ranked higher than multiplication with a ring element, which it could be an endomorphism
        
  function( phi2, phi1 )
    
    if not AreComposableMorphisms( phi2, phi1 ) then
        Error( "the two morphisms are not composable, since the source of the left one and the target of the right one are not \033[01midentical\033[0m\n" );
    fi;
    
    return Compose( AsATwoSequence( phi2, phi1 ) );
    
end );

##
## AsChainMapForPullback
##

InstallGlobalFunction( _Functor_AsChainMapForPullback_OnObjects,	### defines: AsChainMapForPullback
  function( phi, beta1 )
    local R, S, T, c;
    
    R := HomalgRing( phi );
    
    if not IsIdenticalObj( R, HomalgRing( beta1 ) ) then
        Error( "the rings of the two morphisms are not identical\n" );
    fi;
    
    S := HomalgComplex( Source( phi ), 0 );
    T := HomalgComplex( beta1 );
    
    c := HomalgChainMap( phi, S, T, 0 );
    
    if HasIsMorphism( phi ) and IsMorphism( phi ) and
       HasIsMorphism( beta1 ) and IsMorphism( beta1 ) then
        SetIsMorphism( c, true );
    fi;
    
    SetIsChainMapForPullback( c, true );
    
    return c;
    
end );

InstallValue( functor_AsChainMapForPullback,
        CreateHomalgFunctor(
                [ "name", "AsChainMapForPullback" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsHomalgMap ] ] ],
                [ "2", [ [ "covariant" ], [ IsHomalgMap ] ] ],
                [ "OnObjects", _Functor_AsChainMapForPullback_OnObjects ]
                )
        );

functor_AsChainMapForPullback!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

##
## AsChainMapForPushout
##

InstallGlobalFunction( _Functor_AsChainMapForPushout_OnObjects,	### defines: AsChainMapForPushout
  function( alpha1, psi )
    local R, S, T, c;
    
    R := HomalgRing( psi );
    
    if not IsIdenticalObj( R, HomalgRing( alpha1 ) ) then
        Error( "the rings of the two morphisms are not identical\n" );
    fi;
    
    S := HomalgComplex( alpha1 );
    T := HomalgComplex( Range( psi ) );
    
    c := HomalgChainMap( psi, S, T, 1 );
    
    if HasIsMorphism( psi ) and IsMorphism( psi ) and
       HasIsMorphism( alpha1 ) and IsMorphism( alpha1 ) then
        SetIsMorphism( c, true );
    fi;
    
    SetIsChainMapForPushout( c, true );
    
    return c;
    
end );

InstallValue( functor_AsChainMapForPushout,
        CreateHomalgFunctor(
                [ "name", "AsChainMapForPushout" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsHomalgMap ] ] ],
                [ "2", [ [ "covariant" ], [ IsHomalgMap ] ] ],
                [ "OnObjects", _Functor_AsChainMapForPushout_OnObjects ]
                )
        );

functor_AsChainMapForPushout!.ContainerForWeakPointersOnComputedBasicObjects :=
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
## Compose( phi, psi )
##

InstallFunctorOnObjects( functor_Compose );

##
## AsChainMapForPullback( phi, beta1 )
##

InstallFunctorOnObjects( functor_AsChainMapForPullback );

##
## AsChainMapForPushout( alpha1, psi )
##

InstallFunctorOnObjects( functor_AsChainMapForPushout );

