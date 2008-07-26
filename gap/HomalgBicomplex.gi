#############################################################################
##
##  HomalgBicomplex.gi          homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for homalg bicomplexes.
##
#############################################################################

####################################
#
# representations:
#
####################################

# two new representations for the GAP-category IsHomalgComplex
# which are subrepresentations of the representation IsFinitelyPresentedObjectRep:
DeclareRepresentation( "IsBicomplexOfFinitelyPresentedObjectsRep",
        IsHomalgBicomplex and IsFinitelyPresentedObjectRep,
        [  ] );

DeclareRepresentation( "IsBicocomplexOfFinitelyPresentedObjectsRep",
        IsHomalgBicomplex and IsFinitelyPresentedObjectRep,
        [  ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgBicomplexes",
        NewFamily( "TheFamilyOfHomalgBicomplexes" ) );

# four new types:
BindGlobal( "TheTypeHomalgBicomplexOfLeftObjects",
        NewType( TheFamilyOfHomalgBicomplexes,
                IsBicomplexOfFinitelyPresentedObjectsRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgBicomplexOfRightObjects",
        NewType( TheFamilyOfHomalgBicomplexes,
                IsBicomplexOfFinitelyPresentedObjectsRep and IsHomalgRightObjectOrMorphismOfRightObjects ) );

BindGlobal( "TheTypeHomalgBicocomplexOfLeftObjects",
        NewType( TheFamilyOfHomalgBicomplexes,
                IsBicocomplexOfFinitelyPresentedObjectsRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgBicocomplexOfRightObjects",
        NewType( TheFamilyOfHomalgBicomplexes,
                IsBicocomplexOfFinitelyPresentedObjectsRep and IsHomalgRightObjectOrMorphismOfRightObjects ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( UnderlyingComplex,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    
    return B!.complex;
    
end );

##
InstallMethod( HomalgRing,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    
    return HomalgRing( UnderlyingComplex( B ) );
    
end );

##
InstallMethod( homalgResetFilters,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    local property;
    
    if not IsBound( HOMALG.PropertiesOfBicomplexes ) then
        HOMALG.PropertiesOfBicomplexes :=
          [ IsZero,
            IsBisequence,
            IsBicomplex ];
    fi;
    
    for property in HOMALG.PropertiesOfBicomplexes do
        ResetFilterObj( B, property );
    od;
    
    if IsBound( B!.TotalComplex ) then
        Unbind( B!.TotalComplex );
    fi;
    
end );

##
InstallMethod( PositionOfTheDefaultSetOfRelations,	## provided to avoid branching in the code and always returns fail
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( M )
    
    return fail;
    
end );

##
InstallMethod( ObjectDegreesOfBicomplex,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    local C, deg_p, o, deg_q;
    
    C := UnderlyingComplex( B );
    
    deg_p := ObjectDegreesOfComplex( C );
    
    o := LowestDegreeObjectInComplex( C );
    
    deg_q := ObjectDegreesOfComplex( o );
    
    if IsComplexOfFinitelyPresentedObjectsRep( C ) and IsCocomplexOfFinitelyPresentedObjectsRep( o ) then
        deg_q := Reversed( -deg_q );
        ConvertToRangeRep( deg_q );
    elif IsCocomplexOfFinitelyPresentedObjectsRep( C ) and IsComplexOfFinitelyPresentedObjectsRep( o ) then
        deg_q := Reversed( -deg_q );
        ConvertToRangeRep( deg_q );
    fi;
    
    return [ deg_p, deg_q ];
    
end );

##
InstallMethod( LowestBidegreeInBicomplex,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    local bidegrees;
    
    bidegrees := ObjectDegreesOfBicomplex( B );
    
    return [ bidegrees[1][1], bidegrees[2][1] ];
    
end );

##
InstallMethod( HighestBidegreeInBicomplex,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    local bidegrees;
    
    bidegrees := ObjectDegreesOfBicomplex( B );
    
    return [ bidegrees[1][Length( bidegrees[1] )], bidegrees[2][Length( bidegrees[2] )] ];
    
end );

##
InstallMethod( CertainObject,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex, IsList ],
        
  function( B, pq )
    local bidegree, C, obj_p;
    
    if not ForAll( pq, IsInt ) or not Length( pq ) = 2 then
        Error( "the second argument must be a list of two integers\n" );
    fi;
    
    bidegree := B!.bidegree_getter( pq );
    
    C := UnderlyingComplex( B );
    
    obj_p := CertainObject( C, bidegree[1] );
    
    if obj_p = fail then
        return fail;
    else
        return CertainObject( obj_p, bidegree[2] );
    fi;
    
end );

##
InstallMethod( ObjectsOfBicomplex,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    local bidegrees;
    
    bidegrees := ObjectDegreesOfBicomplex( B );
    
    return List( bidegrees[2], q -> List( bidegrees[1], p -> CertainObject( B, [ p, q ] ) ) );
    
end );

##
InstallMethod( LowestBidegreeObjectInBicomplex,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    local p_q;
    
    p_q := LowestBidegreeInBicomplex( B );
    
    return CertainObject( B, p_q[1], p_q[2] );
    
end );

##
InstallMethod( HighestBidegreeObjectInBicomplex,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    local p_q;
    
    p_q := HighestBidegreeInBicomplex( B );
    
    return CertainObject( B, p_q[1], p_q[2] );
    
end );

##
InstallMethod( CertainVerticalMorphism,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex, IsList ],
        
  function( B, pq )
    local bidegree, C, obj_p;
    
    if not ForAll( pq, IsInt ) or not Length( pq ) = 2 then
        Error( "the second argument must be a list of two integers\n" );
    fi;
    
    bidegree := B!.bidegree_getter( pq );
    
    C := UnderlyingComplex( B );
    
    obj_p := CertainObject( C, bidegree[1] );
    
    if obj_p = fail then
        return fail;
    else
        return MinusOne( HomalgRing( B ) )^pq[1] * CertainMorphism( obj_p, bidegree[2] );
    fi;
    
end );

##
InstallMethod( CertainHorizontalMorphism,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex, IsList ],
        
  function( B, pq )
    local bidegree, C, mor_p;
    
    if not ForAll( pq, IsInt ) or not Length( pq ) = 2 then
        Error( "the second argument must be a list of two integers\n" );
    fi;
    
    bidegree := B!.bidegree_getter( pq );
    
    C := UnderlyingComplex( B );
    
    mor_p := CertainMorphism( C, bidegree[1] );
    
    if mor_p = fail then
        return fail;
    else
        return CertainMorphism( mor_p, bidegree[2] );
    fi;
    
end );

##
InstallMethod( BiDegreesOfObjectOfTotalComplex,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex, IsInt ],
        
  function( B, n )
    local bidegrees, n_lowest, n_highest, tot_n, p, q;
    
    bidegrees := ObjectDegreesOfBicomplex( B );
    
    n_lowest := bidegrees[1][1] + bidegrees[2][1];
    n_highest := bidegrees[1][Length(bidegrees[1])] + bidegrees[2][Length(bidegrees[2])]; 
    
    tot_n := [ ];
    
    if n < n_lowest or n > n_highest then
        return tot_n;
    fi;
    
    if n - n_lowest < n_highest - n then
        for p in bidegrees[1][1] + [ 0 .. n - n_lowest ] do
            Add( tot_n, [ p, n - p ] );
        od;
    else
        for q in bidegrees[2][Length( bidegrees[2] )] - [ 0 .. n_highest - n ] do
            Add( tot_n, [ n - q, q ] );
        od;
    fi;
    
    return tot_n;
    
end );

##
InstallMethod( ObjectOfTotalComplex,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex, IsInt ],
        
  function( B, n )
    local bidegrees, tot_n, pq;
    
    bidegrees := BiDegreesOfObjectOfTotalComplex( B, n );
    
    if bidegrees = [ ] then
        return fail;
    fi;
    
    tot_n := [ ];
    
    for pq in bidegrees do
        Add( tot_n, CertainObject( B, pq ) );
    od;
    
    return Sum( tot_n );
    
end );

