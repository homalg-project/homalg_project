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
    local inv, inv2;

    inv := PostInverse( UnderlyingMorphism( phi ) );

    if IsHomalgMap( inv ) then
        
        inv2 := GradedMap( inv, Range( phi ), Source( phi ) );
        
        if HasIsMorphism( phi ) and IsMorphism( phi ) and HasIsMorphism( inv ) and IsMorphism( inv ) then
            Assert( 4, IsMorphism( inv2 ) );
            SetIsMorphism( inv2, true );
        fi;
        
    elif IsBool(inv) then
        
        inv2 := inv;
        
    else
        Error( "unknown return value from PostInverse" );
    fi;
    
    return inv2;

end );

##
InstallMethod( OnAFreeSource,
        "for homalg graded maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    local psi;
    
    psi := GradedMap( OnAFreeSource( UnderlyingMorphism( phi ) ), "create", Range( phi ) );
    
    if HasIsMorphism( phi ) and IsMorphism( phi ) then
        Assert( 4, IsMorphism( psi ) );
        SetIsMorphism( psi, true );
    fi;
    
    return psi;
    
end );

##
InstallMethod( RemoveMorphismAid,
        "for homalg graded maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    local psi2, psi;
    
    psi2 := RemoveMorphismAid( UnderlyingMorphism( phi ) );
    
    psi := GradedMap( psi2, Source( phi ), Range( phi ) );
    
    if HasIsMorphism( phi ) and IsMorphism( phi ) and HasIsMorphism( psi2 ) and IsMorphism( psi2 ) then
        Assert( 4, IsMorphism( psi ) );
        SetIsMorphism( psi, true );
    fi;
    
    if HasIsEpimorphism( phi ) then
        SetIsEpimorphism( psi, IsEpimorphism( phi ) );
    fi;
    
    return psi;
    
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
    local psi;
    
    if not IsMapOfGradedModulesRep( morphism_aid_map ) and not ( IsList( morphism_aid_map ) and Length( morphism_aid_map ) = 1 and IsHomalgMap( morphism_aid_map[1] ) ) then
        return phi;
    fi;
    
    if not IsList( morphism_aid_map ) and not IsIdenticalObj( Range( phi ), Range( morphism_aid_map ) ) then
        Error( "the targets of the two morphisms must coincide or the target of the morphism must be source of its aid\n" );
    fi;
    
    if IsList( morphism_aid_map ) then
        psi := GeneralizedMorphism( UnderlyingMorphism( phi ), [ UnderlyingMorphism( morphism_aid_map[1] ) ] );
    else
        psi := GeneralizedMorphism( UnderlyingMorphism( phi ), UnderlyingMorphism( morphism_aid_map ) );
    fi;
    
    psi := GradedMap( psi, Source( phi ), Range( phi ) );
    
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
    
    if HasIsMorphism( phi ) and IsMorphism( phi ) then
        Assert( 4, IsMorphism( result ) );
        SetIsMorphism( result, true );
    fi;
    
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
    
    if HasIsMorphism( phi ) and IsMorphism( phi ) then
        Assert( 4, IsMorphism( result ) );
        SetIsMorphism( result, true );
    fi;
    
    phi!.PreInverse := result;
    
    return result;
    
end );
