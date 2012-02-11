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
               
  function( variety )
    
    return IsSmooth( ConeOfVariety( variety ) );
    
end );

##################################
##
## Attributes
##
##################################

##
InstallMethod( ConeOfVariety,
               "for affine varieties",
               [ IsToricVariety and IsAffine ],
               
  function( variety )
    local factors, cones_of_factors;
    
    factors := IsProductOf( variety );
    
    if Length( factors ) > 1 then
        
        cones_of_factors := List( factors, ConeOfVariety );
        
        return Product( cones_of_factors );
        
    fi;
    
    if HasFanOfVariety( variety ) then
        
        return MaximalCones( FanOfVariety( variety ) )[ 1 ];
        
    fi;
    
    TryNextMethod();
    
end );

InstallMethod( CoordinateRing,
               " for affine convex varieties",
               [ IsConeRep ],
               
  function( variety )
    local factors, coordinate_ring;
    
    if Length( IsProductOf( variety ) ) > 1 then
        
        factors := IsProductOf( variety );
        
        if ForAll( factors, HasCoordinateRing ) then
            
            coordinate_ring := Product( List( factors, CoordinateRing ) );
            
            return coordinate_ring;
            
        fi;
        
    fi;
    
    Error( "no indeterminates given");
    
end );

##
InstallMethod( CoordinateRing,
               " for affine convex varities",
               [ IsConeRep, IsString ],
               
  function( variety, str )
    
    return CoordinateRing( variety, [ str ] );
    
end );

##
InstallMethod( CoordinateRing,
               " for affine convex varieties",
               [ IsConeRep, IsList ],
               
  function( variety, variables )
    local factors, hilbert_basis, n, indeterminates, variables_string, coordinate_ring, relations, i, k, j, a, b;
    
    if Length( IsProductOf( variety ) ) > 1 then
        
        factors := IsProductOf( variety );
        
        if ForAll( factors, HasCoordinateRing ) then
            
            coordinate_ring := Product( List( factors, CoordinateRing ) );
            
            SetCoordinateRing( variety, coordinate_ring );
            
            return coordinate_ring;
            
        fi;
        
    fi;
    
    hilbert_basis := HilbertBasis( DualCone( ConeOfVariety( variety ) ) );
    
    n := Length( hilbert_basis );
    
    if Length( variables ) = 1 then
        
        variables := List( [ 1 .. n ], i -> JoinStringsWithSeparator( [ variables[ 1 ], i ], "_" ) );
    
    fi;
    
    if not Length( variables ) = n then
        
        Error( "not the correct number of variables given" );
        
    fi;
    
    variables_string := JoinStringsWithSeparator( variables, "," );
    
    coordinate_ring := DefaultFieldForToricVarieties() * variables_string;
    
    relations := HomalgMatrix( hilbert_basis, HOMALG_MATRICES.ZZ );
    
    relations := HomalgMap( relations, "free", "free" );
    
    relations := GeneratingElements( KernelSubobject( relations ) );
    
    Apply( relations, UnderlyingListOfRingElements );
    
    if LoadPackage( "ToricIdeals" ) then
        
        relations := GensetForToricIdeal( relations );
        
    else
        
        Error( "missing package ToricIdeals" );
        
    fi;
    
    if Length( relations ) > 0 then
        
        k := Length( relations );
        
        for i in [ 1 .. k ] do
            
            a := "";
            
            b := "";
            
            for j in [ 1 .. n ] do
                
                if relations[ i ][ j ] < 0 then
                    
                    b := JoinStringsWithSeparator( [ b , JoinStringsWithSeparator( [ variables[ j ], String( - relations[ i ][ j ] ) ], "^" ) ], "*" );
                    
                elif relations[ i ][ j ] > 0 then
                    
                    a := JoinStringsWithSeparator( [ a, JoinStringsWithSeparator( [ variables[ j ], String( relations[ i ][ j ] ) ], "^" ) ], "*" );
                    
                fi;
                
            od;
            
            relations[ i ] := JoinStringsWithSeparator( [ a, b ], "-" );
            
            relations[ i ] := HomalgRingElement( relations[ i ], coordinate_ring );
            
        od;
        
        coordinate_ring := coordinate_ring / relations;
        
    fi;
    
    SetCoordinateRing( variety, coordinate_ring );
    
    return coordinate_ring;
    
end );

##
InstallMethod( ListOfVariablesOfCoordinateRing,
               "for toric varieties with cox rings",
               [ IsAffineToricVariety ],
               
  function( variety )
    local coord_ring, variable_list, string_list, i;
    
    if not HasCoordinateRing( variety ) then
        
        Error( "no cox ring has no variables\n" );
        
    fi;
    
    coord_ring := CoordinateRing( variety );
    
    variable_list := Indeterminates( coord_ring );
    
    string_list := [ ];
    
    for i in variable_list do
        
        Add( string_list, String( i ) );
        
    od;
    
    return string_list;
    
end );

##
InstallMethod( \*,
               " for affine varieties",
               [ IsConeRep, IsConeRep ],
               
  function( variety1, variety2 )
    local variety;
    
    variety := ToricVariety( ConeOfVariety( variety1 ) * ConeOfVariety( variety2 ) );
    
    SetIsProductOf( variety, Flat( [ IsProductOf( variety1 ), IsProductOf( variety2 ) ] ) );
    
    return variety;
    
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
               [ IsCone ],
               
  function( cone )
    local variety, cover;
    
    variety := rec( WeilDivisors := WeakPointerObj( [ ] ) );
    
    ObjectifyWithAttributes(
                            variety, TheTypeConeToricVariety,
                            IsAffine, true,
                            IsProjective, false,
                            IsComplete, false,
                            IsNormalVariety, true,
                            ConeOfVariety, cone,
                            FanOfVariety, cone
                            );
    
    cover := ToricSubvariety( variety, variety );
    
    SetAffineOpenCovering( variety, [ cover ] );
    
    return variety;
    
end );

