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
                   already_installed_immediate_methods := [ ]
                   
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
InstallGlobalFunction( ToolsForHomalg_MoveAToDoListEntry,
                       
  function( entry, done_value )
    local source_list, i, pos, target;
    
    if not IsToDoListEntry( entry ) or not IsBool( done_value ) then
        
        Error( "somewhere something went terribly wrong" );
        
    fi;
    
    source_list := SourcePart( entry );
    
    if done_value = true then
        
        for i in source_list do
            
            Add( ToDoList( i[ 1 ] )!.already_done, entry );
            
            pos := Position( ToDoList( i[ 1 ] )!.todo, entry );
            
            if pos <> fail then
                
                Remove( ToDoList( i[ 1 ] )!.todo, i );
                
            fi;
            
        od;
        
        target := TargetPart( i )[ 1 ];
        
        Add( ToDoList( target )!.from_others, entry );
        
    elif done_value = false then
        
        for i in source_list do
            
            Add( ToDoList( i[ 1 ] )!.precondition_not_fulfilled, entry );
            
        od;
        
    fi;
    
end );

##
InstallGlobalFunction( ToolsForHomalg_ProcessToDoListEquivalenciesAndContrapositions,
                       
  function( entry )
    local i;
    
    if IsBound( entry!.contrapositions ) then
        
        for i in entry!.contrapositions do
            
            ToolsForHomalg_MoveAToDoListEntry( i, false );
            
        od;
        
    fi;
    
end );

##########################################
##
## General methods
##
##########################################

##
InstallMethod( AddToToDoList,
               "for a todo list entry",
               [ IsToDoListEntryWithListOfSourcesRep ],
               
  function( entry )
    local result, source, source_list, source_object_list, todo_list, target;
    
    result := ProcessAToDoListEntry( entry );
    
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
    
    for source in source_object_list do
        
        todo_list := ToDoList( source );
        
        if result = true then
        
            Add( todo_list!.already_done, entry );
            
        elif result = false and not PreconditionsDefinitelyNotFulfilled( entry ) then
            
            Add( todo_list!.todos, entry );
            
            SetFilterObj( source, HasSomethingToDo );
#             
#             CreateImmediateMethodForToDoListEntry( entry );
            
        elif result = false and PreconditionsDefinitelyNotFulfilled( entry ) then
            
            Add( todo_list!.precondition_not_fulfilled, entry );
            
        elif result = fail then
            
            Add( todo_list!.garbage, entry );
            
        fi;
        
    od;
    
end );

##
InstallMethod( AreCompatible,
               "for todo-list entries",
               [ IsToDoListEntryWithDefinedTargetRep, IsToDoListEntry ],
               
  function( entry1, entry2 )
    
    return  Position( SourcePart( entry2 ), TargetPart( entry1 ) ) <> fail;
    
end );

##
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
    
    if list = [ ] then
        
        return [ ];
        
    fi;
    
    if not ForAll( list, IsToDoListEntry ) then
        
        Error( "must be a list of ToDo-list entries\n" );
        
    fi;
    
    if not ForAll( [ 1 .. Length( list ) - 1 ], i -> AreCompatible( list[ i ], list[ i + 1 ] ) ) then
        
        Error( "entries are not compatible\n" );
        
    fi;
    
    if not ForAll( [ 1 .. Length( list ) - 1 ], i -> IsToDoListEntryWithDefinedTargetRep( list[ i ] ) ) then
        
        Error( "entries without targets cannot be composed\n" );
        
    fi;
    
    new_entry := rec ( );
    
    ObjectifyWithAttributes( new_entry, TheTypeToDoListEntryMadeFromOtherToDoListEntries );
    
    SetGenesisOfToDoListEntry( new_entry, Concatenation( List( list, GenesisOfToDoListEntry ) ) );
    
    return new_entry;
    
end );

