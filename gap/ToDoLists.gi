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
    local result, source, todo_list;
    
    result := ProcessAToDoListEntry( entry );
    
    source := SourcePart( entry );
    
    if source = fail then
        
        return;
        
    fi;
    
    todo_list := ToDoList( source[ 1 ] );
    
    if result = true then
        
        Add( todo_list!.already_done, entry );
        
    elif result = false then
        
        Add( todo_list!.todos, entry );
        
        SetFilterObj( source[ 1 ], HasSomethingToDo );
        
    elif result = fail then
        
        Add( todo_list!.garbage, entry );
        
    fi;
    
end );

##
InstallMethod( ProcessToDoList_Real,
               "for objects that have something to do",
               [ IsObject and HasSomethingToDo ],
                        
  function( M )
    local todo_list, todos, i, result, remove_list;
    
    todo_list := ToDoList( M );
    
    todos := todo_list!.todos;
    
    remove_list := [ ];
    
    for i in [ 1 .. Length( todos ) ] do
        
        result := ProcessAToDoListEntry( todos[ i ] );
        
        if result = true then
            
            Add( todo_list!.already_done, todos[ i ] );
            
            Add( remove_list, i );
            
        elif result = fail then
            
            Add( todo_list!.garbage, todos[ i ] );
            
            Add( remove_list, i );
            
        fi;
        
    od;
    
    for i in remove_list do
        
        ##This is sensitive
        Remove( todos, i );
        
    od;
    
    if Length( todos ) = 0 then
        
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
    
    return List( TraceProof( [ startobj, attr_name, attr_value ], startobj, attr_name, attr_value ), i -> JoinToDoListEntries( i ) );
    
end );

##
InstallMethod( TraceProof,
               "recursive part",
               [ IsList, IsObject, IsString, IsObject ],
               
  function( start_list, start_obj, attr_name, attr_value )
    local todo_list, entry, i, temp_tar, source, return_list;
    
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
        
        source := SourcePart( i );
        
        if source = start_list then
            
            Add( return_list, [ i ] );
            
        elif source <> fail then
            
            return_list := Concatenation( return_list, List( TraceProof( start_list, source[ 1 ], source[ 2 ], source[ 3 ] ), j -> Concatenation( j, entry ) ) );
            
        fi;
        
    od;
    
    if return_list = [ ] then
        
        return [ [ ] ];
        
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