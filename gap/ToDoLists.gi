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
    
    todo_list := ObjectifyWithAttributes( rec(), TheTypeToDoList );
    
    todo_list!.todos := [ ];
    
    todo_list!.already_done := [ ];
    
    todo_list!.garbage := [ ];
    
    return todo_list;
    
end );



################################
##
## Methods for all objects
##
################################

##
InstallGlobalFunction( Process_A_ToDo_List_Entry,
  
  function( entry )
    local M, attr_to_pull, val_to_pull, obj_to_push, attr_to_push, val_to_push;
    
    if not ForAll( [ 1 .. 4 ], i -> IsBoundElmWPObj( entry[ 2 ], i ) ) then
        
        return fail;
        
    fi;
    
    M := ElmWPObj( entry[ 2 ], 1 );
    
    attr_to_pull := ValueGlobal( entry[ 1 ][ 1 ] );
    
    val_to_pull := ElmWPObj( entry[ 2 ], 2 );
    
    if Tester( attr_to_pull )( val_to_pull ) then
        
        obj_to_push := ElmWPObj( entry[ 2 ], 3 );
        
        attr_to_push := ValueGlobal( entry[ 1 ][ 2 ] );
        
        val_to_push := ElmWPObj( entry[ 2 ], 4 );
        
        Setter( attr_to_push )( obj_to_push, val_to_push );
        
        return true;
        
    else
        
        return false;
        
    fi;
    
end );

##
InstallMethod( ToDoList,
               "for an object",
               [ IsAttributeStoringRep ],
               
  function( object )
    
    return NewToDoList( );
    
end );

##
InstallMethod( AddToToDoList,
               "with 6 arguments",
               [ IsObject, IsString, IsObject, IsObject, IsString, IsObject ],
               
  function( M, attr_to_pull, val_to_pull, obj_to_push, attr_to_push, val_to_push )
    local pair, string_list, value_list, ret_value, todo_list;
    
    value_list := WeakPointerObj( [ M, val_to_pull, obj_to_push, val_to_push ] );
    
    string_list := [ attr_to_pull, attr_to_push ];
    
    pair := [ string_list, value_list ];
    
    ## check first if you can not do this directly
    ret_value := Process_A_ToDo_List_Entry( pair );
    
    todo_list := ToDoList( M );
    
    if ret_value = true then
        
        Add( todo_list!.already_done, pair );
        
    elif ret_value = fail then
        
        Add( todo_list!.garbage, pair );
        
    else
        
        Add( todo_list!.todos, pair );
        
        SetFilterObj( M, HasSomethingToDo );
        
    fi;
    
end );

##
InstallImmediateMethod( ProcessToDoList,
                        IsObject and HasSomethingToDo,
                        0,
                        
  function( M )
    local todo_list, todos, i, result, remove_list;
    
    todo_list := ToDoList( M );
    
    todos := todo_list!.todos;
    
    remove_list := [ ];
    
    for i in Length( todos ) do
        
        result := Process_A_ToDo_List_Entry( todos[ i ] );
        
        if result = true then
            
            Add( todo_list!.already_done, todos[ i ] );
            
            Add( remove_list, i );
            
        elif ret_value = fail then
            
            Add( todo_list!.garbage, todos[ i ] );
            
            Add( remove_list, i );
            
        fi;
        
    od;
    
    for i in remove_list do
        
        ##This is sensitive
        Remove( todos, i );
        
    fi;
    
    if Length( todos ) = 0 then
        
        ResetFilterObj( M, HasSomethingToDo );
        
    fi;
    
    TryNextMethod();
    
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
    
    Print( " aktive, " );
    
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
    
    Print( " aktive, " );
    
    Print( Length( list!.already_done ) );
    
    Print( " done, and " );
    
    Print( Length( list!.garbage ) );
    
    Print( " failed entries." );
    
end );