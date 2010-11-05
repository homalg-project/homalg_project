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
    
    natural := NaturalGeneralizedEmbedding( sum );
    # the direct sum is cokernel of this map
    phi := MorphismAid( natural );
    # create the graded direct sum from the cokernel epimorphism of phi
    sum := Range( GradedMap( CokernelEpi( phi ), degMN, "create", S ) );
    
    # grade the natural transformations
    iotaM := GradedMap( iotaM, M, sum, S );
    iotaN := GradedMap( iotaN, N, sum, S );
    piM := GradedMap( piM, sum, M, S );
    piN := GradedMap( piN, sum, N, S );
    
    sum!.NaturalGeneralizedEmbedding := GradedMap( natural, sum, "create", S );
    
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
                [ "OnMorphisms", _Functor_DirectSum_OnMaps ]
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
  function( mor )
    local S, zero, mat, deg, i, j;
    
    S := HomalgRing( mor );
    
    zero := Zero( S );
    
    mat := ShallowCopy( MatrixOfMap( mor ) );
    
    SetIsMutableMatrix( mat, true );
    
    deg := DegreesOfEntries( mat );
    
    if not ( deg <> [] and IsHomogeneousList( deg ) and IsHomogeneousList( deg[1] ) and IsInt( deg[1][1] ) ) then
      Error( "Multigraduations are not yet supported" );
    fi;
    
    for i in [ 1 .. Length( deg ) ] do
      for j in [ 1 .. Length( deg[1] ) ] do
        if deg[i][j]>1 then
          SetEntryOfHomalgMatrix( mat, i, j, zero );
        fi;
      od;
    od;
    
    SetIsMutableMatrix( mat, false );
    
    return mat;
    
end );

