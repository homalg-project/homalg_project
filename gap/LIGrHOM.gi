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
        [ "IsMorphism", "IsMonomorphism", "IsEpimorphism", "IsIsomorphism",
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
InstallMethod( AdditiveInverse,
        "for homalg graded maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    
    return GradedMap( -UnderlyingMorphism( phi ), Source( phi ), Range( phi ) );
    
end );

##
InstallMethod( CastelnuovoMumfordRegularity,
        "for homalg graded maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    
    return Maximum( CastelnuovoMumfordRegularity( Source( phi ) ), CastelnuovoMumfordRegularity( Range( phi ) ) );
    
end );
