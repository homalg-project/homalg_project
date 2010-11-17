#############################################################################
##
##  LICHM.gi                    LICHM subpackage             Mohamed Barakat
##
##         LICHM = Logical Implications for homalg CHain Maps
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for the LICHM subpackage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

##
InstallValue( LogicalImplicationsForHomalgChainMaps,
        [ 
          
          [ IsGradedMorphism,
            "implies", IsMorphism ],
          
          [ IsIsomorphism,
            "implies", IsQuasiIsomorphism ],
          
          ] );

####################################
#
# logical implications methods:
#
####################################

InstallLogicalImplicationsForHomalgObjects( LogicalImplicationsForHomalgChainMaps, IsHomalgChainMap );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallImmediateMethod( IsGradedMorphism,
        IsHomalgChainMap, 0,
        
  function( phi )
    local S, T;
    
    S := Source( phi );
    T := Range( phi );
    
    if HasIsGradedObject( S ) and HasIsGradedObject( T ) then
        return IsGradedObject( S ) and IsGradedObject( T );
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( IsZero,
        "LICHM: for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( cm )
    local morphisms;
    
    morphisms := MorphismsOfChainMap( cm );
    
    return ForAll( morphisms, IsZero );
    
end );

##
InstallMethod( IsMorphism,
        "LICHM: for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( cm )
    local degree, degrees, l, S, T;
    
    if not IsComplex( Source( cm ) ) then
        return false;
    elif not IsComplex( Range( cm ) ) then
        return false;
    fi;
    
    degree := DegreeOfMorphism( cm );
    
    degrees := DegreesOfChainMap( cm );
    
    l := Length( degrees );
    
    degrees := degrees{[ 1 .. l - 1 ]};
    
    S := Source( cm );
    T := Range( cm );
    
    if l = 1 then
        if Length( ObjectDegreesOfComplex( S ) ) = 1 then
            return true;
        else
            Error( "not implemented for chain maps containing as single morphism\n" );
        fi;
    elif IsChainMapOfFinitelyPresentedObjectsRep( cm ) and IsHomalgLeftObjectOrMorphismOfLeftObjects( cm ) then
        return ForAll( degrees, i -> CertainMorphism( cm, i + 1 ) * CertainMorphism( T, i + 1 + degree ) = CertainMorphism( S, i + 1 ) * CertainMorphism( cm, i ) );
    elif IsCochainMapOfFinitelyPresentedObjectsRep( cm ) and IsHomalgRightObjectOrMorphismOfRightObjects( cm ) then
        return ForAll( degrees, i -> CertainMorphism( T, i + degree ) * CertainMorphism( cm, i ) = CertainMorphism( cm, i + 1 ) * CertainMorphism( S, i ) );
    elif IsChainMapOfFinitelyPresentedObjectsRep( cm ) and IsHomalgRightObjectOrMorphismOfRightObjects( cm ) then
        return ForAll( degrees, i -> CertainMorphism( T, i + 1 + degree ) * CertainMorphism( cm, i + 1 ) = CertainMorphism( cm, i ) * CertainMorphism( S, i + 1 ) );
    else
        return ForAll( degrees, i -> CertainMorphism( cm, i ) * CertainMorphism( T, i + degree ) = CertainMorphism( S, i ) * CertainMorphism( cm, i + 1 ) );
    fi;
    
end );

##
InstallMethod( IsEpimorphism,
        "LICHM: for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( cm )
    
    ## not true for split epimorphisms
    return IsMorphism( cm ) and ForAll( MorphismsOfChainMap( cm ), IsEpimorphism );
    
end );

##
InstallMethod( IsMonomorphism,
        "LICHM: for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( cm )
    
    ## not true for split monomorphisms
    return IsMorphism( cm ) and ForAll( MorphismsOfChainMap( cm ), IsMonomorphism );
    
end );
##
InstallMethod( IsGradedMorphism,
        "LICHM: for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( phi )
    
    return IsGradedObject( Source( phi ) ) and IsGradedObject( Range( phi ) );
    
end );

##
InstallMethod( IsQuasiIsomorphism,
        "LICHM: for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( phi )
    
    return IsIsomorphism( DefectOfExactness( phi ) );
    
end );


####################################
#
# methods for attributes:
#
####################################