InstallValue( Functor_LinearPart_ForGradedModules,
        CreateHomalgFunctor(
                [ "name", "LinearPart" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "LinearPart" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant", "left adjoint", "distinguished" ], HOMALG_GRADED_MODULES.FunctorOn ] ],
                [ "OnObjects", _Functor_LinearPart_OnGradedModules ],
                [ "OnMorphisms", _Functor_LinearPart_OnGradedMaps ],
                [ "MorphismConstructor", HOMALG_GRADED_MODULES.category.MorphismConstructor ],
                [ "IsIdentityOnObjects", true ]
                )
        );

Functor_LinearPart_ForGradedModules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_LinearPart_ForGradedModules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctor( Functor_LinearPart_ForGradedModules );


##
## StandardModule
##
## (cf. Eisenbud, Floystad, Schreyer: Sheaf Cohomology and Free Resolutions over Exterior Algebras)

InstallGlobalFunction( _Functor_StandardModule_OnGradedModules,    ### defines: StandardModule (object part)
  function( M )
      local S, E, left, var_E, max_E, F_E, map_E, var_S, max_S, F_S, map_S, reg, i, tate, B, ltate, StdM, new_part_of_StdM, old_part_of_StdM, presentation_of_StdM,
            jj, j, tate_morphism, t, var_s_morphism, k, matrix_of_extension, extension_map, var_s_and_extension, enlarged_old_presentation;
      
      if IsBound( M!.StandardModule ) then
          return M!.StandardModule;
      fi;
      
      S := HomalgRing( M );
      
      E := KoszulDualRing( S, List( [ 0 .. Length( Indeterminates( S ) ) - 1 ], e -> Concatenation( "e", String( e ) ) ) );
      
      left := IsHomalgLeftObjectOrMorphismOfLeftObjects( M );
      
      # create maps with generators of maximal ideals for E ...
      var_E := IndeterminatesOfExteriorRing( E );
      if left then
          max_E := HomalgMatrix( var_E, Length( var_E ), 1, E );
          F_E := FreeLeftModuleWithDegrees( Length( var_E ), E, 0 );
      else
          max_E := HomalgMatrix( var_E, 1, Length( var_E ), E );
          F_E := FreeRightModuleWithDegrees( Length( var_E ), E, 0 );
      fi;
      map_E := GradedMap( max_E, F_E, "free" );
      
      # ... and S
      var_S := Indeterminates( S );
      if left then
          max_S := HomalgMatrix( var_S, Length( var_S ), 1, S );
          F_S := FreeLeftModuleWithDegrees( Length( var_S ), S, 0 );
      else
          max_S := HomalgMatrix( var_S, 1, Length( var_S ), S );
          F_S := FreeRightModuleWithDegrees( Length( var_S ), S, 0 );
      fi;
      map_S := GradedMap( max_S, F_S, "free" );
      
      reg := CastelnuovoMumfordRegularity( M );
      
      #this is the trivial case, when the positive graded part already generates the standard module
      if reg <=0 then
        StdM := UnderlyingObject( SubmoduleGeneratedByHomogeneousPart( 0, M ) );
        ByASmallerPresentation( StdM );
        return StdM;
      fi;
      
      #determine, how far down we need to go (experimental!)
      i := reg;
      while i>=0 do
          i := i - 1;
          tate := TateResolution( M, i, i );
          B := BettiDiagram( tate );
          if B!.matrix[Length(B!.matrix)][i-B!.column_range[1]+1]=0 then break; fi; #the homology is zero 
      od;
      i := i + 1;
      
      ltate:= LinearPart( tate );
      
      StdM := UnderlyingObject( SubmoduleGeneratedByHomogeneousPart( reg, M ) );
      
      #
      # picture for left-modules:
      #
      #  /                           |                         |                      \
      #  |    var_s_morphism         |   extension_map         |         0            |      <--- var_s_and_extension
      #  |                           |                         |                      |
      #  | ------------------------- + ----------------------- + -------------------- |
      #  |                           |                         |                      |
      #  |                           | ( new_part_of_StdM )    | ( old_part_of_StdM ) |
      #  |              0            |                                                |      <--- enlarged_old_presentation
      #  |                           |              presentation_of_StdM              |
      #  \                           |                                                /
      #
      # next loop iteration:
      #  |   new_part_of_StdM        |             old_part_of_StdM                   |
      
      new_part_of_StdM := PresentationMorphism( StdM );
      
      old_part_of_StdM := GradedZeroMap( Source( new_part_of_StdM ), Zero( StdM ) );
      
      presentation_of_StdM := ProductMorphism( new_part_of_StdM, old_part_of_StdM );
      
      for jj in [ i + 1 .. reg  ] do
          j := reg + i - jj;
          
          # create the extension map from the tate-resolution
          # e.g. ( e_0, e_1, 3*e_0+2*e_1 ) leads to  /   1,   0,   3   \
          #                                          \   0,   1,   2   /
          tate_morphism := CertainMorphism( ltate, j );
          t := NrGenerators( Range( tate_morphism ) );
          if left then
              var_s_morphism := - TensorProduct( map_S , FreeLeftModuleWithDegrees( NrGenerators( Source( tate_morphism ) ), S, 0 ) );
          else
              var_s_morphism := - TensorProduct( map_S , FreeRightModuleWithDegrees( NrGenerators( Source( tate_morphism ) ), S, 0 ) );
          fi;
          matrix_of_extension := PostDivide( tate_morphism, TensorProduct( map_E, Range( tate_morphism ) ) );
          matrix_of_extension := S * MatrixOfMap( matrix_of_extension );
          if left then
              extension_map := HomalgZeroMatrix( 0, NrGenerators( Range( tate_morphism ) ), S );
              for k in [ 1..Length( var_S ) ] do
                  extension_map := UnionOfRows( extension_map, CertainColumns( matrix_of_extension, [ (k-1) * t + 1 .. k * t ] ) );
              od;
          else
              extension_map := HomalgZeroMatrix( NrGenerators( Range( tate_morphism ) ), 0, S );
              for k in [ 1..Length( var_S ) ] do
                  extension_map := UnionOfColumns( extension_map, CertainRows( matrix_of_extension, [ (k-1) * t + 1 .. k * t ] ) );
              od;
          
          fi;
          extension_map := GradedMap( extension_map, Source( var_s_morphism ), Range( new_part_of_StdM ), S );
          
          # this will e.g. get combined into
          # /  x_0,   1,   0,   3   \
          # \  x_1,   0,   1,   2   /
          var_s_and_extension := ProductMorphism(
              var_s_morphism,
              ProductMorphism(
                  extension_map,
                  GradedZeroMap( Source( extension_map ), Range( old_part_of_StdM ) )
              )
          );
          
          enlarged_old_presentation := ProductMorphism(
              GradedZeroMap( Source( presentation_of_StdM ), Range( var_s_morphism ) ),
              presentation_of_StdM
          );
          
          old_part_of_StdM := presentation_of_StdM;
          new_part_of_StdM := var_s_morphism;
          presentation_of_StdM := CoproductMorphism( var_s_and_extension, enlarged_old_presentation );
          
      od;
      
      StdM := Cokernel( presentation_of_StdM );
      
      ByASmallerPresentation( StdM );
      
      StdM!.StandardModule := StdM;
      
      return StdM;
      
end );

##
InstallGlobalFunction( _Functor_StandardModule_OnGradedMaps, ### defines: StandardModule (morphism part)
  function( mor )
    
    Error( "Not yet implemented" );
    
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

