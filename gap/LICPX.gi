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

# a central place for configuration variables:

InstallValue( LICPX,
        rec(
            color := "\033[4;30;46m",
            )
        );

##
InstallValue( LogicalImplicationsForHomalgComplexes,
        [ 
          
          [ IsZero,
            "implies", IsGradedObject ],
          
          [ IsZero,
            "implies", IsExactSequence ],
          
          [ IsGradedObject,
            "implies", IsComplex ],
          
          [ IsLeftAcyclic,
            "implies", IsAcyclic ],
          
          [ IsRightAcyclic,
            "implies", IsAcyclic ],
          
          [ IsLeftAcyclic, "and", IsRightAcyclic,
            "imply", IsExactSequence ],
          
          [ IsAcyclic,
            "implies", IsComplex ],
          
          [ IsComplex,
            "implies", IsSequence ],
          
          [ IsExactSequence,
            "implies", IsLeftAcyclic ],
          
          [ IsExactSequence,
            "implies", IsRightAcyclic ],
          
          [ IsShortExactSequence,
            "implies", IsExactSequence ],
          
          [ IsExactTriangle,
            "implies", IsTriangle ],
          
          [ IsExactTriangle,
            "implies", IsExactSequence ],
          
          [ IsSplitShortExactSequence,
            "implies", IsShortExactSequence ],
          
          ] );

####################################
#
# logical implications methods:
#
####################################