##
InstallMethod( MorphismOfTotalComplex,
        "for homalg bicomplexes",
        [ IsBicomplexOfFinitelyPresentedObjectsRep, IsInt ],
        
  function( B, n )
    local bidegrees_source, bidegrees_target, stack, horizontal, vertical,
          pq_source, pq_target, diff, augment, source;
    
    bidegrees_source := BiDegreesOfObjectOfTotalComplex( B, n );
    bidegrees_target := BiDegreesOfObjectOfTotalComplex( B, n - 1 );
    
    if bidegrees_source = [ ] or bidegrees_target = [ ] then
        return fail;
    fi;
    
    stack := [ ];
    
    horizontal := [ -1, 0 ];
    vertical := [ 0, -1 ];
    
    for pq_source in bidegrees_source do
        augment := [ ];
        for pq_target in bidegrees_target do
            source := CertainObject( B, pq_source );
            diff := pq_target - pq_source;
            if diff = horizontal then
                Add( augment, CertainHorizontalMorphism( B, pq_source ) );
            elif diff = vertical then
                Add( augment, CertainVerticalMorphism( B, pq_source ) );
            else
                Add( augment, HomalgZeroMap( source, CertainObject( B, pq_target ) ) );
            fi;
        od;
        Add( stack, Iterated( augment, AugmentMaps ) );
    od;
    
    return Iterated( stack, StackMaps );
    
end );

