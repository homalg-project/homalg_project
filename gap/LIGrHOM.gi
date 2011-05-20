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
            intrinsic_properties := LIHOM.intrinsic_properties,
            intrinsic_attributes := LIHOM.intrinsic_attributes,
            exchangeable_true_properties :=
                                    [ 
                                      ],
            exchangeable_false_properties :=
                                    [ "IsMorphism",
                                      ],
            exchangeable_properties :=
                                    [ "IsZero",
                                      "IsOne",
                                      ## conditionally exchangeable attributes
                                      [ "IsGeneralizedEpimorphism", [ "IsGeneralizedMorphism" ] ],
                                      [ "IsGeneralizedMonomorphism", [ "IsGeneralizedMorphism" ] ],
                                      [ "IsGeneralizedIsomorphism", [ "IsGeneralizedMorphism" ] ],
                                      [ "IsMonomorphism", [ "IsMorphism" ] ],
                                      [ "IsEpimorphism", [ "IsMorphism" ] ],
                                      [ "IsSplitMonomorphism", [ "IsMorphism" ] ],
                                      [ "IsSplitEpimorphism", [ "IsMorphism" ] ],
                                      [ "IsIsomorphism", [ "IsMorphism" ] ],
                                      ],
            exchangeable_attributes :=
                                    [ 
                                      ],
            )
        );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallImmediateMethodToPullPropertiesOrAttributes(
        IsMapOfGradedModulesRep,
        IsMapOfGradedModulesRep,
        LIGrHOM.exchangeable_properties,
        Concatenation( LIGrHOM.intrinsic_properties, LIGrHOM.intrinsic_attributes ),
        UnderlyingMorphism );

##
InstallImmediateMethodToPullTrueProperties(
        IsMapOfGradedModulesRep,
        IsMapOfGradedModulesRep,
        LIGrHOM.exchangeable_true_properties,
        Concatenation( LIGrHOM.intrinsic_properties, LIGrHOM.intrinsic_attributes ),
        UnderlyingMorphism );

##
InstallImmediateMethodToPullFalseProperties(
        IsMapOfGradedModulesRep,
        IsMapOfGradedModulesRep,
        LIGrHOM.exchangeable_false_properties,
        Concatenation( LIGrHOM.intrinsic_properties, LIGrHOM.intrinsic_attributes ),
        UnderlyingMorphism );

##
InstallImmediateMethodToPushPropertiesOrAttributes( Twitter,
        IsMapOfGradedModulesRep,
        LIGrHOM.exchangeable_properties,
        UnderlyingMorphism );

##
InstallImmediateMethodToPushFalseProperties( Twitter,
        IsMapOfGradedModulesRep,
        LIGrHOM.exchangeable_true_properties,
        UnderlyingMorphism );

##
InstallImmediateMethodToPushTrueProperties( Twitter,
        IsMapOfGradedModulesRep,
        LIGrHOM.exchangeable_false_properties,
        UnderlyingMorphism );

####################################
#
# immediate methods for attributes:
#
####################################

##
InstallImmediateMethodToPullPropertiesOrAttributes(
        IsMapOfGradedModulesRep,
        IsMapOfGradedModulesRep,
        LIGrHOM.exchangeable_attributes,
        Concatenation( LIGrHOM.intrinsic_properties, LIGrHOM.intrinsic_attributes ),
        UnderlyingMorphism );

##
InstallImmediateMethodToPushPropertiesOrAttributes( Twitter,
        IsMapOfGradedModulesRep,
        LIGrHOM.exchangeable_attributes,
        UnderlyingMorphism );

##
InstallImmediateMethod( DegreeOfMorphism,
        IsMapOfGradedModulesRep and IsMorphism, 0,
        
  function( M )
    
    return 0;
    
end );

####################################
#
# methods for attributes:
#
####################################

