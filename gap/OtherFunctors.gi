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
            psi2 := HomalgChainMap( phi2, T2, T, i );
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
            psi1 := HomalgChainMap( phi1, T1, T2, i );
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
                [ "1", [ [ "covariant", "left adjoint", "distinguished" ], [ IsHomalgComplex, IsHomalgChainMap ] ] ],
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
        "for arguemnt lists of the functor HomogeneousExteriorComplexToModule on objects",
        [ IsList, IsList ],

  function( l_old, l_new )
      
      return l_old[1] <= l_new[1]
          and 0 in MorphismDegreesOfComplex( l_old[2] )
          and 0 in MorphismDegreesOfComplex( l_new[2] )
          and IsIdenticalObj( CertainMorphism( l_old[2], 0 ), CertainMorphism( l_new[2], 0 ) );
      
end );

InstallGlobalFunction( _Functor_HomogeneousExteriorComplexToModule_OnGradedModules,    ### defines: HomogeneousExteriorComplexToModule (object part)
  function( reg_sheaf, lin_tate )
      local result, EmbeddingsOfHigherDegrees, jj, j, tate_morphism, psi,extension_map, var_s_morphism, T, T2, k, T2b;
      
      result := ModulefromExtensionMap( CertainMorphism( lin_tate, reg_sheaf ) );
      
#   each new step constructs a new StdM as pushout of 
#   extension_map*LeftPushoutMap  and  var_s_morphism.
#   These maps are created from a modified Tate resolution.
#
#     StdM = new (+) old                                   Range( var_s_morphism )
#             /\                                                  /\
#             |                                                   |
#             |                                                   |
#             | LeftPushoutMap                                    | var_s_morphism
#             |                                                   |
#             |           extension_map                           |
#           new  <-------------------------------- Source( var_s_morphism ) = Source( extension_map )
      
      result := Pushout( TheZeroMorphism( Zero( result ), result ), TheZeroMorphism( Zero( result ), Zero( result ) ) );
      
      EmbeddingsOfHigherDegrees := rec( (String( reg_sheaf )) := TheIdentityMorphism( result ) );
      
      for jj in [ 1 .. reg_sheaf ] do
          j := reg_sheaf - jj;
          
          # create the extension map from the tate-resolution
          # e.g. ( e_0, e_1, 3*e_0+2*e_1 ) leads to  /   1,   0,   3   \
          #                                          \   0,   1,   2   /
          # but the gaussian algorithm is applied to the latter matrix (both to rows an columns) for easier simplification
          tate_morphism := CertainMorphism( lin_tate, j );
          
          psi := LeftPushoutMap( result );
          
          extension_map := ExtensionMapsFromExteriorComplex( tate_morphism, psi );
          var_s_morphism := extension_map[1];
          T := extension_map[3];
          extension_map := extension_map[2];
          
          # this line computes the standard module
          result := Pushout( var_s_morphism, PreCompose( extension_map, psi ) );
          
          # This direct sum will be used in different contextes of the summands.
          # We need to ensure that we speak about the same object in each of these cases.
          # Thus, we force homalg to return this object regardless of the context of the summands.
          Range( NaturalGeneralizedEmbedding( result ) )!.IgnoreContextOfArgumentsOfFunctor := true;
          UnderlyingModule( Range( NaturalGeneralizedEmbedding( result ) ) )!.IgnoreContextOfArgumentsOfFunctor := true;
          
          # the "old" StandardModule (the one generated in larger degree) embeds into the new one
          Assert( 1, IsMonomorphism( RightPushoutMap( result ) ) );
          SetIsMonomorphism( RightPushoutMap( result ), true );
          
          # the following block simplifies the standardmodule much faster than ByASmallerPresentation could.
          # We know in advance, which generators we need to generate result. These are 
          # 1) the new generators, i.e. Image( var_s_morphism ),
          # 2) a basis of Cokernel( extension_map ) (which is free), i.e. Image( T ),
          # 3) and the older generators, which have not been made superfluous, i.e. CertainGenerators( result, k ).
          # We build the CoproductMorphism T2 of these three morphisms and its image is a smaller presentation of result
          T := PreCompose( PreCompose( T, psi ), RightPushoutMap( result ) );
          T2 := CoproductMorphism( LeftPushoutMap( result ), T );
          k := PositionProperty( DegreesOfGenerators( result ), function( a ) return a > j+1; end );
          if k <> fail then
              k := [ k .. NrGenerators( result ) ];
              T2b := GradedMap( CertainGenerators( result, k ), "free", result );
              Assert( 1, IsMorphism( T2b ) );
              SetIsMorphism( T2b, true );
              T2 := CoproductMorphism( T2, T2b );
          fi;
          Assert( 1, IsEpimorphism( T2 ) );
          SetIsEpimorphism( T2, true );
          PushPresentationByIsomorphism( NaturalGeneralizedEmbedding( ImageObject( T2 ) ) );
          
          # try to keep the information about higher modules
          EmbeddingsOfHigherDegrees!.(String(j)) := TheIdentityMorphism( result );
          for k in [ j + 1 .. reg_sheaf ] do
              EmbeddingsOfHigherDegrees!.(String(k)) := PreCompose( EmbeddingsOfHigherDegrees!.(String(k)), RightPushoutMap( result ) );
          od;
          
      od;
      
      result!.EmbeddingsOfHigherDegrees := EmbeddingsOfHigherDegrees;
      
      return result;
      
end );

