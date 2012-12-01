#############################################################################
##
##  ToDoListEntry.gi                                 ToolsForHomalg package
##
##  Copyright 2007-2012, Mohamed Barakat, University of Kaiserslautern
##                       Sebastian Gutsche, RWTH-Aachen University
##                  Markus Lange-Hegermann, RWTH-Aachen University
##
##  Entries for ToDo-Lists.
##
#############################################################################

DeclareRepresentation( "IsToDoListEntryRep",
                       IsToDoListEntry and IsAttributeStoringRep,
                       []
                     );

DeclareRepresentation( "IsToDoListEntryWithWeakPointersRep",
                       IsToDoListEntryRep,
                       []
                     );

DeclareRepresentation( "IsToDoListEntryWithPointersRep",
                       IsToDoListEntryRep,
                       []
                     );

DeclareRepresentation( "IsToDoListEntryForEquivalentPropertiesRep",
                       IsToDoListEntryRep,
                       []
                     );

DeclareRepresentation( "IsToDoListEntryMadeFromOtherToDoListEntriesRep",
                       IsToDoListEntryRep,
                       []
                     );

BindGlobal( "TheFamilyOfToDoListEntries",
        NewFamily( "TheFamilyOfToDoListEntries" ) );

BindGlobal( "TheTypeToDoListEntryWithWeakPointers",
        NewType( TheFamilyOfToDoListEntries,
                IsToDoListEntryWithWeakPointersRep ) );

BindGlobal( "TheTypeToDoListEntryWithPointers",
        NewType( TheFamilyOfToDoListEntries,
                IsToDoListEntryWithPointersRep ) );

BindGlobal( "TheTypeToDoListEntryForEquivalentProperties",
        NewType( TheFamilyOfToDoListEntries,
                IsToDoListEntryForEquivalentPropertiesRep ) );

BindGlobal( "TheTypeToDoListEntryMadeFromOtherToDoListEntries",
        NewType( TheFamilyOfToDoListEntries,
                IsToDoListEntryMadeFromOtherToDoListEntriesRep ) );

##########################################
##
## Methods
##
##########################################

##
InstallMethod( ProcessAToDoListEntry,
               [ IsToDoListEntry ],
               
  function( entry )
    local source, pull_attr, target, push_attr;
    
    source := SourcePart( entry );
    
    if source = fail then
        
        return fail;
        
    fi;
    
    pull_attr := ValueGlobal( source[ 2 ] );
    
    if Tester( pull_attr )( source[ 1 ] ) then
        
        target := TargetPart( entry );
        
        if target = fail then
            
            return fail;
            
        fi;
        
        push_attr := ValueGlobal( target[ 2 ] );
        
        if pull_attr( source[ 1 ] ) = source[ 3 ] then
            
            Setter( push_attr )( target[ 1 ], target[ 3 ] );
            
            Add( ToDoList( target[ 1 ] )!.from_others, entry );
            
            return true;
            
        elif IsFilter( push_attr ) then
            
            Setter( push_attr )( target[ 1 ], not target[ 3 ] );
            
            Add( ToDoList( target[ 1 ] )!.from_others, entry );
            
            SetFilterObj( entry, PreconditionsDefinitelyNotFulfilled );
            
            return true;
            
        else
            
            SetFilterObj( entry, PreconditionsDefinitelyNotFulfilled );
            
            return true;
            
        fi;
    fi;
    
    return false;
    
end );

##
InstallMethod( AreCompatible,
               "for todo-list entries",
               [ IsToDoListEntry, IsToDoListEntry ],
               
  function( entry1, entry2 )
    
    return TargetPart( entry1 ) = SourcePart( entry2 );
    
end );

##
InstallMethod( ToDoListEntryWithWeakPointers,
               "for 6 arguments",
               [ IsObject, IsString, IsObject, IsObject, IsString, IsObject ],
               
  function( M, attr_to_pull, val_to_pull, obj_to_push, attr_to_push, val_to_push )
    local string_list, value_list, entry;
    
    value_list := WeakPointerObj( [ M, val_to_pull, obj_to_push, val_to_push ] );
    
    string_list := [ attr_to_pull, attr_to_push ];
    
    entry := rec( );
    
    ObjectifyWithAttributes( entry, TheTypeToDoListEntryWithWeakPointers );
    
    entry!.value_list := value_list;
    
    entry!.string_list := string_list;
    
    return entry;
    
end );

