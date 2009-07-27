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
            color := "\033[4;30;46m" )
        );

##
InstallValue( LogicalImplicationsForHomalgRingMaps,
        [ 
          
          [ IsMonomorphism,
            "implies", IsMorphism ],
          
          [ IsEpimorphism,
            "implies", IsMorphism ],
          
          [ IsEpimorphism,
            "implies", IsGeneralizedEpimorphism ],
          
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

InstallLogicalImplicationsForHomalg( LogicalImplicationsForHomalgRingMaps, IsHomalgRingMap );

InstallLogicalImplicationsForHomalg( LogicalImplicationsForHomalgRingSelfMaps, IsHomalgRingSelfMap );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallImmediateMethod( IsAutomorphism,
        IsHomalgMorphism, 0,
        
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
InstallMethod( IsMonomorphism,
        "LIMAP: for homalg ring maps",
        [ IsHomalgRingMapRep ],
        
  function( phi )
    
    return IsMorphism( phi ) and IsZero( Kernel( phi ) );
    
end );

##
InstallMethod( IsIsomorphism,
        "LIMAP: for homalg morphisms",
        [ IsHomalgMorphism ],
        
  function( phi )
    
    return IsEpimorphism( phi ) and IsMonomorphism( phi );
    
end );

##
InstallMethod( IsAutomorphism,
        "LIMAP: for homalg ring maps",
        [ IsHomalgRingMapRep ],
        
  function( phi )
    
    return IsHomalgSelfMap( phi ) and IsIsomorphism( phi );
    
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
    
    if HasIndeterminatesOfPolynomialRing( S ) and
       HasIndeterminatesOfPolynomialRing( T ) then
        indetsS := IndeterminatesOfPolynomialRing( S );
        indetsT := IndeterminatesOfPolynomialRing( T );
    else
        TryNextMethod( );
    fi;
    
    r := CoefficientsRing( S );
    
    if not IsIdenticalObj( r, CoefficientsRing( T ) ) then
        Error( "different coefficient rings are not supported yet\n" );
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
    
    rel := HomalgRelationsForLeftModule( rel );
    
    G := ST / rel;
    
    G!.indetsS := indetsS;
    G!.indetsT := List( indetsT, x -> x / ST );
    
    return G;
    
end );

##
InstallMethod( KernelEmb,
        "for homalg ring maps",
        [ IsHomalgRingMap ],
        
  function( phi )
    
    return EmbeddingInSuperObject( KernelSubmodule( phi ) );
    
end );

