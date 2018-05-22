#############################################################################
##
##                                                    ToolsForHomalg package
##
##  Copyright 2007-2013, Mohamed Barakat, University of Kaiserslautern
##                     Sebastian Gutsche, University of Kaiserslautern
##                      Markus Lange-Hegermann, RWTH-Aachen University
##
##
#############################################################################

DeclareRepresentation( "IsToDoListWeakPointerRep",
        IsToDoListWeakPointer,
        [ ] );

BindGlobal( "TheFamilyOfToDoListWeakPointers",
        NewFamily( "TheFamilyOfToDoListWeakPointers" ) );

BindGlobal( "TheTypeToDoListWeakPointer",
        NewType( TheFamilyOfToDoListWeakPointers,
                IsToDoListWeakPointerRep ) );

##
InstallGlobalFunction( TODOLIST_WEAK_POINTER_REPLACE,
                       
  function( counter, list )
    local i, replace_list, returned_list, new_list;
    
    replace_list := [ ];
    
    new_list := [ ];
    
    for i in [ 1 .. Length( list ) ] do
        
        if IsList( list[ i ] ) and not IsString( list[ i ] ) then
            
            returned_list := TODOLIST_WEAK_POINTER_REPLACE( counter, list[ i ] );
            
            new_list[ i ] := returned_list[ 1 ];
            
            counter := returned_list[ 2 ];
            
            replace_list := Concatenation( replace_list, returned_list[ 3 ] );
            
        elif IsAttributeStoringRep( list[ i ] ) then
            
            counter := counter + 1;
            
            Add( replace_list, list[ i ] );
            
            new_list[ i ] := JoinStringsWithSeparator( [ "TODOLIST_REPLACED_OBJECT_", String( counter ) ], "" );
            
        else
            
            new_list[ i ] := list[ i ];
            
        fi;
        
    od;
    
    return [ new_list, counter, replace_list ];
    
end );

##
InstallGlobalFunction( TODOLIST_WEAK_POINTER_RECOVER,
                       
  function( list, weak_ptr_list )
    local i, new_list, counter, returned_list;
    
    new_list := [ ];
    
    for i in [ 1 .. Length( list ) ] do
        
        if IsList( list[ i ] ) and not IsString( list[ i ] ) then
            
            returned_list := TODOLIST_WEAK_POINTER_RECOVER( list[ i ], weak_ptr_list );
            
            if returned_list = fail then
                
                return fail;
                
            fi;
            
            new_list[ i ] := returned_list;
            
        elif IsString( list[ i ] ) and PositionSublist( list[ i ], "TODOLIST_REPLACED_OBJECT_" ) <> fail then
            
            counter := Int( list[ i ]{[ 26 .. Length( list[ i ] ) ]} );
            
            if not TOOLS_FOR_HOMALG_ISBOUND_OBJ( weak_ptr_list, counter ) then
                
                return fail;
                
            fi;
            
            new_list[ i ] := TOOLS_FOR_HOMALG_ELM_OBJ( weak_ptr_list, counter );
            
        else
            
            new_list[ i ] := list[ i ];
            
        fi;
        
    od;
    
    return new_list;
    
end );

##
InstallMethod( ToDoListWeakPointer,
               "constructor",
               [ IsList ],
               
  function( list )
    local weak_ptr_obj, return_value;
    
    weak_ptr_obj := rec( );
    
    ObjectifyWithAttributes( weak_ptr_obj, TheTypeToDoListWeakPointer );
    
    return_value := TODOLIST_WEAK_POINTER_REPLACE( 0, list ); ## 0 is the correct value here
    
    weak_ptr_obj!.content_list := return_value[ 1 ];
    
    weak_ptr_obj!.pointers := WeakPointerObj( return_value[ 3 ] );
    
    weak_ptr_obj!.counter := return_value[ 2 ];
    
    return weak_ptr_obj;
    
end );

##
InstallMethod( IsCompleteWeakPointerList,
               "for weak ptrs",
               [ IsToDoListWeakPointerRep ],
               
  function( pointer )
    
    return ForAll( [ 1 .. pointer!.counter ], i -> TOOLS_FOR_HOMALG_ISBOUND_OBJ( pointer!.pointers, i ) );
    
end );

##
InstallMethod( RecoverWholeList,
               "for weak ptrs",
               [ IsToDoListWeakPointerRep ],
               
  function( pointer )
    
    return TODOLIST_WEAK_POINTER_RECOVER( pointer!.content_list, pointer!.pointers );
    
end );

##
InstallMethod( \[\]\:\=,
               "for weak ptrs",
               [ IsToDoListWeakPointerRep, IsInt, IsObject ],
               
  function( ptr, pos, obj )
    local counter;
    
    if IsAttributeStoringRep( obj ) then
        
        counter := ptr!.counter;
        
        counter := counter + 1;
        
        ptr!.pointers[ counter ] := obj;
        
        ptr!.counter := counter;
        
        ptr!.content_list[ pos ] := JoinStringsWithSeparator( [ "TODOLIST_REPLACED_OBJECT_", String( counter ) ], "" );
        
    else
        
        ptr!.content_list[ pos ] := obj;
        
    fi;
    
    return obj;
    
end );

##
InstallMethod( \[\],
               "for weak ptrs",
               [ IsToDoListWeakPointerRep, IsInt ],
               
  function( ptr, pos )
    local content, counter;
    
    content := ptr!.content_list[ pos ];
    
    if IsList( content ) and not IsString( content ) then
        
        content := TODOLIST_WEAK_POINTER_RECOVER( content, ptr!.pointers );
        
        return content;
        
    elif IsString( content ) and PositionSublist( content, "TODOLIST_REPLACED_OBJECT_" ) <> fail then
        
        counter := Int( content{[ 26 .. Length( content ) ]} );
        
        if not TOOLS_FOR_HOMALG_ISBOUND_OBJ( ptr!.pointers, counter ) then
            
            return fail;
            
        fi;
        
        return TOOLS_FOR_HOMALG_ELM_OBJ( ptr!.pointers, counter );
        
    else
        
        return content;
        
    fi;
    
end );

