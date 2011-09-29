#############################################################################
##
##  HomalgDiagram.gi                                   GradedModules package
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Declarations for Betti diagrams.
##
#############################################################################

####################################
#
# families and types:
#
####################################

# a new type:
BindGlobal( "TheTypeBettiDiagram",
        NewType(  TheFamilyOfHomalgDiagrams,
                IsHomalgDiagramRep and
                IsBettiDiagram ) );

####################################
#
# global variables:
#
####################################

HOMALG.SpectralSequenceConventionForBettiDiagramsOfComplexes := false;
HOMALG.SpectralSequenceConventionForBettiDiagramsOfCocomplexes := true;

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( RowDegreesOfBettiDiagram,
        "for Betti diagrams",
        [ IsBettiDiagram ],
        
  function( diag )
    
    return diag!.row_range;
    
end );

##
InstallMethod( ColumnDegreesOfBettiDiagram,
        "for Betti diagrams",
        [ IsBettiDiagram ],
        
  function( diag )
    
    return diag!.column_range;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( HomalgBettiDiagram,
  function( arg )
    local betti, row_range, column_range, object, ar, nr_rows, nr_cols, diagram;
    
    betti := arg[1];
    row_range := arg[2];
    column_range := arg[3];
    object := arg[4];
    
    nr_rows := Length( row_range );
    nr_cols := Length( column_range );
    
    if nr_rows <> Length( betti ) then
        Error( "the Betti table and the row range are incompatible\n" );
    elif Length( betti ) > 0 and nr_cols <> Length( betti[1] ) then
        Error( "the Betti table and the column range are incompatible\n" );
    fi;
    
    diagram := rec(
                   object := object,
                   matrix := betti,
                   row_range := row_range,
                   column_range := column_range,
                   reverse := false	## read the row range upside down?: default value is false (might get reset below)
                   );
    
    ## search for options
    for ar in arg{[ 5 .. Length( arg ) ]} do
        if IsString( ar ) then
            diagram.( ar ) := true;
        elif IsList( ar ) and Length( ar ) = 2 and IsString( ar[1] ) then
            diagram.( ar[1] ) := ar[2];
        fi;
    od;
    
    ## Objectify:
    ObjectifyWithAttributes(
            diagram, TheTypeBettiDiagram,
            NrRows, nr_rows,
            NrColumns, nr_cols
            );
    
    return diagram;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for Betti diagrams",
        [ IsBettiDiagram ],
        
  function( o )
    
    Print( "<A Betti diagram of " );
    
    if HasBettiDiagram ( o!.object ) and IsIdenticalObj( o, BettiDiagram ( o!.object ) ) then
        ViewObj( o!.object );
        Print( ">" );
    else
        Print( "a homalg " );
        if IsBound( o!.object!.string ) then
            Print( o!.object!.string );
        else
            Print( "object" );
        fi;
        Print( ">" );
    fi;
    
end );

##
InstallMethod( homalgCreateDisplayString,
        "for Betti diagrams",
        [ IsBettiDiagram ],
        
  function( o )
    local SpectralSequenceConvention, betti, row_range, column_range,
          higher_vanish, twist, EulerCharacteristic, reverse,
          nr_rows, nr_cols, total, max, twist_range, chi,
          MAX, display, ar, i, pos;
    
    ## the spectral sequence convention for Betti diagrams
    SpectralSequenceConvention := o!.SpectralSequenceConvention;
    
    ## collect the relevant data from the diagram
    betti := MatrixOfDiagram( o );
    
    row_range := RowDegreesOfBettiDiagram( o );
    column_range := ColumnDegreesOfBettiDiagram( o );
    
    if IsBound( o!.higher_vanish ) then
        higher_vanish := o!.higher_vanish;
    fi;
    
    if IsBound( o!.twist ) then
        twist := o!.twist;
    fi;
    
    if IsBound( o!.EulerCharacteristic ) and
       IsUnivariatePolynomial( o!.EulerCharacteristic ) then
        EulerCharacteristic := o!.EulerCharacteristic;
    fi;
    
    ## read the row range upside down?
    reverse := o!.reverse;
    
    nr_rows := NrRows( o );
    nr_cols := NrColumns( o );
    
    ## now prepare constructing the display string
    
    ## the list of total dimensions
    total := ListWithIdenticalEntries( nr_rows, 1 ) * betti;
    
    ## save it
    o!.total := total;
    
    ## get the maximum width in the matrix
    max := MaximumList( List( betti, r -> MaximumList( List( r, a -> Length( String( a ) ) ) ) ) );
    max := Maximum( MaximumList( List( column_range, a -> Length( String( a ) ) ) ), max );
    max := Maximum( MaximumList( List( total, a -> Length( String( a ) ) ) ), max );
    
    if SpectralSequenceConvention then
        ar := column_range[1];
        if nr_rows > 1 then
            max := Maximum( MaximumList( List( [ ar - ( nr_rows - 1 ) .. ar - 1 ], a -> Length( String( a ) ) ) ), max );
        fi;
    fi;
    
    if IsBound( twist ) then
        twist_range := column_range - ( nr_rows - 1 );
        max := Maximum( MaximumList( List( twist_range, a -> Length( String( a ) ) ) ), max );
        if IsBound( EulerCharacteristic ) then
            
            if SpectralSequenceConvention then
                twist_range := [ twist_range[1] .. twist_range[nr_cols] + ( nr_rows - 1 ) ];
                chi := List( twist_range, i -> Value( EulerCharacteristic, i ) );
            else
                chi := List( twist_range + ( nr_rows - 1 ), i -> Value( EulerCharacteristic, i ) );
            fi;
            
            ## save it
            o!.Euler := chi;
            
            max := Maximum( MaximumList( List( chi, a -> Length( String( a ) ) ) ), max );
            
        elif twist = row_range[nr_rows] then ## we might have computed the syzygies up to some degree bound only
            
            chi := List( [ 1 .. nr_cols - twist ], j -> Sum( [ 0 .. nr_rows - 1 ], i -> (-1)^i * betti[nr_rows-i][i+j] ) );
            
            ## save it
            o!.Euler := chi;
            
            if IsBound( higher_vanish ) and column_range[Length( column_range )] >= higher_vanish - 1 then
                Append( chi, List( [ Maximum( nr_cols - twist + 1, 1 ) .. nr_cols ],
                        j -> Sum( [ 0 .. nr_rows - 1 ],
                                function( i )
                                  if IsBound( betti[nr_rows-i][i+j] ) then
                                      return (-1)^i * betti[nr_rows-i][i+j];
                                  else
                                      return 0;
                                  fi; end ) ) );
                                  
                ## save it
                o!.Euler := chi;
            else
                Append( chi, ListWithIdenticalEntries( twist, "?" ) );
            fi;
            
            max := Maximum( MaximumList( List( chi, a -> Length( String( a ) ) ) ), max );
            
        fi;
    fi;
    
    ## finally add a space
    max := max + 1;
    
    ## the maximum of the legend column
    MAX := MaximumList( List( row_range, a -> Length( String( a ) ) ) );
    
    if IsBound( twist ) then
        MAX := Maximum( MAX, Length( "twist" ) );
    else
        MAX := Maximum( MAX, Length( "degree" ) );
    fi;
    
    ## create the display string:
    
    display := "";
    
    if SpectralSequenceConvention then
        nr_cols := nr_cols + nr_rows - 1;
    fi;
    
    ## total:
    if nr_rows > 1 then
        Append( display, FormattedString( "total", MAX ) );
        Append( display, ": " );
        Perform( total, function( i ) Append( display, FormattedString( i, max ) ); end );
        if SpectralSequenceConvention then
            Perform( [ 1 .. nr_rows - 1 ], function( i ) Append( display, FormattedString( "?", max ) ); end );
        fi;
        Append( display, "\n" );
        if SpectralSequenceConvention then
            Append( display, ListWithIdenticalEntries( MAX + 2, '-' ) );
            Append( display, Flat( ListWithIdenticalEntries( nr_cols, Concatenation( ListWithIdenticalEntries( max - 1, '-' ), "|" ) ) ) );
        else
            Append( display, ListWithIdenticalEntries( MAX + 2 + nr_cols * max, '-' ) );
        fi;
        Append( display, "\n" );
    fi;
    
    ## twist:
    if IsBound( twist ) and nr_rows > 1 and not SpectralSequenceConvention then
        Append( display, FormattedString( "twist", MAX ) );
        Append( display, ": " );
        Perform( twist_range, function( i ) Append( display, FormattedString( i, max ) ); end );
        Append( display, "\n" );
        Append( display, ListWithIdenticalEntries( MAX + 2, '-' ) );
        Append( display, Flat( ListWithIdenticalEntries( nr_cols, Concatenation( ListWithIdenticalEntries( max - 1, '-' ), "|" ) ) ) );
        Append( display, "\n" );
    fi;
    
    if reverse then
        row_range := Reversed( row_range );
    fi;
    
    ## betti:
    if SpectralSequenceConvention then
        for ar in [ 1 .. nr_rows ] do
            Append( display, FormattedString( String( row_range[ar] ), MAX ) );
            Append( display, ": " );
            Perform( [ 1 .. ar - 1 ], function( i ) Append( display, FormattedString( "*", max ) ); end );
            for i in [ 1 .. nr_cols - ( nr_rows - 1 ) ] do
                if betti[ar][i] = 0 then
                    Append( display, FormattedString( ".", max ) );
                else
                    Append( display, FormattedString( String( betti[ar][i] ), max ) );
                fi;
            od;
            if IsBound( higher_vanish ) and column_range[Length( column_range )] >= higher_vanish - 1 then
                Perform( [ 1 .. nr_rows - ar ], function( i ) Append( display, FormattedString( "0", max ) ); end );
            else
                Perform( [ 1 .. nr_rows - ar ], function( i ) Append( display, FormattedString( "*", max ) ); end );
            fi;
            Append( display, "\n" );
        od;
    else
        for ar in [ 1 .. nr_rows ] do
            Append( display, FormattedString( String( row_range[ar] ), MAX ) );
            Append( display, ": " );
            for i in [ 1 .. nr_cols ] do
                if betti[ar][i] = 0 then
                    Append( display, FormattedString( ".", max ) );
                else
                    Append( display, FormattedString( String( betti[ar][i] ), max ) );
                fi;
            od;
            Append( display, "\n" );
        od;
    fi;
    
    ## degree/twist:
    if IsBound( twist ) then
        Append( display, ListWithIdenticalEntries( MAX + 2, '-' ) );
        if IsBound( higher_vanish ) then
            pos := Position( column_range, higher_vanish );
        fi;
        
        if IsBound( pos ) and IsPosInt( pos ) then
            pos := pos + nr_cols - Length( column_range );
            Append( display, Flat( ListWithIdenticalEntries( pos - 1, Concatenation( ListWithIdenticalEntries( max - 1, '-' ), "|" ) ) ) );
            Append( display, Concatenation( ListWithIdenticalEntries( max - 1, '-' ), "V" ) );
            Append( display, Flat( ListWithIdenticalEntries( nr_cols - pos, Concatenation( ListWithIdenticalEntries( max - 1, '-' ), "|" ) ) ) );
        else
            Append( display, Flat( ListWithIdenticalEntries( nr_cols, Concatenation( ListWithIdenticalEntries( max - 1, '-' ), "|" ) ) ) );
        fi;
        Append( display, "\n" );
        Append( display, FormattedString( "twist", MAX ) );
    else
        Append( display, ListWithIdenticalEntries( MAX + 2 + nr_cols * max, '-' ) );
        Append( display, "\n" );
        Append( display, FormattedString( "degree", MAX ) );
    fi;
    
    Append( display, ": " );
    
    if SpectralSequenceConvention then
        ar := column_range[1];
        Perform( [ ar - ( nr_rows - 1 ) .. ar - 1 ], function( i ) Append( display, FormattedString( i, max ) ); end );
    fi;
    
    Perform( column_range, function( i ) Append( display, FormattedString( i, max ) ); end );
    
    Append( display, "\n" );
    
    ## Euler characteristic:
    if IsBound( chi ) then
        Append( display, ListWithIdenticalEntries( MAX + 2 + nr_cols * max, '-' ) );
        Append( display, "\n" );
        Append( display, FormattedString( "Euler", MAX ) );
        Append( display, ": " );
        if SpectralSequenceConvention and not IsBound( EulerCharacteristic ) then
            Perform( [ 1 .. nr_rows - 1 ], function( i ) Append( display, FormattedString( "?", max ) ); end );
        fi;
        Perform( chi, function( i ) Append( display, FormattedString( i, max ) ); end );
        Append( display, "\n" );
    fi;
    
    return display;
    
end );

##
InstallMethod( Display,
        "for Betti diagrams",
        [ IsBettiDiagram ],
        
  function( o )
    local SpectralSequenceConvention;
    
    ## the spectral sequence convention for Betti diagrams
    if IsBound( HOMALG.SpectralSequenceConventionForBettiDiagrams ) then
        SpectralSequenceConvention := HOMALG.SpectralSequenceConventionForBettiDiagrams = true;
    elif IsComplexOfFinitelyPresentedObjectsRep( o!.object ) and
      IsBound( HOMALG.SpectralSequenceConventionForBettiDiagramsOfComplexes ) then
        SpectralSequenceConvention := HOMALG.SpectralSequenceConventionForBettiDiagramsOfComplexes = true;
    elif IsCocomplexOfFinitelyPresentedObjectsRep( o!.object ) and
      IsBound( HOMALG.SpectralSequenceConventionForBettiDiagramsOfCocomplexes ) then
        SpectralSequenceConvention := HOMALG.SpectralSequenceConventionForBettiDiagramsOfCocomplexes = true;
    else
        SpectralSequenceConvention := false;
    fi;
    
    if not IsBound( o!.display ) or
       o!.SpectralSequenceConvention <> SpectralSequenceConvention then
        
        o!.SpectralSequenceConvention := SpectralSequenceConvention;
        o!.display := homalgCreateDisplayString( o );
        
    fi;
    
    Print( o!.display );
    
end );

