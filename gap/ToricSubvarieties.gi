#############################################################################
##
##  ToricSubarieties.gi         ToricVarieties package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  The Category of toric Varieties
##
#############################################################################

DeclareRepresentation( "IsCombinatoricalSubRep",
                       IsToricSubvariety and IsAttributeStoringRep,
                       [ UnderlyingToricVariety, AmbientToricVariety ]
                      );

DeclareRepresentation( "IsFanSubRep",
                       IsCombinatoricalSubRep,
                       [ ]
                      );

##################################
##
## Family and Type
##
##################################


BindGlobal( "TheTypeFanToricSubariety",
        NewType( TheFamilyOfToricVarietes,
                 IsFanSubRep ) );

##
TORIC_VARIETIES!.prop_and_attr_shared_by_vars_and_subvars := [
                "IsNormalVariety",
                "IsAffine",
                "IsProjective",
                "IsSmooth",
                "IsComplete",
                "HasTorusfactor",
                "HasNoTorusfactor",
                "IsOrbifold",
                "AffineOpenCovering",
                "CoxRing",
                "ClassGroup",
                "PicardGroup",
                "TorusInvariantDivisorGroup",
                "MapFromCharacterToPrincipalDivisor",
                "Dimension",
                "DimensionOfTorusfactor",
                "CoordinateRingOfTorus",
                "IsProductOf",
                "CharacterLattice",
                "TorusInvariantPrimeDivisors",
                "IrrelevantIdeal",
                "FanOfVariety",
                "PolytopeOfVariety",
                "ConeOfVariety",
                "MorphismFromCoxVariety",
                "CoxVariety",
                "ConeOfVariety",
                "AffineCone",
                "PolytopeOfVariety",
                "ProjectiveEmbedding",
                "CartierTorusInvariantDivisorGroup",
                "NameOfVariety"
                                                             ];

#################################
##
## Methods
##
#################################

##
InstallMethod( ClosureOfTorusOrbitOfCone,
               " for homalg cone",
               [ IsFanRep, IsCone ],
               
  function( variety, cone )
    local star_fan, orbit;
    
    star_fan := StarFan( cone, FanOfVariety( variety ) );
    
    orbit := ToricVariety( star_fan );
    
    orbit := ToricSubvariety( orbit, variety );
    
    SetIsClosed( orbit, true );
    
    SetIsOpen( orbit, false );
    
    return orbit;
    
end );

##
InstallMethod( InclusionMorphism,
               "for open toric varieties",
               [ IsToricSubvariety and IsOpen ],
               
  function( subvariety )
    local morphism, ambvariety;
    
    ambvariety := AmbientToricVariety( subvariety );
    
    morphism := IdentityMat( Dimension( ambvariety ) );
    
    return ToricMorphism( UnderlyingToricVariety( subvariety ), morphism, ambvariety );
    
end );

##################################
##
## Constructors
##
##################################

##
InstallMethod( ToricSubvariety,
               " for 2 toric varieties",
               [ IsToricVariety, IsToricVariety ],
               
  function( variety, ambiebt_variety )
    local subvariety;
    
    subvariety := rec( );
    
    ObjectifyWithAttributes(
                            subvariety, TheTypeFanToricSubariety,
                            UnderlyingToricVariety, variety,
                            AmbientToricVariety, ambiebt_variety
    );
    
    return subvariety;
    
end );






