#############################################################################
##
##  AffineToricVariety.gi     ToricVarieties package       Sebastian Gutsche
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
                       [ ]
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
    
    return IsSmooth( ConeOfVariety( vari ) );
    
end );

##################################
##
## Attributes
##
##################################

##
InstallMethod( ConeOfVariety,
               " for affine varieties",
               [ IsToricVariety and IsAffine ],
               
  function( vari )
    
    return MaximalCones( FanOfVariety( vari ) )[ 1 ];
    
end );

##
InstallMethod( PicardGroup,
               " for affine conxev varieties",
               [ IsToricVariety and IsAffine ],
               
  function( vari )
    
    return 0 * HOMALG_MATRICES.ZZ;
    
end );

InstallMethod( CoordinateRing,
               " for affine convex varieties",
               [ IsConeRep ],
               
  function( vari )
    local prods, hilb, ring;
    
    if Length( IsProductOf( vari ) ) > 1 then
        
        hilb := IsProductOf( vari );
        
        if ForAll( hilb, HasCoordinateRing ) then
            
            ring := Product( List( hilb, CoordinateRing ) );
            
            SetCoordinateRing( vari, ring );
            
            return ring;
            
        fi;
        
    fi;
    
    Error( "no indeterminates given");
    
end );

##
InstallMethod( CoordinateRing,
               " for affine convex varities",
               [ IsConeRep, IsString ],
               
  function( vari, str )
    
    return CoordinateRing( vari, [ str ] );
    
end );

##
InstallMethod( CoordinateRing,
               " for affine convex varieties",
               [ IsConeRep, IsList ],
               
  function( vari, vars )
    local hilb, n, indets, ring, rels, i, k, j, a, b;
    
    if Length( IsProductOf( vari ) ) > 1 then
        
        hilb := IsProductOf( vari );
        
        if ForAll( hilb, HasCoordinateRing ) then
            
            ring := Product( List( hilb, CoordinateRing ) );
            
            SetCoordinateRing( vari, ring );
            
            return ring;
            
        fi;
        
    fi;
    
    hilb := HilbertBasis( DualCone( ConeOfVariety( vari ) ) );
    
    n := Length( hilb );
    
    if Length( vars ) = 1 then
        
        vars := List( [ 1 .. n ], i -> JoinStringsWithSeparator( [ vars[ 1 ], i ], "_" ) );
    
    fi;
    
    if not Length( vars ) = n then
        
        Error( "not the correct number of variables given" );
        
    fi;
    
    vars := JoinStringsWithSeparator( vars, "," );
    
    ring := DefaultFieldForToricVarieties() * vars;
    
    vars := Indeterminates( ring );
    
    rels := HomalgMatrix( hilb, HOMALG_MATRICES.ZZ );
    
    rels := HomalgMap( rels, "free", "free" );
    
    rels := GeneratingElements( KernelSubobject( rels ) );
    
    Apply( rels, UnderlyingListOfRingElements );
    
    if LoadPackage( "ToricIdeals" ) then
        
        rels := GensetForToricIdeal( rels );
        
    else
        
        Error( "missing package ToricIdeals" );
        
    fi;
    
    if Length( rels ) > 0 then
        
        k := Length( rels );
        
        for i in [ 1 .. k ] do
            
            a := One( ring );
            
            b := One( ring );
            
            for j in [ 1 .. n ] do
                
                if rels[ i ][ j ] < 0 then
                    
                    b := b * vars[ j ]^( - rels[ i ][ j ] );
                    
                elif rels[ i ][ j ] > 0 then
                    
                    a := a * vars[ j ]^( rels[ i ][ j ] );
                    
                fi;
                
            od;
            
            rels[ i ] := a - b;
            
        od;
        
        ring := ring / rels;
        
    fi;
    
    SetCoordinateRing( vari, ring );
    
    return ring;
    
end );

##
InstallMethod( \*,
               " for affine varieties",
               [ IsConeRep, IsConeRep ],
               
  function( vari1, vari2 )
    local vari;
    
    vari := ToricVariety( ConeOfVariety( vari1 ) * ConeOfVariety( vari2 ) );
    
    SetIsProductOf( vari, Flat( [ ProductOf( vari1 ), ProductOf( vari2 ) ] ) );
    
    return vari;
    
end );

##################################
##
## Methods
##
##################################

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
    local vari, cover;
    
    vari := rec( );
    
    ObjectifyWithAttributes(
                            vari, TheTypeConeToricVariety,
                            IsAffine, true,
                            IsProjective, false,
                            IsComplete, false,
                            IsNormalVariety, true,
                            ConeOfVariety, cone,
                            FanOfVariety, cone
                            );
    
    cover := ToricSubvariety( vari, vari );
    
    SetIsOpen( cover, true );
    
    SetIsClosed( cover, false );
    
    SetAffineOpenCovering( vari, [ cover ] );
    
    return vari;
    
end );

