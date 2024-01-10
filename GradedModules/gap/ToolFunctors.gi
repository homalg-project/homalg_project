# SPDX-License-Identifier: GPL-2.0-or-later
# GradedModules: A homalg based package for the Abelian category of finitely presented graded modules over computable graded rings
#
# Implementations
#

##  Implementation stuff for some graded tool functors.

####################################
#
# install global functions/variables:
#
####################################

##
## TheZeroMorphism
##

BindGlobal( "_Functor_TheZeroMorphism_OnGradedModules", ### defines: TheZeroMorphism
  function( M, N )
    local psi;
    
    psi := GradedMap( TheZeroMorphism( UnderlyingModule( M ), UnderlyingModule( N ) ), M, N );
    
    SetIsMorphism( psi, true );
    
    return psi;
    
end );

BindGlobal( "functor_TheZeroMorphism_for_graded_modules",
        CreateHomalgFunctor(
                [ "name", "TheZeroMorphism" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "TheZeroMorphism" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "contravariant" ], HOMALG_GRADED_MODULES.FunctorOn ] ],
                [ "2", [ [ "covariant" ], HOMALG_GRADED_MODULES.FunctorOn ] ],
                [ "OnObjects", _Functor_TheZeroMorphism_OnGradedModules ]
                )
        );

#functor_TheZeroMorphism_for_graded_modules!.ContainerForWeakPointersOnComputedBasicObjects := true;

##
## MulMorphism
##

BindGlobal( "_Functor_MulMorphism_OnGradedMaps", ### defines: MulMorphism
  function( a, phi )
    local a_phi;
    
    a_phi := GradedMap( EvalRingElement( a ) * UnderlyingMorphismMutable( phi ), Source( phi ), Range( phi ) );
    
    if IsZero( DegreeOfRingElement( a ) ) then
        
        return SetPropertiesOfMulMorphism( a, phi, a_phi );
        
    else
        
        return a_phi;
        
    fi;
    
end );

BindGlobal( "functor_MulMorphism_for_maps_of_graded_modules",
        CreateHomalgFunctor(
                [ "name", "MulMorphism" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "MulMorphism" ], ## don't install the method for \* automatically, since it needs to be endowed with a high rank (see below)
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsHomalgGradedRingElementRep ] ] ],
                [ "2", [ [ "covariant" ], [ IsMapOfGradedModulesRep ] ] ],
                [ "OnObjects", _Functor_MulMorphism_OnGradedMaps ]
                )
        );

#functor_MulMorphism_for_maps_of_graded_modules!.ContainerForWeakPointersOnComputedBasicObjects := true;

## for convenience
InstallMethod( \*,
        "of graded ring element and graded map",
        [ IsHomalgGradedRingElementRep, IsMapOfGradedModulesRep ], 999, ## it could otherwise run into the method ``PROD: negative integer * additive element with inverse'', value: 24
        
  function( a, phi )
    
    return MulMorphism( a, phi );
    
end );

##
## AddMorphisms
##

BindGlobal( "_Functor_AddMorphisms_OnGradedMaps", ### defines: AddMorphisms
  function( phi1, phi2 )
    local phi;
    
    if not AreComparableMorphisms( phi1, phi2 ) then
        return Error( "the two maps are not comparable" );
    fi;
    
    phi := GradedMap( UnderlyingMorphismMutable( phi1 ) + UnderlyingMorphismMutable( phi2 ), Source( phi1 ), Range( phi1 ) );
    
    return SetPropertiesOfSumMorphism( phi1, phi2, phi );
    
end );

BindGlobal( "functor_AddMorphisms_for_maps_of_graded_modules",
        CreateHomalgFunctor(
                [ "name", "+" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "+" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsMapOfGradedModulesRep ] ] ],
                [ "2", [ [ "covariant" ], [ IsMapOfGradedModulesRep ] ] ],
                [ "OnObjects", _Functor_AddMorphisms_OnGradedMaps ],
                [ "DontCompareEquality", true ]
                )
        );

functor_AddMorphisms_for_maps_of_graded_modules!.ContainerForWeakPointersOnComputedBasicObjects := true;

##
## SubMorphisms
##

BindGlobal( "_Functor_SubMorphisms_OnGradedMaps", ### defines: SubMorphisms
  function( phi1, phi2 )
    local phi;
    
    if not AreComparableMorphisms( phi1, phi2 ) then
        return Error( "the two maps are not comparable" );
    fi;
    
    phi := GradedMap( UnderlyingMorphismMutable( phi1 ) - UnderlyingMorphismMutable( phi2 ), Source( phi1 ), Range( phi1 ) );
    
    return SetPropertiesOfDifferenceMorphism( phi1, phi2, phi );
    
end );

BindGlobal( "functor_SubMorphisms_for_maps_of_graded_modules",
        CreateHomalgFunctor(
                [ "name", "-" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "-" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsMapOfGradedModulesRep ] ] ],
                [ "2", [ [ "covariant" ], [ IsMapOfGradedModulesRep ] ] ],
                [ "OnObjects", _Functor_SubMorphisms_OnGradedMaps ],
                [ "DontCompareEquality", true ]
                )
        );

functor_SubMorphisms_for_maps_of_graded_modules!.ContainerForWeakPointersOnComputedBasicObjects := true;

##
## Compose
##

BindGlobal( "_Functor_PreCompose_OnGradedMaps", ### defines: PreCompose
  function( pre, post )
    local S, source, target, phi;
    
    if not IsIdenticalObj( Range( pre ), Source( post ) ) then
      Error( "Morphisms are not compatible for composition" );
    fi;
    
    S := HomalgRing( pre );
    
    source := Source( pre );
    target := Range( post );
    
    phi := GradedMap( PreCompose( UnderlyingMorphismMutable( pre ), UnderlyingMorphismMutable( post ) ), source, target );
    
    return SetPropertiesOfComposedMorphism( pre, post, phi );
    
end );

