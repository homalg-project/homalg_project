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
                [ "2", [ [ "covariant" ], [ IsFinitelyPresentedModuleRep and AdmissibleInputForHomalgFunctors ] ] ],
                [ "OnObjects", _Functor_TheZeroMorphism_OnModules ]
                )
        );

#functor_TheZeroMorphism_for_fp_modules!.ContainerForWeakPointersOnComputedBasicObjects := true;

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
                [ "2", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep and AdmissibleInputForHomalgFunctors ] ] ],
                [ "OnObjects", _Functor_MulMorphism_OnMaps ]
                )
        );

#functor_MulMorphism_for_maps_of_fg_modules!.ContainerForWeakPointersOnComputedBasicObjects := true;

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
                [ "1", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep and AdmissibleInputForHomalgFunctors ] ] ],
                [ "2", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep and AdmissibleInputForHomalgFunctors ] ] ],
                [ "OnObjects", _Functor_AddMorphisms_OnMaps ],
                [ "DontCompareEquality", true ]
                )
        );

functor_AddMorphisms_for_maps_of_fg_modules!.ContainerForWeakPointersOnComputedBasicObjects := false;

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
                [ "1", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep and AdmissibleInputForHomalgFunctors ] ] ],
                [ "2", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep and AdmissibleInputForHomalgFunctors ] ] ],
                [ "OnObjects", _Functor_SubMorphisms_OnMaps ],
                [ "DontCompareEquality", true ]
                )
        );

functor_SubMorphisms_for_maps_of_fg_modules!.ContainerForWeakPointersOnComputedBasicObjects := false;

##
## PreCompose
##

InstallGlobalFunction( _Functor_PreCompose_OnMaps,	### defines: PreCompose
  function( pre, post )
    local S, T, phi;
    
    S := Source( pre );
    T := Range( post );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( pre ) then
        phi := HomalgMap( MatrixOfMap( pre ) * MatrixOfMap( post ), S, T );
    else
        phi := HomalgMap( MatrixOfMap( post ) * MatrixOfMap( pre ), S, T );
    fi;
    
    return GeneralizedComposedMorphism( pre, post, phi );
    
end );

InstallValue( functor_PreCompose_for_maps_of_fg_modules,
        CreateHomalgFunctor(
                [ "name", "PreCompose" ],
                [ "category", HOMALG_MODULES.category ],
                [ "operation", "PreCompose" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
                [ "2", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
                [ "OnObjects", _Functor_PreCompose_OnMaps ]
                )
        );

#functor_PreCompose_for_maps_of_fg_modules!.ContainerForWeakPointersOnComputedBasicObjects := true;

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
    p := Genesis( SpS )[1][1].("PositionOfTheDefaultPresentationOfTheOutput");
    
    phi_psi := HomalgMap( phi_psi, [ SpS, p ], T );
    
    return GeneralizedCoproductMorphism( phi, psi, phi_psi );
    
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

#functor_CoproductMorphism_for_maps_of_fg_modules!.ContainerForWeakPointersOnComputedBasicObjects := true;

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
    p := Genesis( TpT )[1][1].("PositionOfTheDefaultPresentationOfTheOutput");
    
    phi_psi := HomalgMap( phi_psi, S, [ TpT, p ] );
    
    return GeneralizedProductMorphism( phi, psi, phi_psi );
    
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

#functor_ProductMorphism_for_maps_of_fg_modules!.ContainerForWeakPointersOnComputedBasicObjects := true;

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

InstallGlobalFunction( _Functor_PostDivide_OnMaps,  ### defines: PostDivide
  function( gamma, beta )
    local N, psi, M_;
    
    if HasMorphismAid( gamma ) or HasMorphismAid( beta ) then
        TryNextMethod();
    fi;
    
    N := RelationsOfModule( Range( beta ) );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( gamma ) then
        
        psi := RightDivide( MatrixOfMap( gamma ), MatrixOfMap( beta ), N );
        
    else
        
        psi := LeftDivide( MatrixOfMap( beta ), MatrixOfMap( gamma ), N );
        
    fi;
    
    if IsBool( psi ) then
        return psi;
    fi;
    
    M_ := Source( gamma );
    
    psi := HomalgMap( psi, M_, Source( beta ) );
    
    if HasIsMorphism( gamma ) and IsMorphism( gamma ) and
      ( HasIsFree( M_ ) and IsFree( M_ ) ) then ## [BR08, Subsection 3.1.1,(1)]
        
        Assert( 4, IsMorphism( psi ) );
        SetIsMorphism( psi, true );
    
    fi;
    
    psi := SetPropertiesOfPostDivide( gamma, beta, psi );
    
    return psi;
    
end );

InstallValue( functor_PostDivide_for_maps_of_fg_modules,
        CreateHomalgFunctor(
                [ "name", "PostDivide" ],
                [ "category", HOMALG_MODULES.category ],
                [ "operation", "PostDivide" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
                [ "2", [ [ "covariant" ], [ IsMapOfFinitelyGeneratedModulesRep ] ] ],
                [ "OnObjects", _Functor_PostDivide_OnMaps ]
                )
        );

#functor_PostDivide_for_maps_of_fg_modules!.ContainerForWeakPointersOnComputedBasicObjects := true;

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
## PreCompose( phi, psi ) = phi * psi (for left maps) or psi * phi (for right maps)
##

InstallFunctorOnObjects( functor_PreCompose_for_maps_of_fg_modules );

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

