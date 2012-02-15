#############################################################################
##
##  ProjectiveToricVariety.gi         ToricVarieties package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  The Category of projective toric Varieties
##
#############################################################################

#################################
##
## Representations
##
#################################

DeclareRepresentation( "IsProjectiveSheafRep",
                       IsProjectiveToricVariety and IsSheafRep,
                       [ "Sheaf" ]
                      );

DeclareRepresentation( "IsProjectiveCombinatoricalRep",
                       IsProjectiveToricVariety and IsCombinatoricalRep,
                       [ ]
                      );

DeclareRepresentation( "IsPolytopeRep",
                       IsProjectiveCombinatoricalRep and IsFanRep,
                       [ PolytopeOfVariety ]
                      );

##################################
##
## Family and Type
##
##################################

BindGlobal( "TheTypePolytopeToricVariety",
        NewType( TheFamilyOfToricVarietes,
                 IsPolytopeRep ) );

##################################
##
## Properties
##
##################################

##
InstallMethod( IsNormalVariety,
               "for polytope varieties.",
               [ IsToricVariety and HasPolytopeOfVariety ],
               
  function( variety )
    
    return IsNormalPolytope( PolytopeOfVariety( variety ) );
    
end );

##################################
##
## Attributes
##
##################################

##
InstallMethod( AffineCone,
               "for polytopal varieties",
               [ IsToricVariety and HasPolytopeOfVariety ],
               
  function( variety )
    
    return ToricVariety( AffineCone( PolytopeOfVariety( variety ) ) );
    
end );

##
InstallMethod( FanOfVariety,
               "for projective varieties",
               [ IsPolytopeRep ],
               
  function( variety )
    
    return NormalFan( PolytopeOfVariety( variety ) );
    
end );

##
InstallMethod( PolytopeOfVariety,
               "for products",
               [ IsToricVariety ],
               
  function( variety )
    local factors, polytopes_of_factors;
    
    factors := IsProductOf( variety );
    
    if Length( factors ) > 1 then
        
        polytopes_of_factors := List( factors, PolytopeOfVariety );
        
        return Product( polytopes_of_factors );
        
    fi;
    
    TryNextMethod();
    
end );

##
InstallMethod( ProjectiveEmbedding,
               "for projective varieties",
               [ IsToricVariety and HasPolytopeOfVariety ],
               
  function( variety )
    local gridpoints;
    
    gridpoints := LatticePoints( PolytopeOfVariety( variety ) );
    
    return List( gridpoints, i -> CharacterToRationalFunction( i, variety ) );
    
end );

##################################
##
## Methods
##
##################################

##
InstallMethod( Polytope,
               "for toric varieties",
               [ IsToricVariety and IsProjective ],
               
  function( variety )
    
    return PolytopeOfVariety( variety );
    
end );

##################################
##
## Constructors
##
##################################

##
InstallMethod( ToricVariety,
               "for homalg polytopes",
               [ IsPolytope ],
               
  function( polytope )
    local variety;
    
    variety := rec( WeilDivisors := WeakPointerObj( [ ] ) );
    
    ObjectifyWithAttributes(
                            variety, TheTypePolytopeToricVariety,
                            IsProjective, true,
                            IsAffine, false,
                            IsComplete, true,
                            PolytopeOfVariety, polytope
                            );
    
    return variety;
    
end );