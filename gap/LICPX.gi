#############################################################################
##
##  LICPX.gi                    LICPX subpackage             Mohamed Barakat
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

##
InstallMethod( BettiDiagram,
        "LICPX: for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local cocomplex, degrees, min, C_degrees, l, ll, CM, r, beta, ar;
    
    cocomplex := IsCocomplexOfFinitelyPresentedObjectsRep( C );
    
    if cocomplex then
        if not IsList( DegreesOfGenerators( HighestDegreeObject( C ) ) ) then
            Error( "the highest module was not created as a graded module\n" );
        fi;
    else
        if not IsList( DegreesOfGenerators( LowestDegreeObject( C ) ) ) then
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
        CM := MaximumList( List( ll, j -> MaximumList( degrees[j] ) - ( j - 1 ) ) );
    else
        CM := 0;
    fi;
    
    ## the lowest generator degree of the lowest object in C
    if degrees[1] <> [ ] then
        min := MinimumList( degrees[1] );
    else
        min := CM;
    fi;
    
    ## the row range of the Betti diagram
    r := [ min .. CM ];
    
    ## take care of cocomplexes
    if cocomplex then
        r := Reversed( r );
        l := Reversed( l );
    fi;
    
    ## the Betti table
    beta := List( r, i -> List( l, j -> Length( Filtered( degrees[j], a -> a = i + ( j - 1 ) ) ) ) );
    
    ## take care of cocomplexes
    if cocomplex then
        if ll <> [ ] then
            r := [ min .. CM ] + C_degrees[Length( C_degrees )];
            ConvertToRangeRep( r );
        else
            r := [ 0 ];
        fi;
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

