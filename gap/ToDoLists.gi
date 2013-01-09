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
InstallMethod( AddToToDoList,
               "for a todo list entry",
               [ IsToDoListEntry ],
               
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
            
            CreateImmediateMethodForToDoListEntry( entry );
            
        elif result = false and PreconditionsDefinitelyNotFulfilled( entry ) then
            
            Add( todo_list!.precondition_not_fulfilled, entry );
            
        elif result = fail then
            
            Add( todo_list!.garbage, entry );
            
        fi;
        
    od;
    
# #     THIS DOES NOT WORK ANY MORE, maybe fix it later
# #     if result = false and not PreconditionsDefinitelyNotFulfilled( entry ) then
# #         
# #         target := TargetPart( entry );
# #             
# #         if target <> fail and not IsFunction( target ) then
# #             
# #             target := ToDoList( target[ 1 ] );
# #             
# #             Add( target!.maybe_from_others, entry );
# #             
# #         fi;
# #         
# #     fi;
    
end );

##
InstallMethod( ProcessToDoList_Real,
               "for objects that have something to do",
               [ IsObject and HasSomethingToDo ],
                        
  function( M )
    local todo_list, todos, i, pos, current_entry, result, remove_list;
    
    todo_list := ToDoList( M );
    
    todos := ShallowCopy( todo_list!.todos );
    
    remove_list := [ ];
    
    for i in [ 1 .. Length( todos ) ] do
        
        pos := Position( todo_list!.todos, todos[ i ] );
        
        if pos = fail then
            
            continue;
            
        fi;
        
        Remove( todo_list!.todos, pos );
        
        result := ProcessAToDoListEntry( todos[ i ] );
        
        if result = true then
            
            Add( todo_list!.already_done, todos[ i ] );
            
        elif result = fail then
            
            Add( todo_list!.garbage, todos[ i ] );
            
        elif result = false and PreconditionsDefinitelyNotFulfilled( todos[ i ] ) then
            
            Add( todo_list!.precondition_not_fulfilled, todos[ i ] );
            
        else
            
            Add( todo_list!.todos, todos[ i ] );
            
        fi;
        
    od;
    
    if Length( todo_list!.todos ) = 0 then
        
        ResetFilterObj( M, HasSomethingToDo );
        
    fi;
    
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
            
            if Position( start_list, start_list ) <> fail then
                
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