##
InstallMethod( MorphismOfTotalComplex,
        "for homalg bicomplexes",
        [ IsBicocomplexOfFinitelyPresentedObjectsRep, IsInt ],
        
  function( B, n )
    local bidegrees_source, bidegrees_target, stack, horizontal, vertical,
          pq_source, pq_target, diff, augment, source;
    
    bidegrees_source := BiDegreesOfObjectOfTotalComplex( B, n );
    bidegrees_target := BiDegreesOfObjectOfTotalComplex( B, n + 1 );
    
    if bidegrees_source = [ ] or bidegrees_target = [ ] then
        return fail;
    fi;
    
    stack := [ ];
    
    horizontal := [ 1, 0 ];
    vertical := [ 0, 1 ];
    
    for pq_source in bidegrees_source do
        augment := [ ];
        for pq_target in bidegrees_target do
            source := CertainObject( B, pq_source );
            diff := pq_target - pq_source;
            if diff = horizontal then
                Add( augment, CertainHorizontalMorphism( B, pq_source ) );
            elif diff = vertical then
                Add( augment, CertainVerticalMorphism( B, pq_source ) );
            else
                Add( augment, HomalgZeroMap( source, CertainObject( B, pq_target ) ) );
            fi;
        od;
        Add( stack, Iterated( augment, AugmentMaps ) );
    od;
    
    return Iterated( stack, StackMaps );
    
end );

##
InstallMethod( TotalComplex,
        "for homalg bicomplexes",
        [ IsBicomplexOfFinitelyPresentedObjectsRep ],
        
  function( B )
    local pq_lowest, pq_highest, n_lowest, n_highest, tot, n;
    
    pq_lowest := LowestBidegreeInBicomplex( B );
    pq_highest := HighestBidegreeInBicomplex( B );
    
    n_lowest := pq_lowest[1] + pq_lowest[2];
    n_highest := pq_highest[1] + pq_highest[2];
    
    tot := HomalgComplex( CertainObject( B, pq_lowest ), n_lowest );
    
    for n in [ n_lowest + 1 .. n_highest ] do
        Add( tot, MorphismOfTotalComplex( B, n ) );
    od;
    
    if HasIsBicomplex( B ) then
        SetIsComplex( tot, IsBicomplex( B ) );
    fi;
    
    return tot;
    
end );

##
InstallMethod( TotalComplex,
        "for homalg bicomplexes",
        [ IsBicocomplexOfFinitelyPresentedObjectsRep ],
        
  function( B )
    local pq_lowest, pq_highest, n_lowest, n_highest, tot, n;
    
    pq_lowest := LowestBidegreeInBicomplex( B );
    pq_highest := HighestBidegreeInBicomplex( B );
    
    n_lowest := pq_lowest[1] + pq_lowest[2];
    n_highest := pq_highest[1] + pq_highest[2];
    
    tot := HomalgCocomplex( CertainObject( B, pq_lowest ), n_lowest );
    
    for n in [ n_lowest .. n_highest - 1 ] do
        Add( tot, MorphismOfTotalComplex( B, n ) );
    od;
    
    if HasIsBicomplex( B ) then
        SetIsComplex( tot, IsBicomplex( B ) );
    fi;
    
    return tot;
    
end );

##
InstallMethod( OnLessGenerators,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    
    OnLessGenerators( UnderlyingComplex( B ) );
    
    return B;
    
end );

##
InstallMethod( BasisOfModule,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    
    BasisOfModule( UnderlyingComplex( B ) );
    
    return B;
    
end );

##
InstallMethod( DecideZero,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    
    DecideZero( UnderlyingComplex( B ) );
    
end );