##
InstallMethod( CreateImmediateMethodForToDoListEntry,
               "for a ToDo-list entry",
               [ IsToDoListEntry ],
               
  function( entry )
    local source_list, source, cat_list, cat, tester, i;
    
    source_list := SourcePart( entry );
    
    if source_list = fail then
        
        return;
        
    fi;
    
    for source in source_list do
        
        cat_list := CategoriesOfObject( source[ 1 ] );
        
        cat := IsObject;
        
        for i in cat_list do
            
            if ReplacedString( i, ")", " " ) = i then
                
                cat := cat and ValueGlobal( i );
                
            fi;
            
        od;
        
        tester := Tester( ValueGlobal( source[ 2 ] ) );
        
        tester := cat and tester;
        
        if Position( TODO_LIST_ENTRIES.already_installed_immediate_methods, tester ) <> fail then
            
            return;
            
        else
            
            Add( TODO_LIST_ENTRIES.already_installed_immediate_methods, tester );
            
        fi;
        
        InstallImmediateMethod( ProcessToDoList,
                                HasSomethingToDo and tester,
                                0,
                                
          function( object )
              
              if not HasSomethingToDo( object ) then
                  
                  TryNextMethod();
                  
              fi;
              
              ProcessToDoList_Real( object );
              
              TryNextMethod();
              
        end );
        
    od;
    
end );

##########################################
##
## ProcessAToDoListEntry for ToDoListEntriesWithDefinedTargetRep
##
##########################################

##
InstallMethod( ProcessAToDoListEntry,
               [ IsToDoListEntryWithDefinedTargetRep ],
               
  function( entry )
    local source_list, source, pull_attr, target, push_attr, tester_var, target_value, target_obj,
          return_function;
    
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
            
        elif Length( source ) = 3 and not pull_attr( source[ 1 ] ) = source[ 3 ] then
            
            SetFilterObj( entry, PreconditionsDefinitelyNotFulfilled );
            
            return true;
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
            
            ToolsForHomalg_ProcessToDoListEquivalenciesAndContrapositions( entry );
            
            Setter( push_attr )( target_obj, target_value );
            
            Add( ToDoList( target_obj )!.from_others, entry );
            
        end; 
        
        return return_function;
        
    fi;
    
    return false;
    
end );

##########################################
##
## ToDo-list entry with weak pointers
##
##########################################

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
    
    return [ [ ElmWPObj( entry!.value_list, 1 ), entry!.string_list[ 1 ], ElmWPObj( entry!.value_list, 2 ) ] ];
    
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
InstallMethod( SetTargetValueObject,
               "for weak pointer entries",
               [ IsToDoListEntryWithWeakPointersRep, IsObject ],
               
  function( entry, value )
    
    SetElmWPObj( entry!.value_list, 4, value );
    
end );

##
InstallMethod( SetTargetObject,
               "for weak pointer entries",
               [ IsToDoListEntryWithWeakPointersRep, IsObject ],
               
  function( entry, value )
    
    SetElmWPObj( entry!.value_list, 3, value );
    
end );

##
InstallMethod( \<,
               "for weak pointer entries",
               [ IsToDoListEntryWithDefinedTargetRep, IsToDoListEntryWithListOfSourcesRep ],
               
  function( target_entry, source_entry )
    
    return Position( SourcePart( source_entry ), TargetPart( target_entry ) ) <> fail;
    
end );



##########################################
##
## ToDo-list entry with pointers
##
##########################################

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
    
    return [ entry!.list{ [ 1, 2, 3 ] } ];
    
end );

##
InstallMethod( TargetPart,
               "for entries with pointers",
               [ IsToDoListEntryWithPointersRep ],
               
  function( entry )
    
    return entry!.list{ [ 4, 5, 6 ] };
    
end );

##
InstallMethod( SetTargetValueObject,
               "for pointer entries",
               [ IsToDoListEntryWithPointersRep, IsObject ],
               
  function( entry, value )
    
    entry!.list[ 6 ] := value;
    
end );

##
InstallMethod( SetTargetObject,
               "for pointer entries",
               [ IsToDoListEntryWithPointersRep, IsObject ],
               
  function( entry, value )
    
    entry!.list[ 4 ] := value;
    
end );

##########################################
##
## Concatenated ToDo-list entry
##
##########################################

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

######################
##
## ToDoListEntryWithListOfSources
##
######################

##
InstallMethod( ToDoListEntryWithListOfSources,
               "todo list entry with list of sources",
               [ IsList, IsObject, IsString, IsObject ],
               
  function( source_list, obj_to_push, attr_to_push, val_to_push )
    local entry;
    
    if not ForAll( source_list, i -> IsString( i[ 2 ] ) and ( Length( i ) = 3 or Length( i ) = 2 ) ) then
        
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
               "for weak pointer entries",
               [ IsToDoListEntryWithListOfSourcesRep, IsObject ],
               
  function( entry, value )
    
    entry!.targetlist[ 3 ] := value;
    
end );

