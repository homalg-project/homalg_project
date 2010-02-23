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
InstallMethod( CoordinateRingOfGraph,
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
    
    if not ( IsBound( indetsS ) and IsBound( indetsT ) ) then
        TryNextMethod( );
    fi;
    
    ST := List( indetsS, Name );
    
    Append( ST, List( indetsT, Name ) );
    
    ST := PolynomialRing( r, ST );
    
    if HasRingRelations( S ) then
        relS := RingRelations( S );
        relS := ST * MatrixOfRelations( relS );
        if not NrColumns( relS ) = 1 then
            relS := Involution( relS );
        fi;
        S := AmbientRing( S );
    fi;
    
    if HasRingRelations( T ) then
        relT := RingRelations( T );
        relT := ST * MatrixOfRelations( relT );
        if not NrColumns( relT ) = 1 then
            relT := Involution( relT );
        fi;
        T := AmbientRing( T );
    fi;
    
    images := phi!.images;
    
    images := List( images, x -> x / ST );
    
    images := HomalgMatrix( images, Length( images ), 1, ST );
    
    indetsS := List( indetsS, y -> y / ST );
    
    rel := HomalgMatrix( indetsS, Length( indetsS ), 1, ST ) - images;
    
    if IsBound( relS ) then
        rel := UnionOfRows( relS, rel );
    fi;
    
    if IsBound( relT ) then
        rel := UnionOfRows( rel, relT );
    fi;
    
    rel := HomalgRingRelationsAsGeneratorsOfLeftIdeal( rel );
    
    G := ST / rel;
    
    G!.indetsS := indetsS;
    G!.indetsT := List( indetsT, x -> x / ST );
    
    return G;
    
end );

