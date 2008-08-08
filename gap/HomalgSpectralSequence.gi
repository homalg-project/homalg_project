#############################################################################
##
##  HomalgSpectralSequence.gi   homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for homalg spectral sequences.
##
#############################################################################

####################################
#
# representations:
#
####################################

# two new representations for the GAP-category IsHomalgSpectralSequence
# which are subrepresentations of the representation IsFinitelyPresentedObjectRep:
DeclareRepresentation( "IsSpectralSequenceOfFinitelyPresentedObjectsRep",
        IsHomalgSpectralSequence and IsFinitelyPresentedObjectRep,
        [  ] );

DeclareRepresentation( "IsSpectralCosequenceOfFinitelyPresentedObjectsRep",
        IsHomalgSpectralSequence and IsFinitelyPresentedObjectRep,
        [  ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgSpectralSequencees",
        NewFamily( "TheFamilyOfHomalgSpectralSequencees" ) );

# four new types:
BindGlobal( "TheTypeHomalgSpectralSequenceAssociatedToABicomplexOfLeftObjects",
        NewType( TheFamilyOfHomalgSpectralSequencees,
                IsSpectralSequenceOfFinitelyPresentedObjectsRep and
                IsHomalgSpectralSequenceAssociatedToABicomplex and
                IsHomalgSpectralSequenceAssociatedToAnExactCouple and
                IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgSpectralSequenceAssociatedToABicomplexOfRightObjects",
        NewType( TheFamilyOfHomalgSpectralSequencees,
                IsSpectralSequenceOfFinitelyPresentedObjectsRep and
                IsHomalgSpectralSequenceAssociatedToABicomplex and
                IsHomalgSpectralSequenceAssociatedToAnExactCouple and
                IsHomalgRightObjectOrMorphismOfRightObjects ) );

BindGlobal( "TheTypeHomalgSpectralCosequenceAssociatedToABicomplexOfLeftObjects",
        NewType( TheFamilyOfHomalgSpectralSequencees,
                IsSpectralCosequenceOfFinitelyPresentedObjectsRep and
                IsHomalgSpectralSequenceAssociatedToABicomplex and
                IsHomalgSpectralSequenceAssociatedToAnExactCouple and
                IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgSpectralCosequenceAssociatedToABicomplexOfRightObjects",
        NewType( TheFamilyOfHomalgSpectralSequencees,
                IsSpectralCosequenceOfFinitelyPresentedObjectsRep and
                IsHomalgSpectralSequenceAssociatedToABicomplex and
                IsHomalgSpectralSequenceAssociatedToAnExactCouple and
                IsHomalgRightObjectOrMorphismOfRightObjects ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( homalgResetFilters,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    local property;
    
    if not IsBound( HOMALG.PropertiesOfSpectralSequencees ) then
        HOMALG.PropertiesOfSpectralSequencees :=
          [ IsZero ];
    fi;
    
    for property in HOMALG.PropertiesOfSpectralSequencees do
        ResetFilterObj( E, property );
    od;
    
end );

##
InstallMethod( PositionOfTheDefaultSetOfRelations,	## provided to avoid branching in the code and always returns fail
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    
    return fail;
    
end );

##
InstallMethod( LevelsOfSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    
    return E!.levels;
    
end );

##
InstallMethod( CertainSheet,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence, IsInt ],
        
  function( E, r )
    
    if IsBound(E!.(String( r ))) then
        return E!.(String( r ));
    fi;
    
    return fail;
    
end );

##
InstallMethod( LowestLevelInSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    
    return LevelsOfSpectralSequence( E )[1];
    
end );

##
InstallMethod( HighestLevelInSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    local levels;
    
    levels := LevelsOfSpectralSequence( E );
    
    return levels[Length( levels )];
    
end );

##
InstallMethod( SheetsOfSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    
    return List( LevelsOfSpectralSequence( E ), r -> CertainSheet( E, r ) );
    
end );

##
InstallMethod( LowestLevelSheetInSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    
    return CertainSheet( E, LowestLevelInSpectralSequence( E ) );
    
end );

##
InstallMethod( HighestLevelSheetInSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    
    return CertainSheet( E, HighestLevelInSpectralSequence( E ) );
    
end );

##
InstallMethod( ObjectDegreesOfSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    
    return E!.bidegrees;
    
end );

##
InstallMethod( CertainObject,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence, IsList, IsInt ],
        
  function( E, pq, r )
    local Er;
    
    Er := CertainSheet( E, r );
    
    if Er = fail then
        return fail;
    fi;
    
    return CertainObject( Er, pq );
    
end );

##
InstallMethod( CertainObject,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence, IsList ],
        
  function( E, pq )
    
    return CertainObject( E, pq, HighestLevelInSpectralSequence( E ) );
    
end );

##
InstallMethod( ObjectsOfSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence, IsInt ],
        
  function( E, r )
    local Er;
    
    Er := CertainSheet( E, r );
    
    if Er = fail then
        return fail;
    fi;
    
    return ObjectsOfBigradedObject( Er );
    
end );

##
InstallMethod( ObjectsOfSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    
    return ObjectsOfSpectralSequence( E, HighestLevelInSpectralSequence( E ) );
    
end );

##
InstallMethod( LowestBidegreeInSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    local bidegrees;
    
    bidegrees := ObjectDegreesOfSpectralSequence( E );
    
    return [ bidegrees[1][1], bidegrees[2][1] ];
    
end );

##
InstallMethod( HighestBidegreeInSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    local bidegrees;
    
    bidegrees := ObjectDegreesOfSpectralSequence( E );
    
    return [ bidegrees[1][Length( bidegrees[1] )], bidegrees[2][Length( bidegrees[2] )] ];
    
end );

##
InstallMethod( LowestBidegreeObjectInSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence, IsInt ],
        
  function( E, r )
    local Er, pq;
    
    Er := CertainSheet( E, r );
    
    if Er = fail then
        return fail;
    fi;
    
    pq := LowestBidegreeInSpectralSequence( E );
    
    return CertainObject( Er, pq );
    
end );