##
InstallMethod( ByASmallerPresentation,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    
    ByASmallerPresentation( UnderlyingComplex( B ) );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

InstallGlobalFunction( HomalgBicomplex,
  function( arg )
    local nargs, C, complex, of_complex, left, type, bidegree_getter, B;
    
    nargs := Length( arg );
    
    if nargs = 0 then
        Error( "empty input\n" );
    fi;
    
    C := arg[1];
    
    if not IsHomalgComplex( C ) or not IsHomalgComplex( LowestDegreeObjectInComplex( C ) ) then
        Error( "the first argument is not a complex of complexes\n" );
    fi;
    
    complex := IsComplexOfFinitelyPresentedObjectsRep( C );
    of_complex := IsComplexOfFinitelyPresentedObjectsRep( LowestDegreeObjectInComplex( C ) );
    
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( C );
    
    if complex then
        if left then
            type := TheTypeHomalgBicomplexOfLeftObjects;
        else
            type := TheTypeHomalgBicomplexOfRightObjects;
        fi;
        if of_complex then
            bidegree_getter := function( pq ) return [ pq[1], pq[2] ]; end;
        else
            bidegree_getter := function( pq ) return [ pq[1], -pq[2] ]; end;
        fi;
    else
        if left then
            type := TheTypeHomalgBicocomplexOfLeftObjects;
        else
            type := TheTypeHomalgBicocomplexOfRightObjects;
        fi;
        if of_complex then
            bidegree_getter := function( pq ) return [ pq[1], -pq[2] ]; end;
        else
            bidegree_getter := function( pq ) return [ pq[1], pq[2] ]; end;
        fi;
    fi;
    
    B := rec( complex := C, bidegree_getter := bidegree_getter );
    
    ## Objectify
    Objectify( type, B );
    
    if HasIsComplex( C ) then
        SetIsBicomplex( B, IsComplex( C ) );
    elif HasIsSequence( C ) then
        SetIsBisequence( B, IsSequence( C ) );
    fi;
    
    return B;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( o )
    local cpx, degrees, l;
    
    cpx := IsBicomplexOfFinitelyPresentedObjectsRep( o );
    
    Print( "<A" );
    
    if HasIsZero( o ) then ## if this method applies and HasIsZero is set we already know that o is a non-zero homalg (co)complex
        Print( " non-zero" );
    fi;
    
    if HasIsBicomplex( o ) then
        if IsBicomplex( o ) then
            if cpx then
                Print( " bicomplex" );
            else
                Print( " bicocomplex" );
            fi;
        else
            if cpx then
                Print( " non-bicomplex" );
            else
                Print( " non-bicocomplex" );
            fi;
        fi;
    elif HasIsSequence( o ) then
        if IsSequence( o ) then
            if cpx then
                Print( " bisequence" );
            else
                Print( " bicosequence" );
            fi;
        else
            if cpx then
                Print( " bisequence of non-well-definded morphisms" );
            else
                Print( " bicosequence of non-well-definded morphisms" );
            fi;
        fi;
    else
        if cpx then
            Print( " \"bicomplex\"" );
        else
            Print( " \"bicocomplex\"" );
        fi;
    fi;
    
    Print( ">" );
    
end );

##
InstallMethod( ViewObj,
        "for homalg bicomplexes",
        [ IsBicomplexOfFinitelyPresentedObjectsRep and IsZero ],
        
  function( o )
    
    Print( "<A zero " );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        Print( "left" );
    else
        Print( "right" );
    fi;
    
    Print( " bicomplex>" );
    
end );

##
InstallMethod( ViewObj,
        "for homalg bicomplexes",
        [ IsBicocomplexOfFinitelyPresentedObjectsRep and IsZero ],
        
  function( o )
    
    Print( "<A zero " );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        Print( "left" );
    else
        Print( "right" );
    fi;
    
    Print( " bicocomplex>" );
    
end );

##
InstallMethod( Display,
        "for homalg bicomplexes",
        [ IsBicomplexOfFinitelyPresentedObjectsRep and IsZero ],
        
  function( o )
    
    Print( "0\n" );
    
end );

##
InstallMethod( Display,
        "for homalg bicomplexes",
        [ IsBicocomplexOfFinitelyPresentedObjectsRep and IsZero ],
        
  function( o )
    
    Print( "0\n" );
    
end );

