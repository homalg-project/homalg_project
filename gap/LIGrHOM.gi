#############################################################################
##
##  LIGrHOM.gi                    LIGrHOM subpackage
##
##         LIGrHOM = Logical Implications for Graded HOMomorphisms
##
##  Copyright 2010,      Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Implementation stuff for the LIGrHOM subpackage.
##
#############################################################################

InstallValue( LIGrHOM,
        rec(
            color := "\033[4;30;46m",
            intrinsic_properties := LIMOR.intrinsic_properties,
            intrinsic_attributes := LIMOR.intrinsic_attributes,
            match_properties := 
            [ "IsZero",
              "IsMorphism",
              "IsGeneralizedMorphism",
              "IsGeneralizedEpimorphism",
              "IsGeneralizedMonomorphism",
              "IsGeneralizedIsomorphism",
              "IsIdentityMorphism",
              "IsMonomorphism",
              "IsEpimorphism",
              "IsSplitMonomorphism",
              "IsSplitEpimorphism",
              "IsIsomorphism"
              ],
            match_attributes := []
            )
        );

InstallMethod( PositionOfTheDefaultPresentation,
        "for homalg graded modules",
        [ IsMapOfGradedModulesRep ],
        
  function( psi )
    
      return PairOfPositionsOfTheDefaultPresentations( psi );
#     return PositionOfTheDefaultPresentation( UnderlyingMorphism( psi ) );
    
end );

InstallMethod( PairOfPositionsOfTheDefaultPresentations,
        "for homalg graded modules",
        [ IsMapOfGradedModulesRep ],
        
  function( psi )
    
    return PairOfPositionsOfTheDefaultPresentations( UnderlyingMorphism( psi ) );
    
end );

##
InstallMethod( KernelSubobject,
        "LIGrMOR: for homalg graded module homomorphisms",
        [ IsMapOfGradedModulesRep ],

  function( psi )
    local S, ker, emb, source, target;
    
    S := HomalgRing( psi );
    
    ker := KernelSubobject( UnderlyingMorphism( psi ) );
    
    emb := EmbeddingInSuperObject( ker );
    
    source := Source( psi );
    
    emb := GradedMap( emb, "create", Source( psi ), S );

    ker := ImageSubobject( emb );

    target := Range( psi );

    if HasRankOfObject( source ) and HasRankOfObject( target ) then
        if RankOfObject( target ) = 0 then
            SetRankOfObject( ker, RankOfObject( source ) );
        fi;
    fi;

    return ker;

end );

##
InstallMethod( IsMorphism,
        "for homalg graded module maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    
    return IsMorphism( UnderlyingMorphism( phi ) );
    
end );

##
InstallMethod( IsGeneralizedMorphism,
        "for homalg graded module maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    
    return IsGeneralizedMorphism( UnderlyingMorphism( phi ) );
    
end );

##
InstallMethod( IsGeneralizedMonomorphism,
        "for homalg graded module maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    
    return IsGeneralizedMonomorphism( UnderlyingMorphism( phi ) );
    
end );

##
InstallMethod( IsGeneralizedEpimorphism,
        "for homalg graded module maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    
    return IsGeneralizedEpimorphism( UnderlyingMorphism( phi ) );
    
end );

##
InstallMethod( IsGeneralizedIsomorphism,
        "for homalg graded module maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    
    return IsGeneralizedIsomorphism( UnderlyingMorphism( phi ) );
    
end );

##
InstallMethod( IsIdentityMorphism,
        "for homalg graded module maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    
    return IsIdentityMorphism( UnderlyingMorphism( phi ) );
    
end );

##
InstallMethod( IsMonomorphism,
        "for homalg graded module maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    
    return IsMonomorphism( UnderlyingMorphism( phi ) );
    
end );

##
InstallMethod( IsEpimorphism,
        "for homalg graded module maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    
    return IsEpimorphism( UnderlyingMorphism( phi ) );
    
end );

##
InstallMethod( IsSplitMonomorphism,
        "for homalg graded module maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    
    return IsSplitMonomorphism( UnderlyingMorphism( phi ) );
    
end );

##
InstallMethod( IsSplitEpimorphism,
        "for homalg graded module maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    
    return IsSplitEpimorphism( UnderlyingMorphism( phi ) );
    
end );

##
InstallMethod( IsIsomorphism,
        "for homalg graded module maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    
    return IsIsomorphism( UnderlyingMorphism( phi ) );
    
end );

##
InstallMethod( IsAutomorphism,
        "for homalg graded module maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    
    return IsAutomorphism( UnderlyingMorphism( phi ) );
    
    end );

##
InstallMethod( MatrixOfMap,
        "for homalg graded module maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    
    return GradedMatrix( MatrixOfMap( UnderlyingMorphism( phi ) ), HomalgRing( phi ) );
    
end );

##
InstallMethod( MatrixOfMap,
        "for homalg graded module maps",
        [ IsMapOfGradedModulesRep, IsInt, IsInt ],
        
  function( phi, pos_s, pos_t )
    
    return GradedMatrix( MatrixOfMap( UnderlyingMorphism( phi ), pos_s, pos_t ), HomalgRing( phi ) );
    
end );

