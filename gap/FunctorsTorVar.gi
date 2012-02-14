#############################################################################
##
##  FunctorsTorVar.gi     ToricVarieties       Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Functors for toric varieties.
##
#############################################################################

#########################################
##
## PicardGroup
##
#########################################

##
InstallGlobalFunction( _Functor_PicardGroup_OnToricMorphisms,
                       
  function( F_source, F_target, arg_before_pos, phi, arg_behind_pos )
    local source, range, source_embedding, source_epi, range_embedding, source_picard_subobj,
    range_picard_subobj, range_epi, final_morphism;
    
    source := Source( phi );
    
    range := Range( phi );
    
    source_embedding := EmbeddingInSuperObject( CartierTorusInvariantDivisorGroup( source ) );
    
    range_embedding := EmbeddingInSuperObject( CartierTorusInvariantDivisorGroup( range ) );
    
    source_epi := CokernelEpi( MapFromCharacterToPrincipalDivisor( source ) );
    
    range_epi := CokernelEpi( MapFromCharacterToPrincipalDivisor( range ) );
    
    ## Calculating Picard group as an subobject. Maybe one can
    ## forget about this part later.
    
    source_picard_subobj := PicardGroup( source );
    
    range_picard_subobj := PicardGroup( range );
    
    ## End of said part
    
    source_picard_subobj := EmbeddingInSuperObject( source_picard_subobj );
    
    range_picard_subobj := EmbeddingInSuperObject( range_picard_subobj );
    
    final_morphism := MorphismOnCartierDivisorGroup( phi );
    
    source_epi := PreCompose( source_embedding, source_epi );
    
    source_epi := PostDivide( source_epi, source_picard_subobj );
    
    ## This should be handled with caution.
    SetIsEpimorphism( source_epi, true );
    
    final_morphism := PreDivide( source_epi, final_morphism );
    
    final_morphism := PostDivide( final_morphism, source_picard_subobj );
    
    final_morphism := PreCompose( final_morphism, range_embedding );
    
    final_morphism := PreCompose( final_morphism, range_epi );
    
    final_morphism := PostDivide( final_morphism, range_picard_subobj );
    
    return final_morphism;
    
end );

## TODO: This algorithm is to expensive!
##
InstallGlobalFunction( _Functor_PicardGroup_OnToricVarieties,
                       
  function( variety )
    local iota, phi, psi;
    
    if IsOrbifold( variety ) then
        
        return TorsionFreeFactor( ClassGroup( variety ) );
        
    fi;
    
    iota := MorphismHavingSubobjectAsItsImage( CartierTorusInvariantDivisorGroup( variety ) );
    
    phi := CokernelEpi( MapFromCharacterToPrincipalDivisor( variety ) );
    
    psi := PreCompose( iota, phi );
    
    return ImageSubobject( psi );
    
end );

InstallValue( functor_PicardGroup_for_toric_varieties,
        CreateHomalgFunctor(
                [ "name", "PicardGroup" ],
                [ "category", TORIC_VARIETIES.category ],
                [ "operation", "PicardGroup" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant" ], TORIC_VARIETIES.FunctorOn ] ],
                [ "OnObjects", _Functor_PicardGroup_OnToricVarieties ],
                [ "OnMorphisms", _Functor_PicardGroup_OnToricMorphisms ]
                )
        );

functor_PicardGroup_for_toric_varieties!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

functor_PicardGroup_for_toric_varieties!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctor( functor_PicardGroup_for_toric_varieties );

##
RedispatchOnCondition( PicardGroup, true, [ IsToricVariety ], [ IsOrbifold ], 2 );

##
RedispatchOnCondition( PicardGroup, true, [ IsToricVariety ], [ IsSmooth ], 1 );

##
RedispatchOnCondition( PicardGroup, true, [ IsToricVariety ], [ IsAffine ], 0 );

###################################
##
## ClassGroup
##
###################################

InstallGlobalFunction( _Functor_ClassGroup_OnToricMorphisms,
                       
  function( F_source, F_target, arg_before_pos, morphism, arg_behind_pos )
    local source, range, source_class_morphism, range_class_morphism, class_morphism;
    
    source := SourceObject( morphism );
    
    range := RangeObject( morphism );
    
    class_morphism := MorphismOnWeilDivisorGroup( morphism );
    
    source_class_morphism := CokernelEpi( MapFromCharacterToPrincipalDivisor( source ) );
    
    range_class_morphism := CokernelEpi( MapFromCharacterToPrincipalDivisor( range ) );
    
    class_morphism := PreDivide( source_class_morphism, class_morphism );
    
    class_morphism := PreCompose( class_morphism, range_class_morphism );
    
    return class_morphism;
    
end );

InstallGlobalFunction( _Functor_ClassGroup_OnToricVarieties,
                       
  function( variety )
    
    if Length( IsProductOf( variety ) ) > 1 then
        
        return Sum( List( IsProductOf( variety ), ClassGroup ) );
        
    fi;
    
    return Cokernel( MapFromCharacterToPrincipalDivisor( variety ) );
    
end );

InstallValue( functor_ClassGroup_for_toric_varieties,
        CreateHomalgFunctor(
                [ "name", "ClassGroup" ],
                [ "category", TORIC_VARIETIES.category ],
                [ "operation", "ClassGroup" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant" ], TORIC_VARIETIES.FunctorOn ] ],
                [ "OnObjects", _Functor_ClassGroup_OnToricVarieties ],
                [ "OnMorphisms", _Functor_ClassGroup_OnToricMorphisms ]
                )
        );

functor_ClassGroup_for_toric_varieties!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

functor_ClassGroup_for_toric_varieties!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctor( functor_ClassGroup_for_toric_varieties );
