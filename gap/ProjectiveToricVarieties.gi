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
               " for polytope varieties.",
               [ IsToricVariety and HasPolytopeOfVariety ],
               
  function( vari )
    
    return IsNormalPolytope( PolytopeOfVariety( vari ) );
    
end );

##################################
##
## Attributes
##
##################################

##
InstallMethod( AffineCone,
               " for polytopal varieties",
               [ IsToricVariety and HasPolytopeOfVariety ],
               
  function( vari )
    
    return ToricVariety( AffineCone( PolytopeOfVariety( vari ) ) );
    
end );

##
InstallMethod( FanOfVariety,
               " for projective varieties",
               [ IsPolytopeRep ],
               
  function( vari )
    
    return NormalFan( PolytopeOfVariety( vari ) );
    
end );

##
InstallMethod( ProjectiveEmbedding,
               " for projective varieties",
               [ IsToricVariety and HasPolytopeOfVariety ],
               
  function( vari )
    local gridpoints;
    
    gridpoints := LatticePoints( PolytopeOfVariety( vari ) );
    
    return List( gridpoints, i -> CharacterToRationalFunction( i, vari ) );
    
end );

##################################
##
## Constructors
##
##################################

##
InstallMethod( ToricVariety,
               " for homalg polytopes",
               [ IsHomalgPolytope ],
               
  function( polytope )
    local vari;
    
    vari := rec( );
    
    ObjectifyWithAttributes(
                            vari, TheTypePolytopeToricVariety,
                            IsProjective, true,
                            IsAffine, false,
                            IsComplete, true,
                            PolytopeOfVariety, polytope
                            );
    
    return vari;
    
end );