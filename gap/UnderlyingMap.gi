#############################################################################
##
##  UnderlyingMap.gi
##
##  Copyright 2010,      Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Implementation stuff
##
#############################################################################

##
InstallMethod( PositionOfTheDefaultPresentation,
        "for homalg graded modules",
        [ IsMapOfGradedModulesRep ],
        
  function( psi )
    
      return PairOfPositionsOfTheDefaultPresentations( psi );
#     return PositionOfTheDefaultPresentation( UnderlyingMorphism( psi ) );
    
end );

##
InstallMethod( PairOfPositionsOfTheDefaultPresentations,
        "for homalg graded modules",
        [ IsMapOfGradedModulesRep ],
        
  function( psi )
    
    return PairOfPositionsOfTheDefaultPresentations( UnderlyingMorphism( psi ) );
    
end );

##
InstallMethod( MatrixOfMap,
        "for homalg graded module maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    
    return MatrixOverGradedRing( MatrixOfMap( UnderlyingMorphism( phi ) ), HomalgRing( phi ) );
    
end );

##
InstallMethod( MatrixOfMap,
        "for homalg graded module maps",
        [ IsMapOfGradedModulesRep, IsInt, IsInt ],
        
  function( phi, pos_s, pos_t )
    
    return MatrixOverGradedRing( MatrixOfMap( UnderlyingMorphism( phi ), pos_s, pos_t ), HomalgRing( phi ) );
    
end );

##
InstallMethod( DecideZero,
        "for homalg graded module maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    
    DecideZero( UnderlyingMorphism( phi ) );
    
    return phi;
    
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

##
InstallMethod( PostInverse,
        "for homalg graded maps",
        [ IsMapOfGradedModulesRep and IsMonomorphism ],
        
  function( phi )
    local result;
    
    if IsBound( phi!.PostInverse )  then
        return phi!.PostInverse;
    fi;
    
    result := PostInverse( UnderlyingMorphism( phi ) );
    
    if result = fail or result = false then
        return result;
    fi;
    
    result := GradedMap( result, Range( phi ), Source( phi ) );
    
    phi!.PostInverse := result;
    
    return result;
    
end );

##
InstallMethod( PreInverse,
        "for homalg graded maps",
        [ IsMapOfGradedModulesRep and IsEpimorphism ],
        
  function( phi )
    local result;
    
    if IsBound( phi!.PreInverse )  then
        return phi!.PreInverse;
    fi;
    
    result := PreInverse( UnderlyingMorphism( phi ) );
    
    if result = fail or result = false then
        return result;
    fi;
    
    result := GradedMap( result, Range( phi ), Source( phi ) );
    
    phi!.PreInverse := result;
    
    return result;
    
end );
