# SPDX-License-Identifier: GPL-2.0-or-later
# GradedModules: A homalg based package for the Abelian category of finitely presented graded modules over computable graded rings
#
# Implementations
#

##         LIGrHOM = Logical Implications for Graded HOMomorphisms

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
                                      [ "IsGeneralizedEpimorphism", [ "IsGeneralizedMorphismWithFullDomain" ] ],
                                      [ "IsGeneralizedMonomorphism", [ "IsGeneralizedMorphismWithFullDomain" ] ],
                                      [ "IsGeneralizedIsomorphism", [ "IsGeneralizedMorphismWithFullDomain" ] ],
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
        UnderlyingMorphismMutable );

##
InstallImmediateMethodToPullTrueProperties(
        IsMapOfGradedModulesRep,
        IsMapOfGradedModulesRep,
        LIGrHOM.exchangeable_true_properties,
        Concatenation( LIGrHOM.intrinsic_properties, LIGrHOM.intrinsic_attributes ),
        UnderlyingMorphismMutable );

##
InstallImmediateMethodToPullFalseProperties(
        IsMapOfGradedModulesRep,
        IsMapOfGradedModulesRep,
        LIGrHOM.exchangeable_false_properties,
        Concatenation( LIGrHOM.intrinsic_properties, LIGrHOM.intrinsic_attributes ),
        UnderlyingMorphismMutable );

##
InstallImmediateMethodToPushPropertiesOrAttributes( Twitter,
        IsMapOfGradedModulesRep,
        LIGrHOM.exchangeable_properties,
        UnderlyingMorphismMutable );

##
InstallImmediateMethodToPushFalseProperties( Twitter,
        IsMapOfGradedModulesRep,
        LIGrHOM.exchangeable_true_properties,
        UnderlyingMorphismMutable );

##
InstallImmediateMethodToPushTrueProperties( Twitter,
        IsMapOfGradedModulesRep,
        LIGrHOM.exchangeable_false_properties,
        UnderlyingMorphismMutable );

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
        UnderlyingMorphismMutable );

##
InstallImmediateMethodToPushPropertiesOrAttributes( Twitter,
        IsMapOfGradedModulesRep,
        LIGrHOM.exchangeable_attributes,
        UnderlyingMorphismMutable );

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
    
    ker := KernelSubobject( UnderlyingMorphismMutable( psi ) );
    
    emb := EmbeddingInSuperObject( ker );
    
    # we have to do this strange case distinction
    # even for monomorphisms, the kernel object is not automatically the zero subobject
    # this might happen if we compute the kernel before knowing that the morphisms is mono
    if HasIsMonomorphism( psi ) and IsMonomorphism( psi ) and
       IsIdenticalObj( UnderlyingObject( ker ), UnderlyingObject( UnderlyingModule( ZeroSubobject( source ) ) ) ) then
        emb := GradedMap( emb, UnderlyingObject( ZeroSubobject( Source( psi ) ) ), Source( psi ), S );
    else
        emb := GradedMap( emb, "create", Source( psi ), S );
    fi;
    
    if HasIsMorphism( psi ) and IsMorphism( psi ) then
        Assert( 4, IsMorphism( emb ) );
        SetIsMorphism( emb, true );
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
    
    if HasIsModuleOfGlobalSectionsTruncatedAtCertainDegree( Source( psi ) ) and 
       IsInt( IsModuleOfGlobalSectionsTruncatedAtCertainDegree( Source( psi ) ) ) and
       HasIsModuleOfGlobalSectionsTruncatedAtCertainDegree( Range( psi ) ) and
       IsInt( IsModuleOfGlobalSectionsTruncatedAtCertainDegree( Range( psi ) ) ) and
       IsModuleOfGlobalSectionsTruncatedAtCertainDegree( Source( psi ) ) = IsModuleOfGlobalSectionsTruncatedAtCertainDegree( Range( psi ) ) then
        SetIsModuleOfGlobalSectionsTruncatedAtCertainDegree( UnderlyingObject( ker ), IsModuleOfGlobalSectionsTruncatedAtCertainDegree( Source( psi ) ) );
    fi;
    
    return ker;
    
end );

##
InstallMethod( IsAutomorphism,
        "for homalg graded module maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    
    return IsAutomorphism( UnderlyingMorphismMutable( phi ) ) and IsHomalgGradedSelfMap( phi );
    
end );

##
InstallMethod( AdditiveInverse,
        "for homalg graded maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    local psi;
    
    psi := GradedMap( -UnderlyingMorphismMutable( phi ), Source( phi ), Range( phi ) );
    
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
    
    result := GradedMap( MaximalIdealAsColumnMatrix( S ), F, 1 * S );
    
    Assert( 4, IsMorphism( result ) );
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
    
    Assert( 4, IsMorphism( result ) );
    SetIsMorphism( result, true );
    
    return result;
    
end );

##
InstallMethod( IsMorphism,
        "for homalg graded maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    local degs, degt, deg, mat, i, j, nonzero;
    
    if not IsMorphism( UnderlyingMorphismMutable( phi ) ) then
        return false;
    fi;
    
    deg := DegreesOfEntries( MatrixOfMap( phi ) );
    degs := DegreesOfGenerators( Source( phi ) );
    degt := DegreesOfGenerators( Range( phi ) );
    
#     deg := List( deg, i -> List( i, HomalgElementToInteger ) );
#     degs := List( degs, HomalgElementToInteger );
#     degt := List( degt, HomalgElementToInteger );
    
    mat := MatrixOfMap( phi );
    
    for i in [ 1 .. Length( degs ) ] do
        for j in [ 1 .. Length( degt ) ] do
            if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
                if not ( degs[i] = deg[i][j] + degt[j] ) then
                    if not IsBound( nonzero ) then
                        nonzero := IndicatorMatrixOfNonZeroEntries( mat );
                    fi;
                    if nonzero[i][j] <> 0 then
                       return false;
                    fi;
                fi;
            else
                if not ( degs[i] = deg[j][i] + degt[j] ) then
                    if not IsBound( nonzero ) then
                        nonzero := IndicatorMatrixOfNonZeroEntries( mat );
                    fi;
                    if nonzero[j][i] <> 0 then
                       return false;
                    fi;
                fi;
            fi;
        od;
    od;
    
    return true;
    
end );

