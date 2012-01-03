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
## Attributes
##
##################################

##
InstallMethod( PicardGroup,
               " for affine conxev varieties",
               [ IsConeRep ],
               
  function( vari )
    
    return 0 * HOMALG_MATRICES.ZZ;
    
end );

InstallMethod( CoordinateRing,
               " for affine convex varieties",
               [ IsConeRep ],
               
  function( vari )
    
    if HasCoordinateRingOfTorus( vari ) then
        
        return CoordinateRing( vari, [ ] );
        
    fi;
    
    Error( "no indeterminates given");
    
end );

##
InstallMethod( CoordinateRing,
               " for affine convex varieties",
               [ IsConeRep, IsList ],
               
  function( vari, vars )
    local hilb, n, ring, rels, i, k;
    
    hilb := HilbertBasis( DualCone( UnderlyingConvexObject( vari ) ) );
    
    n := Length( hilb );
    
    ring := CoordinateRingOfTorus( vari, vars );
    
    vars := Indeterminates( AmbientRing( ring ) );
    
    rels := [ 1 .. n ];
    
    for i in [ 1 .. n ] do
        
        rels[ i ] := 1;
        
        for k in [ 1 .. Length( hilb[ i ] ) ] do
            
            if hilb[ i ][ k ] < 0 then
                
                rels[ i ] := rels[ i ] * ( vars[ 2 * k ]^( - hilb[ i ][ k ] ) );
              
            else
                
                rels[ i ] := rels[ i ] * ( vars[ 2 * k - 1 ]^( hilb[ i ][ k ] ) );
                
            fi;
            
        od;
        
    od;
    
    ring := CoefficientsRing( AmbientRing( ring ) ) * rels;
    
    ring := ring / RingRelations( CoordinateRingOfTorus( vari ) );
    
    SetCoordinateRing( vari, ring );
    
    return ring;
    
end );

##################################
##
## Methods
##
##################################

##
InstallMethod( FanToConeRep,
               " for affine varieties",
               [ IsFanRep ],
               
  function( vari )
    local rays, cone;
    
    if not IsAffine( vari ) then
        
        Error( " variety is not affine." );
        
    fi;
    
    rays := UnderlyingConvexObject( vari );
    
    rays := Rays( rays );
    
    cone := HomalgCone( rays );
    
    vari!.ConvexObject := cone;
    
    ChangeTypeObj( TheTypeConeToricVariety, vari );
    
    SetIsAffine( vari, true );
    
    SetIsProjective( vari, false );
    
    SetIsComplete( vari, false );
    
    return vari;
    
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

