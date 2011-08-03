#############################################################################
##
##  LICPX.gi                                                LICPX subpackage
##
##         LICPX = Logical Implications for homalg ComPleXes
##
##  Copyright 2007-2010, Mohamed Barakat, RWTH-Aachen
##
##  Implementation stuff for the LICPX subpackage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

####################################
#
# logical implications methods:
#
####################################

####################################
#
# immediate methods for properties:
#
####################################

####################################
#
# methods for properties:
#
####################################

####################################
#
# methods for attributes:
#
####################################

InstallMethod( BettiDiagramOverCoeffcientsRing,
        "LICPX: for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local S, k, weights, min, max, i, N, deg, M, j, CC;
    
    S := HomalgRing( C );
    
    k := CoefficientsRing( S );
    
    weights := WeightsOfIndeterminates( S );
    
    min := 0;
    max := 0;
    for i in weights do
        if i < 0 then
            min := min + i;
        else
            max := max + i;
        fi;
    od;
    
    for i in ObjectDegreesOfComplex( C ) do
        
        N := CertainObject( C, i );
        deg := DegreesOfGenerators( N );
        M := 0 * S;
        
        if deg <> [] then
            
            for j in [ min + Minimum( deg ).. max + Maximum( deg ) ] do
                
                M := M + S * HomogeneousPartOverCoefficientsRing( j, N );
                
            od;
            
        fi;
        
        if IsBound( CC ) then
            
            Add( CC, M );
            
        else
            
            if IsCocomplexOfFinitelyPresentedObjectsRep( C ) then
                CC := HomalgCocomplex( M, i );
            else
                CC := HomalgComplex( M, i );
            fi;
            
        fi;
        
    od;
    
    return BettiDiagram( CC );
        
end );

##
InstallMethod( BettiDiagram,
        "LICPX: for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local weights, positive, higher_degrees, lower_degrees, factor, cocomplex, degrees,
          min, C_degrees, l, ll, CM, r, beta, ar;
    
    weights := WeightsOfIndeterminates( HomalgRing( C ) );
    
    if weights = [ ] then
        Error( "the set of weights is empty" );
    elif not IsInt( weights[1] ) then
        Error( "not yet implemented" );
    else
        positive := weights[1] > 0;
    fi;
    
    if positive then
        higher_degrees := MaximumList;
        lower_degrees := MinimumList;
        factor := 1;
    else
        higher_degrees := MinimumList;
        lower_degrees := MaximumList;
        factor := -1;
    fi;
    
    cocomplex := IsCocomplexOfFinitelyPresentedObjectsRep( C );
    
    if cocomplex then
        if not IsHomalgGradedModule( HighestDegreeObject( C ) ) then
            Error( "the highest module was not created as a graded module\n" );
        fi;
    else
        if not IsHomalgGradedModule( LowestDegreeObject( C ) ) then
            Error( "the lowest module was not created as a graded module\n" );
        fi;
    fi;
    
    ## the list of generators degrees of the objects of the complex C
    degrees := List( ObjectsOfComplex( C ), DegreesOfGenerators );
    
    ## take care of cocomplexes
    if cocomplex then
        degrees := Reversed( degrees );
    fi;
    
    ## the (co)homological degrees of the (co)complex
    C_degrees := ObjectDegreesOfComplex( C );
    
    ## a counting list
    l := [ 1 .. Length( C_degrees ) ];
    
    ## the non-empty list
    ll := Filtered( l, j -> degrees[j] <> [ ] );
    
    ## the graded Castelnuovo-Mumford regularity of the resolved module
    if ll <> [ ] then
        CM := higher_degrees( List( ll, j -> higher_degrees( degrees[j] ) - factor * ( j - 1 ) ) );
    else
        CM := 0;
    fi;
    
    ## the lowest generator degree of the lowest object in C
    if ll <> [ ] then
        min := lower_degrees( List( ll, j -> lower_degrees( degrees[j] ) - factor * ( j - 1 ) ) );
    else
        min := CM;
    fi;
    
    ## the row range of the Betti diagram
    if positive then
        r := [ min .. CM ];
    else
        r := [ CM .. min ];
    fi;
    
    ## take care of cocomplexes
    if cocomplex then
        if positive then
            r := Reversed( r );
        fi;
        l := Reversed( l );
    fi;
    
    ## the Betti table
    beta := List( r, i -> List( l, j -> Length( Filtered( degrees[j], a -> a = i + factor * ( j - 1 ) ) ) ) );
    
    ## take care of cocomplexes
    if cocomplex then
        if ll <> [ ] then
            if positive then
                r := [ min .. CM ] + C_degrees[Length( C_degrees )];
            else
                r := Reversed( -[ CM .. min ] + C_degrees[Length( C_degrees )] );
            fi;
            ConvertToRangeRep( r );
        else
            r := [ 0 ];
        fi;
    fi;
    
    if HasIsExteriorRing( HomalgRing( C ) ) and IsExteriorRing( HomalgRing( C ) ) then
        r := r + Length( Indeterminates( HomalgRing( C ) ) );
    fi;
    
    ar := [ beta, r, C_degrees, C ];
    
    if IsBound( C!.display_twist ) and C!.display_twist = true then
        Append( ar, [ [ "twist", Length( Indeterminates( HomalgRing( C ) ) ) - 1 ] ] );
    fi;
    
    if IsBound( C!.higher_vanish ) and IsInt( C!.higher_vanish ) then
        Append( ar, [ [ "higher_vanish", C!.higher_vanish ] ] );
    fi;
    
    ## take care of cocomplexes
    if cocomplex then
        Append( ar, [ "reverse" ] );	## read the row range upside down
    fi;
    
    return CallFuncList( HomalgBettiDiagram, ar  );
    
end );