##
InstallMethod( LowestBidegreeObjectInSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    
    return LowestBidegreeObjectInSpectralSequence( E, HighestLevelInSpectralSequence( E ) );
    
end );

##
InstallMethod( HighestBidegreeObjectInSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence, IsInt ],
        
  function( E, r )
    local Er, pq;
    
    Er := CertainSheet( E, r );
    
    if Er = fail then
        return fail;
    fi;
    
    pq := HighestBidegreeInSpectralSequence( E );
    
    return CertainObject( Er, pq );
    
end );

##
InstallMethod( HighestBidegreeObjectInSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    
    return HighestBidegreeObjectInSpectralSequence( E, HighestLevelInSpectralSequence( E ) );
    
end );

##
InstallMethod( HomalgRing,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    
    return HomalgRing( LowestLevelSheetInSpectralSequence( E ) );
    
end );

##
InstallMethod( CertainMorphism,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence, IsList, IsInt ],
        
  function( E, pq, r )
    local Er;
    
    if Er = fail then
        return fail;
    fi;
    
    return CertainMorphism( Er, pq );
    
end );

##
InstallMethod( CertainMorphism,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence, IsList ],
        
  function( E, pq )
    
    return CertainMorphism( E, pq, HighestLevelInSpectralSequence( E ) );
    
end );

##
InstallMethod( UnderlyingBicomplex,
        "for homalg spectral sequences stemming from a bicomplex",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex and IsSpectralSequenceOfFinitelyPresentedObjectsRep ],
        
  function( E )
    
    if IsBound(E!.bicomplex) then
        return E!.bicomplex;
    fi;
    
    Error( "it seems that the spectral sequence does not stem from a bicomplex\n" );
    
end );

##
InstallMethod( OnLessGenerators,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    
    
    
end );

##
InstallMethod( BasisOfModule,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    
        
end );

##
InstallMethod( DecideZero,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    
    
    
end );