# ##
InstallMethod( DecideZero,
        "for homalg graded module maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    
    return GradedMap( DecideZero( UnderlyingMorphism( phi ) ), HomalgRing( phi ) );
    
end );

##
InstallMethod( IsZero,
        "for homalg graded module maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    
    return IsZero( UnderlyingMorphism( phi ) );
    
end );

##
InstallMethod( \=,
        "for homalg graded module maps",
        [ IsMapOfGradedModulesRep, IsMapOfGradedModulesRep ],
        
  function( phi, psi )
    
    return AreComparableMorphisms( phi, psi ) and ( UnderlyingMorphism( phi ) = UnderlyingMorphism( psi ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for homalg graded maps",
        [ IsMapOfGradedModulesRep ],
  function( phi )
    local syz;

    syz := SyzygiesGenerators( UnderlyingMorphism( phi ) );

    if NrRelations( syz ) = 0 then
      SetIsMonomorphism( phi, true );
    fi;

    return syz;

end );

##
InstallMethod( ReducedSyzygiesGenerators,
        "for homalg graded maps",
        [ IsMapOfGradedModulesRep ],
  function( phi )
    local syz;

    syz := ReducedSyzygiesGenerators( UnderlyingMorphism( phi ) );

    if NrRelations( syz ) = 0 then
      SetIsMonomorphism( phi, true );
    fi;

    return syz;

end );

##
InstallMethod( PostInverse,
        "for homalg graded maps",
        [ IsMapOfGradedModulesRep ],
  function( phi )
    local inv;

    inv := PostInverse( UnderlyingMorphism( phi ) );

    if IsHomalgMap( inv ) then
      return GradedMap( inv , Range( phi ), Source( phi ) );
    elif IsBool(inv) then
      return inv;
    else
      Error( "unknown return value from PostInverse" );
    fi;

end );

##
InstallMethod( GeneralizedInverse,
        "for homalg graded maps",
        [ IsMapOfGradedModulesRep ],10000,# to prevent the homalg method from being called
  function( phi )
    local psi;

    if HasGeneralizedInverse( phi ) then
      return phi!.GeneralizedInverse;
    fi;

    #we always create the cokernel here, since CokernelEpi will be called in the creation of the cokernel
    psi := GradedMap( GeneralizedInverse( UnderlyingMorphism( phi ) ), Range( phi ), Source( phi ) );

    SetGeneralizedInverse( phi, psi );
    
    return psi;

end );

##
InstallMethod( OnAFreeSource,
        "for homalg graded maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    
    return GradedMap( OnAFreeSource( UnderlyingMorphism( phi ) ), "create", Range( phi ) );
    
end );

##
InstallMethod( RemoveMorphismAid,
        "for homalg graded maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    
    return GradedMap( RemoveMorphismAid( UnderlyingMorphism( phi ) ), Source( phi ), Range( phi ) );
    
end );

##
InstallMethod( AddToMorphismAid,
        "for homalg maps",
        [ IsMapOfGradedModulesRep, IsObject ],
        
  function( phi, morphism_aid_map )
    local morphism_aid_map1, morphism_aid_map0;
    
    if not IsMapOfGradedModulesRep( morphism_aid_map ) then
        return phi;
    fi;
    
    if not IsIdenticalObj( Range( phi ), Range( morphism_aid_map ) ) then
        Error( "the targets of the two morphisms must coincide\n" );
    fi;
    
    ## we don't need the source of the new morphism aid map
    morphism_aid_map1 := OnAFreeSource( morphism_aid_map );
    
    if HasMorphismAid( phi ) then
        ## we don't need the source of the old morphism aid map
        morphism_aid_map0 := OnAFreeSource( MorphismAid( phi ) );
        morphism_aid_map1 := CoproductMorphism( morphism_aid_map0, morphism_aid_map1 );
    fi;
    
    return GeneralizedMorphism( phi, morphism_aid_map1 );
    
end );

##
InstallMethod( GeneralizedMorphism,
        "for homalg graded maps",
        [ IsMapOfGradedModulesRep, IsObject ],
        
  function( phi, morphism_aid_map )
    local morphism_aid_map1, psi;
    
    if not IsMapOfGradedModulesRep( morphism_aid_map ) then
        return phi;
    fi;
    
    if not IsIdenticalObj( Range( phi ), Range( morphism_aid_map ) ) then
        Error( "the targets of the two morphisms must coincide\n" );
    fi;
    
    ## we don't need the source of the morphism aid map
    morphism_aid_map1 := OnAFreeSource( morphism_aid_map );
    
    ## prepare a copy of phi
    psi := GradedMap( GeneralizedMorphism( UnderlyingMorphism( phi ), UnderlyingMorphism( morphism_aid_map1 ) ), Source( phi ), Range( phi ) );
    
    SetMorphismAid( psi, morphism_aid_map1 );
    
    ## some properties of the morphism phi imply
    ## properties for the generalized morphism psi
    SetPropertiesOfGeneralizedMorphism( psi, phi );
    
    return psi;
    
end );

InstallMethod( AdditiveInverse,
        "for homalg graded maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    
    return GradedMap( -UnderlyingMorphism( phi ), Source( phi ), Range( phi ) );
    
end );