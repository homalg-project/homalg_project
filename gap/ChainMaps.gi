#############################################################################
##
##  ChainMaps.gi                homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations of homalg procedures for chain maps.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( DefectOfExactness,
        "for a homalg chain maps",
        [ IsChainMapOfFinitelyPresentedObjectsRep, IsInt ],
        
  function( cm, i )
    local degree, degrees, S, source_degrees, T, target_degrees, sq, def;
    
    degree := DegreeOfMorphism( cm );
    
    degrees := DegreesOfChainMap( cm );
    
    S := Source( cm );
    
    source_degrees := ObjectDegreesOfComplex( S );
    
    T := Range( cm );
    
    target_degrees := ObjectDegreesOfComplex( T );
    
    if PositionSet( degrees, i ) = fail then
        Error( "the second argument ", i, " is outside the degree range of the chain map\n" );
    elif HasIsGradedObject( S ) and IsGradedObject( S ) and
      HasIsGradedObject( T ) and IsGradedObject( T ) then
        return CertainMorphism( cm, i );
    elif i = degrees[1] and i = source_degrees[1] and i + degree = target_degrees[1] then
        sq := CertainMorphismAsImageSquare( cm, i );
        def := Cokernel( sq );
    elif i = degrees[Length( degrees )] and i = source_degrees[Length( source_degrees )] and i + degree = target_degrees[Length( target_degrees )] then
        sq := CertainMorphismAsKernelSquare( cm, i );
        def := Kernel( sq );
    elif i <> source_degrees[1] and i + degree <> target_degrees[1] and
      i <> source_degrees[Length( source_degrees )] and i + degree <> target_degrees[Length( target_degrees )] then
        sq := CertainMorphismAsLambekPairOfSquares( cm, i );
        def := DefectOfExactness( sq );
    else
        Error( "the ", i, ". morphism of the chain map is neither at one of the ends nor in the middle of both source and target complexes\n" );
    fi;
    
    return def;		## the output is handled by the methods installed by InstallSpecialFunctorOnMorphisms
    
end );

##
InstallMethod( DefectOfExactness,
        "for a homalg chain maps",
        [ IsCochainMapOfFinitelyPresentedObjectsRep, IsInt ],
        
  function( cm, i )
    local degree, degrees, S, source_degrees, T, target_degrees, sq, def;
    
    degree := DegreeOfMorphism( cm );
    
    degrees := DegreesOfChainMap( cm );
    
    S := Source( cm );
    
    source_degrees := ObjectDegreesOfComplex( S );
    
    T := Range( cm );
    
    target_degrees := ObjectDegreesOfComplex( T );
    
    if PositionSet( degrees, i ) = fail then
        Error( "the second argument ", i, " is outside the degree range of the chain map\n" );
    elif HasIsGradedObject( S ) and IsGradedObject( S ) and
      HasIsGradedObject( T ) and IsGradedObject( T ) then
        return CertainMorphism( cm, i );
    elif i = degrees[1] and i = source_degrees[1] and i + degree = target_degrees[1] then
        sq := CertainMorphismAsKernelSquare( cm, i );
        def := Kernel( sq );
    elif i = degrees[Length( degrees )] and i = source_degrees[Length( source_degrees )] and i + degree = target_degrees[Length( target_degrees )] then
        sq := CertainMorphismAsImageSquare( cm, i );
        def := Cokernel( sq );
    elif i <> source_degrees[1] and i + degree <> target_degrees[1] and
      i <> source_degrees[Length( source_degrees )] and i + degree <> target_degrees[Length( target_degrees )] then
        sq := CertainMorphismAsLambekPairOfSquares( cm, i );
        def := DefectOfExactness( sq );
    else
        Error( "the ", i, ". morphism of the chain map is neither at one of the ends nor in the middle of both source and target complexes\n" );
    fi;
    
    return def;		## the output is handled by the methods installed by InstallSpecialFunctorOnMorphisms
    
end );

##
InstallMethod( Homology,
        "for a homalg chain maps",
        [ IsHomalgChainMap, IsInt ],
        
  function( cm, i )
    
    if IsCochainMapOfFinitelyPresentedObjectsRep( cm ) then
        Error( "this is a cocomplex: use \033[1mCohomology\033[0m instead\n" );
    fi;
    
    return DefectOfExactness( cm, i );
    
end );

##
InstallMethod( Cohomology,
        "for a homalg chain maps",
        [ IsHomalgChainMap, IsInt ],
        
  function( cm, i )
    
    if IsChainMapOfFinitelyPresentedObjectsRep( cm ) then
        Error( "this is a complex: use \033[1mHomology\033[0m instead\n" );
    fi;
    
    return DefectOfExactness( cm, i );
    
end );

##
InstallMethod( DefectOfExactness,
        "for a homalg chain maps",
        [ IsChainMapOfFinitelyPresentedObjectsRep ],
        
  function( cm )
    local degrees, S, T, def, i;
    
    degrees := DegreesOfChainMap( cm );
    
    S := DefectOfExactness( Source( cm ) );
    T := DefectOfExactness( Range( cm ) );
    
    def := HomalgChainMap( DefectOfExactness( cm, degrees[1] ), S, T );
    
    for i in degrees{[ 2 .. Length( degrees ) ]} do
        Add( def, DefectOfExactness( cm, i ) );
    od;
    
    SetIsGradedMorphism( def, true );
    
    return def;
    
end );

##
InstallMethod( DefectOfExactness,
        "for a homalg chain maps",
        [ IsCochainMapOfFinitelyPresentedObjectsRep ],
        
  function( cm )
    local degrees, S, T, def, i;
    
    degrees := DegreesOfChainMap( cm );
    
    S := DefectOfExactness( Source( cm ) );
    T := DefectOfExactness( Range( cm ) );
    
    def := HomalgChainMap( DefectOfExactness( cm, degrees[1] ), S, T );
    
    for i in degrees{[ 2 .. Length( degrees ) ]} do
        Add( def, DefectOfExactness( cm, i ) );
    od;
    
    SetIsGradedMorphism( def, true );
    
    return def;
    
end );

##
InstallMethod( Homology,
        "for a homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( cm )
    
    if IsCochainMapOfFinitelyPresentedObjectsRep( cm ) then
        Error( "this is a cocomplex: use \033[1mCohomology\033[0m instead\n" );
    fi;
    
    return DefectOfExactness( cm );
    
end );

##
InstallMethod( Cohomology,
        "for a homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( cm )
    
    if IsChainMapOfFinitelyPresentedObjectsRep( cm ) then
        Error( "this is a complex: use \033[1mHomology\033[0m instead\n" );
    fi;
    
    return DefectOfExactness( cm );
    
end );

