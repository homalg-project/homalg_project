#############################################################################
##
##  LIMAP.gi                    LIMAP subpackage             Mohamed Barakat
##
##         LIMAP = Logical Implications for homalg ring MAPs
##
##  Copyright 2009, Mohamed Barakat, Universität des Saarlandes
##
##  Implementation stuff for the LIMAP subpackage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( LIMAP,
        rec(
            color := "\033[4;30;46m",
            )
        );

##
InstallValue( LogicalImplicationsForHomalgRingMaps,
        [ 
          
          [ IsMonomorphism,
            "implies", IsMorphism ],
          
          [ IsEpimorphism,
            "implies", IsMorphism ],
          
          [ IsAutomorphism,
            "implies", IsIsomorphism ],
          
          [ IsEpimorphism, "and", IsMonomorphism,
            "imply", IsIsomorphism ],
          
          [ IsIdentityMorphism,
            "implies", IsAutomorphism ],
          
          ] );

##
InstallValue( LogicalImplicationsForHomalgRingSelfMaps,
        [ 
          
          [ IsIsomorphism,
            "implies", IsAutomorphism ],
          
          ] );

####################################
#
# logical implications methods:
#
####################################

InstallLogicalImplicationsForHomalgBasicObjects( LogicalImplicationsForHomalgRingMaps, IsHomalgRingMap );

