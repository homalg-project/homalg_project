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
    
    for source in source_list do
        
        if IsBound( source[ 3 ] ) then
            
            source[ 3 ] := ToDoLists_Process_Entry_Part( source[ 3 ] );
            
        fi;
        
    od;
    
    target := TargetPart( entry );
    
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
InstallGlobalFunction( ToolsForHomalg_ProcessToDoListEquivalenciesAndContrapositions,
                       
  function( entry )
    local i;
    
    if IsBound( entry!.contrapositions ) then
        
        for i in entry!.contrapositions do
            
            SetFilterObj( i, PreconditionsDefinitelyNotFulfilled );
            
        od;
        
    fi;
    
    if IsBound( entry!.equivalencies ) then
        
        for i in entry!.equivalencies do
            
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
    
    source_list := SourcePart( entry );
    
    if source_list = fail then
        
        return;
        
    fi;
    
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
    
    for source in source_object_list do
        
        todo_list := ToDoList( source );
        
        if IsFunction( result ) then
            
            Add( todo_list!.already_done, entry );
            
        elif result = false and not PreconditionsDefinitelyNotFulfilled( entry ) and CanHaveAToDoList( source ) then
            
            Add( todo_list!.todos, entry );
            
            SetFilterObj( source, HasSomethingToDo );
            
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
    
    return entry!.source_list;
    
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
    
    entry := rec( source_list := source_list, func := func );
    
    ObjectifyWithAttributes( entry, TheTypeToDoListWhichLaunchesAFunction );
    
    return entry;
    
end );

##
InstallMethod( ProcessAToDoListEntry,
               [ IsToDoListEntryWhichLaunchesAFunctionRep ],
               
  function( entry )
    local source_list, source, pull_attr, target, push_attr, tester_var;
    
    source_list := SourcePart( entry );
    
    if source_list = fail then
        
        return fail;
        
    fi;
    
    target := TargetPart( entry );
    
    if target = fail then
    
        return fail;
    
    fi;
    
    tester_var := true;
    
    for source in source_list do
          
        pull_attr := ValueGlobal( source[ 2 ] );
        
        if not Tester( pull_attr )( source[ 1 ] ) then
            
            tester_var := false;
            
            break;
            
        elif Length( source ) = 3 then
            
            if IsList( source[ 3 ] ) then
                
                source[ 3 ] := ToDoLists_Process_Entry_Part( source[ 3 ] );
                
            fi;
            
            if not pull_attr( source[ 1 ] ) = source[ 3 ] then
                
                SetFilterObj( entry, PreconditionsDefinitelyNotFulfilled );
                
                return false;
                
            fi;
            
        fi;
        
    od;
    
    if tester_var then
        
        SetFilterObj( entry, IsProcessedEntry );
        
        return target;
        
    fi;
    
    return false;
    
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
    local entry;
    
    if not ForAll( source_list, i -> IsList( i[ 2 ] ) and ( Length( i ) = 3 or Length( i ) = 2 or Length( i ) = 4 ) ) then
        
        Error( "wrong input format" );
        
    fi;
    
    entry := rec( source_list := source_list, targetlist := [ obj_to_push, attr_to_push, val_to_push ] );
    
    ObjectifyWithAttributes( entry, TheTypeToDoListEntryWithListOfSources );
    
    return entry;
    
end );

##
InstallMethod( SourcePart,
               "for entries with lists of sources",
               [ IsToDoListEntryWithListOfSourcesRep ],
               
  function( entry )
    
    return entry!.source_list;
    
end );

##
InstallMethod( TargetPart,
               "for entries with lists of sources",
               [ IsToDoListEntryWithListOfSourcesRep ],
               
  function( entry )
    
    return entry!.targetlist;
    
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
    
    for source in source_list do
        
        source_status := ToolsForHomalg_CheckASourcePart( source );
        
        if source_status = fail then
            
            SetFilterObj( entry, PreconditionsDefinitelyNotFulfilled );
            
            return false;
            
        elif not source_status then
            
            return false;
            
        fi;
        
    od;
    
    if tester_var then
        
        return_function := function()
            local push_attr, target_obj, target_value;
            
            push_attr := ValueGlobal( target[ 2 ] );
            
            target_obj := ToDoLists_Process_Entry_Part( target[ 1 ] );
            
            target_value := ToDoLists_Process_Entry_Part( target[ 3 ] );
            
            SetTargetObject( entry, target_obj );
            
            SetTargetValueObject( entry, target_value );
            
            Setter( push_attr )( target_obj, target_value );
            
            Add( ToDoList( target_obj )!.from_others, entry );
            
        end;
        
        ToolsForHomalg_ProcessToDoListEquivalenciesAndContrapositions( entry );
        
        SetFilterObj( entry, IsProcessedEntry );
        
        return return_function;
        
    fi;
    
    return false;
    
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
    
    entry!.input := [ source, sprop, sval, target, tprop, tval ];
    
    return entry;
    
end );