##
InstallMethod( KernelSubobject,
        "LIGrMOR: for homalg graded module homomorphisms",
        [ IsMapOfGradedModulesRep ],
        
  function( psi )
    local S, ker, emb, source, target;
    
    S := HomalgRing( psi );
    
    source := Source( psi );
    
    ker := KernelSubobject( UnderlyingMorphism( psi ) );
    
    emb := EmbeddingInSuperObject( ker );

    if HasIsMonomorphism( psi ) and IsMonomorphism( psi ) then
        emb := GradedMap( emb, UnderlyingObject( ZeroSubobject( Source( psi ) ) ), Source( psi ), S );
    else
        emb := GradedMap( emb, "create", Source( psi ), S );
    fi;
    
    ker := ImageSubobject( emb );
    
    target := Range( psi );
    
    if HasIsEpimorphism( psi ) and IsEpimorphism( psi ) then
        SetCokernelEpi( ker, psi );
    fi;
    
    if HasRankOfObject( source ) and HasRankOfObject( target ) then
        if RankOfObject( target ) = 0 then
            SetRankOfObject( ker, RankOfObject( source ) );
        fi;
    fi;
    
    if HasIsModuleOfGlobalSections( Source( psi ) ) and IsModuleOfGlobalSections( Source( psi ) ) and
       HasIsModuleOfGlobalSections( Range( psi ) ) and IsModuleOfGlobalSections( Range( psi ) ) then
        SetIsModuleOfGlobalSections( UnderlyingObject( ker ), true );
    fi;
    
    return ker;
    
end );

##
InstallMethod( IsAutomorphism,
        "for homalg graded module maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    
    return IsAutomorphism( UnderlyingMorphism( phi ) ) and IsHomalgGradedSelfMap( phi );
    
end );

##
InstallMethod( AdditiveInverse,
        "for homalg graded maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    local psi;
    
    psi := GradedMap( -UnderlyingMorphism( phi ), Source( phi ), Range( phi ) );
    
    SetPropertiesOfAdditiveInverse( psi, phi );
    
    return psi;
    
end );

##
InstallMethod( CastelnuovoMumfordRegularity,
        "for homalg graded maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    
    return Maximum( CastelnuovoMumfordRegularity( Source( phi ) ), CastelnuovoMumfordRegularity( Range( phi ) ) );
    
end );

##
InstallMethod( MaximalIdealAsLeftMorphism,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    local F,result;
    
    F := FreeLeftModuleWithDegrees( WeightsOfIndeterminates( S ), S );
    
    result := GradedMap( MaximalIdealAsColumnMatrix( S ), F, S^0 );
    
    Assert( 1, IsMorphism( result ) );
    SetIsMorphism( result, true );
    
    return result;
    
end );

##
InstallMethod( MaximalIdealAsRightMorphism,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    local F,result;
    
    F := FreeRightModuleWithDegrees( WeightsOfIndeterminates( S ), S );
    
    result := GradedMap( MaximalIdealAsRowMatrix( S ), F, S * 1 );
    
    Assert( 1, IsMorphism( result ) );
    SetIsMorphism( result, true );
    
    return result;
    
end );

##
InstallMethod( IsMorphism,
        "for homalg graded maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    local degs, degt, deg, entries, i, j;
    
    if not IsMorphism( UnderlyingMorphism( phi ) ) then
        return false;
    fi;
    
    deg := DegreesOfEntries( MatrixOfMap( phi ) );
    degs := DegreesOfGenerators( Source( phi ) );
    degt := DegreesOfGenerators( Range( phi ) );
    
    entries := EntriesOfHomalgMatrixAsListList( MatrixOfMap( phi ) );
    
    for i in [ 1 .. Length( degs ) ] do
        for j in [ 1 .. Length( degt ) ] do
            if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
                if not IsZero( entries[i][j] ) and not ( degs[i] = deg[i][j] + degt[j] ) then
                    return false;
                fi;
            else
                if not IsZero( entries[j][i] ) and not ( degs[i] = deg[j][i] + degt[j] ) then
                    return false;
                fi;
            fi;
        od;
    od;
    
    return true;
    
end );