InstallLogicalImplicationsForHomalgBasicObjects( LogicalImplicationsForHomalgRingSelfMaps, IsHomalgRingSelfMap );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallImmediateMethod( IsAutomorphism,
        IsHomalgRingMap, 0,
        
  function( phi )
    
    if not IsIdenticalObj( Source( phi ), Range( phi ) ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( IsIsomorphism,
        "LIMAP: for homalg morphisms",
        [ IsHomalgRingMap ],
        
  function( phi )
    
    return IsEpimorphism( phi ) and IsMonomorphism( phi );
    
end );

##
InstallMethod( IsAutomorphism,
        "LIMAP: for homalg ring maps",
        [ IsHomalgRingMapRep ],
        
  function( phi )
    
    return IsHomalgRingSelfMap( phi ) and IsIsomorphism( phi );
    
end );

####################################
#
# methods for attributes:
#
####################################

##
InstallMethod( DataOfCoordinateRingOfGraph,
        "LIMAP: for homalg ring maps",
        [ IsHomalgRingMapRep ],
        
  function( phi )
    local S, T, indetsS, indetsT, r, relS, relT, ST, images, rel, G;
    
    S := Source( phi );
    T := Range( phi );
    
    if HasIndeterminatesOfPolynomialRing( S ) then
        indetsS := IndeterminatesOfPolynomialRing( S );
        r := CoefficientsRing( S );
    elif HasAmbientRing( S ) and HasIndeterminatesOfPolynomialRing( AmbientRing( S ) ) then
        indetsS := IndeterminatesOfPolynomialRing( AmbientRing( S ) );
        r := CoefficientsRing( AmbientRing( S ) );
    else
        indetsS := [ ];
        r := S;
    fi;
    
    if HasIndeterminatesOfPolynomialRing( T ) then
        indetsT := IndeterminatesOfPolynomialRing( T );
        if not IsIdenticalObj( r, CoefficientsRing( T ) ) then
            Error( "different coefficient rings are not supported yet\n" );
        fi;
    elif HasAmbientRing( T ) and HasIndeterminatesOfPolynomialRing( AmbientRing( T ) ) then
        indetsT := IndeterminatesOfPolynomialRing( AmbientRing( T ) );
        if not IsIdenticalObj( r, CoefficientsRing( AmbientRing( T ) ) ) then
            Error( "different coefficient rings are not supported yet\n" );
        fi;
    fi;
    
    if not IsBound( indetsT ) then
        indetsT := [ ];
    fi;
    
    if not IsBound( indetsS ) then
        indetsS := [ ];
    fi;
    
    ST := List( indetsS, Name );
    
    Append( ST, List( indetsT, Name ) );
    
    ST := PolynomialRing( r, ST );
    
    if HasRingRelations( S ) then
        relS := ST * MatrixOfRelations( S );
        if not NrColumns( relS ) = 1 then
            relS := Involution( relS );
        fi;
    fi;
    
    if HasRingRelations( T ) then
        relT := ST * MatrixOfRelations( T );
        if not NrColumns( relT ) = 1 then
            relT := Involution( relT );
        fi;
    fi;
    
    images := ImagesOfRingMap( phi );
    
    images := List( images, x -> x / ST );
    
    images := HomalgMatrix( images, Length( images ), 1, ST );
    
    if not IsBound( relS ) then
        relS := HomalgZeroMatrix( 0, 1, ST );
    fi;
    
    if not IsBound( relT ) then
        relT := HomalgZeroMatrix( 0, 1, ST );
    fi;
    
    return [ [ ST, List( indetsS, y -> y / ST ), List( indetsT, x -> x / ST ) ],
             [ relS, images, relT ] ];
    
end );

##
InstallMethod( CoordinateRingOfGraph,
        "LIMAP: for homalg ring maps",
        [ IsHomalgRingMapRep ],
        
  function( phi )
    local data, indetsS, indetsT, relS, relT, ST, images, rel, G;
    
    data := DataOfCoordinateRingOfGraph( phi );
    
    ST := data[1][1];
    indetsS := data[1][2];
    indetsT := data[1][3];
    
    relS := data[2][1];
    images := data[2][2];
    relT := data[2][3];
    
    rel := HomalgMatrix( indetsS, Length( indetsS ), 1, ST ) - images;
    
    rel := UnionOfRowsOp( relS, rel );
    
    rel := UnionOfRowsOp( rel, relT );
    
    rel := HomalgRingRelationsAsGeneratorsOfLeftIdeal( rel );
    
    G := ST / rel;
    
    G!.indetsS := indetsS;
    G!.indetsT := indetsT;
    
    return G;
    
end );

##
InstallMethod( GeneratorsOfKernelOfRingMap,
        "for homalg ring maps",
        [ IsHomalgRingMap ],
        
  function( phi )
    local G, S, T, indetsS, indetsT, rel;
    
    G := CoordinateRingOfGraph( phi );
    
    S := Source( phi );
    T := Range( phi );
    
    indetsT := G!.indetsT;
    
    rel := RingRelations( G );
    rel := MatrixOfRelations( rel );
    
    rel := Eliminate( rel, indetsT );
    
    rel := S * rel;
    
    rel := BasisOfRows( rel );
    
    return rel;
    
end );

## KernelSubobject of projections
InstallMethod( GeneratorsOfKernelOfRingMap,
        "for homalg ring maps",
        [ IsHomalgRingMap ],
        
  function( phi )
    local T, mat, indetsT, lT, S, indetsS, lS, imgs, elim, zero, indets, iota;
    
    T := Range( phi );
    
    if HasRingRelations( T ) then
        mat := MatrixOfRelations( T );
        T := AmbientRing( T );
    else
        mat := HomalgZeroMatrix( 0, 1, T );
    fi;
    
    indetsT := Indeterminates( T );
    
    lT := Length( indetsT );
    
    S := Source( phi );
    
    indetsS := Indeterminates( S );
    
    lS := Length( indetsS );
    
    imgs := ImagesOfRingMap( phi );
    
    elim := Difference( indetsT, imgs );
    
    if not Length( elim ) = lT - lS then
        TryNextMethod( );
    fi;
    
    mat := Eliminate( mat, elim );
    
    ## computing a basis might be expensive (delaying the output)
    ## so leave it to the user or the next procedure
    #mat := BasisOfRows( mat );
    
    zero := Zero( S );
    
    indets := ListWithIdenticalEntries( lT, zero );
    
    imgs := PositionsProperty( indetsT, a -> a in imgs );
    
    indets{imgs} := indetsS;
    
    iota := RingMap( indets, T, S );
    
    mat := Pullback( iota, mat );
    
    mat := BasisOfRows( mat );
    
    return mat;
    
end );