##
InstallMethod( AddToToDoList,
               "for ToDoListEntriesWithContraposition",
               [ IsToDoListEntryWithContrapositionRep ],
               
  function( entry )
    local input, entry1, entry_contra, description, description_list_entry;
    
    input := entry!.input;
    
    entry1 := ToDoListEntry ( [ input{[ 1 .. 3 ]} ], input[ 4 ], input[ 5 ], input[ 6 ] );
    
    entry_contra := ToDoListEntry( [ [ input[ 4 ], input[ 5 ], not input[ 6 ] ] ], input[ 1 ], input[ 2 ], not input[ 3 ] );
    
    entry1!.contrapositions := [ entry_contra ];
    
    entry_contra!.contrapositions := [ entry1 ];
    
    AddToToDoList( ToDoListEntry( [ [ entry, "DescriptionOfImplication" ] ], entry1, "DescriptionOfImplication", [ DescriptionOfImplication, entry ] ) );
    
    AddToToDoList( ToDoListEntry( [ [ entry, "DescriptionOfImplication" ] ], entry_contra, "DescriptionOfImplication", [ DescriptionOfImplication, entry ] ) );
    
    AddToToDoList( entry1 );
    
    AddToToDoList( entry_contra );
    
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
    
    entry := rec( input := [ obj1, prop1, obj2, prop2 ] );
    
    ObjectifyWithAttributes( entry, TheTypeToDoListEntryForEqualProperties );
    
    return entry;
    
end );

##
InstallMethod( AddToToDoList,
               "for entries for equivalent properties",
               [ IsToDoListEntryForEqualPropertiesRep ],
               
  function( entry )
    local input, entry_forward, entry_backwards;
    
    input := entry!.input;
    
    entry_forward := ToDoListEntry( [ [ input[ 1 ], input[ 2 ] ] ], input[ 3 ], input[ 4 ], [ ValueGlobal( input[ 2 ] ), input[ 1 ] ] );
    
    entry_backwards := ToDoListEntry( [ [ input[ 3 ], input[ 4 ] ] ], input[ 1 ], input[ 2 ], [ ValueGlobal( input[ 4 ] ), input[ 3 ] ] );
    
    entry_forward!.equivalencies := [ entry_backwards ];
    
    entry_backwards!.equivalencies := [ entry_forward ];
    
    AddToToDoList( ToDoListEntry( [ [ entry, "DescriptionOfImplication" ] ], entry_forward, "DescriptionOfImplication", [ DescriptionOfImplication, entry ] ) );
    
    AddToToDoList( ToDoListEntry( [ [ entry, "DescriptionOfImplication" ] ], entry_backwards, "DescriptionOfImplication", [ DescriptionOfImplication, entry ] ) );
    
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
    
    entry := rec( input := [ obj1, prop1, val1, obj2, prop2, val2 ] );
    
    ObjectifyWithAttributes( entry, TheTypeToDoListEntryForEquivalentProperties );
    
    return entry;
    
end );

##
InstallMethod( AddToToDoList,
               "for entries for equivalent properties",
               [ IsToDoListEntryForEquivalentPropertiesRep ],
               
  function( entry )
    local input, entry_forward, entry_backwards;
    
    entry_forward := ToDoListEntry( [ [ input[ 1 ], input[ 2 ], input[ 3 ] ] ], input[ 4 ], input[ 5 ], input[ 6 ] );
    
    entry_backwards := ToDoListEntry( [ [ input[ 4 ], input[ 5 ], input[ 6 ] ] ], input[ 1 ], input[ 2 ], input[ 3 ] );
    
    entry_forward!.equivalencies := [ entry_backwards ];
    
    entry_backwards!.equivalencies := [ entry_forward ];
    
    AddToToDoList( ToDoListEntry( [ [ entry, "DescriptionOfImplication" ] ], entry_forward, "DescriptionOfImplication", [ DescriptionOfImplication, entry ] ) );
    
    AddToToDoList( ToDoListEntry( [ [ entry, "DescriptionOfImplication" ] ], entry_backwards, "DescriptionOfImplication", [ DescriptionOfImplication, entry ] ) );
    
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