##
InstallMethod( ByASmallerPresentation,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    
    
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( HomalgSpectralSequence,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex, IsInt ],
        
  function( B, r )
    local bidegrees, E, Ei, type, rr, i;
    
    bidegrees := ObjectDegreesOfBicomplex( B );
    
    E := rec( bidegrees := bidegrees,
              levels := [ 0 ],
              bicomplex := B );
    
    Ei := HomalgBigradedObject( B );
    
    E.0 := Ei;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( E.0 ) then
        if IsBicomplexOfFinitelyPresentedObjectsRep( B ) then
            type := TheTypeHomalgSpectralSequenceAssociatedToABicomplexOfLeftObjects;
        else
            type := TheTypeHomalgSpectralCosequenceAssociatedToABicomplexOfLeftObjects;
        fi;
    else
        if IsBicomplexOfFinitelyPresentedObjectsRep( B ) then
            type := TheTypeHomalgSpectralSequenceAssociatedToABicomplexOfRightObjects;
        else
            type := TheTypeHomalgSpectralCosequenceAssociatedToABicomplexOfRightObjects;
        fi;
    fi;
    
    rr := r;
    i := 0;
    
    while rr <> 0 do
        if r <  0 and
           ( IsZero( Ei ) or
             ( ( HasIsStableSheet( Ei ) or IsBound( Ei!.stable ) ) and IsStableSheet( Ei ) ) ) then
            break;
        fi;
        AsDifferentialObject( Ei );
        Ei := DefectOfExactness( Ei );
        i := i + 1;
        Add( E.levels, i );
        E.(String(i)) := Ei;
        rr := rr - 1;
    od;
    
    ConvertToRangeRep( E.levels );
    
    ## Objectify
    Objectify( type, E );
    
    return E;
    
end );


##
InstallMethod( HomalgSpectralSequence,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    local E;
    
    E := HomalgSpectralSequence( B, -1 );
    
    SetSpectralSequence( B, E );
    
    return E;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( o )
    local Er, levels, degrees, l, opq;
    
    Print( "<A" );
    
    if HasIsZero( o ) then ## if this method applies and HasIsZero is set we already know that o is a non-zero homalg spectral sequence
        Print( " non-zero" );
    fi;
    
    Er := HighestLevelSheetInSpectralSequence( o );
    
    if HasIsStableSheet( Er ) then
        if IsStableSheet( Er ) then
            Print( " stable" );
        else
            Print( " yet unstable" );
        fi;
    fi;
    
    if IsSpectralCosequenceOfFinitelyPresentedObjectsRep( o ) then
        Print( " co" );
    else
        Print( " " );
    fi;
    
    Print( "homological spectral sequence with " );
    
    levels := o!.levels;
    
    if Length( levels ) = 1 then
        Print( "a single sheet at level ", levels[1], " consisting of " );
    else
        Print( "sheets at levels ", levels, " each consisting of " );
    fi;
    
    degrees := ObjectDegreesOfSpectralSequence( o );
    
    l := Length( degrees[1] ) * Length( degrees[2] );
    
    opq := CertainObject( o, [ degrees[1][1], degrees[2][1] ] );
    
    if l = 1 then
        
        Print( "a single " );
        
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
            Print( "left" );
        else
            Print( "right" );
        fi;
        
        if IsHomalgModule( opq ) then
            Print( " module" );
        else
            if IsComplexOfFinitelyPresentedObjectsRep( opq ) then
                Print( " complex" );
            else
                Print( " cocomplex" );
            fi;
        fi;
        
        Print( " per sheet at bidegree ", [ degrees[1][1], degrees[2][1] ], ">" );
        
    else
        
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
            Print( "left" );
        else
            Print( "right" );
        fi;
        
        if IsHomalgModule( opq ) then
            Print( " modules" );
        else
            if IsComplexOfFinitelyPresentedObjectsRep( opq ) then
                Print( " complexes" );
            else
                Print( " cocomplexes" );
            fi;
        fi;
        
        Print( " at bidegrees ", degrees[1], "x", degrees[2], ">" );
        
    fi;
    
end );

##
InstallMethod( ViewObj,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence and IsZero ],
        
  function( o )
    
    Print( "<A zero " );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        Print( "left" );
    else
        Print( "right" );
    fi;
    
    if IsSpectralCosequenceOfFinitelyPresentedObjectsRep( o ) then
        Print( " co" );
    else
        Print( " " );
    fi;
    
    Print( "homological spectral sequence>" );
    
end );

##
InstallMethod( Display,
        "for homalg spectral sequences",
        [ IsSpectralSequenceOfFinitelyPresentedObjectsRep ],
        
  function( o )
    local Ers, Er;
    
    Ers := SheetsOfSpectralSequence( o );
    
    Display( Ers[1] );
    
    for Er in Ers{[ 2 .. Length( Ers ) ]} do
        Print( "---------\n" );
        Display( Er );
    od;
    
end );

