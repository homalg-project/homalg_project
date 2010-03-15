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
## TheZeroMorphism
##

InstallGlobalFunction( _Functor_TheZeroMorphism_OnObjects,	### defines: TheZeroMorphism
  function( M, N )
    
    return HomalgZeroMap( M, N );
    
end );

InstallValue( functor_TheZeroMorphism,
        CreateHomalgFunctor(
                [ "name", "TheZeroMorphism" ],
                [ "operation", "TheZeroMorphism" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "contravariant" ] ] ],
                [ "2", [ [ "covariant" ] ] ],
                [ "OnObjects", _Functor_TheZeroMorphism_OnObjects ]
                )
        );

functor_TheZeroMorphism!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

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
## MulMap
##

InstallGlobalFunction( _Functor_MulMap_OnObjects,	### defines: MulMap
  function( a, phi )
    local a_phi;
    
    a_phi := HomalgMap( a * MatrixOfMap( phi ), Source( phi ), Range( phi ) );
    
    if IsUnit( HomalgRing( phi ), a ) then
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

InstallValue( functor_MulMap,
        CreateHomalgFunctor(
                [ "name", "MulMap" ],
                [ "operation", "MulMap" ],	## don't install the method for \* automatically, since it needs to be endowed with a high rank (see below)
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsRingElement ] ] ],
                [ "2", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
                [ "OnObjects", _Functor_MulMap_OnObjects ]
                )
        );

functor_MulMap!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

## for convenience
InstallMethod( \*,
        "of two homalg maps",
        [ IsRingElement, IsMapOfFinitelyGeneratedModulesRep ], 999, ## it could otherwise run into the method ``PROD: negative integer * additive element with inverse'', value: 24
        
  function( a, phi )
    
    return MulMap( a, phi );
    
end );

##
## AddMap
##

InstallGlobalFunction( _Functor_AddMap_OnObjects,	### defines: AddMap
  function( phi1, phi2 )
    local phi;
    
    if not AreComparableMorphisms( phi1, phi2 ) then
        return Error( "the two maps are not comparable" );
    fi;
    
    phi := HomalgMap( MatrixOfMap( phi1 ) + MatrixOfMap( phi2 ), Source( phi1 ), Range( phi1 ) );
    
    if HasIsMorphism( phi1 ) and IsMorphism( phi1 ) and
       HasIsMorphism( phi2 ) and IsMorphism( phi2 ) then
        SetIsMorphism( phi, true );
    fi;
    
    return phi;
    
end );