# Constructs a morphism between two modules F_source and F_target from the degree-zero cochain map lin_tate
# Since F_source and F_target were created by this functor, we can assume the structure from above
# and use the morphisms of the cochain map as maps between the targets of var_s_morphism.
InstallGlobalFunction( _Functor_HomogeneousExteriorComplexToModule_OnGradedMaps,    ### defines: HomogeneousExteriorComplexToModule (morphism part)
  function( F_source, F_target, arg_before_pos, lin_tate, arg_behind_pos )
    local S, Embeddings_source, Embeddings_target, reg_sheaf, jj, j,
          SubmoduleGeneratedInDegree_j_source, SubmoduleGeneratedInDegree_j_target, phi,
          FreeModuleGeneratedInDegree_j_source, FreeModuleGeneratedInDegree_j_target, phi_new,
          Pushout_source, Pushout_target;
      
      S := HomalgRing( F_source );
      
      Assert( 4, IsIdenticalObj( S, KoszulDualRing( HomalgRing( lin_tate ) ) ) );
      
      Embeddings_source := F_source!.EmbeddingsOfHigherDegrees;
      Embeddings_target := F_target!.EmbeddingsOfHigherDegrees;
      
      reg_sheaf := arg_before_pos[1];
      
      SubmoduleGeneratedInDegree_j_source := Source( Embeddings_source!.(String( reg_sheaf )) );
      SubmoduleGeneratedInDegree_j_target := Source( Embeddings_target!.(String( reg_sheaf )) );
      
      phi := GradedMap( S * MatrixOfMap( CertainMorphism( lin_tate, reg_sheaf ) ), SubmoduleGeneratedInDegree_j_source, SubmoduleGeneratedInDegree_j_target, S );
      Assert( 1, IsMorphism( phi ) );
      SetIsMorphism( phi, true );
      
      for jj in [ 1 .. reg_sheaf ] do
          j := reg_sheaf - jj;
          
          SubmoduleGeneratedInDegree_j_source := Source( Embeddings_source!.(String( j )) );
          SubmoduleGeneratedInDegree_j_target := Source( Embeddings_target!.(String( j )) );
          
          FreeModuleGeneratedInDegree_j_source := Source( PushoutPairOfMaps( SubmoduleGeneratedInDegree_j_source )[1] );
          FreeModuleGeneratedInDegree_j_target := Source( PushoutPairOfMaps( SubmoduleGeneratedInDegree_j_target )[1] );
          
          phi_new := GradedMap( S * MatrixOfMap( CertainMorphism( lin_tate, j ) ), FreeModuleGeneratedInDegree_j_source, FreeModuleGeneratedInDegree_j_target, S );
          Assert( 1, IsMorphism( phi_new ) );
          SetIsMorphism( phi_new, true );
          
          Pushout_source := Genesis( SubmoduleGeneratedInDegree_j_source )[1][1]!.arguments_of_functor[1];
          Pushout_target := Genesis( SubmoduleGeneratedInDegree_j_target )[1][1]!.arguments_of_functor[1];
          
          phi := Pushout(
                    HighestDegreeMorphism( Source( Pushout_source ) ),
                    HighestDegreeMorphism( Pushout_source ),
                    phi_new,
                    phi,
                    HighestDegreeMorphism( Source( Pushout_target ) ),
                    HighestDegreeMorphism( Pushout_target )
                 );
          
      od;
      
      return phi;
      
end );

