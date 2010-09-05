#############################################################################
##
##  ToolFunctors.gi             Modules package              Mohamed Barakat
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
## TheZeroMorphism
##

InstallGlobalFunction( _Functor_TheZeroMorphism_OnModules,	### defines: TheZeroMorphism
  function( M, N )
    
    return HomalgZeroMap( M, N );
    
end );

InstallValue( functor_TheZeroMorphism_for_fp_modules,
        CreateHomalgFunctor(
                [ "name", "TheZeroMorphism" ],
                [ "category", HOMALG_MODULES.category ],
                [ "operation", "TheZeroMorphism" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "contravariant" ] ] ],
                [ "2", [ [ "covariant" ] ] ],
                [ "OnObjects", _Functor_TheZeroMorphism_OnModules ]
                )
        );

functor_TheZeroMorphism_for_fp_modules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

##
## MulMorphism
##

InstallGlobalFunction( _Functor_MulMorphism_OnMaps,	### defines: MulMorphism
  function( a, phi )
    local a_phi;
    
    a_phi := HomalgMap( a * MatrixOfMap( phi ), Source( phi ), Range( phi ) );
    
    return SetPropertiesOfMulMorphism( a, phi, a_phi );
    
end );

InstallValue( functor_MulMorphism_for_maps_of_fg_modules,
        CreateHomalgFunctor(
                [ "name", "MulMorphism" ],
                [ "category", HOMALG_MODULES.category ],
                [ "operation", "MulMorphism" ],	## don't install the method for \* automatically, since it needs to be endowed with a high rank (see below)
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsRingElement ] ] ],
                [ "2", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
                [ "OnObjects", _Functor_MulMorphism_OnMaps ]
                )
        );

functor_MulMorphism_for_maps_of_fg_modules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

## for convenience
InstallMethod( \*,
        "of two homalg maps",
        [ IsRingElement, IsMapOfFinitelyGeneratedModulesRep ], 999, ## it could otherwise run into the method ``PROD: negative integer * additive element with inverse'', value: 24
        
  function( a, phi )
    
    return MulMorphism( a, phi );
    
end );

##
## AddMorphisms
##

InstallGlobalFunction( _Functor_AddMorphisms_OnMaps,	### defines: AddMorphisms
  function( phi1, phi2 )
    local phi;
    
    if not AreComparableMorphisms( phi1, phi2 ) then
        return Error( "the two maps are not comparable" );
    fi;
    
    phi := HomalgMap( MatrixOfMap( phi1 ) + MatrixOfMap( phi2 ), Source( phi1 ), Range( phi1 ) );
    
    return SetPropertiesOfSumMorphism( phi1, phi2, phi );
    
end );

