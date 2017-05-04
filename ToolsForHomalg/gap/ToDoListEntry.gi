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

InstallValue( TODO_LIST_ENTRIES,
              rec(
                  already_installed_immediate_methods := [ ],
                  implications := [ ]
              )
);

DeclareRepresentation( "IsToDoListEntryRep",
                       IsToDoListEntry and IsAttributeStoringRep,
                       []
                     );

DeclareRepresentation( "IsToDoListEntryForEquivalentPropertiesRep",
                       IsToDoListEntryRep,
                       []
                     );

DeclareRepresentation( "IsToDoListEntryForEqualPropertiesRep",
                       IsToDoListEntryRep,
                       []
                     );

DeclareRepresentation( "IsToDoListEntryWithListOfSourcesRep",
                       IsToDoListEntryRep,
                       []
                     );

DeclareRepresentation( "IsToDoListEntryWhichLaunchesAFunctionRep",
                       IsToDoListEntryWithListOfSourcesRep,
                       []
                     );

DeclareRepresentation( "IsToDoListEntryWithDefinedTargetRep",
                       IsToDoListEntryWithListOfSourcesRep,
                       []
                     );

DeclareRepresentation( "IsToDoListEntryWithSingleSourceRep",
                       IsToDoListEntryWithDefinedTargetRep,
                       []
                      );

DeclareRepresentation( "IsToDoListEntryWithWeakPointersRep",
                       IsToDoListEntryWithSingleSourceRep,
                       []
                     );

DeclareRepresentation( "IsToDoListEntryWithPointersRep",
                       IsToDoListEntryWithSingleSourceRep,
                       []
                     );

