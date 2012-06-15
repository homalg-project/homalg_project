#############################################################################
##
##  Relative.gi                 Graded Modules package
##
##  Copyright 2008-2010, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Implementations of procedures for the relative situation.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( RelativeRepresentationMapOfKoszulId,
        "for homalg modules",
        [ IsHomalgModule, IsHomalgRing and IsExteriorRing ],
        
  function( M, A )
    local presentation, certain_relations, union, S, vars, anti, param,
          m0, degrees0, pos0, AM0, max, M1, m1, degrees1, pos1, AM1, n, map;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        
        presentation := LeftPresentationWithDegrees;
        certain_relations := CertainRows;
        union := UnionOfColumns;
        
    else
        
        presentation := RightPresentationWithDegrees;
        certain_relations := CertainColumns;
        union := UnionOfRows;
        
    fi;
    
    S := HomalgRing( M );
    
    vars := Indeterminates( S );
    
    anti := Indeterminates( A );
    
    param := Intersection( List( vars, Name ), List( anti, Name ) );
    
    vars := Filtered( vars, v -> not Name( v ) in param );
    
    anti := Filtered( anti, v -> not Name( v ) in param );
    
    ## End(A,M_0):
    
    m0 := PresentationMorphism( M );
    
    degrees0 := DegreesOfGenerators( Source( m0 ) );
    
    pos0 := Filtered( [ 1 .. Length( degrees0 ) ], p -> degrees0[p] = 0 );
    
    m0 := certain_relations( MatrixOfMap( m0 ), pos0 );
    
    AM0 := presentation( A * m0, -DegreesOfGenerators( M ) );
    
    ## End(A,M_1):
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        max := Subobject( vars, ( 1 * S )^0 );
    else
        max := Subobject( vars, ( S * 1 )^0 );
    fi;
    
    M1 := max * M;
    
    M1 := UnderlyingObject( M1 );
    
    m1 := PresentationMorphism( M1 );
    
    degrees1 := DegreesOfGenerators( Source( m1 ) );
    
    pos1 := Filtered( [ 1 .. Length( degrees1 ) ], p -> degrees1[p] = 1 );
    
    m1 := certain_relations( MatrixOfMap( m1 ), pos1 );
    
    AM1 := presentation( A * m1, -DegreesOfGenerators( M1 ) );
    
    ## End(E,M_0) -> End(E,M_1):
    
    n := NrGenerators( M );
    
    map := List( anti, e -> HomalgScalarMatrix( e, n, A ) );
    
    map := Iterated( map, union );
    
    map := HomalgMap( map, AM0, AM1 );
    
    ## check assertion
    Assert( 1, IsMorphism( map ) );
    
    SetIsMorphism( map, true );
    
    return map;
    
end );

##
InstallMethod( RelativeRepresentationMapOfKoszulId,
        "for homalg modules",
        [ IsHomalgModule ],
        
  function( M )
    local A;
    
    A := KoszulDualRing( HomalgRing( M ) );
    
    return RelativeRepresentationMapOfKoszulId( M, A );
    
end );

##
InstallMethod( DegreeZeroSubcomplex,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedObjectsRep, IsHomalgRing ],
        
  function( T, R )
    local presentation, certain_relations, certain_generators,
          lowest, highest, objects, degrees, degrees0, morphisms, m, ranges0,
          Rpi, mor;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( T ) then
        
        presentation := HomalgFreeLeftModule;
        certain_relations := CertainRows;
        certain_generators := CertainColumns;
        
    else
        
        presentation := HomalgFreeRightModule;
        certain_relations := CertainColumns;
        certain_generators := CertainRows;
        
    fi;
    
    lowest := LowestDegree( T );
    highest := HighestDegree( T );
    
    lowest := HomalgElementToInteger( lowest );
    highest := HomalgElementToInteger( highest );
    
    ## the objects:
    objects := ObjectsOfComplex( T );
    
    degrees := List( objects, DegreesOfGenerators );
    
    degrees := List( degrees, i -> List( i, HomalgElementToInteger ) );
    
    degrees0 := List( degrees, degs -> Filtered( degs, d -> d = 0 ) );
    
    objects := List( degrees0, degs -> presentation( Length( degs ), R ) );
    
    ## the morphisms:
    morphisms := MorphismsOfComplex( T );
    
    morphisms := List( morphisms, a -> R * a );
    
    morphisms := List( morphisms, MatrixOfMap );
    
    ranges0 := List( degrees, degs -> Filtered( [ 1 .. Length( degs ) ], p -> degs[p] = 0 ) );
    
    m := Length( morphisms );
    
    morphisms := List( [ 1 .. m ],
                       i ->
                       HomalgMap( certain_generators( certain_relations( morphisms[i], ranges0[i + 1] ), ranges0[i] ),
                               objects[i + 1], objects[i] )
                       );
    
    Rpi := HomalgComplex( morphisms[1], lowest + 1 );
    
    for mor in morphisms{[ 2 .. m ]} do
        Add( Rpi, mor );
    od;
    
    ## check assertion
    Assert( 1, IsComplex( Rpi ) );
    
    SetIsComplex( Rpi, true );
    
    return Rpi;
    
end );

