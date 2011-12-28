#############################################################################
##
##  AffineToricVariety.gi     ToricVarietiesForHomalg package       Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  The Category of affine toric Varieties
##
#############################################################################

#################################
##
## Representations
##
#################################

DeclareRepresentation( "IsAffineSheafRep",
                       IsAffineToricVariety and IsSheafRep,
                       [ "Sheaf" ]
                      );

DeclareRepresentation( "IsAffineCombinatoricalRep",
                       IsAffineToricVariety and IsCombinatoricalRep,
                       [ ]
                      );

DeclareRepresentation( "IsConeRep",
                       IsAffineCombinatoricalRep and IsFanRep,
                       []
                      );

##################################
##
## Family and Type
##
##################################

BindGlobal( "TheTypeConeToricVariety",
        NewType( TheFamilyOfToricVarietes,
                 IsConeRep ) );

##################################
##
## Properties
##
##################################

##
InstallMethod( IsSmooth,
               " for convex varieties",
               [ IsConeRep ],
               
  function( vari )
    
    return IsSmooth( UnderlyingConvexObject( vari ) );
    
end );

##################################
##
## Constructors
##
##################################

##
InstallMethod( ToricVariety,
               " for cones",
               [ IsHomalgCone ],
               
  function( cone )
    local vari;
    
    vari := rec(
                ConvexObject := cone 
               );
    
    ObjectifyWithAttributes(
                            vari, TheTypeConeToricVariety
                            );
    
    SetIsAffine( vari, true );
    
    SetIsProjective( vari, false );
    
    SetIsComplete( vari, false );
    
    SetAffineOpenCovering( vari, vari );
    
##    SetIsNormal( vari, true );
    
    return vari;
    
end );

