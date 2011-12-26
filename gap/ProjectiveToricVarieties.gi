#############################################################################
##
##  ProjectiveToricVariety.gi         ToricVarietiesForHomalg package         Sebastian Gutsche
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
                       []
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
## Constructors
##
##################################

##
InstallMethod( ToricVariety,
               " for homalg polytopes",
               [ IsHomalgPolytope ],
               
  function( polytope )
    local vari;
    
    vari := rec( ConvexObject := polytope
                );
    
    ObjectifyWithAttributes(
                            vari, TheTypePolytopeToricVariety
                            );
    
    SetIsProjective( vari, true );
    
    SetIsAffine( vari, true );
    
    SetIsComplete( vari, true );
    
    return vari;
    
end );