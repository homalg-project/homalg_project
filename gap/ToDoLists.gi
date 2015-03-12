#############################################################################
##
##  ToDoLists.gi                                 ToolsForHomalg package
##
##  Copyright 2007-2012, Mohamed Barakat, University of Kaiserslautern
##                       Sebastian Gutsche, RWTH-Aachen University
##                  Markus Lange-Hegermann, RWTH-Aachen University
##
##  Implementations for ToDo-Lists.
##
#############################################################################

DeclareRepresentation( "IsToDoListRep",
        IsToDoList and IsAttributeStoringRep,
        [ ] );

BindGlobal( "TheFamilyOfToDoLists",
        NewFamily( "TheFamilyOfToDoLists" ) );

BindGlobal( "TheTypeToDoList",
        NewType( TheFamilyOfToDoLists,
                IsToDoListRep ) );

InstallValue( TODO_LISTS,
            rec(
              activated := true,
              are_currently_activated := true,
              where_infos := false,
            )
           );

################################
##
## Methods for ToDo-lists.
##
################################

BindGlobal( "ShowToDoListInfo",
            
  function( arg )
    local level;
    
    if Length( arg ) = 0 then
        
        level := 2;
        
    else
        
        level := arg[ 1 ];
        
    fi;
  
    SetInfoLevel( InfoToDoList, level );
    
end );

##
InstallMethod( NewToDoList,
               "without arguments",
               [ ],
               
  function( )
    local todo_list;
    
    todo_list := rec( );
    
    ObjectifyWithAttributes( todo_list, TheTypeToDoList );
    
    todo_list!.todos := rec( );
    
    todo_list!.already_done := [ ];
    
    todo_list!.precondition_not_fulfilled := [ ];
    
    todo_list!.garbage := [ ];
    
    todo_list!.from_others := [ ];
    
    todo_list!.maybe_from_others := [ ];
    
    return todo_list;
    
end );



################################
##
## Methods for all objects
##
################################

##
InstallMethod( ToDoList,
               "for an object",
               [ IsAttributeStoringRep ],
               
  function( object )
    
    return NewToDoList( );
    
end );

##
InstallMethod( ProcessToDoList_Real,
               "for objects that have something to do",
               [ IsObject and HasSomethingToDo, IsObject ],
                        
  function( M, bitlist )
    local filter_names, todo_list, todos_orig, todos, i, pos, current_entry, result, remove_list, function_list, move_list, name;
    
    Info( InfoToDoList, 2, "\033[00;32mTODOLIST:\033[00;30m Process a todo list" );
    
    filter_names := NamesFilter( bitlist );
    
    todo_list := ToDoList( M );
    
    function_list := [ ];
    
    for name in filter_names do
        
        if not IsBound( todo_list!.todos.( name ) ) then
            
            continue;
            
        fi;
        
        todos_orig := todo_list!.todos.( name );
        
        todos := ShallowCopy( todo_list!.todos.( name ) ); 
        
        remove_list := [ ];
        
        move_list := [ ];
        
        for i in [ 1 .. Length( todos ) ] do
            
            if not IsBound( todos[ i ] ) then
                
                continue;
                
            fi;
            
            if not ToDoList_Is_Sane_Entry( todos[ i ] ) then
                
                continue;
                
            fi;
            
            if IsProcessedEntry( todos[ i ] ) then
                
                Add( todo_list!.already_done, todos[ i ] );
                
                Add( move_list, todos[ i ] );
                
                Remove( todos_orig, Position( todos_orig, todos[ i ] ) );
                
                continue;
                
            elif PreconditionsDefinitelyNotFulfilled( todos[ i ] ) then
                
                Add( todo_list!.precondition_not_fulfilled, todos[ i ] );
                
                Remove( todos_orig, Position( todos_orig, todos[ i ] ) );
                
                continue;
                
            fi;
            
            result := ProcessAToDoListEntry( todos[ i ] );
            
            if IsFunction( result ) then
                
                Info( InfoToDoList, 2, "\033[00;32mTODOLIST:\033[00;31m Propagated an entry" );
                
                Add( function_list, result );
                
                Remove( todos_orig, Position( todos_orig, todos[ i ] ) );
            
                Add( todo_list!.already_done, todos[ i ] );
                
            elif result = fail then
                
                Add( todo_list!.garbage, todos[ i ] );
                
                Remove( todos_orig, Position( todos_orig, todos[ i ] ) );
                
            elif result = false and PreconditionsDefinitelyNotFulfilled( todos[ i ] ) then
                
                Add( todo_list!.precondition_not_fulfilled, todos[ i ] );
                
                Remove( todos_orig, Position( todos_orig, todos[ i ] ) );
                
            fi;
            
        od;
        
        if todo_list!.todos.( name ) = [ ] then
            
            Unbind( todo_list!.todos.( name ) );
            
        fi;
        
    od;
    
    if ToDoList( M )!.todos = rec( ) then
        
        ResetFilterObj( M, HasSomethingToDo );
        
    fi;
    
    for i in function_list do
        
        i( );
        
    od;
    
    return;
    
end );

##############################
##
## Trace
##
##############################