##
InstallMethod( SetTargetObject,
               "for weak pointer entries",
               [ IsToDoListEntryWithListOfSourcesRep, IsObject ],
               
  function( entry, value )
    
    entry!.targetlist[ 1 ] := value;
    
end );

##
InstallMethod( \<,
               "for list of sources",
               [ IsToDoListEntryWithListOfSourcesRep, IsToDoListEntryWithListOfSourcesRep ],
               
  function( entry1, entry2 )
    
    return Position( SourcePart( entry2 ), TargetPart( entry1 ) ) <> fail;
    
end );

######################
##
## ToDoListEntryWhichLaunchesAFunction
##
######################

##
InstallMethod( ToDoListEntryWhichLaunchesAFunction,
               "constructor",
               [ IsList, IsFunction ],
               
  function( source_list, func )
    local entry;
    
    if not ForAll( source_list, i -> IsString( i[ 2 ] ) and ( Length( i ) = 3 or Length( i ) = 2 ) ) then
        
        Error( "wrong input format" );
        
    fi;
    
    entry := rec( source_list := source_list, func := func );
    
    ObjectifyWithAttributes( entry, TheTypeToDoListWhichLaunchesAFunction );
    
    return entry;
    
end );

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
            
        elif Length( source ) = 3 and not pull_attr( source[ 1 ] ) = source[ 3 ] then
            
            SetFilterObj( entry, PreconditionsDefinitelyNotFulfilled );
            
            return false;
        fi;
        
    od;
    
    ToolsForHomalg_ProcessToDoListEquivalenciesAndContrapositions( entry );
    
    if tester_var then
        
        return target;
        
    fi;
    
    return false;
    
end );

InstallMethod( \<,
               "ToDoListEntryWhichLaunchesAFunction",
               [ IsToDoListEntryWhichLaunchesAFunctionRep, IsToDoListEntry ],
               
  function( entry1, entry2 )
    
    return false;
    
end );

######################
##
## ToDoListEntry for equivalent properties
## This one needs different handling
##
######################

##
InstallMethod( ToDoListEntryForEquivalentProperties,
               "todo-list-entry-for-equivalent-properties",
               [ IsObject, IsString, IsObject, IsString ],
               
  function( obj1, prop1, obj2, prop2 )
    local entry;
    
    entry := rec( input := [ obj1, prop1, obj2, prop2 ] );
    
    ObjectifyWithAttributes( entry, TheTypeToDoListEntryForEquivalentProperties );
    
    return entry;
    
end );

##
InstallMethod( AddToToDoList,
               "for entries for equivalent properties",
               [ IsToDoListEntryForEquivalentPropertiesRep ],
               
  function( entry )
    local var, input;
    
    var := ProcessAToDoListEntry( entry );
    
    if IsFunction( var ) then
        
        var();
        
        return;
        
    fi;
    
    if not var then
        
        input := entry!.input;
        
        Add( ToDoList( input[ 1 ] )!.todos, entry );
        
        Add( ToDoList( input[ 3 ] )!.todos, entry );
        
        SetFilterObj( input[ 1 ], HasSomethingToDo );
        
        SetFilterObj( input[ 3 ], HasSomethingToDo );
        
    fi;
    
end );

##
InstallMethod( ProcessAToDoListEntry,
               "for equivalent properties",
               [ IsToDoListEntryForEquivalentPropertiesRep ],
               
  function( entry )
    local input, prop1, prop2, tester_var, ret_func;
    
    input := entry!.input;
    
    prop1 := ValueGlobal( input[ 2 ] );
    
    prop2 := ValueGlobal( input[ 4 ] );
    
    tester_var := false;
    
    if Tester( prop1 )( input[ 1 ] ) then
        
        tester_var := 1;
        
    elif Tester( prop2 )( input[ 3 ] ) then
        
        tester_var := 2;
        
    fi;
    
    if tester_var = 1 then
        
        ret_func := function()
            
            Setter( prop2 )( input[ 3 ], prop1( input[ 1 ] ) );
            
            entry!.value_which_was_given := prop1( input[ 1 ] );
            
            Add( ToDoList( input[ 1 ] )!.from_others, entry );
            
            Add( ToDoList( input[ 3 ] )!.from_others, entry );
            
        end;
        
        return ret_func;
        
    elif tester_var = 2 then
        
        ret_func := function()
            
            Setter( prop1 )( input[ 1 ], prop2( input[ 3 ] ) );
            
            entry!.value_which_was_given := prop2( input[ 3 ] );
        
            Add( ToDoList( input[ 1 ] )!.from_others, entry );
            
            Add( ToDoList( input[ 3 ] )!.from_others, entry );
            
        end;
        
        return ret_func;
        
    fi;
    
    return false;
    
end );

