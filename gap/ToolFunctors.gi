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
    local pre, post, C;
    
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
                [ "operation", "AsATwoSequence" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
                [ "2", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
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
## AsChainMapForPullback
##

InstallGlobalFunction( _Functor_AsChainMapForPullback_OnObjects,	### defines: AsChainMapForPullback
  function( phi, beta1 )
    local S, T, c;
    
    S := HomalgComplex( Source( phi ), 0 );
    T := HomalgComplex( beta1 );
    
    c := HomalgChainMap( phi, S, T, 0 );
    
    if HasIsMorphism( phi ) and IsMorphism( phi ) and
       HasIsMorphism( beta1 ) and IsMorphism( beta1 ) then
        SetIsMorphism( c, true );
    elif HasIsGeneralizedMorphism( phi ) and IsGeneralizedMorphism( phi ) and
      HasIsGeneralizedMorphism( beta1 ) and IsGeneralizedMorphism( beta1 ) then
        SetIsGeneralizedMorphism( c, true );
    fi;
    
    SetIsChainMapForPullback( c, true );
    
    return c;
    
end );

InstallValue( functor_AsChainMapForPullback,
        CreateHomalgFunctor(
                [ "name", "AsChainMapForPullback" ],
                [ "operation", "AsChainMapForPullback" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
                [ "2", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
                [ "OnObjects", _Functor_AsChainMapForPullback_OnObjects ]
                )
        );

functor_AsChainMapForPullback!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

## for convenience
InstallMethod( \/,
        "for homalg maps with the same target",
        [ IsMapOfFinitelyGeneratedModulesRep, IsMapOfFinitelyGeneratedModulesRep ],
        
  function( gamma, beta )
    
    if not IsIdenticalObj( Range( gamma ), Range( beta ) ) then
        Error( "the target modules of the two morphisms are not identical\n" );
    fi;
    
    return PostDivide( AsChainMapForPullback( gamma, beta ) );
    
end );

InstallMethod( PostDivide,
        "for homalg maps with the same target",
        [ IsMapOfFinitelyGeneratedModulesRep, IsMapOfFinitelyGeneratedModulesRep ],
        
  function( gamma, beta )
    
    if not IsIdenticalObj( Range( gamma ), Range( beta ) ) then
        Error( "the target modules of the two morphisms are not identical\n" );
    fi;
    
    return PostDivide( AsChainMapForPullback( gamma, beta ) );
    
end );

##
InstallMethod( PreDivide,
        "for homalg maps with the same source",
        [ IsMapOfFinitelyGeneratedModulesRep, IsMapOfFinitelyGeneratedModulesRep ],
        
  function( epsilon, eta )
    
    if not IsIdenticalObj( Source( epsilon ), Source( eta ) ) then
        Error( "the source modules of the two morphisms are not identical\n" );
    fi;
    
    return PreDivide( AsChainMapForPushout( epsilon, eta ) );
    
end );

##
## AsChainMapForPushout
##

InstallGlobalFunction( _Functor_AsChainMapForPushout_OnObjects,	### defines: AsChainMapForPushout
  function( alpha1, psi )
    local S, T, c;
    
    S := HomalgComplex( alpha1 );
    T := HomalgComplex( Range( psi ), 1 );
    
    c := HomalgChainMap( psi, S, T, 1 );
    
    if HasIsMorphism( psi ) and IsMorphism( psi ) and
       HasIsMorphism( alpha1 ) and IsMorphism( alpha1 ) then
        SetIsMorphism( c, true );
    elif HasIsGeneralizedMorphism( psi ) and IsGeneralizedMorphism( psi ) and
      HasIsGeneralizedMorphism( alpha1 ) and IsGeneralizedMorphism( alpha1 ) then
        SetIsGeneralizedMorphism( c, true );
    fi;
    
    SetIsChainMapForPushout( c, true );
    
    return c;
    
end );

InstallValue( functor_AsChainMapForPushout,
        CreateHomalgFunctor(
                [ "name", "AsChainMapForPushout" ],
                [ "operation", "AsChainMapForPushout" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
                [ "2", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
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
## AsChainMapForPullback( phi, beta1 )
##

InstallFunctorOnObjects( functor_AsChainMapForPullback );

##
## AsChainMapForPushout( alpha1, psi )
##

InstallFunctorOnObjects( functor_AsChainMapForPushout );