InstallValue( Functor_HomogeneousExteriorComplexToModule_ForGradedModules,
        CreateHomalgFunctor(
                [ "name", "HomogeneousExteriorComplexToModule" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "HomogeneousExteriorComplexToModule" ],
                [ "number_of_arguments", 1 ],
                [ "0", [ IsInt ] ],
                [ "1", [ [ "covariant", "left adjoint", "distinguished" ], [ IsHomalgComplex, IsHomalgChainMap ] ] ],
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
## StandardModule
##
## (cf. Eisenbud, Floystad, Schreyer: Sheaf Cohomology and Free Resolutions over Exterior Algebras)

InstallGlobalFunction( _Functor_StandardModule_OnGradedModules,    ### defines: StandardModule (object part)
  function( M )
      local reg, tate, B, reg_sheaf, lin_tate, StdM;
      
#       if IsBound( M!.StandardModule ) then
#           return M!.StandardModule;
#       fi;
      
#       if HasIsFree( UnderlyingModule( M ) ) and IsFree( UnderlyingModule( M ) ) then
#           StdM := M;
#           reg_sheaf := Maximum( 0, CastelnuovoMumfordRegularity( M ) );
#           
#       else
          
          reg := Maximum( 0, CastelnuovoMumfordRegularity( M ) );
          
#           tate := TateResolution( M, 0, reg+1 );
#           
#           # Compute the regularity of the sheaf
#           # it might be smaller than the regularity of the module
#           B := BettiDiagram( tate )!.matrix;
#           if Length( B ) = 1 then
#               reg_sheaf := 0;
#           else
#               reg_sheaf := Maximum( List( [ 1 .. Length( B ) - 1 ], j -> Position( B[ j ], 0 ) ) ) - 1;
#               if reg_sheaf = fail then
#                   reg_sheaf := reg;
#               fi;
#           fi;
#           
#           lin_tate := LinearStrand( 0, tate );
          
          lin_tate := LinearStrandOfTateResolution( M, 0, reg+1 );
          reg_sheaf := lin_tate!.regularity;
          
          StdM := HomogeneousExteriorComplexToModule( reg_sheaf, lin_tate );
          
          Assert( 3, CastelnuovoMumfordRegularity( StdM ) = reg_sheaf );
          SetCastelnuovoMumfordRegularity( StdM, reg_sheaf );
      
#       fi;
      
      StdM!.StandardModule := StdM;
      
      return StdM;
      
end );

##
InstallGlobalFunction( _Functor_StandardModule_OnGradedMaps, ### defines: StandardModule (morphism part)
  function( F_source, F_target, arg_before_pos, mor, arg_behind_pos )
      local reg, lin_tate, reg_sheaf, Std_mor;
      
#       if IsBound( mor!.StandardModule ) then
#           return mor!.StandardModule;
#       fi;
      
      reg := Maximum( 0, CastelnuovoMumfordRegularity( mor ) );
      
#       lin_tate := LinearStrand( 0, TateResolution( mor, 0, reg+1 ) );

      lin_tate := LinearStrandOfTateResolution( mor, 0, reg+1 );
      
      reg_sheaf := Maximum( 0, CastelnuovoMumfordRegularity( F_source ), CastelnuovoMumfordRegularity( F_target ) );
      
      Std_mor := HomogeneousExteriorComplexToModule( reg_sheaf, lin_tate );
      
      Assert( 0, IsIdenticalObj( F_target, Range( Std_mor ) ) );
      
      Std_mor!.StandardModule := Std_mor;
      
      return Std_mor;
    
end );

InstallValue( Functor_StandardModule_ForGradedModules,
        CreateHomalgFunctor(
                [ "name", "StandardModule" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "StandardModule" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant", "left adjoint", "distinguished" ], HOMALG_GRADED_MODULES.FunctorOn ] ],
                [ "OnObjects", _Functor_StandardModule_OnGradedModules ],
                [ "OnMorphisms", _Functor_StandardModule_OnGradedMaps ],
                [ "MorphismConstructor", HOMALG_GRADED_MODULES.category.MorphismConstructor ]
                )
        );

Functor_StandardModule_ForGradedModules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_StandardModule_ForGradedModules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctor( Functor_StandardModule_ForGradedModules );


##
## HomogeneousPartOverCoefficientsRing
##

##  <#GAPDoc Label="HomogeneousPartOverCoefficientsRing">
##  <ManSection>
##    <Oper Arg="d, M" Name="HomogeneousPartOverCoefficientsRing"/>
##    <Returns>a &homalg; module</Returns>
##    <Description>
##      The degree <M>d</M> homogeneous part of the graded <M>R</M>-module <A>M</A>
##      as a module over the coefficient ring or field of <M>R</M>.
##      <#Include Label="HomogeneousPartOverCoefficientsRing:example">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( RepresentationOfMorphismOnHomogeneousParts,
        "for homalg ring elements",
        [ IsMapOfGradedModulesRep, IsInt, IsInt ],
        
  function( phi, m, n )
    local S, M, N, M_le_m, M_le_m_epi, N_le_n, N_le_n_epi, phi_le_m;
    
    if m > n then
        Error( "The first given degree needs to be larger then the second one" );
    fi;
    
    S := HomalgRing( phi );
    
    M := Source( phi );
    
    N := Range( phi );
    
    M_le_m := SubmoduleGeneratedByHomogeneousPart( m, M );
    
    M_le_m_epi := M_le_m!.map_having_subobject_as_its_image;
    
    N_le_n := SubmoduleGeneratedByHomogeneousPart( n, N );
    
    N_le_n_epi := N_le_n!.map_having_subobject_as_its_image;
    
    return CompleteImageSquare( M_le_m_epi, phi, N_le_n_epi );
    
end );

InstallGlobalFunction( _Functor_HomogeneousPartOverCoefficientsRing_OnGradedModules , ### defines: HomogeneousPartOverCoefficientsRing (object part)
        [ IsInt, IsGradedModuleOrGradedSubmoduleRep ],
        
  function( d, M )
    local S, k, N, gen, l, rel, result;
    
    S := HomalgRing( M );
    
    if not HasCoefficientsRing( S ) then
        TryNextMethod( );
    fi;
    
    k := CoefficientsRing( S );
    
    N := SubmoduleGeneratedByHomogeneousPart( d, M );
    
    gen := GeneratorsOfModule( N );
    
    gen := NewHomalgGenerators( MatrixOfGenerators( gen ), gen );
    
    gen!.ring := k;
    
    l := NrGenerators( gen );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        rel := HomalgZeroMatrix( 0, l, k );
        rel := HomalgRelationsForLeftModule( rel );
    else
        rel := HomalgZeroMatrix( l, 0, k );
        rel := HomalgRelationsForRightModule( rel );
    fi;
    
    result := Presentation( gen, rel );
    
    result!.GradedRingOfAmbientGradedModule := S;
    
    result!.NaturalGeneralizedEmbedding := TheIdentityMorphism( result );
    
    return result;
    
end );


##
InstallGlobalFunction( _Functor_HomogeneousPartOverCoefficientsRing_OnGradedMaps, ### defines: HomogeneousPartOverCoefficientsRing (morphism part)
  function( F_source, F_target, arg_before_pos, phi, arg_behind_pos )
    local S, k, d, mat;
    
    S := HomalgRing( phi );
    
    if not HasCoefficientsRing( S ) then
        TryNextMethod( );
    fi;
    
    k := CoefficientsRing( S );
    
    d := arg_before_pos[1];
    
    mat := k * MatrixOfMap( RepresentationOfMorphismOnHomogeneousParts( phi, d, d ) );
    
    return HomalgMap( mat, F_source, F_target );
    
end );

InstallValue( Functor_HomogeneousPartOverCoefficientsRing_ForGradedModules,
        CreateHomalgFunctor(
                [ "name", "HomogeneousPartOverCoefficientsRing" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "HomogeneousPartOverCoefficientsRing" ],
                [ "number_of_arguments", 1 ],
                [ "0", [ IsInt ] ],
                [ "1", [ [ "covariant", "left adjoint", "distinguished" ], HOMALG_GRADED_MODULES.FunctorOn ] ],
                [ "OnObjects", _Functor_HomogeneousPartOverCoefficientsRing_OnGradedModules ],
                [ "OnMorphisms", _Functor_HomogeneousPartOverCoefficientsRing_OnGradedMaps ],
                [ "MorphismConstructor", HOMALG_MODULES.category.MorphismConstructor ]
                )
        );

Functor_HomogeneousPartOverCoefficientsRing_ForGradedModules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_HomogeneousPartOverCoefficientsRing_ForGradedModules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctor( Functor_HomogeneousPartOverCoefficientsRing_ForGradedModules );

##
## HomogeneousPartOfDegreeZeroOverCoefficientsRing
##

InstallGlobalFunction( _Functor_HomogeneousPartOfDegreeZeroOverCoefficientsRing_OnGradedModules , ### defines: HomogeneousPartOfDegreeZeroOverCoefficientsRing (object part)
        [ IsGradedModuleOrGradedSubmoduleRep ],
        
  function( M )
    
    return HomogeneousPartOverCoefficientsRing( 0, M );
    
end );


##
InstallGlobalFunction( _Functor_HomogeneousPartOfDegreeZeroOverCoefficientsRing_OnGradedMaps, ### defines: HomogeneousPartOfDegreeZeroOverCoefficientsRing (morphism part)
  function( F_source, F_target, arg_before_pos, phi, arg_behind_pos )
    
    return HomogeneousPartOverCoefficientsRing( 0, phi );
    
end );

InstallValue( Functor_HomogeneousPartOfDegreeZeroOverCoefficientsRing_ForGradedModules,
        CreateHomalgFunctor(
                [ "name", "HomogeneousPartOfDegreeZeroOverCoefficientsRing" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "HomogeneousPartOfDegreeZeroOverCoefficientsRing" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant", "left adjoint", "distinguished" ], HOMALG_GRADED_MODULES.FunctorOn ] ],
                [ "OnObjects", _Functor_HomogeneousPartOfDegreeZeroOverCoefficientsRing_OnGradedModules ],
                [ "OnMorphisms", _Functor_HomogeneousPartOfDegreeZeroOverCoefficientsRing_OnGradedMaps ],
                [ "MorphismConstructor", HOMALG_MODULES.category.MorphismConstructor ]
                )
        );

Functor_HomogeneousPartOfDegreeZeroOverCoefficientsRing_ForGradedModules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_HomogeneousPartOfDegreeZeroOverCoefficientsRing_ForGradedModules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctor( Functor_HomogeneousPartOfDegreeZeroOverCoefficientsRing_ForGradedModules );

##
## GuessGlobalSectionsModuleFromATateMap
##

##
InstallMethod( GuessGlobalSectionsModuleFromATateMap,
        "for homalg modules",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    
    return GuessGlobalSectionsModuleFromATateMap( 1, phi );
    
end );

InstallGlobalFunction( _Functor_GuessGlobalSectionsModuleFromATateMap_OnGradedMaps, ### defines: GuessGlobalSectionsModuleFromATateMap (object part)
        [ IsMapOfGradedModulesRep ],
        
  function( steps, phi )
    local A, psi, deg, lin_tate, alpha, j, K, tate, i, tate2;
    
    Info( InfoWarning, 1, "GuessGlobalSectionsModuleFromATateMap uses unproven assumptions.\n Do not trust the result." );
    
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

InstallValue( Functor_GuessGlobalSectionsModuleFromATateMap_ForGradedMaps,
        CreateHomalgFunctor(
                [ "name", "GuessGlobalSectionsModuleFromATateMap" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "GuessGlobalSectionsModuleFromATateMap" ],
                [ "number_of_arguments", 1 ],
                [ "0", [ IsInt ] ],
                [ "1", [ [ "covariant", "left adjoint", "distinguished" ], [ IsMapOfGradedModulesRep ] ] ],
                [ "OnObjects", _Functor_GuessGlobalSectionsModuleFromATateMap_OnGradedMaps ],
                [ "MorphismConstructor", HOMALG_MODULES.category.MorphismConstructor ]
                )
        );

Functor_GuessGlobalSectionsModuleFromATateMap_ForGradedMaps!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctor( Functor_GuessGlobalSectionsModuleFromATateMap_ForGradedMaps );

##
## Hom
##

ComposeFunctors( Functor_HomogeneousPartOfDegreeZeroOverCoefficientsRing_ForGradedModules, 1, Functor_GradedHom_ForGradedModules, "Hom", "Hom" );

####################################
#
# temporary
#
####################################

# ## works only for principal ideal domains
# InstallGlobalFunction( _UCT_Homology,
#   function( H, G )
#     local HG;
#     
#     HG := H * G + Tor( 1, Shift( H, -1 ), G );
#     
#     return ByASmallerPresentation( HG );
#     
# end );
# 
# ## works only for principal ideal domains
# InstallGlobalFunction( _UCT_Cohomology,
#   function( H, G )
#     local HG;
#     
#     HG := Hom( H, G ) + Ext( 1, Shift( H, -1 ), G );
#     
#     return ByASmallerPresentation( HG );
#     
# end );