InstallValue( functor_AddMorphisms_for_maps_of_fg_modules,
        CreateHomalgFunctor(
                [ "name", "+" ],
                [ "category", HOMALG_MODULES.category ],
                [ "operation", "+" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
                [ "2", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
                [ "OnObjects", _Functor_AddMorphisms_OnMaps ]
                )
        );

functor_AddMorphisms_for_maps_of_fg_modules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

##
## SubMorphisms
##

InstallGlobalFunction( _Functor_SubMorphisms_OnMaps,	### defines: SubMorphisms
  function( phi1, phi2 )
    local phi;
    
    if not AreComparableMorphisms( phi1, phi2 ) then
        return Error( "the two maps are not comparable" );
    fi;
    
    phi := HomalgMap( MatrixOfMap( phi1 ) - MatrixOfMap( phi2 ), Source( phi1 ), Range( phi1 ) );
    
    return SetPropertiesOfDifferenceMorphism( phi1, phi2, phi );
    
end );

InstallValue( functor_SubMorphisms_for_maps_of_fg_modules,
        CreateHomalgFunctor(
                [ "name", "-" ],
                [ "category", HOMALG_MODULES.category ],
                [ "operation", "-" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
                [ "2", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
                [ "OnObjects", _Functor_SubMorphisms_OnMaps ]
                )
        );

functor_SubMorphisms_for_maps_of_fg_modules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

##
## Compose
##

InstallGlobalFunction( _Functor_Compose_OnMaps,	### defines: Compose
  function( cpx_post_pre )
    local pre, post, S, T, phi;
    
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
    
    return SetPropertiesOfComposedMorphism( pre, post, phi );
    
end );

InstallValue( functor_Compose_for_maps_of_fg_modules,
        CreateHomalgFunctor(
                [ "name", "Compose" ],
                [ "category", HOMALG_MODULES.category ],
                [ "operation", "Compose" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant" ], [ IsHomalgComplex and IsATwoSequence ] ] ],
                [ "OnObjects", _Functor_Compose_OnMaps ]
                )
        );

functor_Compose_for_maps_of_fg_modules!.ContainerForWeakPointersOnComputedBasicObjects :=
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
## CoproductMorphism
##

InstallGlobalFunction( _Functor_CoproductMorphism_OnMaps,	### defines: CoproductMorphism
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
    p := Genesis( SpS ).("PositionOfTheDefaultPresentationOfTheOutput");
    
    phi_psi := HomalgMap( phi_psi, [ SpS, p ], T );
    
    return SetPropertiesOfCoproductMorphism( phi, psi, phi_psi );
    
end );

InstallValue( functor_CoproductMorphism_for_maps_of_fg_modules,
        CreateHomalgFunctor(
                [ "name", "CoproductMorphism" ],
                [ "category", HOMALG_MODULES.category ],
                [ "operation", "CoproductMorphism" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
                [ "2", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
                [ "OnObjects", _Functor_CoproductMorphism_OnMaps ]
                )
        );

functor_CoproductMorphism_for_maps_of_fg_modules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

##
## ProductMorphism
##

InstallGlobalFunction( _Functor_ProductMorphism_OnMaps,	### defines: ProductMorphism
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
    p := Genesis( TpT ).("PositionOfTheDefaultPresentationOfTheOutput");
    
    phi_psi := HomalgMap( phi_psi, S, [ TpT, p ] );
    
    return SetPropertiesOfProductMorphism( phi, psi, phi_psi );
    
end );

InstallValue( functor_ProductMorphism_for_maps_of_fg_modules,
        CreateHomalgFunctor(
                [ "name", "ProductMorphism" ],
                [ "category", HOMALG_MODULES.category ],
                [ "operation", "ProductMorphism" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
                [ "2", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
                [ "OnObjects", _Functor_ProductMorphism_OnMaps ]
                )
        );

functor_ProductMorphism_for_maps_of_fg_modules!.ContainerForWeakPointersOnComputedBasicObjects :=
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

InstallGlobalFunction( _Functor_PostDivide_OnMaps,	### defines: PostDivide
  function( chm_pb )
    local gamma, beta, N, psi, M_;
    
    gamma := LowestDegreeMorphism( chm_pb );
    beta := LowestDegreeMorphism( Range( chm_pb ) );
    
    N := Range( beta );
    
    ## thanks Yunis, Yusif and Mariam for playing that other saturday
    ## so cheerfully and loudly, inspiring me to this idea :-)
    ## this is the most decisive part of the code
    ## (the idea of generalized embeddings in action):
    if HasMorphismAid( beta ) then
        N := UnionOfRelations( MorphismAid( beta ) );	## this replaces [BR08, Footnote 13]
        if HasMorphismAid( gamma ) then
            N := UnionOfRelations( N, MatrixOfMap( MorphismAid( gamma ) ) );
        fi;
    elif HasMorphismAid( gamma ) then
        N := UnionOfRelations( MorphismAid( gamma ) );
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
        
    elif HasMorphismAid( gamma ) and not HasMorphismAid( beta ) then
        
        #### we cannot activate the following lines, since MorphismAid( gamma ) / beta fails in general (cf. the example Grothendieck.g)
        #### instead one should activate them where they make sense (cf. SpectralSequences.gi)
        #SetMorphismAid( psi, MorphismAid( gamma ) / beta );
        #SetIsGeneralizedMorphism( psi, true );
        
    fi;
    
    return psi;
    
end );

InstallValue( functor_PostDivide_for_maps_of_fg_modules,
        CreateHomalgFunctor(
                [ "name", "PostDivide" ],
                [ "category", HOMALG_MODULES.category ],
                [ "operation", "PostDivide" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant" ], [ IsHomalgChainMap and IsChainMapForPullback ] ] ],
                [ "OnObjects", _Functor_PostDivide_OnMaps ]
                )
        );

functor_PostDivide_for_maps_of_fg_modules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

####################################
#
# methods for operations & attributes:
#
####################################

##
## TheZeroMorphism( M, N )
##

InstallFunctorOnObjects( functor_TheZeroMorphism_for_fp_modules );

##
## MulMorphism( a, phi ) = a * phi
##

InstallFunctorOnObjects( functor_MulMorphism_for_maps_of_fg_modules );

##
## phi1 + phi2
##

InstallFunctorOnObjects( functor_AddMorphisms_for_maps_of_fg_modules );

##
## phi1 - phi2
##

InstallFunctorOnObjects( functor_SubMorphisms_for_maps_of_fg_modules );

##
## Compose( phi, psi ) = phi * psi
##

InstallFunctorOnObjects( functor_Compose_for_maps_of_fg_modules );

##
## CoproductMorphism( phi, psi )
##

InstallFunctorOnObjects( functor_CoproductMorphism_for_maps_of_fg_modules );

##
## ProductMorphism( phi, psi )
##

InstallFunctorOnObjects( functor_ProductMorphism_for_maps_of_fg_modules );

##
## gamma / beta = PostDivide( gamma, beta )
##

InstallFunctorOnObjects( functor_PostDivide_for_maps_of_fg_modules );