##
InstallMethod( TraceProof,
               "beginning of recursion, returns entry",
               [ IsObject, IsString, IsObject ],
               
  function( startobj, attr_name, attr_value )
    local trees, ret_tree;
    
    trees := ToolsForHomalg_ToDoList_TaceProof_RecursivePart( [ [ startobj, attr_name, attr_value ] ], startobj, attr_name, attr_value );
    
    ret_tree := Tree( [ startobj, attr_name, attr_value ] );
    
    Add( ret_tree, trees );
    
    return ret_tree;
    
end );

##
InstallGlobalFunction( ToolsForHomalg_ToDoList_TaceProof_RecursivePart,
                       "recursive part",
               
  function( start_list, start_obj, attr_name, attr_value )
    local todo_list, entry, i, temp_tar, source_list, source, return_list, return_trees, current_tree;
    
    todo_list := ToDoList( start_obj );
    
    entry := [ ];
    
    for i in todo_list!.from_others do
        
        temp_tar := TargetPart( i );
        
        if temp_tar = [ start_obj, attr_name, attr_value ] then
            
            Add( entry, i );
            
        fi;
        
    od;
    
    return_list := [ ];
    
    for i in entry do
        
        source_list := SourcePart( i );
        
        if source_list = fail then
            
            continue;
            
        fi;
        
        for source in source_list do
            
            if TraceProof_Position( start_list, source ) <> fail then
                
                Add( return_list, Tree( i ) );
                
            elif source <> fail then
                
                return_trees := ToolsForHomalg_ToDoList_TaceProof_RecursivePart( Concatenation( start_list, [ source ] ), source[ 1 ], source[ 2 ], source[ 3 ] );
                
                current_tree := Tree( i );
                
                Add( current_tree, return_trees );
                
                Add( return_list, current_tree );
                
            fi;
            
        od;
        
    od;
    
    if return_list = [ ] then
        
        return [ ];
        
    fi;
    
    return return_list;
    
end );

InstallGlobalFunction( "TraceProof_Position",
                       
  function( list, comp )
    local i;
    
    for i in [ 1 .. Length( list ) ] do
        
        if IsIdenticalObj( comp[ 1 ], list[ i ][ 1 ] ) and comp[ 2 ]=list[ i ][ 2 ] and comp[ 3 ]=list[ i ][ 3 ] then
            
            return i;
            
        fi;
        
    od;
    
    return fail;
    
end );

##############################
##
## View & Display
##
##############################

##
InstallMethod( ViewObj,
               "for todo lists",
               [ IsToDoList ],
               
  function( list )
    local length, i;
    
    Print( "<A ToDo-List currently containing " );
    
    length := 0;
    
    for i in RecNames( list!.todos ) do
        
        length := length + Length( list!.todos.( i ) );
        
    od;
    
    Print( length );
    
    Print( " active, " );
    
    Print( Length( list!.already_done ) );
    
    Print( " done, and " );
    
    Print( Length( list!.garbage ) );
    
    Print( " failed entries>" );
    
end );

##
InstallMethod( Display,
               "for todo lists",
               [ IsToDoList ],
               
  function( list )
    local length, i;
    
    Print( "A ToDo-List currently containing " );
    
    length := 0;
    
    for i in RecNames( list!.todos ) do
        
        length := length + Length( list!.todos.( i ) );
        
    od;
    
    Print( length );
    
    Print( " active, " );
    
    Print( Length( list!.already_done ) );
    
    Print( " done, and " );
    
    Print( Length( list!.garbage ) );
    
    Print( " failed entries." );
    
end );

###### CRUCIAL:
###### This is a HACK given by Max H.
###### Maybe we can replace this later.
###### It also might slow down the whole system.

ORIG_RunImmediateMethods := RunImmediateMethods;
MakeReadWriteGlobal("RunImmediateMethods");
NEW_RunImmediateMethods := function( obj, bitlist )
                              if HasSomethingToDo( obj ) and CanHaveAToDoList( obj ) and TODO_LISTS.activated then
                                  ProcessToDoList_Real( obj, bitlist );
                              fi;
                              ORIG_RunImmediateMethods( obj, bitlist );
                           end;
RunImmediateMethods:=NEW_RunImmediateMethods;
MakeReadOnlyGlobal("RunImmediateMethods");


###########################################
##
## Tool Methods
##
###########################################

##
InstallImmediateMethod( MaintainanceMethodForToDoLists,
                        IsAttributeStoringRep,
                        0,
                        
  function( obj )
    
    if TODO_LISTS.activated then
        
        SetFilterObj( obj, CanHaveAToDoList );
        
    fi;
    
    TryNextMethod();
    
end );

##
InstallMethod( ActivateToDoList,
               "for one object",
               [ IsObject ],
               
  function( obj )
    
    SetFilterObj( obj, CanHaveAToDoList );
    
end );

##
InstallMethod( ActivateToDoList,
               "for all objects",
               [ ],
               
  function( )
    
    TODO_LISTS.activated := true;
    
end );

##
InstallMethod( DeactivateToDoList,
               "for one object",
               [ IsObject ],
               
  function( obj )
    
    ResetFilterObj( obj, CanHaveAToDoList );
    
end );

##
InstallMethod( DeactivateToDoList,
               "for all objects",
               [ ],
               
  function( )
    
    TODO_LISTS.activated := false;
    
end );

##
InstallGlobalFunction( ActivateWhereInfosInEntries,
                       
  function( )
    
    TODO_LISTS.where_infos := true;
    
end );

##
InstallGlobalFunction( DeactivateWhereInfosInEntries,
                       
  function( )
    
    TODO_LISTS.where_infos := false;
    
end );
