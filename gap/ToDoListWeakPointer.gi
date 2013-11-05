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
            
            new_list[ i ] := Concatenation( "TODOLIST_REPLACED_OBJECT_", String( counter ) );
            
        else
            
            new_list := list[ i ];
            
        fi;
        
    od;
    
    return [ new_list, counter, replace_list ];
    
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
InstallMethod( IsComplete,
               "for weak ptrs",
               [ IsToDoListWeakPointerRep ],
               
  function( pointer )
    
    return ForAll( [ 1 .. pointer!.counter ], i -> IsBoundElmWPObj( pointer!.pointers, i ) );
    
end );

##
InstallMethod( RecoverWholeList,
               "for weak ptrs",
               [ IsToDoListWeakPointerRep ],
               
  function( pointer )
    local new_list;
    
end );