##
InstallMethod( SourcePart,
               "for weak pointer entries",
               [ IsToDoListEntryWithWeakPointersRep ],
               
  function( entry )
    
    if not IsBoundElmWPObj( entry!.value_list, 1 ) or not IsBoundElmWPObj( entry!.value_list, 2 ) then
        
        return fail;
        
    fi;
    
    return [ ElmWPObj( entry!.value_list, 1 ), entry!.string_list[ 1 ], ElmWPObj( entry!.value_list, 2 ) ];
    
end );

##
InstallMethod( TargetPart,
               "for weak pointer entries",
               [ IsToDoListEntryWithWeakPointersRep ],
               
  function( entry )
    
    if not IsBoundElmWPObj( entry!.value_list, 3 ) or not IsBoundElmWPObj( entry!.value_list, 4 ) then
        
        return fail;
        
    fi;
    
    return [ ElmWPObj( entry!.value_list, 3 ), entry!.string_list[ 2 ], ElmWPObj( entry!.value_list, 4 ) ];
    
end );

##
InstallMethod( ToDoListEntryWithPointers,
               "for 6 arguments",
               [ IsObject, IsString, IsObject, IsObject, IsString, IsObject ],
               
  function( M, attr_to_pull, val_to_pull, obj_to_push, attr_to_push, val_to_push )
    local entry;
    
    entry := rec( );
    
    ObjectifyWithAttributes( entry, TheTypeToDoListEntryWithPointers );
    
    entry!.list := [ M, attr_to_pull, val_to_pull, obj_to_push, attr_to_push, val_to_push ];
    
    return entry;
    
end );

##
InstallMethod( SourcePart,
               "for entries with pointers",
               [ IsToDoListEntryWithPointersRep ],
               
  function( entry )
    
    return entry!.list{ [ 1, 2, 3 ] };
    
end );

##
InstallMethod( TargetPart,
               "for entries with pointers",
               [ IsToDoListEntryWithPointersRep ],
               
  function( entry )
    
    return entry!.list{ [ 4, 5, 6 ] };
    
end );

InstallMethod( GenesisOfToDoListEntry,
               "for atomic entries",
               [ IsToDoListEntry ],
               
  function( entry )
    
    return [ entry ];
    
end );

##
InstallMethod( JoinToDoListEntries,
               "for a list of ToDo-list entries",
               [ IsList ],
               
  function( list )
    local new_entry;
    
    if not ForAll( list, IsToDoListEntry ) then
        
        Error( "must be a list of ToDo-list entries\n" );
        
    fi;
    
    if not ForAll( [ 1 .. Length( list ) - 1 ], i -> AreCompatible( list[ i ], list[ i + 1 ] ) ) then
        
        Error( "entries are not compatible\n" );
        
    fi;
    
    new_entry := rec ( );
    
    ObjectifyWithAttributes( new_entry, TheTypeToDoListEntryMadeFromOtherToDoListEntries );
    
    SetGenesisOfToDoListEntry( new_entry, Concatenation( List( list, GenesisOfToDoListEntry ) ) );
    
    return new_entry;
    
end );

##
InstallMethod( SourcePart,
               "for concatenation",
               [ IsToDoListEntryMadeFromOtherToDoListEntriesRep ],
               
  function( entry )
    local gen;
    
    gen := GenesisOfToDoListEntry( entry );
    
    return SourcePart( gen[ 1 ] );
    
end );

##
InstallMethod( TargetPart,
               "for concatenation",
               [ IsToDoListEntryMadeFromOtherToDoListEntriesRep ],
               
  function( entry )
    local gen;
    
    gen := GenesisOfToDoListEntry( entry );
    
    return TargetPart( gen[ Length( gen ) ] );
    
end );
