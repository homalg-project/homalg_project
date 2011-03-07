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
              "IsGeneralizedMorphism",
              "IsGeneralizedEpimorphism",
              "IsGeneralizedMonomorphism",
              "IsGeneralizedIsomorphism",
              "IsOne",
              "IsMonomorphism",
              "IsEpimorphism",
              "IsSplitMonomorphism",
              "IsSplitEpimorphism",
              "IsIsomorphism"
              ],
            match_attributes := []
            )
        );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallMethodToPullPropertiesOrAttributes(
        IsMapOfGradedModulesRep, IsMapOfGradedModulesRep,
        [ "IsMonomorphism", "IsEpimorphism", "IsIsomorphism",
          "IsGeneralizedMorphism", "IsGeneralizedMonomorphism",
          "IsGeneralizedEpimorphism", "IsGeneralizedIsomorphism",
          "IsSplitMonomorphism", "IsSplitEpimorphism",
          "IsOne", "IsZero" ],
        UnderlyingMorphism );

##
InstallImmediateMethodToTwitterPropertiesOrAttributes(
        Twitter, IsMapOfGradedModulesRep, LIHOM.intrinsic_properties, UnderlyingMorphism );

####################################
#
# immediate methods for attributes:
#
####################################

##
InstallImmediateMethodToTwitterPropertiesOrAttributes(
        Twitter, IsMapOfGradedModulesRep, LIHOM.intrinsic_attributes, UnderlyingMorphism );

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
    
    Assert( 1, IsMorphism( emb ) );
    SetIsMorphism( emb, true );
    
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
    local result;
    
    result := GradedMap( -UnderlyingMorphism( phi ), Source( phi ), Range( phi ) );
    
    if HasIsMorphism( phi ) and IsMorphism( phi ) then
        SetIsMorphism( result, true );
    fi;
    
    return result;
    
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
    local degs, degt, deg, i, j;
    
    if not IsMorphism( UnderlyingMorphism( phi ) ) then
        return false;
    fi;
    
    deg := DegreesOfEntries( MatrixOfMap( phi ) );
    degs := DegreesOfGenerators( Source( phi ) );
    degt := DegreesOfGenerators( Range( phi ) );
    
    for i in [ 1 .. Length( degs ) ] do
        for j in [ 1 .. Length( degt ) ] do
            if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
                if deg[i][j] >= 0 and not ( degs[i] = deg[i][j] + degt[j] ) then
                    return false;
                fi;
            else
                if deg[j][i] >= 0 and not ( degs[i] = deg[j][i] + degt[j] ) then
                    return false;
                fi;
            fi;
        od;
    od;
    
    return true;
    
end );

