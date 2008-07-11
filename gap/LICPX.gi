#############################################################################
##
##  LICPX.gi                    LICPX subpackage             Mohamed Barakat
##
##         LICPX = Logical Implications for homalg MODules
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
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
            color := "\033[4;30;46m" )
        );

##
InstallValue( LogicalImplicationsForHomalgComplexes,
        [ 
          
          [ IsZero,
            "implies", IsGradedObject ],
          
          [ IsGradedObject,
            "implies", IsComplex ],
          
          [ IsAcyclic,
            "implies", IsComplex ],
          
          [ IsComplex,
            "implies", IsSequence ],
          
          [ IsExactSequence,
            "implies", IsComplex ],
          
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

InstallLogicalImplicationsForHomalg( LogicalImplicationsForHomalgComplexes, IsHomalgComplex );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallImmediateMethod( IsShortExactSequence,
        IsHomalgComplex and IsExactSequence, 0,
        
  function( C )
    
    if Length( ObjectDegreesOfComplex( C ) ) = 3 then
        return true;
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
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local modules;
    
    modules := ObjectsOfComplex( C );
    
    return ForAll( modules, IsZero );
    
end );

##
InstallMethod( \=,
        "for two homalg complexes",
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
    
    if IsHomalgModule( objects1[1] ) then
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
InstallMethod( IsGradedObject,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local morphisms;
    
    morphisms := MorphismsOfComplex( C );
    
    return ForAll( morphisms, IsZero );
    
end );

##
InstallMethod( IsSequence,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local morphisms;
    
    morphisms := MorphismsOfComplex( C );
    
    return ForAll( morphisms, IsMorphism );
    
end );

##
InstallMethod( IsComplex,
        "for homalg complexes",
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
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local degrees, l, b;
    
    if ObjectDegreesOfComplex( C )[1] <> 0 then
        return false;
    fi;
    
    degrees := MorphismDegreesOfComplex( C );
    
    degrees := degrees{[ 1 .. Length( degrees ) - 1 ]};
    
    if not IsComplex( C ) then
        return false;
    fi;
    
    if degrees = [ ] then
        return true;
    elif ( IsComplexOfFinitelyPresentedObjectsRep( C ) and IsHomalgLeftObjectOrMorphismOfLeftObjects( C ) )
      or ( IsCocomplexOfFinitelyPresentedObjectsRep( C ) and IsHomalgRightObjectOrMorphismOfRightObjects( C ) ) then
        b := ForAll( degrees, i -> IsZero( DefectOfExactness( CertainMorphism( C, i + 1 ), CertainMorphism( C, i ) ) ) );
    else
        b := ForAll( degrees, i -> IsZero( DefectOfExactness( CertainMorphism( C, i ), CertainMorphism( C, i + 1 ) ) ) );
    fi;
    
    if not b then
        return b;
    fi;
    
    if IsComplexOfFinitelyPresentedObjectsRep( C ) then
        return IsZero( Kernel( HighestDegreeMorphismInComplex( C ) ) );
    else
        return IsZero( Cokernel( HighestDegreeMorphismInComplex( C ) ) );
    fi;
    
end );

##
InstallMethod( IsExactSequence,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local degrees, b;
    
    if not IsComplex( C ) then
        return false;
    fi;
    
    degrees := MorphismDegreesOfComplex( C );
    
    if degrees = [ ] then
        return true;
    fi;
    
    degrees := degrees{[ 1 .. Length( degrees ) - 1 ]};
    
    if ( IsComplexOfFinitelyPresentedObjectsRep( C ) and IsHomalgLeftObjectOrMorphismOfLeftObjects( C ) )
      or ( IsCocomplexOfFinitelyPresentedObjectsRep( C ) and IsHomalgRightObjectOrMorphismOfRightObjects( C ) ) then
        b := ForAll( degrees, i -> IsZero( DefectOfExactness( CertainMorphism( C, i + 1 ), CertainMorphism( C, i ) ) ) );
    else
        b := ForAll( degrees, i -> IsZero( DefectOfExactness( CertainMorphism( C, i ), CertainMorphism( C, i + 1 ) ) ) );
    fi;
    
    if not b then
        return b;
    fi;
    
    if IsComplexOfFinitelyPresentedObjectsRep( C ) then
        return ForAll( [ Kernel( HighestDegreeMorphismInComplex( C ) ), Cokernel( LowestDegreeMorphismInComplex( C ) ) ], IsZero );
    else
        return ForAll( [ Cokernel( HighestDegreeMorphismInComplex( C ) ), Kernel( LowestDegreeMorphismInComplex( C ) ) ], IsZero );
    fi;
    
end );

##
InstallMethod( IsShortExactSequence,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local support, l;
    
    support := SupportOfComplex( C );
    
    l := Length( support );
    
    if support = [ ] then			## the zero complex
        return true;
    elif support[l] - support[1] > 2 then	## too many non-trivial modules
        return false;
    fi;
    
    return IsExactSequence( C );
    
end );