DeclareRepresentation( "IsToDoListEntryWithContrapositionRep",
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

BindGlobal( "TheTypeToDoListEntryForEqualProperties",
        NewType( TheFamilyOfToDoListEntries,
                IsToDoListEntryForEqualPropertiesRep ) );

BindGlobal( "TheTypeToDoListEntryMadeFromOtherToDoListEntries",
        NewType( TheFamilyOfToDoListEntries,
                IsToDoListEntryMadeFromOtherToDoListEntriesRep ) );

BindGlobal( "TheTypeToDoListEntryWithListOfSources",
        NewType( TheFamilyOfToDoListEntries,
                IsToDoListEntryWithDefinedTargetRep ) );

BindGlobal( "TheTypeToDoListWhichLaunchesAFunction",
        NewType( TheFamilyOfToDoListEntries,
                IsToDoListEntryWhichLaunchesAFunctionRep ) );

BindGlobal( "TheTypeToDoListEntryWithContraposition",
        NewType( TheFamilyOfToDoListEntries,
                IsToDoListEntryWithContrapositionRep ) );

##########################################
##
## Methods
##
##########################################

##
BindGlobal( "TODOLIST_ADD_TO_RECORD_AT_POSITION",
            
  function( record, position, entry )
    
    if not IsBound( record.( position ) ) then
        
        record.( position ) := [ ];
        
    elif ForAny( record.( position ), i -> IsIdenticalObj( i, entry ) ) then
        
        return;
        
   fi;
   
   Add( record.( position ), entry );
   
end );

##
InstallMethod( \=,
               [ IsToDoListEntry, IsToDoListEntry ],
               
  IsIdenticalObj
  
);

##
InstallGlobalFunction( ToDoLists_Process_Entry_Part,
                       
  function( entry_list )
    
    if IsFunction( entry_list ) then
        
        return entry_list();
        
    elif IsList( entry_list ) and Length( entry_list ) > 0 and IsFunction( entry_list[ 1 ] ) then
        
        return CallFuncList( entry_list[ 1 ], entry_list{[ 2 .. Length( entry_list ) ]} );
        
    fi;
    
    return entry_list;
    
end );

##
InstallMethod( ToDoLists_Move_To_Target_ToDo_List,
               "for entries",
               [ IsToDoListEntryWithDefinedTargetRep ],
               
  function( entry )
    local source_list, target, source;
    
    source_list := SourcePart( entry );
    
    if source_list = fail then
        
        return;
        
    fi;
    
    for source in source_list do
        
        if IsBound( source[ 3 ] ) then
            
            source[ 3 ] := ToDoLists_Process_Entry_Part( source[ 3 ] );
            
        elif IsString( source[ 2 ] ) and not IsBound( source[ 3 ] ) and Tester( ValueGlobal( source[ 2 ] ) )( source[ 1 ] ) then
            
            Add( source, ValueGlobal( source[ 2 ] )( source[ 1 ] ) );
            
        fi;
        
    od;
    
    target := TargetPart( entry );
    
    if target = fail then
        
        return;
        
    fi;
    
    SetTargetObject( entry, ToDoLists_Process_Entry_Part( target[ 1 ] ) );
    
    SetTargetValueObject( entry, ToDoLists_Process_Entry_Part( target[ 3 ] ) );
    
    target := target[ 1 ];
    
    if Position( ToDoList( target )!.from_others, entry ) = fail then
        
        Add( ToDoList( target )!.from_others, entry );
        
    fi;
    
end );

##
InstallMethod( ToDoLists_Move_To_Target_ToDo_List,
               "for all entries",
               [ IsToDoListEntry ],
               
  function( entry )
  
end );

##
InstallGlobalFunction( ToolsForHomalg_ProcessToDoListEquivalencesAndContrapositions,
                       
  function( entry )
    local i;
    
    if IsBound( entry!.contrapositions ) then
        
        for i in entry!.contrapositions do
            
            SetFilterObj( i, PreconditionsDefinitelyNotFulfilled );
            
        od;
        
    fi;
    
    if IsBound( entry!.equivalences ) then
        
        for i in entry!.equivalences do
            
            SetFilterObj( i, IsProcessedEntry );
            
        od;
        
    fi;
    
end );

##
InstallGlobalFunction( ToolsForHomalg_CheckASourcePart,
                       
  function( source_part )
    local pull_attr, comparator, i;
    
    if ( not IsList( source_part ) ) or Length( source_part ) < 2 or Length( source_part ) > 4 then
        
        Error( "not a valid argument" );
        
        return fail;
        
    fi;
    
    if not IsString( source_part[ 2 ] ) then
        
        if ForAll( source_part[ 2 ], i -> Tester( ValueGlobal( i ) )( source_part[ 1 ] ) ) then
            
            if not IsBound( source_part[ 3 ] ) then
                
                return true;
                
            elif source_part[ 3 ]() then
                
                source_part[ 3 ] := true;
                
                return true;
                
            else
                
                source_part[ 3 ] := false;
                
                return fail;
                
            fi;
            
        else
            
            return false;
            
        fi;
        
    fi;
    
    pull_attr := ValueGlobal( source_part[ 2 ] );
    
    if Length( source_part ) = 4 and IsFunction( source_part[ 4 ] ) then
        
        comparator := source_part[ 4 ];
        
    else
        
        comparator := \=;
        
    fi;
    
    if not Tester( pull_attr )( source_part[ 1 ] ) then
        
        return false;
        
    elif Length( source_part ) = 3 then
        
        if IsList( source_part[ 3 ] ) then
            
            source_part[ 3 ] := ToDoLists_Process_Entry_Part( source_part[ 3 ] );
            
        fi;
        
        if not comparator( pull_attr( source_part[ 1 ] ), source_part[ 3 ] ) then
            
            return fail;
            
        fi;
        
    fi;
    
    return true;
    
end );

##########################################
##
## General methods
##
##########################################

##
InstallMethod( AddToToDoList,
               "for lists",
               [ IsList ],
               
  function( entry_list )
    
    Perform( entry_list, AddToToDoList );
    
end );

##
InstallMethod( AddToToDoList,
               "for a todo list entry",
               [ IsToDoListEntryWithListOfSourcesRep ],
               
  function( entry )
    local result, source, source_list, source_object_list, todo_list, target;
    
    if not ToDoList_Is_Sane_Entry( entry ) then
        
        return;
        
    fi;
    
    source_list := SourcePart( entry );
    
    if source_list = fail then
        
        return;
        
    fi;
    
    entry!.source_tester_list := List( source_list, i -> false );
    
    source_object_list := [ ];
    
    for source in source_list do
        
        if ForAll( source_object_list, i -> not IsIdenticalObj( i, source[ 1 ] ) ) then
            
            Add( source_object_list, source[ 1 ] );
            
        fi;
        
    od;
    
    if not ForAny( source_object_list, CanHaveAToDoList ) then
        
        return;
        
    fi;
    
    result := ProcessAToDoListEntry( entry );
    
    for source in source_list do
        
        todo_list := ToDoList( source[ 1 ] );
        
        if IsFunction( result ) then
            
            Add( todo_list!.already_done, entry );
            
        elif result = false and not PreconditionsDefinitelyNotFulfilled( entry ) and CanHaveAToDoList( source[ 1 ] ) then
            
            TODOLIST_ADD_TO_RECORD_AT_POSITION( todo_list!.todos, source[ 2 ], entry );
            
            SetFilterObj( source[ 1 ], HasSomethingToDo );
            
        elif result = false and PreconditionsDefinitelyNotFulfilled( entry ) then
            
            Add( todo_list!.precondition_not_fulfilled, entry );
            
        elif result = fail then
            
            Add( todo_list!.garbage, entry );
            
        fi;
        
    od;
    
    if IsFunction( result ) then
        
        result();
        
    fi;
    
end );

##########################################
##
## Entry with functions
##
##########################################

##
InstallMethod( SourcePart,
               "for entries that launches functions",
               [ IsToDoListEntryWhichLaunchesAFunctionRep ],
               
  function( entry )
    
    return RecoverWholeList( entry!.source_list );
    
end );

##
InstallMethod( TargetPart,
               "for entries that launches functions",
               [ IsToDoListEntryWhichLaunchesAFunctionRep ],
               
  function( entry )
    
    return entry!.func;
    
end );

##
InstallMethod( ToDoListEntry,
               "constructor",
               [ IsList, IsFunction ],
               
  function( source_list, func )
    local entry;
    
    if not ForAll( source_list, i -> IsList( i[ 2 ] ) and ( Length( i ) = 3 or Length( i ) = 2 or Length( i ) = 4 ) ) then
        
        Error( "wrong input format" );
        
    fi;
    
    entry := rec( source_list := ToDoListWeakPointer( source_list ), func := func );
    
    ObjectifyWithAttributes( entry, TheTypeToDoListWhichLaunchesAFunction );
    
    return entry;
    
end );

##
InstallMethod( ToDoList_Is_Sane_Entry,
               "function entries",
               [ IsToDoListEntryWhichLaunchesAFunctionRep ],
               
  function( entry )
    
    return IsCompleteWeakPointerList( entry!.source_list );
    
end );

##
InstallMethod( ProcessAToDoListEntry,
               [ IsToDoListEntryWhichLaunchesAFunctionRep ],
               
  function( entry )
    local source_list, source, pull_attr, target, push_attr, tester_var, source_status;
    
    source_list := SourcePart( entry );
    
    if source_list = fail then
        
        return fail;
        
    fi;
    
    target := TargetPart( entry );
    
    if target = fail then
    
        return fail;
    
    fi;
    
    for source in [ 1 .. Length( source_list ) ] do
        
        if entry!.source_tester_list[ source ] = true then
            
            continue;
            
        fi;
        
        source_status := ToolsForHomalg_CheckASourcePart( source_list[ source ] );
        
        if source_status = fail then
            
            SetFilterObj( entry, PreconditionsDefinitelyNotFulfilled );
            
            return false;
            
        elif not source_status then
            
            return false;
            
        else
            
            entry!.source_tester_list[ source ] := true;
            
        fi;
        
    od;
    
    SetFilterObj( entry, IsProcessedEntry );
    
    return target;
    
end );

##########################################
##
## Entry with list of sources
##
##########################################

##
InstallMethod( ToDoListEntry,
               "todo list entry with list of sources",
               [ IsList, IsObject, IsString, IsObject ],
               
  function( source_list, obj_to_push, attr_to_push, val_to_push )
    local wpt_source_list, targetlist, entry;
    
    if not ForAll( source_list, i -> IsList( i[ 2 ] ) and ( Length( i ) = 3 or Length( i ) = 2 or Length( i ) = 4 ) ) then
        
        Error( "wrong input format" );
        
    fi;
    
    wpt_source_list := ToDoListWeakPointer( source_list );
    
    targetlist := ToDoListWeakPointer( [ obj_to_push, attr_to_push, val_to_push ] );
    
    entry := rec( source_list := wpt_source_list, targetlist := targetlist );
    
    ObjectifyWithAttributes( entry, TheTypeToDoListEntryWithListOfSources );
    
    return entry;
    
end );

##
InstallMethod( ToDoList_Is_Sane_Entry,
               "for list entries",
               [ IsToDoListEntryWithListOfSourcesRep ],
               
  function( entry )
    
    return IsCompleteWeakPointerList( entry!.source_list ) and IsCompleteWeakPointerList( entry!.targetlist );
    
end );

##
InstallMethod( SourcePart,
               "for entries with lists of sources",
               [ IsToDoListEntryWithListOfSourcesRep ],
               
  function( entry )
    
    return RecoverWholeList( entry!.source_list );
    
end );

##
InstallMethod( TargetPart,
               "for entries with lists of sources",
               [ IsToDoListEntryWithListOfSourcesRep ],
               
  function( entry )
    
    return RecoverWholeList( entry!.targetlist );
    
end );

##
InstallMethod( SetTargetValueObject,
               "for los entries",
               [ IsToDoListEntryWithListOfSourcesRep, IsObject ],
               
  function( entry, value )
    
    entry!.targetlist[ 3 ] := value;
    
end );

##
InstallMethod( SetTargetObject,
               "for los entries",
               [ IsToDoListEntryWithListOfSourcesRep, IsObject ],
               
  function( entry, value )
    
    entry!.targetlist[ 1 ] := value;
    
end );

##
InstallMethod( ProcessAToDoListEntry,
               [ IsToDoListEntryWithDefinedTargetRep ],
               
  function( entry )
    local source_list, source, pull_attr, target, push_attr, tester_var, target_value, target_obj,
          return_function, source_status;
    
    source_list := SourcePart( entry );
    
    if source_list = fail then
        
        return fail;
        
    fi;
    
    target := TargetPart( entry );
    
    if target = fail then
    
        return fail;
    
    fi;
    
    tester_var := true;
    
    for source in [ 1 .. Length( source_list ) ] do
        
        if entry!.source_tester_list[ source ] = true then
            
            continue;
            
        fi;
        
        source_status := ToolsForHomalg_CheckASourcePart( source_list[ source ] );
        
        if source_status = fail then
            
            SetFilterObj( entry, PreconditionsDefinitelyNotFulfilled );
            
            return false;
            
        elif not source_status then
            
            return false;
            
        else
            
            entry!.source_tester_list[ source ] := true;
            
        fi;
        
    od;
    
    if not tester_var then
        return false;
    fi;
        
    ## Sanitize the source.
    
    for source in source_list do
        
        if Length( source ) = 2 and IsString( source[ 2 ] ) then
            
            Add( source, ValueGlobal( source[ 2 ] )( source[ 1 ] ) );
            
        elif Length( source ) = 4 and IsString( source[ 2 ] ) then
            
            source[ 3 ] := ValueGlobal( source[ 2 ] )( source[ 1 ] );
            
            Remove( source, 4 );
            
        fi;
        
    od;
    
    return_function := function()
        local push_attr, target_obj, target_value, str, out;
        
        push_attr := ValueGlobal( target[ 2 ] );
        
        target_obj := ToDoLists_Process_Entry_Part( target[ 1 ] );
        
        target_value := ToDoLists_Process_Entry_Part( target[ 3 ] );
        
        SetTargetObject( entry, target_obj );
        
        SetTargetValueObject( entry, target_value );
        
        if not Tester( push_attr )( target_obj ) then
            
            SetFilterObj( entry, HasSetAttributeOfObject );
            
            if TODO_LISTS.where_infos then
                
                str := "";
                
                out := OutputTextString( str, false );
                
                PrintTo1( out, function()
                                   Where( 100 );
                               end );
                
                CloseStream( out );
                
                entry!.where_infos := str;
                
            fi;
            
        fi;
        
        Setter( push_attr )( target_obj, target_value );
        
        Add( ToDoList( target_obj )!.from_others, entry );
        
    end;
    
    ToolsForHomalg_ProcessToDoListEquivalencesAndContrapositions( entry );
    
    SetFilterObj( entry, IsProcessedEntry );
    
    return return_function;
    
end );

##########################################
##
## Entry with contraposition
##
##########################################

##
InstallMethod( ToDoListEntryWithContraposition,
               "constructor",
               [ IsObject, IsString, IsBool, IsObject, IsString, IsBool ],
               
  function( source, sprop, sval, target, tprop, tval )
    local entry;
    
    entry := rec( );
    
    ObjectifyWithAttributes( entry, TheTypeToDoListEntryWithContraposition );
    
    entry!.input := ToDoListWeakPointer( [ source, sprop, sval, target, tprop, tval ] );
    
    return entry;
    
end );

##
InstallMethod( AddToToDoList,
               "for ToDoListEntriesWithContraposition",
               [ IsToDoListEntryWithContrapositionRep ],
               
  function( entry )
    local input, entry1, entry_contra, description, description_list_entry;
    
    input := RecoverWholeList( entry!.input );
    
    if input = fail then
        
        return;
        
    fi;
    
    entry1 := ToDoListEntry ( [ input{[ 1 .. 3 ]} ], input[ 4 ], input[ 5 ], input[ 6 ] );
    
    entry_contra := ToDoListEntry( [ [ input[ 4 ], input[ 5 ], not input[ 6 ] ] ], input[ 1 ], input[ 2 ], not input[ 3 ] );
    
    entry1!.contrapositions := [ entry_contra ];
    
    entry_contra!.contrapositions := [ entry1 ];
#     
#     AddToToDoList( ToDoListEntry( [ [ entry, "DescriptionOfImplication" ] ], entry1, "DescriptionOfImplication", [ DescriptionOfImplication, entry ] ) );
#     
#     AddToToDoList( ToDoListEntry( [ [ entry, "DescriptionOfImplication" ] ], entry_contra, "DescriptionOfImplication", [ DescriptionOfImplication, entry ] ) );
#     
    AddToToDoList( entry1 );
    
    AddToToDoList( entry_contra );
    
end );

##
InstallMethod( ToDoList_Is_Sane_Entry,
               "for entry with contraposition",
               [ IsToDoListEntryWithContrapositionRep ],
               
  function( entry )
    
    return IsCompleteWeakPointerList( entry!.input );
    
end );

##########################################
##
## Equal
##
##########################################

##
InstallMethod( ToDoListEntryForEqualAttributes,
               "todo-list-entry-for-equivalent-properties",
               [ IsObject, IsString, IsObject, IsString ],
               
  function( obj1, prop1, obj2, prop2 )
    local entry;
    
    entry := rec( input := ToDoListWeakPointer( [ obj1, prop1, obj2, prop2 ] ) );
    
    ObjectifyWithAttributes( entry, TheTypeToDoListEntryForEqualProperties );
    
    SetDescriptionOfImplication( entry, Concatenation( "propagate equal attributes ", prop1, " and ", prop2 ) );
    
    return entry;
    
end );

##
InstallMethod( ToDoList_Is_Sane_Entry,
               "for entry with equal",
               [ IsToDoListEntryForEqualPropertiesRep ],
               
  function( entry )
    
    return IsCompleteWeakPointerList( entry!.input );
    
end );

##
InstallMethod( AddToToDoList,
               "for entries for equivalent properties",
               [ IsToDoListEntryForEqualPropertiesRep ],
               
  function( entry )
    local input, entry_forward, entry_backwards;
    
    input := RecoverWholeList( entry!.input );
    
    if input = fail then
        
        return;
        
    fi;
    
    entry_forward := ToDoListEntry( [ [ input[ 1 ], input[ 2 ] ] ], input[ 3 ], input[ 4 ], [ ValueGlobal( input[ 2 ] ), input[ 1 ] ] );
    
    entry_backwards := ToDoListEntry( [ [ input[ 3 ], input[ 4 ] ] ], input[ 1 ], input[ 2 ], [ ValueGlobal( input[ 4 ] ), input[ 3 ] ] );
    
    entry_forward!.equivalences := [ entry_backwards ];
    
    entry_backwards!.equivalences := [ entry_forward ];
#     
#     AddToToDoList( ToDoListEntry( [ [ entry, "DescriptionOfImplication" ] ], entry_forward, "DescriptionOfImplication", [ DescriptionOfImplication, entry ] ) );
#     
#     AddToToDoList( ToDoListEntry( [ [ entry, "DescriptionOfImplication" ] ], entry_backwards, "DescriptionOfImplication", [ DescriptionOfImplication, entry ] ) );
    
    AddToToDoList( entry_forward );
    
    AddToToDoList( entry_backwards );
    
end );

##########################################
##
## Equal
##
##########################################

##
InstallMethod( ToDoListEntryForEquivalentAttributes,
               "todo-list-entry-for-equivalent-properties",
               [ IsObject, IsString, IsObject, IsObject, IsString, IsObject ],
               
  function( obj1, prop1, val1, obj2, prop2, val2 )
    local entry;
    
    entry := rec( input := ToDoListWeakPointer( [ obj1, prop1, val1, obj2, prop2, val2 ] ) );
    
    ObjectifyWithAttributes( entry, TheTypeToDoListEntryForEquivalentProperties );
    
    return entry;
    
end );

##
InstallMethod( ToDoList_Is_Sane_Entry,
               "for entry with equal",
               [ IsToDoListEntryForEquivalentPropertiesRep ],
               
  function( entry )
    
    return IsCompleteWeakPointerList( entry!.input );
    
end );

##
InstallMethod( AddToToDoList,
               "for entries for equivalent properties",
               [ IsToDoListEntryForEquivalentPropertiesRep ],
               
  function( entry )
    local input, entry_forward, entry_backwards;
    
    input := RecoverWholeList( entry!.input );
    
    if input = fail then
        
        return;
        
    fi;
    
    entry_forward := ToDoListEntry( [ [ input[ 1 ], input[ 2 ], input[ 3 ] ] ], input[ 4 ], input[ 5 ], input[ 6 ] );
    
    entry_backwards := ToDoListEntry( [ [ input[ 4 ], input[ 5 ], input[ 6 ] ] ], input[ 1 ], input[ 2 ], input[ 3 ] );
    
    entry_forward!.equivalences := [ entry_backwards ];
    
    entry_backwards!.equivalences := [ entry_forward ];
#     
#     AddToToDoList( ToDoListEntry( [ [ entry, "DescriptionOfImplication" ] ], entry_forward, "DescriptionOfImplication", [ DescriptionOfImplication, entry ] ) );
#     
#     AddToToDoList( ToDoListEntry( [ [ entry, "DescriptionOfImplication" ] ], entry_backwards, "DescriptionOfImplication", [ DescriptionOfImplication, entry ] ) );
    
    AddToToDoList( entry_forward );
    
    AddToToDoList( entry_backwards );
    
end );

############################################
##
## Display & View
##
############################################

##
##
InstallMethod( ViewObj,
               "for todo-list entry",
               [ IsToDoListEntry ],
               
  function( entry )
    
    Print( "<A ToDo-list entry" );
    
    if HasDescriptionOfImplication( entry ) then
        
        Print( Concatenation( " with description: ", DescriptionOfImplication( entry ) ) );
        
    fi;
    
    Print( ">" );
    
end );

##
InstallMethod( Display,
               "for todo-list entry",
               [ IsToDoListEntry ],
               
  function( entry )
    
    Print( "A ToDo-list entry" );
    
    if HasDescriptionOfImplication( entry ) then
        
        Print( Concatenation( " with description: ", DescriptionOfImplication( entry ) ) );
        
    fi;
    
    Print( ".\n" );
    
end );