InstallValue( functor_AddMap,
        CreateHomalgFunctor(
                [ "name", "+" ],
                [ "operation", "+" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
                [ "2", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
                [ "OnObjects", _Functor_AddMap_OnObjects ]
                )
        );

functor_AddMap!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

##
## SubMap
##

InstallGlobalFunction( _Functor_SubMap_OnObjects,	### defines: SubMap
  function( phi1, phi2 )
    local phi;
    
    if not AreComparableMorphisms( phi1, phi2 ) then
        return Error( "the two maps are not comparable" );
    fi;
    
    phi := HomalgMap( MatrixOfMap( phi1 ) - MatrixOfMap( phi2 ), Source( phi1 ), Range( phi1 ) );
    
    if HasIsMorphism( phi1 ) and IsMorphism( phi1 ) and
       HasIsMorphism( phi2 ) and IsMorphism( phi2 ) then
        SetIsMorphism( phi, true );
    fi;
    
    return phi;
    
end );

InstallValue( functor_SubMap,
        CreateHomalgFunctor(
                [ "name", "-" ],
                [ "operation", "-" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
                [ "2", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
                [ "OnObjects", _Functor_SubMap_OnObjects ]
                )
        );

functor_SubMap!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

##
## Compose
##

InstallGlobalFunction( _Functor_Compose_OnObjects,	### defines: Compose
  function( cpx_post_pre )
    local pre, post, S, T, phi, morphism_aid_pre;
    
    if not ( IsHomalgComplex( cpx_post_pre ) and Length( ObjectDegreesOfComplex( cpx_post_pre ) ) = 3 ) then
        Error( "expecting a complex containing two morphisms\n" );
    fi;
    
    pre := HighestDegreeMorphism( cpx_post_pre );
    post := LowestDegreeMorphism( cpx_post_pre );
    
    S := Source( pre );
    T := Range( post );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( pre ) then
        phi := HomalgMap( MatrixOfMap( pre ) * MatrixOfMap( post ), S, T );
    else
        phi := HomalgMap( MatrixOfMap( post ) * MatrixOfMap( pre ), S, T );
    fi;
    
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
    if HasMorphismAidMap( pre ) then
        
        morphism_aid_pre := PreCompose( MorphismAidMap( pre ), RemoveMorphismAidMap( post ) );
        
        if HasMorphismAidMap( post ) then
            SetMorphismAidMap( phi, StackMaps( MorphismAidMap( post ), morphism_aid_pre ) );
        else
            SetMorphismAidMap( phi, morphism_aid_pre );
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
        
    elif HasMorphismAidMap( post ) then
        
        SetMorphismAidMap( phi, MorphismAidMap( post ) );
        
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

InstallValue( functor_Compose,
        CreateHomalgFunctor(
                [ "name", "Compose" ],
                [ "operation", "Compose" ],
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

##
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
## StackMaps
##

InstallGlobalFunction( _Functor_StackMaps_OnObjects,	### defines: StackMaps
  function( phi, psi )
    local T, phi_psi, SpS, p;
    
    T := Range( phi );
    
    if not IsIdenticalObj( T, Range( psi ) ) then
        Error( "the two morphisms must have identical target modules\n" );
    fi;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
        phi_psi := UnionOfRows( MatrixOfMap( phi ), MatrixOfMap( psi ) );
    else
        phi_psi := UnionOfColumns( MatrixOfMap( phi ), MatrixOfMap( psi ) );
    fi;
    
    SpS := Source( phi ) + Source( psi );
    
    ## get the position of the set of relations immediately after creating SpS;
    p := Genesis( SpS ).("PositionOfTheDefaultSetOfRelationsOfTheOutput");
    
    phi_psi := HomalgMap( phi_psi, [ SpS, p ], T );
    
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

InstallValue( functor_StackMaps,
        CreateHomalgFunctor(
                [ "name", "StackMaps" ],
                [ "operation", "StackMaps" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
                [ "2", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
                [ "OnObjects", _Functor_StackMaps_OnObjects ]
                )
        );

functor_StackMaps!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

##
## AugmentMaps
##

InstallGlobalFunction( _Functor_AugmentMaps_OnObjects,	### defines: AugmentMaps
  function( phi, psi )
    local S, phi_psi, TpT, p;
    
    S := Source( phi );
    
    if not IsIdenticalObj( S, Source( psi ) ) then
        Error( "the two morphisms must have identical source modules\n" );
    fi;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
        phi_psi := UnionOfColumns( MatrixOfMap( phi ), MatrixOfMap( psi ) );
    else
        phi_psi := UnionOfRows( MatrixOfMap( phi ), MatrixOfMap( psi ) );
    fi;
    
    TpT := Range( phi ) + Range( psi );
    
    ## get the position of the set of relations immediately after creating TpT;
    p := Genesis( TpT ).("PositionOfTheDefaultSetOfRelationsOfTheOutput");
    
    phi_psi := HomalgMap( phi_psi, S, [ TpT, p ] );
    
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

InstallValue( functor_AugmentMaps,
        CreateHomalgFunctor(
                [ "name", "AugmentMaps" ],
                [ "operation", "AugmentMaps" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
                [ "2", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
                [ "OnObjects", _Functor_AugmentMaps_OnObjects ]
                )
        );

functor_AugmentMaps!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

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
#
# row convention (left modules): psi := gamma * beta^(-1)	( -> RightDivide )
# column convention (right modules): psi := beta^(-1) * gamma	( -> LeftDivide )
#_______________________________________________________________________

##
## PostDivide
##

InstallGlobalFunction( _Functor_PostDivide_OnObjects,	### defines: PostDivide
  function( chm_pb )
    local gamma, beta, N, psi, M_;
    
    gamma := LowestDegreeMorphism( chm_pb );
    beta := LowestDegreeMorphism( Range( chm_pb ) );
    
    N := Range( beta );
    
    ## thanks Yunis, Yusif and Mariam for playing that other saturday
    ## so cheerfully and loudly, inspiring me to this idea :-)
    ## this is the most decisive part of the code
    ## (the idea of generalized embeddings in action):
    if HasMorphismAidMap( beta ) then
        N := UnionOfRelations( MorphismAidMap( beta ) );	## this replaces [BR08, Footnote 13]
        if HasMorphismAidMap( gamma ) then
            N := UnionOfRelations( N, MatrixOfMap( MorphismAidMap( gamma ) ) );
        fi;
    elif HasMorphismAidMap( gamma ) then
        N := UnionOfRelations( MorphismAidMap( gamma ) );
    else
        N := RelationsOfModule( N );
    fi;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( chm_pb ) then
        
        psi := RightDivide( MatrixOfMap( gamma ), MatrixOfMap( beta ), N );
        
        if IsBool( psi ) then
            Error( "the second argument of RightDivide is not a right factor of the first modulo the third, i.e. the rows of the second and third argument are not a generating set!\n" );
        fi;
        
    else
        
        psi := LeftDivide( MatrixOfMap( beta ), MatrixOfMap( gamma ), N );
        
        if IsBool( psi ) then
            Error( "the first argument of LeftDivide is not a left factor of the second modulo the third, i.e. the columns of the first and third arguments are not a generating set!\n" );
        fi;
        
    fi;
    
    M_ := Source( gamma );
    
    psi := HomalgMap( psi, M_, Source( beta ) );
    
    if HasIsMorphism( gamma ) and IsMorphism( gamma ) and
       ( ( HasNrRelations( M_ ) and NrRelations( M_ ) = 0 ) or		## [BR08, Subsection 3.1.1,(1)]
         ( HasIsMonomorphism( beta ) and IsMonomorphism( beta ) ) or	## [BR08, Subsection 3.1.1,(2)]
         ( HasIsGeneralizedMonomorphism( beta ) and IsGeneralizedMonomorphism( beta ) ) ) then	## "generalizes" [BR08, Subsection 3.1.1,(2)]
        
        Assert( 2, IsMorphism( psi ) );
        
        SetIsMorphism( psi, true );
        
    elif HasMorphismAidMap( gamma ) and not HasMorphismAidMap( beta ) then
        
        #### we cannot activate the following lines, since MorphismAidMap( gamma ) / beta fails in general (cf. the example Grothendieck.g)
        #### instead one should activate them where they make sense (cf. SpectralSequences.gi)
        #SetMorphismAidMap( psi, MorphismAidMap( gamma ) / beta );
        #SetIsGeneralizedMorphism( psi, true );
        
    fi;
    
    return psi;
    
end );

InstallValue( functor_PostDivide,
        CreateHomalgFunctor(
                [ "name", "PostDivide" ],
                [ "operation", "PostDivide" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant" ], [ IsHomalgChainMap and IsChainMapForPullback ] ] ],
                [ "OnObjects", _Functor_PostDivide_OnObjects ]
                )
        );

functor_PostDivide!.ContainerForWeakPointersOnComputedBasicObjects :=
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
# row convention (left modules): eta0 := epsilon^(-1) * eta
# column convention (right modules): eta0 := eta * epsilon^(-1)
#_______________________________________________________________________

##
## PreDivide
##

InstallGlobalFunction( _Functor_PreDivide_OnObjects,	### defines: PreDivide
  function( chm_po )
    local epsilon, eta, gen_iso, eta0;
    
    epsilon := HighestDegreeMorphism( Source( chm_po ) );
    eta := HighestDegreeMorphism( chm_po );
    
    if not ( HasIsEpimorphism( epsilon ) and IsEpimorphism( epsilon ) ) then
        Error( "the first morphism is either not an epimorphism or not yet known to be one\n" );
    fi;
    
    ## this is in general not a morphism;
    ## it would be a generalized isomorphism if we would
    ## add the appropriate morphism aid, but we don't need this here
    gen_iso := GeneralizedInverse( epsilon );
    
    ## make a copy without the morphism aid map
    gen_iso := RemoveMorphismAidMap( gen_iso );
    
    eta0 := PreCompose( gen_iso, eta );
    
    ## check assertion
    Assert( 2, IsMorphism( eta0 ) );
    
    SetIsMorphism( eta0, true );
    
    return eta0;
    
end );

InstallValue( functor_PreDivide,
        CreateHomalgFunctor(
                [ "name", "PreDivide" ],
                [ "operation", "PreDivide" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant" ], [ IsHomalgChainMap and IsChainMapForPushout ] ] ],
                [ "OnObjects", _Functor_PreDivide_OnObjects ]
                )
        );

functor_PreDivide!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

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
## TheZeroMorphism( M, N )
##

InstallFunctorOnObjects( functor_TheZeroMorphism );

##
## AsATwoSequence( phi, psi )
##

InstallFunctorOnObjects( functor_AsATwoSequence );

##
## MulMap( a, phi ) = a * phi
##

InstallFunctorOnObjects( functor_MulMap );

##
## phi1 + phi2
##

InstallFunctorOnObjects( functor_AddMap );

##
## phi1 - phi2
##

InstallFunctorOnObjects( functor_SubMap );

##
## Compose( phi, psi ) = phi * psi
##

InstallFunctorOnObjects( functor_Compose );

##
## StackMaps( phi, psi )
##

InstallFunctorOnObjects( functor_StackMaps );

##
## AugmentMaps( phi, psi )
##

InstallFunctorOnObjects( functor_AugmentMaps );

##
## AsChainMapForPullback( phi, beta1 )
##

InstallFunctorOnObjects( functor_AsChainMapForPullback );

##
## gamma / beta = PostDivide( gamma, beta )
##

InstallFunctorOnObjects( functor_PostDivide );

##
## PreDivide( gamma, beta )
##

InstallFunctorOnObjects( functor_PreDivide );

##
## AsChainMapForPushout( alpha1, psi )
##

InstallFunctorOnObjects( functor_AsChainMapForPushout );