##
InstallMethod( \<,
               "equiv and list of src",
               [ IsToDoListEntryWithDefinedTargetRep, IsToDoListEntryForEquivalentPropertiesRep ],
               
  function( target_entry, source_entry )
    local part, input, value;
    
    if not IsBound( source_entry!.value_which_was_given ) then
        
        return false;
        
    fi;
    
    input := source_entry!.input;
    
    value := source_entry!.value_which_was_given;
    
    part := [ [ input[ 1 ], input[ 2 ], value ], [ input[ 3 ], input[ 4 ], value ] ];
    
    return Position( part, TargetPart( target_entry ) ) <> fail;
    
end );

##
InstallMethod( \<,
               "equiv and list of src",
               [ IsToDoListEntryForEquivalentPropertiesRep, IsToDoListEntryWithDefinedTargetRep ],
               
  function( target_entry, source_entry )
    local part1, part2, input, value, source;
    
    if not IsBound( target_entry!.value_which_was_given ) then
        
        return false;
        
    fi;
    
    input := target_entry!.input;
    
    value := target_entry!.value_which_was_given;
    
    part1 := [ input[ 1 ], input[ 2 ], value ];
    
    part2 := [ input[ 3 ], input[ 4 ], value ];
    
    source := SourcePart( source_entry );
    
    return Position( source, part1 ) <> fail or Position( source, part2 ) <> fail;
    
end );

######################
##
## ToDoListEntryWithContraposition
##
######################

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
    local process, input, source1, source2;
    
    process := ProcessAToDoListEntry( entry );
    
    if IsFunction( process ) then
        
        process();
        
        return;
        
    fi;
    
    input := entry!.input;
    
    source1 := input[ 1 ];
    
    source2 := input[ 4 ];
    
    Add( ToDoList( source1 )!.todos, entry );
    
    SetFilterObj( source1, HasSomethingToDo );
    
    Add( ToDoList( source2 )!.todos, entry );
    
    SetFilterObj( source2, HasSomethingToDo );
    
end );

##
InstallMethod( ProcessAToDoListEntry,
               "contrapositions",
               [ IsToDoListEntryWithContrapositionRep ],
               
  function( entry )
    local input, source1, source2, prop1, prop2, pos, ret_func;
    
    input := entry!.input;
    
    prop1 := ValueGlobal( input[ 2 ] );
    
    if Tester( prop1 )( input[ 1 ] ) and prop1( input[ 1 ] ) = input[ 3 ] then
        
        ret_func := function()
            
            prop2 := ValueGlobal( input[ 5 ] );
            
            ToolsForHomalg_RemoveContrapositionFromBothToDoLists( entry );
            
            Setter( prop2 )( input[ 4 ], input[ 6 ] );
            
            Add( ToDoList( input[ 4 ] )!.from_others, entry );
            
            SetIsProcededEntry( entry, true );
            
        end;
        
        return ret_func;
        
    fi;
    
    prop2 := ValueGlobal( input[ 5 ] );
    
    if Tester( prop2 )( input[ 4 ] ) and prop2( input[ 4 ] ) <> input[ 6 ] then
        
        ret_func := function()
            
            ToolsForHomalg_RemoveContrapositionFromBothToDoLists( entry );
            
            Setter( prop1 )( input[ 1 ], not input[ 3 ] );
            
            Add( ToDoList( input[ 4 ] )!.from_others, entry );
            
            SetIsProcededEntry( entry, true );
            
        end;
        
        return ret_func;
        
    fi;
    
    if ( Tester( prop1 )( input[ 1 ] ) and prop1( input[ 1 ] ) <> input[ 3 ] ) or ( Tester( prop2 )( input[ 4 ] ) and prop2( input[ 4 ] ) = input[ 6 ] ) then
        
        SetFilterObj( entry, PreconditionsDefinitelyNotFulfilled );
        
        return false;
        
    fi;
    
    return false;
    
end );

InstallGlobalFunction( ToolsForHomalg_RemoveContrapositionFromBothToDoLists,
  
  function( entry )
    local input, todo_list1, todo_list2, pos;
    
    input := entry!.input;
    
    todo_list1 := ToDoList( input[ 1 ] )!.todos;
    
    pos := Position( todo_list1, entry );
    
    if pos <> fail then
        
        Remove( todo_list1, pos );
        
    fi;
    
    todo_list2 := ToDoList( input[ 4 ] )!.todos;
    
    pos := Position( todo_list2, entry );
    
    if pos <> fail then
        
        Remove( todo_list2, pos );
        
    fi;
    
end );

