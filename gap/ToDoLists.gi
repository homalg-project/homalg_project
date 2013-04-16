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
              are_currently_activated := true
            )
           );

################################
##
## Methods for ToDo-lists.
##
################################

##
InstallMethod( NewToDoList,
               "without arguments",
               [ ],
               
  function( )
    local todo_list;
    
    todo_list := rec( );
    
    ObjectifyWithAttributes( todo_list, TheTypeToDoList );
    
    todo_list!.todos := [ ];
    
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
               [ IsObject and HasSomethingToDo ],
                        
  function( M )
    local todo_list, todos, i, pos, current_entry, result, remove_list, function_list, move_list;
    
    todo_list := ToDoList( M );
    
    todos := todo_list!.todos;
    
#     todos := ShallowCopy( todo_list!.todos ); Deprecated, we now process them at once.
    
    remove_list := [ ];
    
    function_list := [ ];
    
    move_list := [ ];
    
    for i in [ 1 .. Length( todos ) ] do
        
        if not IsBound( todos[ i ] ) then
            
            continue;
            
        fi;
        
        if IsProcessedEntry( todos[ i ] ) then
            
            Add( todo_list!.already_done, todos[ i ] );
            
            Add( move_list, todos[ i ] );
            
            Add ( remove_list, todos[ i ] );
            
            continue;
            
        elif PreconditionsDefinitelyNotFulfilled( todos[ i ] ) then
            
            Add( todo_list!.precondition_not_fulfilled, todos[ i ] );
            
            Add( remove_list, todos[ i ] );
            
            continue;
            
        fi;
        
        result := ProcessAToDoListEntry( todos[ i ] );
        
        if IsFunction( result ) then
            
            Add( function_list, result );
            
#                         Error( "3" );
            
            Add( remove_list, todos[ i ] );
            
            Add( todo_list!.already_done, todos[ i ] );
            
        elif result = fail then
            
            Add( todo_list!.garbage, todos[ i ] );
            
#                         Error( "4" );
            
            Add( remove_list, todos[ i ] );
            
        elif result = false and PreconditionsDefinitelyNotFulfilled( todos[ i ] ) then
            
            Add( todo_list!.precondition_not_fulfilled, todos[ i ] );
            
            Add( remove_list, todos[ i ] );
            
        fi;
        
    od;
    
    for i in remove_list do
        
        pos := Position( ToDoList( M )!.todos, i );
        
        if pos <> fail then
            
            Remove( ToDoList( M )!.todos, pos );
            
        fi;
        
    od;
    
    if Length( ToDoList( M )!.todos ) = 0 then
        
        ResetFilterObj( M, HasSomethingToDo );
        
    fi;
    
    for i in function_list do
        
        i( );
        
    od;
    
    for i in move_list do
        
        ToDoLists_Move_To_Target_ToDo_List( i );
        
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
        
        for source in source_list do
            
            if Position( start_list, source ) <> fail then
                
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
    
    Print( "<A ToDo-List currently containing " );
    
    Print( Length( list!.todos ) );
    
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
    
    Print( "A ToDo-List currently containing " );
    
    Print( Length( list!.todos ) );
    
    Print( " active, " );
    
    Print( Length( list!.already_done ) );
    
    Print( " done, and " );
    
    Print( Length( list!.garbage ) );
    
    Print( " failed entries." );
    
end );

###### DO NOT DO THIS AT HOME!
###### This is a HACK given by Max H.
###### Maybe we can replace this later.
###### It also might slow down the whole system.

ORIG_RunImmediateMethods := RunImmediateMethods;
MakeReadWriteGlobal("RunImmediateMethods");
NEW_RunImmediateMethods := function( obj, bitlist )
                              if HasSomethingToDo( obj ) and CanHaveAToDoList( obj ) and TODO_LISTS.activated then
                                  ProcessToDoList_Real( obj );
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