InstallLogicalImplicationsForHomalgObjects( LogicalImplicationsForHomalgComplexes, IsHomalgComplex );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallImmediateMethod( IsZero,
        IsHomalgComplex, 0,
        
  function( C )
    
    if ForAny( ObjectsOfComplex( C ), o -> HasIsZero( o ) and not IsZero( o ) ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgBicomplex, 0,
        
  function( C )
    local B;
    
    B := UnderlyingComplex( C );
    
    if HasIsZero( B ) then
        return IsZero( B );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsShortExactSequence,
        IsHomalgComplex and IsExactSequence, 0,
        
  function( C )
    
    if Length( ObjectDegreesOfComplex( C ) ) = 3 then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsBicomplex,
        IsHomalgBicomplex, 0,
        
  function( B )
    
    if HasIsComplex( UnderlyingComplex( B ) ) then
        return IsComplex( UnderlyingComplex( B ) );
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
        "LICPX: for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local objects;
    
    objects := ObjectsOfComplex( C );
    
    return ForAll( objects, IsZero );
    
end );

##
InstallMethod( IsZero,
        "LICPX: for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    
    return IsZero( UnderlyingComplex( B ) );
    
end );

##
InstallMethod( IsZero,
        "LICPX: for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( Er )
    local Epq;
    
    Epq := ObjectsOfBigradedObject( Er );
    
    return ForAll( Epq, a -> ForAll( a, IsZero ) );
    
end );

##
InstallMethod( IsZero,
        "LICPX: for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    
    return ForAll( SheetsOfSpectralSequence( E ), IsZero );
    
end );

##
InstallMethod( \=,
        "LICPX: for pairs of homalg complexes",
        [ IsHomalgComplex, IsHomalgComplex ],
        
  function( C1, C2 )
    local degrees, l, objects1, objects2, b, morphisms1, morphisms2;
    
    degrees := ObjectDegreesOfComplex( C1 );
    
    if degrees <> ObjectDegreesOfComplex( C2 ) then
        return false;
    fi;
    
    l := Length( degrees );
    
    objects1 := ObjectsOfComplex( C1 );
    objects2 := ObjectsOfComplex( C2 );
    
    if IsHomalgStaticObject( objects1[1] ) then
        b := ForAll( [ 1 .. l ], i -> IsIdenticalObj( objects1[i], objects2[i] ) );	## yes, identical.
        if not b then
            return false;
        fi;
    else
        b := ForAll( [ 1 .. l ], i -> objects1[i] = objects2[i] );
        if not b then
            return false;
        fi;
    fi;
    
    morphisms1 := MorphismsOfComplex( C1 );
    morphisms2 := MorphismsOfComplex( C2 );
    
    return ForAll( [ 1 .. Length( morphisms1 ) ], i -> morphisms1[i] = morphisms2[i] );
    
end );

##
InstallMethod( \=,
        "LICPX: for pairs of homalg bicomplexes",
        [ IsHomalgBicomplex, IsHomalgBicomplex ],
        
  function( C1, C2 )
    
    return UnderlyingComplex( C1 ) = UnderlyingComplex( C2 );
    
end );

##
InstallMethod( IsBicomplex,
        "LICPX: for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    
    return IsComplex( UnderlyingComplex( B ) );
    
end );

##
InstallMethod( IsGradedObject,
        "LICPX: for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local morphisms;
    
    morphisms := MorphismsOfComplex( C );
    
    return ForAll( morphisms, IsZero );
    
end );

##
InstallMethod( IsSequence,
        "LICPX: for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local morphisms;
    
    morphisms := MorphismsOfComplex( C );
    
    return ForAll( morphisms, IsMorphism );
    
end );

##
InstallMethod( IsComplex,
        "LICPX: for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local degrees;
    
    if not IsSequence( C ) then
        return false;
    fi;
    
    degrees := MorphismDegreesOfComplex( C );
    
    degrees := degrees{[ 1 .. Length( degrees ) - 1 ]};
    
    if degrees = [ ] then
        return true;
    elif ( IsComplexOfFinitelyPresentedObjectsRep( C ) and IsHomalgLeftObjectOrMorphismOfLeftObjects( C ) )
      or ( IsCocomplexOfFinitelyPresentedObjectsRep( C ) and IsHomalgRightObjectOrMorphismOfRightObjects( C ) ) then
        return ForAll( degrees, i -> IsZero( CertainMorphism( C, i + 1 ) * CertainMorphism( C, i ) ) );
    else
        return ForAll( degrees, i -> IsZero( CertainMorphism( C, i ) * CertainMorphism( C, i + 1 ) ) );
    fi;
    
end );

##
InstallMethod( IsAcyclic,
        "LICPX: for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local degrees;
    
    if not IsComplex( C ) then
        return false;
    fi;
    
    degrees := MorphismDegreesOfComplex( C );
    
    degrees := degrees{[ 1 .. Length( degrees ) - 1 ]};
    
    if degrees = [ ] then
        return true;
    fi;
    
    if ( IsComplexOfFinitelyPresentedObjectsRep( C ) and IsHomalgLeftObjectOrMorphismOfLeftObjects( C ) )
       or ( IsCocomplexOfFinitelyPresentedObjectsRep( C ) and IsHomalgRightObjectOrMorphismOfRightObjects( C ) ) then
        return ForAll( degrees, i -> IsZero( DefectOfExactness( CertainMorphism( C, i + 1 ), CertainMorphism( C, i ) ) ) );
    else
        return ForAll( degrees, i -> IsZero( DefectOfExactness( CertainMorphism( C, i ), CertainMorphism( C, i + 1 ) ) ) );
    fi;
    
end );

##
InstallMethod( IsRightAcyclic,
        "LICPX: for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    if not IsAcyclic( C ) then
        return false;
    fi;
    
    if MorphismDegreesOfComplex( C ) = [ ] then	## just a single module
        return true;
    fi;
    
    if IsComplexOfFinitelyPresentedObjectsRep( C ) then
        return IsZero( Kernel( HighestDegreeMorphism( C ) ) );
    else
        return IsZero( Cokernel( HighestDegreeMorphism( C ) ) );
    fi;
    
end );

##
InstallMethod( IsLeftAcyclic,
        "LICPX: for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local degrees;
    
    if not IsAcyclic( C ) then
        return false;
    fi;
    
    if MorphismDegreesOfComplex( C ) = [ ] then	## just a single module
        return IsZero( LowestDegreeObject( C ) );
    fi;
    
    if IsComplexOfFinitelyPresentedObjectsRep( C ) then
        return IsZero( Cokernel( LowestDegreeMorphism( C ) ) );
    else
        return IsZero( Kernel( LowestDegreeMorphism( C ) ) );
    fi;
    
end );

##
InstallMethod( IsExactSequence,
        "LICPX: for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    return IsLeftAcyclic( C ) and IsRightAcyclic( C );
    
end );

##
InstallMethod( IsShortExactSequence,
        "LICPX: for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local support, l;
    
    support := SupportOfComplex( C );
    
    l := Length( support );
    
    if support = [ ] then			## the zero complex
        return true;
    elif support[l] - support[1] > 2 then	## too many non-trivial objects
        return false;
    fi;
    
    return IsExactSequence( C );
    
end );

####################################
#
# methods for attributes:
#
####################################

##
InstallMethod( FiltrationByShortExactSequence,
        "for short exact sequences",
        [ IsHomalgComplex and IsShortExactSequence ],
        
  function( C )
    local gen_embs;
    
    gen_embs := rec( degrees := [ 0, 1 ] );
    
    gen_embs.0 := HighestDegreeMorphism( C );
    gen_embs.1 := GeneralizedInverse( LowestDegreeMorphism( C ) );
    
    return HomalgAscendingFiltration( gen_embs, IsFiltration, true );
    
end );

