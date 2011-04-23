#############################################################################
##
##  OtherFunctors.gi                                  Graded Modules package
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Implementation stuff for some other graded functors.
##
#############################################################################

####################################
#
# install global functions/variables:
#
####################################

##
## DirectSum
##

InstallGlobalFunction( _Functor_DirectSum_OnGradedModules,	### defines: DirectSum
  function( M, N )
    local S, degMN, sum, iotaM, iotaN, piM, piN, natural, phi;
    
    CheckIfTheyLieInTheSameCategory( M, N );
    
    S := HomalgRing( M );
    
    degMN := Concatenation( DegreesOfGenerators( M ), DegreesOfGenerators( N ) );
    
    sum := DirectSum( UnderlyingModule( M ), UnderlyingModule( N ) );
    
    # take the non-graded natural transformations
    iotaM := MonoOfLeftSummand( sum );
    iotaN:= MonoOfRightSummand( sum );
    piM := EpiOnLeftFactor( sum );
    piN := EpiOnRightFactor( sum );
    
    # create the graded sum with the help of its natural generalized embedding
    natural := NaturalGeneralizedEmbedding( sum );
    natural := GradedMap( natural, "create", degMN, S );
    sum := Source( natural );
    sum!.NaturalGeneralizedEmbedding := natural;
    
    # grade the natural transformations
    iotaM := GradedMap( iotaM, M, sum, S );
    iotaN := GradedMap( iotaN, N, sum, S );
    piM := GradedMap( piM, sum, M, S );
    piN := GradedMap( piN, sum, N, S );
    
    return SetPropertiesOfDirectSum( [ M, N ], sum, iotaM, iotaN, piM, piN );
    
end );

InstallValue( Functor_DirectSum_for_graded_modules,
        CreateHomalgFunctor(
                [ "name", "DirectSum" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "DirectSumOp" ],
                [ "natural_transformation1", "EpiOnLeftFactor" ],
                [ "natural_transformation2", "EpiOnRightFactor" ],
                [ "natural_transformation3", "MonoOfLeftSummand" ],
                [ "natural_transformation4", "MonoOfRightSummand" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], HOMALG_GRADED_MODULES.FunctorOn ] ],
                [ "2", [ [ "covariant" ], HOMALG_GRADED_MODULES.FunctorOn ] ],
                [ "OnObjects", _Functor_DirectSum_OnGradedModules ],
                [ "OnMorphismsHull", _Functor_DirectSum_OnMaps ]
                )
        );

Functor_DirectSum_for_graded_modules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_DirectSum_for_graded_modules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctor( Functor_DirectSum_for_graded_modules );

##
## LinearPart
##
## (cf. Eisenbud, Floystad, Schreyer: Sheaf Cohomology and Free Resolutions over Exterior Algebras)

InstallGlobalFunction( _Functor_LinearPart_OnGradedModules,    ### defines: LinearPart (object part)
  function( M )
    return M;
end );

##
InstallGlobalFunction( _Functor_LinearPart_OnGradedMaps, ### defines: LinearPart (morphism part)
  function( F_source, F_target, arg_before_pos, phi, arg_behind_pos )
    local deg_s, deg_t, S, zero, mat, deg, i, j, result;
    
    if HasIsZero( phi ) and IsZero( phi ) then
        return phi;
    fi;
    
    deg_s := Set( DegreesOfGenerators( F_source ) );
    deg_t := Set( DegreesOfGenerators( F_source ) );
    if Length( deg_s ) = 1 and Length( deg_t ) = 1 and deg_s[1] = deg_t[1] - 1 then
        return phi;
    fi;
    
    S := HomalgRing( phi );
    
    zero := Zero( S );
    
    mat := ShallowCopy( MatrixOfMap( phi ) );
    
    SetIsMutableMatrix( mat, true );
    
    deg := DegreesOfEntries( mat );
    
    if not ( deg <> [] and IsHomogeneousList( deg ) and IsHomogeneousList( deg[1] ) and IsInt( deg[1][1] ) ) then
      Error( "Multigraduations are not yet supported" );
    fi;
    
    for i in [ 1 .. Length( deg ) ] do
      for j in [ 1 .. Length( deg[1] ) ] do
        if deg[i][j] <> -1 then
          SetEntryOfHomalgMatrix( mat, i, j, zero );
        fi;
      od;
    od;
    
    SetIsMutableMatrix( mat, false );
    
    result := GradedMap( mat, F_source, F_target );
    
    Assert( 1, IsMorphism( result ) );
    SetIsMorphism( result, true );
    
    return result;
    
end );