## FIXME
InstallMethod( SourcePart,
               "for entries with contrapositions",
               [ IsToDoListEntryWithContrapositionRep ],
               
  function( entry )
    
    return [ entry!.input{[ 1 .. 3 ]} ];
    
end );

## FIXME
InstallMethod( TargetPart,
               "for entries with contrapositions",
               [ IsToDoListEntryWithContrapositionRep ],
               
  function( entry )
    
    return [ entry!.input{[ 4 .. 6 ]} ];
    
end );

##
InstallMethod( \<,
               "contraposition to contraposition",
               [ IsToDoListEntryWithContrapositionRep, IsToDoListEntryWithContrapositionRep ],
               
  function( target_entry, source_entry )
    local source, target;
    
    source := source_entry!.input{[ 1 .. 3 ]};
    
    target := target_entry!.input{[ 4 .. 6 ]};
    
    if source = target then
        
        return true;
        
    fi;
    
    return false;
    
end );

##
InstallMethod( \<,
               "contrapos to equiv",
               [ IsToDoListEntryWithContrapositionRep, IsToDoListEntryForEquivalentPropertiesRep ],
               
  function( target_entry, source_entry )
    local source, target;
    
    if not IsBound( source_entry!.value_which_was_given ) then
        
        return false;
        
    fi;
    
    source := [ 1, 2 ];
    
    source[ 1 ] := Concatenation( source_entry!.input{[ 1 .. 2 ]}, [ source_entry!.value_which_was_given ] );
    
    source[ 2 ] := Concatenation( source_entry!.input{[ 3 .. 4 ]}, [ source_entry!.value_which_was_given ] );
    
    target := target_entry!.input{[ 4 .. 6 ]};
    
    if Position( source, target ) <> fail then
        
        return true;
        
    fi;
    
    return false;
    
end );

##
InstallMethod( \<,
               "equiv to contrapos",
               [ IsToDoListEntryForEquivalentPropertiesRep, IsToDoListEntryWithContrapositionRep ],
               
    function( source_entry, target_entry )
    local source, target;
    
    if not IsBound( source_entry!.value_which_was_given ) then
        
        return false;
        
    fi;
    
    source := [ 1, 2 ];
    
    source[ 1 ] := Concatenation( source_entry!.input{[ 1 .. 2 ]}, [ source_entry!.value_which_was_given ] );
    
    source[ 2 ] := Concatenation( source_entry!.input{[ 3 .. 4 ]}, [ source_entry!.value_which_was_given ] );
    
    target := target_entry!.input{[ 1 .. 3 ]};
    
    if Position( source, target ) <> fail then
        
        return true;
        
    fi;
    
    return false;
    
end );

##
InstallMethod( \<,
               "contra to listofsources",
               [ IsToDoListEntryWithContrapositionRep, IsToDoListEntryWithListOfSourcesRep ],
               
  function( target_entry, source_entry )
    local source, target;
    
    target := target_entry!.input{[ 4 .. 6]};
    
    source := SourcePart( source_entry );
    
    if Position( source, target ) <> fail then
        
        return true;
        
    fi;
    
    return false;
    
end );

##
InstallMethod( \<,
               "deftarg to contra",
               [ IsToDoListEntryWithDefinedTargetRep, IsToDoListEntryWithContrapositionRep ],
               
  function( target_entry, source_entry )
    local source, target;
    
    target := TargetPart( target_entry );
    
    source := source_entry!.input{[ 1 .. 3 ]};
    
    return target = source;
    
end );
    

######################
##
## Display & View
##
######################

