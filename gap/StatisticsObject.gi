#############################################################################
##
##  StatisticsObject.gi       HomalgToCAS package            Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Implementation for statistics objects.
##
#############################################################################

####################################
#
# representations:
#
####################################

##
DeclareRepresentation( "IsStatisticsObjectRep",
        IsStatisticsObject,
        [ "statistics" ] );

##
DeclareRepresentation( "IsStatisticsObjectForStreamsRep",
        IsStatisticsObjectRep,
        [ "statistics" ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfStatisticsObjects",
        NewFamily( "TheFamilyOfStatisticsObjects" ) );

# a new type:
BindGlobal( "TheTypeStatisticsObject",
        NewType(  TheFamilyOfStatisticsObjects,
                IsStatisticsObjectRep ) );

BindGlobal( "TheTypeStatisticsObjectForStreams",
        NewType(  TheFamilyOfStatisticsObjects,
                IsStatisticsObjectForStreamsRep ) );

####################################
#
# methods for operations and global functions:
#
####################################

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( NewStatisticsObject,
  function( arg )
    local nargs, statistics, type;
    
    nargs := Length( arg );
    
    type := TheTypeStatisticsObject;
    
    if nargs = 0 then
        statistics := rec( );
    elif IsRecord( arg[1] ) then
        statistics := arg[1];
        if nargs > 1 and IsType( arg[2] ) then
            type := arg[2];
        fi;
    fi;
    
    if not IsBound( statistics.Sort ) then
        ## sort by value
        statistics.SortByValue := function( a, b ) return a[2] < b[2] or ( a[2] = b[2] and a[1] < b[1] ); end;
        statistics.SortByName := function( a, b ) return a[1] < b[1] or ( a[1] = b[1] and a[2] < b[2] ); end;
        statistics.Sort := statistics.SortByName;
    fi;
    
    ## Objectify:
    Objectify( type, statistics );
    
    return statistics;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for statistics objects",
        [ IsStatisticsObjectRep ],
        
  function( o )
    
    Print( "<A statistics object>" );
    
end );

##
InstallMethod( ViewObj,
        "for statistics objects",
        [ IsStatisticsObjectForStreamsRep ],
        
  function( o )
    
    Print( "summary_" );
    ViewObj( o!.summary );
    
end );

##
InstallMethod( Display,
        "for statistics objects",
        [ IsStatisticsObjectForStreamsRep ],
        
  function( o )
    local LookupTable, statistics, components, p, r;
    
    LookupTable := SplitString( o!.LookupTable, '.' );
    
    if Length( LookupTable ) > 1 then
        LookupTable := ValueGlobal( LookupTable[1] ).(LookupTable[2]);
    else
        LookupTable := ValueGlobal( LookupTable[1] );
    fi;
    
    statistics := [ ];
    
    components := NamesOfComponents( LookupTable );
    
    for p in components do
        if p <> "LookupTable" and IsBound( o!.(LookupTable.(p)) ) then
            Add( statistics, [ p, o!.(LookupTable.(p)) ] );
        fi;
    od;
    
    Sort( statistics, o!.Sort );
    
    r := rec( );
    
    for p in statistics do
        r.(p[1]) := p[2];
    od;
    
    Display( r );
    
end );