InstallValue( Functor_LinearPart_ForGradedModules,
        CreateHomalgFunctor(
                [ "name", "LinearPart" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "LinearPart" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant", "left adjoint", "distinguished" ], HOMALG_GRADED_MODULES.FunctorOn ] ],
                [ "OnObjects", _Functor_LinearPart_OnGradedModules ],
                [ "OnMorphisms", _Functor_LinearPart_OnGradedMaps ]
                )
        );

Functor_LinearPart_ForGradedModules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_LinearPart_ForGradedModules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctor( Functor_LinearPart_ForGradedModules );

##
## LinearStrand
##

# returns the subfactor complex of a free complex,
# where cohomological degree + shift = internal degree

InstallGlobalFunction( _Functor_LinearStrand_OnFreeCocomplexes,    ### defines: LinearStrand (object part)
  function( shift, T )
  local i, M, deg, l1, l2, phi1, phi2, T1, T2, psi1, psi2, result;
    
    for i in ObjectDegreesOfComplex( T ) do
        
        M := CertainObject( T, i );
        
        deg := DegreesOfGenerators( M );
        l2 := Filtered( [ 1 .. Length( deg ) ], a -> deg[a] > i + shift );
        phi2 := GradedMap( CertainGenerators( M, l2 ), "free", M );
        Assert( 1, IsMorphism( phi2 ) );
        SetIsMorphism( phi2, true );
        
        if l2 = [ 1 .. Length( deg ) ] then
            Assert( 1, IsEpimorphism( phi2 ) );
            SetIsEpimorphism( phi2, true );
        fi;
        Assert( 1, IsMonomorphism( phi2 ) );
        SetIsMonomorphism( phi2, true );
        
        if not IsBound( T2 ) then
            T2 := HomalgCocomplex( Source( phi2 ), i );
        else
            Add( T2, Source( phi2 ) );
        fi;
        
        if not IsBound( psi2 ) then
            psi2 := HomalgChainMorphism( phi2, T2, T, i );
        else
            Add( psi2, phi2 );
        fi;
        
    od;
    
    #T2 := CokernelEpi( psi2 );
    T2 := Cokernel( psi2 );
    
    for i in ObjectDegreesOfComplex( T2 ) do
        
        M := CertainObject( T2, i );
        
        deg := DegreesOfGenerators( M );
        l1 := Filtered( [ 1 .. Length( deg ) ], a -> deg[a] = i + shift );
        phi1 := GradedMap( CertainGenerators( M, l1 ), "free", M );
        Assert( 1, IsMonomorphism( phi1 ) );
        SetIsMonomorphism( phi1, true );
        
        if l1 = [ 1 .. Length( deg ) ] then
            Assert( 1, IsEpimorphism( phi1 ) );
            SetIsEpimorphism( phi1, true );
        fi;
        Assert( 1, IsMonomorphism( phi1 ) );
        SetIsMonomorphism( phi1, true );
        
        if not IsBound( T1 ) then
            T1 := HomalgCocomplex( Source( phi1 ), i );
        else
            Add( T1, CompleteImageSquare( CertainMorphism( psi1, i-1 ), CertainMorphism( T2, i-1 ), phi1 ) );
        fi;
        
        if not IsBound( psi1 ) then
            psi1 := HomalgChainMorphism( phi1, T1, T2, i );
        else
            Add( psi1, phi1 );
        fi;
        
    od;
    
    result := Source( psi1 );
    
    ByASmallerPresentation( result );
    
    result!.LinearStrandImageMap := psi1;
    result!.LinearStrandCokernelMap := psi2;
    
    Assert( 1, IsComplex( result ) );
    SetIsComplex( result, true );
    
    return result;
    
end );

InstallGlobalFunction( _Functor_LinearStrand_OnCochainMaps,    ### defines: LinearStrand (morphism part)
  function( F_source, F_target, arg_before_pos, phi, arg_behind_pos )
    local shift, psi1_source, psi1_target, psi2_source, psi2_target, phi1, ps, pt, phi2;
    
    shift := arg_before_pos[1];
    
    if not IsBound( F_source!.LinearStrandImageMap ) or not IsBound( F_target!.LinearStrandImageMap ) or not IsBound( F_source!.LinearStrandCokernelMap ) or not IsBound( F_target!.LinearStrandCokernelMap ) then
        Error( "This Complex is not output of LinearStrand" );
    fi;
    
    psi1_source := F_source!.LinearStrandImageMap;
    psi1_target := F_target!.LinearStrandImageMap;
    psi2_source := F_source!.LinearStrandCokernelMap;
    psi2_target := F_target!.LinearStrandCokernelMap;
    
    phi1 := CompleteKernelSquare( CokernelEpi( psi2_source ), phi, CokernelEpi( psi2_target ) );
    
    ps := PreCompose( psi1_source, CokernelEpi( psi2_source ) );
    pt := PreCompose( psi1_target, CokernelEpi( psi2_target ) );
    phi2 := CompleteImageSquare( ps, phi1, pt );
    
    return phi2;
    
end );
  

InstallValue( Functor_LinearStrand_ForGradedModules,
        CreateHomalgFunctor(
                [ "name", "LinearStrand" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "LinearStrand" ],
                [ "number_of_arguments", 1 ],
                [ "0", [ IsInt ] ],
                [ "1", [ [ "covariant", "left adjoint", "distinguished" ], [ IsHomalgComplex, IsHomalgChainMorphism ] ] ],
                [ "OnObjects", _Functor_LinearStrand_OnFreeCocomplexes ],
                [ "OnMorphisms", _Functor_LinearStrand_OnCochainMaps ]
                )
        );

Functor_LinearStrand_ForGradedModules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_LinearStrand_ForGradedModules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

# InstallFunctor( Functor_LinearStrand_ForGradedModules );
InstallFunctorOnObjects( Functor_LinearStrand_ForGradedModules );
InstallFunctorOnMorphisms( Functor_LinearStrand_ForGradedModules );

##
## HomogeneousExteriorComplexToModule
##

# This functor creates a module from a linear complex over the exterior algebra
# (and a module map from a degree 0 cochain map).
# first we introduce two helper functions

##
# Takes a linear map phi over a graded ring with indeterminates x_i
# write phi = sum_i x_i*phi_i
# returns (for left objects) the matrix
# <phi_0,
#  phi_1
#
#  phi_n>
# and a map with matrix
# <x_0*I,
#  x_1*I
#
#  x_n*I>
# where I is the identity matrix of size Source( phi ), i.e. both matrices have the same number of rows
# later we will use these two maps to produce a pushout.
InstallMethod( SplitLinearMapAccordingToIndeterminates,
        "for linear complexes over the exterior algebra",
        [ IsMapOfGradedModulesRep ],
  function( phi )
      local E, S, K, l_var, left, map_E, map_S, t, F, var_s_morphism, k, matrix_of_extension, c, extension_matrix,l_test;
      
      E := HomalgRing( phi );
      
      S := KoszulDualRing( E );
      
      K := CoefficientsRing( E );
      
      Assert( 3, IsIdenticalObj( K, CoefficientsRing( S ) ) );
      
      l_var := Length( Indeterminates( S ) );
      
      left := IsHomalgLeftObjectOrMorphismOfLeftObjects( phi );
      
      if left then
          map_E := MaximalIdealAsLeftMorphism( E );
          map_S := MaximalIdealAsLeftMorphism( S );
      else
          map_E := MaximalIdealAsRightMorphism( E );
          map_S := MaximalIdealAsRightMorphism( S );
      fi;
      
      t := NrGenerators( Range( phi ) );
      if left then
          if DegreesOfGenerators( Range( phi ) ) <> [ ] then
              F := FreeLeftModuleWithDegrees( NrGenerators( Source( phi ) ), S, DegreesOfGenerators( Range( phi ) )[1]-1 );
          else
              F := FreeLeftModuleWithDegrees( NrGenerators( Source( phi ) ), S, 0 );
          fi;
          var_s_morphism := - TensorProduct( map_S , F );
      else
          if DegreesOfGenerators( Range( phi ) ) <> [ ] then
              F := FreeRightModuleWithDegrees( NrGenerators( Source( phi ) ), S, DegreesOfGenerators( Range( phi ) )[1]-1 );
          else
              F := FreeRightModuleWithDegrees( NrGenerators( Source( phi ) ), S, 0 );
          fi;
          var_s_morphism := - TensorProduct( map_S , F );
      fi;
      
      matrix_of_extension := PostDivide( phi, TensorProduct( map_E, Range( phi ) ) );
      matrix_of_extension := K * MatrixOfMap( matrix_of_extension );
      if left then
          extension_matrix := HomalgZeroMatrix( 0, NrGenerators( Range( phi ) ), K );
          for k in [ 1 .. l_var ] do
              c := CertainColumns( matrix_of_extension, [ (k-1) * t + 1 .. k * t ] );
              extension_matrix := UnionOfRows( extension_matrix, c );
          od;
      else
          extension_matrix := HomalgZeroMatrix( NrGenerators( Range( phi ) ), 0, K );
          for k in [ 1 .. l_var ] do
              c := CertainRows( matrix_of_extension, [ (k-1) * t + 1 .. k * t ] );
              extension_matrix := UnionOfColumns( extension_matrix, c );
          od;
      fi;
      
      return [ extension_matrix, var_s_morphism ];
    
end );

##
# Takes a linear map phi over a graded ring with indeterminates x_i
# write phi = sum_i x_i*phi_i
# creates (for left objects) the maps var_s_morphism and extension_map with matrices
# <x_0*I,
#  x_1*I
#
#  x_n*I>
# and
# <phi_0,
#  phi_1
#
#  phi_n>
# where I is the identity matrix of size Source( phi ),
# i.e. both matrices have the same number of rows and (accordingly) both maps the same source.
# The target of var_s_morphism is newly created 
# and of extension_map is taken to be the source of the second argument psi.
# Then a base change is performed on source and target of extension_map, to have this
# map (with a matrix with entries over the ground field) in a simple shape for later use.
# In this process, a complement alpha of the image of extension_map is created (also for later use)
# we return [ var_s_morphism, extension_map, alpha ]
InstallMethod( ExtensionMapsFromExteriorComplex,
        "for linear complexes over the exterior algebra",
        [ IsMapOfGradedModulesRep, IsMapOfGradedModulesRep ],

  function( phi, psi )
      local N, E, S, K, extension_matrix, var_s_morphism, M, extension_map, alpha,l_test;
      
      N := Source( psi );
      
      E := HomalgRing( phi );
      
      S := KoszulDualRing( E );
      
      extension_matrix := SplitLinearMapAccordingToIndeterminates( phi );
      var_s_morphism := extension_matrix[2];
      M := Source( var_s_morphism );
      extension_matrix := extension_matrix[1];
      
      # compute over the free module instead of N, because it is faster
      extension_map := GradedMap( S * extension_matrix, M, N, S );
      Assert( 1, IsMorphism( extension_map ) );
      SetIsMorphism( extension_map, true );
      
      # This command changes the presentation of Source and Range of extension_map.
      # In particular, N is changes, which was used before
      # the change is due to the wish of a much faster ByASmallerPresentation
      NormalizeGradedMorphism( extension_map );
      
      alpha := extension_map!.complement_of_image;
      
      return [ var_s_morphism, extension_map, alpha ];
    
end );

##
# This method creates a module from a single linear map over the exterior algebra.
# The idea behind this is, that the submodule of cohomology module generated by a certain degree
# above the regularity can be constructed from this single map phi.
# Let e_i be the generators of the exterior algebra and x_i the generators of the symmetric algebra.
# Write phi=sum e_i*phi_i, then the phi_i are matrices over the ground field.
# (Left modules) Let extension_map be the map with stacked matrix
# <phi_0,
#  phi_1
#
#  phi_n>
# and var_s_morphism the map with stacked matrix
# <x_0*I,
#  x_1*I
#
#  x_n*I>
# where I is the identity matrix of size Source( phi ).
# (both maps have the same source)
# Then cokernel( kernel( extension_map ) * var_s_morphism ) the the wanted module.
InstallMethod( ModulefromExtensionMap,
        "for linear complexes over the exterior algebra",
        [ IsMapOfGradedModulesRep ],

  function( phi )
      local  E, S, K, extension_matrix, var_s_morphism, M, ar, N, extension_map, result;
      
      E := HomalgRing( phi );
      
      S := KoszulDualRing( E );
      
      if IsZero( phi ) then
          if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
              return 0*S;
          else
              return S*0;
          fi;
      fi;
      
      extension_matrix := SplitLinearMapAccordingToIndeterminates( phi );
      var_s_morphism := extension_matrix[2];
      M := Source( var_s_morphism );
      extension_matrix := extension_matrix[1];
      
      ar := [ NrGenerators( Range( phi ) ), S, DegreesOfGenerators( M )[1] ];
      if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
          N := CallFuncList( FreeLeftModuleWithDegrees, ar );
      else
          N := CallFuncList( FreeRightModuleWithDegrees, ar );
      fi;
      extension_map := GradedMap( S * extension_matrix, M, N, S );
      Assert( 1, IsMorphism( extension_map ) );
      SetIsMorphism( extension_map, true );
      result := Cokernel( PreCompose( KernelEmb( extension_map ), var_s_morphism ) );
      
      return result;
      
end );

InstallMethod( CompareArgumentsForHomogeneousExteriorComplexToModuleOnObjects,
        "for argument lists of the functor HomogeneousExteriorComplexToModule on objects",
        [ IsList, IsList ],

  function( l_old, l_new )
      
      return l_old[1] <= l_new[1]
          and 0 in MorphismDegreesOfComplex( l_old[2] )
          and 0 in MorphismDegreesOfComplex( l_new[2] )
          and IsIdenticalObj( CertainMorphism( l_old[2], 0 ), CertainMorphism( l_new[2], 0 ) );
      
end );

InstallGlobalFunction( _Functor_HomogeneousExteriorComplexToModule_OnGradedModules,    ### defines: HomogeneousExteriorComplexToModule (object part)
  function( reg_sheaf, lin_tate )
      local A, S, k, result, EmbeddingsOfHigherDegrees, RecursiveEmbeddingsOfHigherDegrees, jj, j,
      tate_morphism, psi, extension_map, var_s_morphism, T, T2, l, T2b, V1, V2, V1_iso_V2, source_emb, map, deg, certain_deg, t1, t2, phi;
      
      A := HomalgRing( lin_tate );
      
      S := KoszulDualRing( A );
      
      k := CoefficientsRing( A );
      
      result := ModulefromExtensionMap( CertainMorphism( lin_tate, reg_sheaf ) );
      
#   each new step constructs a new StdM as pushout of 
#   extension_map*LeftPushoutMorphism  and  var_s_morphism.
#   These maps are created from a modified Tate resolution.
#
#     StdM = new (+) old                                   Range( var_s_morphism )
#             /\                                                  /\
#             |                                                   |
#             |                                                   |
#             | LeftPushoutMorphism                               | var_s_morphism
#             |                                                   |
#             |           extension_map                           |
#           new  <-------------------------------- Source( var_s_morphism ) = Source( extension_map )
      
      result := Pushout( TheZeroMorphism( Zero( result ), result ), TheZeroMorphism( Zero( result ), Zero( result ) ) );
      
      EmbeddingsOfHigherDegrees := rec( (String( reg_sheaf )) := TheIdentityMorphism( result ) );
      RecursiveEmbeddingsOfHigherDegrees := rec( );
      
      for jj in [ 1 .. reg_sheaf ] do
          j := reg_sheaf - jj;
          
          # create the extension map from the tate-resolution
          # e.g. ( e_0, e_1, 3*e_0+2*e_1 ) leads to  /   1,   0,   3   \
          #                                          \   0,   1,   2   /
          # but the gaussian algorithm is applied to the latter matrix (both to rows an columns) for easier simplification
          tate_morphism := CertainMorphism( lin_tate, j );
          
          psi := LeftPushoutMorphism( result );
          
          extension_map := ExtensionMapsFromExteriorComplex( tate_morphism, psi );
          var_s_morphism := extension_map[1];
          T := extension_map[3];
          extension_map := extension_map[2];
          
          # this line computes the global sections module
          result := Pushout( var_s_morphism, PreCompose( extension_map, psi ) );
          
          # This direct sum will be used in different contextes of the summands.
          # We need to ensure that we speak about the same object in each of these cases.
          # Thus, we force homalg to return this object regardless of the context of the summands.
          Range( NaturalGeneralizedEmbedding( result ) )!.IgnoreContextOfArgumentsOfFunctor := true;
          UnderlyingModule( Range( NaturalGeneralizedEmbedding( result ) ) )!.IgnoreContextOfArgumentsOfFunctor := true;
          
          # the "old" ModuleOfGlobalSections (the one generated in larger degree) embeds into the new one
          Assert( 1, IsMonomorphism( RightPushoutMorphism( result ) ) );
          SetIsMonomorphism( RightPushoutMorphism( result ), true );
          
          # the following block simplifies the ModuleOfGlobalSections much faster than ByASmallerPresentation could.
          # We know in advance, which generators we need to generate result. These are 
          # 1) the new generators, i.e. Image( var_s_morphism ),
          # 2) a basis of Cokernel( extension_map ) (which is free), i.e. Image( T ),
          # 3) and the older generators, which have not been made superfluous, i.e. CertainGenerators( result, k ).
          # We build the CoproductMorphism T2 of these three morphisms and its image is a smaller presentation of result
          T := PreCompose( PreCompose( T, psi ), RightPushoutMorphism( result ) );
          T2 := CoproductMorphism( LeftPushoutMorphism( result ), T );
          l := PositionProperty( DegreesOfGenerators( result ), function( a ) return a > j+1; end );
          if l <> fail then
              l := [ l .. NrGenerators( result ) ];
              T2b := GradedMap( CertainGenerators( result, l ), "free", result );
              Assert( 1, IsMorphism( T2b ) );
              SetIsMorphism( T2b, true );
              T2 := CoproductMorphism( T2, T2b );
          fi;
          Assert( 1, IsEpimorphism( T2 ) );
          SetIsEpimorphism( T2, true );
          PushPresentationByIsomorphism( NaturalGeneralizedEmbedding( ImageObject( T2 ) ) );
          
          # try to keep the information about higher modules
          EmbeddingsOfHigherDegrees!.(String(j)) := TheIdentityMorphism( result );
          for l in [ j + 1 .. reg_sheaf ] do
              EmbeddingsOfHigherDegrees!.(String(l)) := PreCompose( EmbeddingsOfHigherDegrees!.(String(l)), RightPushoutMorphism( result ) );
          od;
          RecursiveEmbeddingsOfHigherDegrees!.(String(j+1)) := RightPushoutMorphism( result );
          
      od;
      
      # end core procedure
      
      # Now set some properties of the module collected during the computation.
      # Most of these are needed in the morphism part of this functor.
      
      for l in [ 0 .. reg_sheaf ] do
          if fail = GetFunctorObjCachedValue( Functor_TruncatedSubmoduleEmbed_ForGradedModules, [ l, result ] ) then
              SetFunctorObjCachedValue( Functor_TruncatedSubmoduleEmbed_ForGradedModules, [ l, result ], EmbeddingsOfHigherDegrees!.(String(l)) );
          fi;
      od;
      for l in [ 0 .. reg_sheaf - 1 ] do
          if fail = GetFunctorObjCachedValue( Functor_TruncatedSubmoduleRecursiveEmbed_ForGradedModules, [ l, result ] ) then
              SetFunctorObjCachedValue( Functor_TruncatedSubmoduleRecursiveEmbed_ForGradedModules, [ l, result ], RecursiveEmbeddingsOfHigherDegrees!.(String(l+1)) );
          fi;
      od;
      
      for l in [ 0 .. reg_sheaf ] do
          
          V1 := HomogeneousPartOverCoefficientsRing( l, CertainObject( lin_tate, l ) );

          V1_iso_V2 := GradedMap( HomalgIdentityMatrix( NrGenerators( V1 ), k ), "free", V1 );
          Assert( 1, IsMorphism( V1_iso_V2 ) );
          SetIsMorphism( V1_iso_V2, true );
          
          V2 := Source( V1_iso_V2 );
          
          SetMapFromHomogenousPartOverSymmetricAlgebraToHomogeneousPartOverExteriorAlgebra( V2, V1_iso_V2 );
          SetMapFromHomogenousPartOverExteriorAlgebraToHomogeneousPartOverSymmetricAlgebra( V1, V1_iso_V2 );
          
          source_emb := Source( EmbeddingsOfHigherDegrees!.(String(l)) );
          
          deg := DegreesOfGenerators( source_emb );
          certain_deg := Filtered( [ 1 .. Length( deg ) ], a -> deg[a] = l );
          if IsHomalgLeftObjectOrMorphismOfLeftObjects( result ) then
              map := GradedMap( CertainRows( HomalgIdentityMatrix( NrGenerators( source_emb ), S ), certain_deg ), S * V2, source_emb );
          else
              map := GradedMap( CertainColumns( HomalgIdentityMatrix( NrGenerators( source_emb ), S ), certain_deg ), S * V2, source_emb );
          fi;
          Assert( 1, IsMorphism( map ) );
          SetIsMorphism( map, true );
          
          map := PreCompose( map, EmbeddingsOfHigherDegrees!.(String(l)) );
          
          if fail = GetFunctorObjCachedValue( Functor_HomogeneousPartOverCoefficientsRing_ForGradedModules, [ l, result ] ) then
              SetFunctorObjCachedValue( Functor_HomogeneousPartOverCoefficientsRing_ForGradedModules, [ l, result ], V2 );
          fi;
          
          SetNaturalTransformation(
              Functor_HomogeneousPartOverCoefficientsRing_ForGradedModules,
              [ l, result ],
              "EmbeddingOfSubmoduleGeneratedByHomogeneousPart",
              map
          );
      
      od;
      
      t1 := CertainObject( lin_tate, 0 );
      t2 := RepresentationObjectOfKoszulId( 0, result );
      
      phi := GradedMap( HomalgIdentityMatrix( NrGenerators( t1 ), A ), t1, t2 );
      Assert( 1, IsMorphism( phi ) );
      SetIsMorphism( phi, true );
      SetNaturalMapFromExteriorComplexToRightAdjoint( t1, phi );
      
      return result;
      
end );

InstallMethod( ConstructMorphismFromLayers,
        "for argument lists of the functor HomogeneousExteriorComplexToModule on objects",
        [ IsGradedModuleRep, IsGradedModuleRep, IsHomalgChainMorphism ],

  function( F_source, F_target, psi )
    local reg, phi, jj, j, emb_new_source, emb_new_target, emb_old_source, emb_old_target, epi_source, epi_target, phi_new;
    
    Assert( 0, 0 = LowestDegree( psi ) );
    
    reg := HighestDegree( psi );
    
    phi := HighestDegreeMorphism( psi );

    for jj in [ 1 .. reg ] do
        j := reg - jj;
        
        if j = reg - 1 then
            emb_old_source := PostDivide( SubmoduleGeneratedByHomogeneousPartEmbed( j + 1, F_source ), TruncatedSubmoduleEmbed( j, F_source ) );
            emb_old_target := PostDivide( SubmoduleGeneratedByHomogeneousPartEmbed( j + 1, F_target ), TruncatedSubmoduleEmbed( j, F_target ) );
        else
            emb_old_source := TruncatedSubmoduleRecursiveEmbed( j, F_source );
            emb_old_target := TruncatedSubmoduleRecursiveEmbed( j, F_target );
        fi;
        
        emb_new_source := PostDivide( SubmoduleGeneratedByHomogeneousPartEmbed( j, F_source ), TruncatedSubmoduleEmbed( j, F_source ) );
        emb_new_target := PostDivide( SubmoduleGeneratedByHomogeneousPartEmbed( j, F_target ), TruncatedSubmoduleEmbed( j, F_target ) );

        epi_source := CoproductMorphism( emb_new_source, -emb_old_source );
        epi_target := CoproductMorphism( emb_new_target, -emb_old_target );

        Assert( 1, IsEpimorphism( epi_source ) );
        SetIsEpimorphism( epi_source, true );
        Assert( 1, IsEpimorphism( epi_target ) );
        SetIsEpimorphism( epi_target, true );
        
        phi_new := CertainMorphism( psi, j );
        
        # We should have
        # IsZero( PreCompose( PreCompose( KernelEmb( emb_new_source ), phi_new ), emb_new_target ) )
        # to call CompleteKernelSquare. But since emb_new_source maps from a free module and not from
        # SubmoduleGeneratedByHomogeneousPart( j, F_source ) the kernel is too big.
        # We could compute the relations in Source( emb_new_source ). This would imply a costly syzygy
        # computation, which i would like to circumwent. So CompleteKernelSquare does not yield a
        # well defined result, but the final result is well defined
        Assert( 1000, IsZero( PreCompose( PreCompose( KernelEmb( emb_new_source ), phi_new ), emb_new_target ) ) );
        phi := DiagonalMorphism( -phi_new, phi );
        Assert( 1000, IsZero( PreCompose( PreCompose( KernelEmb( epi_source ), phi), epi_target ) ) );
        phi := CompleteKernelSquare( epi_source, phi, epi_target );
        
    od;
    
    return phi;

end );

# Constructs a morphism between two modules F_source and F_target from the cochain map lin_tate
# We begin by constructing the map from F_source_{>=reg}=SubmoduleGeneratedByHomogeneousPart(reg,F_source)
# to F_target_{>=reg}=SubmoduleGeneratedByHomogeneousPart(reg,F_target).
# This map can be directly read of from the morphism in lin_tate at degree reg.
# Now we inductively construct maps from the submodules generated by a certain degree of F_source and F_target.
# Since F_{>=j} = F_{>=j+1} \oplus <F_j> we have the map starting from the direct sum and finally
# also from the factor of this direct sum.
InstallGlobalFunction( _Functor_HomogeneousExteriorComplexToModule_OnGradedMaps,    ### defines: HomogeneousExteriorComplexToModule (morphism part)
  function( F_source, F_target, arg_before_pos, lin_tate, arg_behind_pos )
    local S, k, reg_sheaf, jj, j, phi, H_source, H_target, phi1, phi2, psi;
      
      S := HomalgRing( F_source );
      
      k := CoefficientsRing( S );
      
      Assert( 4, IsIdenticalObj( S, KoszulDualRing( HomalgRing( lin_tate ) ) ) );
      
      reg_sheaf := arg_before_pos[1];
      
      phi := CertainMorphism( lin_tate, reg_sheaf );
      
      phi := HomogeneousPartOverCoefficientsRing( reg_sheaf, phi );
      
      H_source := HomogeneousPartOverCoefficientsRing( reg_sheaf, F_source );
      H_target := HomogeneousPartOverCoefficientsRing( reg_sheaf, F_target );
      
      #phi1 := isomorphism from H_source to Source( phi )
      if not HasMapFromHomogenousPartOverSymmetricAlgebraToHomogeneousPartOverExteriorAlgebra( H_source ) then
          phi1 := GradedMap( HomalgIdentityMatrix( NrGenerators( H_source ), k ), H_source, Source( phi ) );
          Assert( 1, IsMorphism( phi1 ) );
          SetIsMorphism( phi1, true );
          SetMapFromHomogenousPartOverSymmetricAlgebraToHomogeneousPartOverExteriorAlgebra( H_source, phi1 );
          SetMapFromHomogenousPartOverExteriorAlgebraToHomogeneousPartOverSymmetricAlgebra( Source( phi ), phi1 );
      fi;
      phi1 := MapFromHomogenousPartOverSymmetricAlgebraToHomogeneousPartOverExteriorAlgebra( H_source );
      #phi2 := isomorphism from H_target to Range( phi )
      if not HasMapFromHomogenousPartOverSymmetricAlgebraToHomogeneousPartOverExteriorAlgebra( H_target ) then
          phi2 := GradedMap( HomalgIdentityMatrix( NrGenerators( H_target ), k ), H_target, Range( phi ) );
          Assert( 1, IsMorphism( phi2 ) );
          SetIsMorphism( phi2, true );
          SetMapFromHomogenousPartOverSymmetricAlgebraToHomogeneousPartOverExteriorAlgebra( H_target, phi2 );
          SetMapFromHomogenousPartOverExteriorAlgebraToHomogeneousPartOverSymmetricAlgebra( Range( phi ), phi2 );
      fi;
      phi2 := MapFromHomogenousPartOverSymmetricAlgebraToHomogeneousPartOverExteriorAlgebra( H_target );
      
      phi := CompleteImageSquare( phi1, phi, phi2 );
      
      phi := S * phi;
      
      psi := HomalgChainMorphism( phi, HomalgCocomplex( Source( phi ), reg_sheaf ), HomalgCocomplex( Range( phi ), reg_sheaf ), reg_sheaf );

      for jj in [ 1 .. reg_sheaf ] do
          j := reg_sheaf - jj;

          phi := HomogeneousPartOverCoefficientsRing( j, CertainMorphism( lin_tate, j ) );
          
          H_source := HomogeneousPartOverCoefficientsRing( j, F_source );
          H_target := HomogeneousPartOverCoefficientsRing( j, F_target );
          
          #phi1 := isomorphism from H_source to Source( phi )
          if not HasMapFromHomogenousPartOverSymmetricAlgebraToHomogeneousPartOverExteriorAlgebra( H_source ) then
              phi1 := GradedMap( HomalgIdentityMatrix( NrGenerators( H_source ), k ), H_source, Source( phi ) );
              Assert( 1, IsMorphism( phi1 ) );
              SetIsMorphism( phi1, true );
              SetMapFromHomogenousPartOverSymmetricAlgebraToHomogeneousPartOverExteriorAlgebra( H_source, phi1 );
              SetMapFromHomogenousPartOverExteriorAlgebraToHomogeneousPartOverSymmetricAlgebra( Source( phi ), phi1 );
          fi;
          phi1 := MapFromHomogenousPartOverSymmetricAlgebraToHomogeneousPartOverExteriorAlgebra( H_source );
          #phi2 := isomorphism from H_target to Range( phi )
          if not HasMapFromHomogenousPartOverSymmetricAlgebraToHomogeneousPartOverExteriorAlgebra( H_target ) then
              phi2 := GradedMap( HomalgIdentityMatrix( NrGenerators( H_target ), k ), H_target, Range( phi ) );
              Assert( 1, IsMorphism( phi2 ) );
              SetIsMorphism( phi2, true );
              SetMapFromHomogenousPartOverSymmetricAlgebraToHomogeneousPartOverExteriorAlgebra( H_target, phi2 );
              SetMapFromHomogenousPartOverExteriorAlgebraToHomogeneousPartOverSymmetricAlgebra( Range( phi ), phi2 );
          fi;
          phi2 := MapFromHomogenousPartOverSymmetricAlgebraToHomogeneousPartOverExteriorAlgebra( H_target );
          
          phi := CompleteImageSquare( phi1, phi, phi2 );
          
          phi := S * phi;
          
          Add( Source( phi ), Source( psi ) );
          Add( Range( phi ), Range( psi ) );
          Add( phi, psi );
          
      od;
      
      return ConstructMorphismFromLayers( F_source, F_target, psi );
      
end );

InstallValue( Functor_HomogeneousExteriorComplexToModule_ForGradedModules,
        CreateHomalgFunctor(
                [ "name", "HomogeneousExteriorComplexToModule" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "HomogeneousExteriorComplexToModule" ],
                [ "number_of_arguments", 1 ],
                [ "0", [ IsInt ] ],
                [ "1", [ [ "covariant", "left adjoint", "distinguished" ], [ IsHomalgComplex, IsHomalgChainMorphism ] ] ],
                [ "OnObjects", _Functor_HomogeneousExteriorComplexToModule_OnGradedModules ],
                [ "OnMorphisms", _Functor_HomogeneousExteriorComplexToModule_OnGradedMaps ],
                [ "CompareArgumentsForFunctorObj", CompareArgumentsForHomogeneousExteriorComplexToModuleOnObjects ]
                )
        );

Functor_HomogeneousExteriorComplexToModule_ForGradedModules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_HomogeneousExteriorComplexToModule_ForGradedModules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctor( Functor_HomogeneousExteriorComplexToModule_ForGradedModules );

##
## ModuleOfGlobalSections
##
## (cf. Eisenbud, Floystad, Schreyer: Sheaf Cohomology and Free Resolutions over Exterior Algebras)

InstallGlobalFunction( _Functor_ModuleOfGlobalSections_OnGradedModules,    ### defines: ModuleOfGlobalSections (object part)
  function( M )
    local reg, tate, B, reg_sheaf, lin_tate, HM, i, hom_part;
      
      if HasIsModuleOfGlobalSections( M ) and IsModuleOfGlobalSections( M ) then
          return M;
      fi;
      
      if HasIsFree( UnderlyingModule( M ) ) and IsFree( UnderlyingModule( M ) ) then
            
            HM := Source( TruncatedSubmoduleEmbed( 0, M ) );
            
            if DegreesOfGenerators( HM ) = [ ] then
                reg_sheaf := -999999;
            else
                reg_sheaf := Maximum( DegreesOfGenerators( HM ) );
            fi;
            Assert( 3, CastelnuovoMumfordRegularity( HM ) = reg_sheaf );
            SetCastelnuovoMumfordRegularity( HM, reg_sheaf );
            
        elif CastelnuovoMumfordRegularity( M ) <=0 then
        
            HM := Source( TruncatedSubmoduleEmbed( 0, M ) );
            if DegreesOfGenerators( HM ) = [ ] then
                reg_sheaf := -999999;
            else
                reg_sheaf := 0;
            fi;
            Assert( 3, CastelnuovoMumfordRegularity( HM ) = reg_sheaf );
            SetCastelnuovoMumfordRegularity( HM, reg_sheaf );
            

      else
          
          reg := Maximum( 0, CastelnuovoMumfordRegularity( M ) );
          lin_tate := LinearStrandOfTateResolution( M, 0, reg+1 );
          reg_sheaf := lin_tate!.regularity;
          
          HM := HomogeneousExteriorComplexToModule( reg_sheaf, lin_tate );
          
          Assert( 3, CastelnuovoMumfordRegularity( HM ) = reg_sheaf );
          SetCastelnuovoMumfordRegularity( HM, reg_sheaf );
          
      fi;
      
      SetIsModuleOfGlobalSections( HM, true );
      
      SetTrivialArtinianSubmodule( HM, true );
      
      return HM;
      
end );

##
InstallGlobalFunction( _Functor_ModuleOfGlobalSections_OnGradedMaps, ### defines: ModuleOfGlobalSections (morphism part)
  function( F_source, F_target, arg_before_pos, mor, arg_behind_pos )
      local reg, lin_tate, reg_sheaf, H_mor;
      
      if IsIdenticalObj( Source( mor ), F_source ) and IsIdenticalObj( Range( mor ), F_target ) then
          return mor;
      fi;
      
      reg := Maximum( 0, CastelnuovoMumfordRegularity( mor ) );

      lin_tate := LinearStrandOfTateResolution( mor, 0, reg+1 );
      
      reg_sheaf := Maximum( 0, CastelnuovoMumfordRegularity( F_source ), CastelnuovoMumfordRegularity( F_target ) );
      
      # setting these functors is vital, since ModuleOfGlobalSections on object does not compute with
      # HomogeneousExteriorComplexToModule in every case, but we want to have identical objects
      if fail = GetFunctorObjCachedValue( Functor_HomogeneousExteriorComplexToModule_ForGradedModules, [ reg_sheaf, Source( lin_tate ) ] ) then
          SetFunctorObjCachedValue( Functor_HomogeneousExteriorComplexToModule_ForGradedModules, [ reg_sheaf, Source( lin_tate ) ], ModuleOfGlobalSections( Source( mor ) ) );
      fi;
      if fail = GetFunctorObjCachedValue( Functor_HomogeneousExteriorComplexToModule_ForGradedModules, [ reg_sheaf, Range( lin_tate ) ] ) then
          SetFunctorObjCachedValue( Functor_HomogeneousExteriorComplexToModule_ForGradedModules, [ reg_sheaf, Range( lin_tate ) ], ModuleOfGlobalSections( Range( mor ) ) );
      fi;
      
      H_mor := HomogeneousExteriorComplexToModule( reg_sheaf, lin_tate );
      
      #TODO: ( this does not exist in homalg)
      # ModuleOfGlobalSections is a projection
#       SetFunctorObjCachedValue( Functor_ModuleOfGlobalSections_ForGradedModules, [ H_mor ], H_mor );
      
      return H_mor;
    
end );

##
## We create a map by following the layers from 
## T1) the homogeneous layers of M to
## T2) the homogenous parts of coefficients rings in R(M) to
## T3) the linear strand of the Tate resolution of M (we possibly need to do CompleteImageSquare here to get down from the regularity of the module to the regularity of the sheaf) to
## T4) the homogenous parts of coefficients rings in R(Gamma(M)) (we possibly need to do CompleteKernelSquare here to get back up from the regularity of the sheaf to the regularity of the module) to
## T5) the homogeneous layers of Gamma(M)
##
InstallMethod( NaturalMapToModuleOfGlobalSections,
        "for homalg graded modules",
        [ IsGradedModuleRep ],

  function( M )
    local S, A, regM, HM, regHM, T1, i, RM, T2, t1, linTM, T3, tau2, ii, t2, RHM, T4, T5, tau3, alpha, id1, id2, t3, t4, phi;
    
    if HasIsModuleOfGlobalSections( M ) and IsModuleOfGlobalSections( M ) then
        return TheIdentityMorphism( M );
    fi;
    
    S := HomalgRing( M );
    
    A := KoszulDualRing( S );
    
    regM := CastelnuovoMumfordRegularity( M );
    
    HM := ModuleOfGlobalSections( M );
    
    regHM := CastelnuovoMumfordRegularity( HM );
    
    T1 := HomalgCocomplex( HomogeneousPartOverCoefficientsRing( 0, M ), 0 );
    for i in [ 1 .. regM +1 ] do
        Add( T1, HomogeneousPartOverCoefficientsRing( i, M ) );
    od;
    
    RM := KoszulRightAdjoint( M, 0, regM + 1 );
    T2 := HomalgCocomplex( HomogeneousPartOverCoefficientsRing( 0, CertainObject( RM, 0 ) ), 0 );
    for i in [ 1 .. regM +1 ] do
        Add( T2, HomogeneousPartOverCoefficientsRing( i, CertainObject( RM, i ) ) );
    od;
    
    t1 := HomalgChainMorphism( MapFromHomogeneousPartofModuleToHomogeneousPartOfKoszulRightAdjoint( 0, M ), T1, T2, 0 );
    for i in [ 1 .. regM +1 ] do
        Add( t1, MapFromHomogeneousPartofModuleToHomogeneousPartOfKoszulRightAdjoint( i, M ) );
    od;
    Assert( 1, IsMorphism( t1 ) );
    SetIsMorphism( t1, true );
    
    linTM := LinearStrandOfTateResolution( M, 0, regM + 1 );
    T3 := HomalgCocomplex( HomogeneousPartOverCoefficientsRing( 0, CertainObject( linTM, 0 ) ), 0 );
    for i in [ 1 .. regM +1 ] do
        Add( T3, HomogeneousPartOverCoefficientsRing( i, CertainObject( linTM, i ) ) );
    od;
    
    tau2 := HomalgChainMorphism( TheIdentityMorphism( CertainObject( RM, regM + 1 ) ), RM, linTM, regM + 1 );
    for ii in [ 0 .. regM ] do
        i := regM - ii;
        Add( CompleteImageSquare( CertainMorphism( RM, i ), LowestDegreeMorphism( tau2 ), CertainMorphism( linTM, i ) ), tau2 );
    od;
    
    t2 := HomalgChainMorphism( HomogeneousPartOverCoefficientsRing( 0, CertainMorphism( tau2, 0 ) ), T2, T3, 0 );
    for i in [ 1 .. regM +1 ] do
        Add( t2, HomogeneousPartOverCoefficientsRing( i, CertainMorphism( tau2, i ) ) );
    od;
    Assert( 1, IsMorphism( t2 ) );
    SetIsMorphism( t2, true );
    
    RHM := KoszulRightAdjoint( HM, 0, regM + 1 );
    T4 := HomalgCocomplex( HomogeneousPartOverCoefficientsRing( 0, CertainObject( RHM, 0 ) ), 0 );
    for i in [ 1 .. regM +1 ] do
        Add( T4, HomogeneousPartOverCoefficientsRing( i, CertainObject( RHM, i ) ) );
    od;
    
    tau3 := HomalgChainMorphism( NaturalMapFromExteriorComplexToRightAdjoint( CertainObject( linTM, 0 ) ), linTM, RHM, 0 );
    for i in [ 1 .. regM + 1 ] do
        # we cannot do CompleteKernelSquare, because CertainMorphism( linTM, i - 1 ) is not epi
        # Add( tau3, CompleteKernelSquare( CertainMorphism( linTM, i - 1 ), HighestDegreeMorphism( tau3 ), CertainMorphism( RHM, i - 1 ) ) );
        alpha := CompleteImageSquare( GradedHom( CertainMorphism( RHM, i - 1 ), A ), GradedHom( HighestDegreeMorphism( tau3 ), A ), GradedHom( CertainMorphism( linTM, i - 1 ), A ) );
        alpha := GradedHom( alpha, A );
        Assert( 1, IsIsomorphism( alpha ) );
        SetIsIsomorphism( alpha, true );
        id1 := NatTrIdToHomHom_R( CertainObject( linTM, i ) );
        Assert( 1, IsIsomorphism( id1 ) );
        SetIsIsomorphism( id1, true );
        id2 := NatTrIdToHomHom_R( CertainObject( RHM, i ) );
        Assert( 1, IsIsomorphism( id2 ) );
        SetIsIsomorphism( id2, true );
        Add( tau3, PreCompose( PreCompose( id1, alpha ), id2^(-1) ) );
    od;
    
    t3 := HomalgChainMorphism( HomogeneousPartOverCoefficientsRing( 0, CertainMorphism( tau3, 0 ) ), T3, T4, 0 );
    for i in [ 1 .. regM +1 ] do
        Add( t3, HomogeneousPartOverCoefficientsRing( i, CertainMorphism( tau3, i ) ) );
    od;
    Assert( 1, IsMorphism( t3 ) );
    SetIsMorphism( t3, true );
    
    T5 := HomalgCocomplex( HomogeneousPartOverCoefficientsRing( 0, HM ), 0 );
    for i in [ 1 .. regM +1 ] do
        Add( T5, HomogeneousPartOverCoefficientsRing( i, HM ) );
    od;
    
    t4 := HomalgChainMorphism( MapFromHomogeneousPartofModuleToHomogeneousPartOfKoszulRightAdjoint( 0, HM )^(-1), T4, T5, 0 );
    for i in [ 1 .. regM +1 ] do
        Add( t4, MapFromHomogeneousPartofModuleToHomogeneousPartOfKoszulRightAdjoint( i, HM )^(-1) );
    od;
    Assert( 1, IsMorphism( t4 ) );
    SetIsMorphism( t4, true );
    
    phi := PreCompose( PreCompose( t1, t2 ), PreCompose( t3, t4 ) );
    
    return ConstructMorphismFromLayers( Source( TruncatedSubmoduleEmbed( 0, M ) ), HM, S * phi );
    
end );

InstallValue( Functor_ModuleOfGlobalSections_ForGradedModules,
        CreateHomalgFunctor(
                [ "name", "ModuleOfGlobalSections" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "ModuleOfGlobalSections" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant", "left adjoint", "distinguished" ], HOMALG_GRADED_MODULES.FunctorOn ] ],
                [ "OnObjects", _Functor_ModuleOfGlobalSections_OnGradedModules ],
                [ "OnMorphisms", _Functor_ModuleOfGlobalSections_OnGradedMaps ],
                [ "MorphismConstructor", HOMALG_GRADED_MODULES.category.MorphismConstructor ]
                )
        );

Functor_ModuleOfGlobalSections_ForGradedModules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_ModuleOfGlobalSections_ForGradedModules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctor( Functor_ModuleOfGlobalSections_ForGradedModules );


##
## GuessModuleOfGlobalSectionsFromATateMap
##

##
InstallMethod( GuessModuleOfGlobalSectionsFromATateMap,
        "for homalg modules",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    
    return GuessModuleOfGlobalSectionsFromATateMap( 1, phi );
    
end );

InstallGlobalFunction( _Functor_GuessModuleOfGlobalSectionsFromATateMap_OnGradedMaps, ### defines: GuessModuleOfGlobalSectionsFromATateMap (object part)
        [ IsInt, IsMapOfGradedModulesRep ],
        
  function( steps, phi )
    local A, psi, deg, lin_tate, alpha, j, K, tate, i, tate2;
    
    Info( InfoWarning, 1, "GuessModuleOfGlobalSectionsFromATateMap uses unproven assumptions.\n Do not trust the result." );
    
    A := HomalgRing( phi );
    
    # go up to the regularity
    
    psi := GradedHom( phi, A );
    
    deg := Minimum( DegreesOfGenerators( Source( psi ) ) );
    
    lin_tate := HomalgCocomplex( psi, deg );
    
    alpha := LowestDegreeMorphism( lin_tate );
    
    for j in [ 1 .. Maximum( 1, steps ) ] do
    
        repeat
                
            K := Kernel( alpha );
            ByASmallerPresentation( K );
            Add( PreCompose( HullEpi( K ), KernelEmb( alpha ) ), lin_tate );
        
            alpha := LowestDegreeMorphism( lin_tate );
            
            deg := Minimum( DegreesOfGenerators( Source( alpha ) ) );
            if deg <> Minimum( ObjectDegreesOfComplex( lin_tate ) ) then
                lin_tate := HomalgCocomplex( alpha, deg );
            fi;
            
        until Minimum( DegreesOfGenerators( Source( alpha ) ) ) = Maximum( DegreesOfGenerators( Source( alpha ) ) )
          and Minimum( DegreesOfGenerators( Range( alpha ) ) ) = Maximum( DegreesOfGenerators( Range( alpha ) ) )
          and DegreesOfGenerators( Range( alpha ) )[1] = DegreesOfGenerators( Source( alpha ) )[1] + 1;
          
    od;
      
    lin_tate := LinearStrand( 0, lin_tate );
    
    tate := GradedHom( lin_tate, A );
    
    for i in MorphismDegreesOfComplex( tate ) do
        if not IsBound( tate2 ) then
            tate2 := HomalgCocomplex( CertainMorphism( tate, i ), -i );
        else
            Add( CertainMorphism( tate, i ), tate2 );
        fi;
    od;
    
    # go down to 0
    
    ResolveLinearly( Minimum( ObjectDegreesOfComplex( tate2 ) ), tate2 );
    
    # reconstruct the module
    
    return HomogeneousExteriorComplexToModule( Maximum( ObjectDegreesOfComplex( tate2 ) ) - 1, tate2 );
    
    
    
end );

InstallValue( Functor_GuessModuleOfGlobalSectionsFromATateMap_ForGradedMaps,
        CreateHomalgFunctor(
                [ "name", "GuessModuleOfGlobalSectionsFromATateMap" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "GuessModuleOfGlobalSectionsFromATateMap" ],
                [ "number_of_arguments", 1 ],
                [ "0", [ IsInt ] ],
                [ "1", [ [ "covariant", "left adjoint", "distinguished" ], [ IsMapOfGradedModulesRep ] ] ],
                [ "OnObjects", _Functor_GuessModuleOfGlobalSectionsFromATateMap_OnGradedMaps ],
                [ "MorphismConstructor", HOMALG_MODULES.category.MorphismConstructor ]
                )
        );

Functor_GuessModuleOfGlobalSectionsFromATateMap_ForGradedMaps!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctor( Functor_GuessModuleOfGlobalSectionsFromATateMap_ForGradedMaps );