##
InstallMethod( ViewObj,
               "for todo-list entries",
               [ IsToDoListEntry ],
               
  function( entry )
    local source_list, source, i, target, string;
    
    source_list := SourcePart( entry );
    
    target := TargetPart( entry );
    
    if source_list <> fail and target <> fail then
        
        source := source_list[ 1 ];
        
        Print( "<The ToDo-list entry: " );
        
        if IsBound( source[ 3 ] ) then
            
            Print( Concatenation( source[ 2 ], "( ", String( source[ 1 ] ), " ) = ", String( source[ 3 ] ) ) );
            
        else
            
            Print( Concatenation( "Has", source[ 2 ], "( ", String( source[ 1 ] ), " )= true" ) );
            
        fi;
        
        for i in [ 2 .. Length( source_list ) ] do
            
            source := source_list[ i ];
            
            Print( " and " );
            
            if IsBound( source[ 3 ] ) then
                
                Print( Concatenation( source[ 2 ], "( ", String( source[ 1 ] ), " ) = ", String( source[ 3 ] ) ) );
                
            else
                
                Print( Concatenation( "Has", source[ 2 ], "( ", String( source[ 1 ] ), " ) = true" ) );
                
            fi;
            
        od;
        
        Print( " => " );
        
        if IsFunction( target ) then
            
            Print( target );
            
        else
            
            Print( Concatenation( target[ 2 ], "( ", String( target[ 1 ] ), " ) = ", String( target[ 3 ] ) ) );
            
        fi;
        
        Print( ">" );
        
    else
        
        Print( "<An incomplete ToDo-list entry>" );
        
    fi;
    
end );

##
InstallMethod( Display,
               "for todo-list entry",
               [ IsToDoListEntry ],
               
  function( entry )
    local source_list, i, source, target, string;
    
    source_list := SourcePart( entry );
    
    target := TargetPart( entry );
    
    if source_list <> fail and target <> fail then
        
        source := source_list[ 1 ];
        
        Print( "<The ToDo-list entry: " );
        
        if IsBound( source[ 3 ] ) then
            
            Print( Concatenation( source[ 2 ], "( ", String( source[ 1 ] ), " ) = ", String( source[ 3 ] ) ) );
            
        else
            
            Print( Concatenation( "Has", source[ 2 ], "( ", String( source[ 1 ] ), " ) = true" ) );
            
        fi;
        
        for i in [ 2 .. Length( source_list ) ] do
            
            source := source_list[ i ];
            
            Print( " and " );
            
            if IsBound( source[ 3 ] ) then
                
                Print( Concatenation( source[ 2 ], "( ", String( source[ 1 ] ), " ) = ", String( source[ 3 ] ) ) );
                
            else
                
                Print( Concatenation( "Has", source[ 2 ], "( ", String( source[ 1 ] ), " ) = true" ) );
                
            fi;
            
        od;
        
        if HasDescriptionOfImplication( entry ) then
            
            Print( "\n" );
            
            Print( Concatenation( "because ", DescriptionOfImplication( entry ), "\n" ) );
            
        fi;
        
        Print( " => " );
        
        if IsFunction( target ) then
            
            Print( target );
            
        else
            
            Print( Concatenation( target[ 2 ], "( ", String( target[ 1 ] ), " ) = ", String( target[ 3 ] ) ) );
            
        fi;
        
        Print( ".\n" );
        
    else
        
        Print( "An incomplete ToDo-list entry.\n" );
        
    fi;
    
end );

##
InstallMethod( Display,
               "for concatenated ToDo-list entries",
               [ IsToDoListEntryMadeFromOtherToDoListEntriesRep ],
               
  function( entry )
    local gen, sourcelist, targetlist, target;
    
    gen := GenesisOfToDoListEntry( entry );
    
    sourcelist := List( gen, SourcePart );
    
    targetlist := List( gen, TargetPart );
    
    if ForAny( sourcelist, i -> i = fail ) or ForAny( targetlist, i -> i = fail ) then
        
        Print( "An incomplete ToDo-list entry.\n" );
        
    fi;
    
    Print( "The ToDo-list entry:\n" );
    
    ## FIXME: This needs to be done more accurate, once the new structure is fully functional
    Print( Concatenation( sourcelist[ 1 ][ 1 ][ 2 ], "( ", String( sourcelist[ 1 ][ 1 ][ 1 ] ), " ) = ", String( sourcelist[ 1 ][ 1 ][ 3 ] ) ) );
    
    for target in [ 1 .. Length( targetlist ) ] do
        
        Print( "\n" );
        
        if HasDescriptionOfImplication( gen[ target ] ) then
            
            Print( Concatenation( "because ", DescriptionOfImplication( gen[ target ] ), "\n" ) );
        fi;
        
        Print( " => " );
        
        target := targetlist[ target ];
        
        if IsFunction( target ) then
            
            Print( target );
            
        else
            
            Print( Concatenation( target[ 2 ], "( ", String( target[ 1 ] ), " ) = ", String( target[ 3 ] ) ) );
            
        fi;
        
    od;
    
    Print( ".\n" );
    
end );
