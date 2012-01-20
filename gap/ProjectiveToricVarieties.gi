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
                       IsProjectiveCombinatoricalRep,
                       [ ]
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

##################################
##
## Constructors
##
##################################

##
InstallMethod( PolytopeToFanRep,
               " for polytopal varieties",
               [ IsPolytopeRep ],
               
  function( vari )
    local fan, poly;
    
    fan := NormalFan( UnderlyingConvexObject( vari ) );
    
    poly := vari!.ConvexObject;
    
    vari!.ConvexObject := fan;
    
    ChangeTypeObj( TheTypeFanToricVariety, vari );
    
    SetPolytopeOfVariety( vari, poly );
    
    return vari;
    
end );

##
InstallMethod( ToricVariety,
               " for homalg polytopes",
               [ IsHomalgPolytope ],
               
  function( polytope )
    local vari;
    
    vari := rec( ConvexObject := polytope
                );
    
    ObjectifyWithAttributes(
                            vari, TheTypePolytopeToricVariety,
                            IsProjective, true,
                            IsAffine, false,
                            IsComplete, true,
                            PolytopeOfVariety, polytope
                            );
    
    return vari;
    
end );