BindGlobal( "functor_PreCompose_for_maps_of_graded_modules",
        CreateHomalgFunctor(
                [ "name", "PreCompose" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "PreCompose" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsMapOfGradedModulesRep ] ] ],
                [ "2", [ [ "covariant" ], [ IsMapOfGradedModulesRep ] ] ],
                [ "OnObjects", _Functor_PreCompose_OnGradedMaps ]
                )
        );

#functor_PreCompose_for_maps_of_graded_modules!.ContainerForWeakPointersOnComputedBasicObjects := true;

##
## CoproductMorphism
##

BindGlobal( "_Functor_CoproductMorphism_OnGradedMaps", ### defines: CoproductMorphism
  function( phi, psi )
    local phi_psi;
    
    phi_psi := CoproductMorphism( UnderlyingMorphismMutable( phi ), UnderlyingMorphismMutable( psi ) );
    
    phi_psi := GradedMap( phi_psi, Source( phi ) + Source( psi ), Range( phi ) );
    
    return SetPropertiesOfCoproductMorphism( phi, psi, phi_psi );
    
end );

BindGlobal( "functor_CoproductMorphism_for_maps_of_graded_modules",
        CreateHomalgFunctor(
                [ "name", "CoproductMorphism" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "CoproductMorphism" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsMapOfGradedModulesRep ] ] ],
                [ "2", [ [ "covariant" ], [ IsMapOfGradedModulesRep ] ] ],
                [ "OnObjects", _Functor_CoproductMorphism_OnGradedMaps ]
                )
        );

#functor_CoproductMorphism_for_maps_of_graded_modules!.ContainerForWeakPointersOnComputedBasicObjects := true;

##
## ProductMorphism
##

BindGlobal( "_Functor_ProductMorphism_OnGradedMaps", ### defines: ProductMorphism
  function( phi, psi )
    local phi_psi;
    
    phi_psi := ProductMorphism( UnderlyingMorphismMutable( phi ), UnderlyingMorphismMutable( psi ) );
    
    phi_psi := GradedMap( phi_psi, Source( phi ), Range( phi ) + Range( psi ) );
    
    return SetPropertiesOfProductMorphism( phi, psi, phi_psi );
    
end );

BindGlobal( "functor_ProductMorphism_for_maps_of_graded_modules",
        CreateHomalgFunctor(
                [ "name", "ProductMorphism" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "ProductMorphism" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsMapOfGradedModulesRep ] ] ],
                [ "2", [ [ "covariant" ], [ IsMapOfGradedModulesRep ] ] ],
                [ "OnObjects", _Functor_ProductMorphism_OnGradedMaps ]
                )
        );

#functor_ProductMorphism_for_maps_of_graded_modules!.ContainerForWeakPointersOnComputedBasicObjects := true;

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
# row convention (left modules): psi := gamma * beta^(-1)       ( -> RightDivide )
# column convention (right modules): psi := beta^(-1) * gamma   ( -> LeftDivide )
#_______________________________________________________________________

##
## PostDivide
##

BindGlobal( "_Functor_PostDivide_OnGradedMaps",  ### defines: PostDivide
  function( gamma, beta )
    local N, psi, M_;
    
    if HasMorphismAid( gamma ) or HasMorphismAid( beta ) then
        TryNextMethod();
    fi;
    
    N := Range( beta );
    
    psi := PostDivide( UnderlyingMorphismMutable( gamma ), UnderlyingMorphismMutable( beta ) );
    
    if IsBool( psi ) then
        return psi;
    fi;
    
    M_ := Source( gamma );
    
    psi := GradedMap( psi, M_, Source( beta ) );
    
    SetPropertiesOfPostDivide( gamma, beta, psi );
    
    return psi;
    
end );

BindGlobal( "functor_PostDivide_for_maps_of_graded_modules",
        CreateHomalgFunctor(
                [ "name", "PostDivide" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "PostDivide" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsMapOfGradedModulesRep ] ] ],
                [ "2", [ [ "covariant" ], [ IsMapOfGradedModulesRep ] ] ],
                [ "OnObjects", _Functor_PostDivide_OnGradedMaps ]
                )
        );

#functor_PostDivide_for_maps_of_graded_modules!.ContainerForWeakPointersOnComputedBasicObjects := true;

####################################
#
# methods for operations & attributes:
#
####################################

##
## TheZeroMorphism( M, N )
##

InstallFunctorOnObjects( functor_TheZeroMorphism_for_graded_modules );

##
## MulMorphism( a, phi ) = a * phi
##

InstallFunctorOnObjects( functor_MulMorphism_for_maps_of_graded_modules );

#
# phi1 + phi2
#

InstallFunctorOnObjects( functor_AddMorphisms_for_maps_of_graded_modules );

##
## phi1 - phi2
##

InstallFunctorOnObjects( functor_SubMorphisms_for_maps_of_graded_modules );

##
## PreCompose( phi, psi )
##

InstallFunctorOnObjects( functor_PreCompose_for_maps_of_graded_modules );

##
## CoproductMorphism( phi, psi )
##

InstallFunctorOnObjects( functor_CoproductMorphism_for_maps_of_graded_modules );

##
## ProductMorphism( phi, psi )
##

InstallFunctorOnObjects( functor_ProductMorphism_for_maps_of_graded_modules );

##
## gamma / beta = PostDivide( gamma, beta )
##

InstallFunctorOnObjects( functor_PostDivide_for_maps_of_graded_modules );
