#############################################################################
##
##  ToDoListBluePrints.gi                              ToolsForHomalg package
##
##  Copyright 2007-2012, Mohamed Barakat, University of Kaiserslautern
##                       Sebastian Gutsche, RWTH-Aachen University
##                  Markus Lange-Hegermann, RWTH-Aachen University
##
##  Blueprints for ToDo-Lists.
##
#############################################################################

##
InstallMethod( ToDoListEntryToMaintainEqualAttributes,
               "generates entry",
               [ IsList, IsList, IsList ],
               
  function( generator, objects, pairs )
    local install_function, entry;
    
    install_function := function()
        local obj1, obj2, i, entry_list;
        
        entry_list := [ ];
        
        obj1 := ToDoLists_Process_Entry_Part( objects[ 1 ] );
        
        obj2 := ToDoLists_Process_Entry_Part( objects[ 2 ] );
        
        for i in pairs do
            
            if IsList( i ) and Length( i ) = 2 then
                
                Add( entry_list, ToDoListEntryForEqualAttributes( obj1, i[ 1 ], obj2, i[ 2 ] ) );
                
            elif IsString( i ) then
                
                Add( entry_list, ToDoListEntryForEqualAttributes( obj1, i, obj2, i ) );
               
            else
                
                Error( "Wrong input syntax" );
                
            fi;
            
        od;
        
        Perform( entry_list, AddToToDoList );
        
    end;
    
    return ToDoListEntry( generator, install_function );
    
end );

##
InstallMethod( ToDoListEntryToMaintainFollowingAttributes,
               "generates entry",
               [ IsList, IsList, IsList ],
               
  function( generator, objects, pairs )
    local install_function, entry;
    
    install_function := function()
      local obj1, obj2, j, i, entry_list, input_list, desc_string, current_description;
      
      entry_list := [ ];
      
      obj1 := ToDoLists_Process_Entry_Part( objects[ 1 ] );
      
      obj2 := ToDoLists_Process_Entry_Part( objects[ 2 ] );
      
      for j in pairs do
          
          if IsList( j ) and Length( j ) = 2 then
              
              i := j[ 2 ];
              
              current_description := j[ 1 ];
              
          else
              
              i := j;
              
              current_description := "";
              
          fi;
          
          ## Prepare the input
          
          if IsString( i ) then
              
              Add( entry_list, ToDoListEntry( [ [ obj1, i ] ], obj2, i, [ ValueGlobal( i ), obj1 ] ) );
              
          elif IsList( i ) and Length( i ) = 2 then
              
              if IsString( i[ 1 ] ) then
                  
                  input_list := [ [ obj1, i[ 1 ] ] ];
                  
                  desc_string := i[ 1 ];
                  
              elif IsList( i[ 1 ] ) and Length( i[ 1 ] ) = 2 then
                  
                  input_list := [ [ obj1, i[ 1 ][ 1 ], i[ 1 ][ 2 ] ] ];
                  
                  desc_string := i[ 1 ][ 1 ];
                  
              else
                  
                  Error( "Wrong input syntax" );
                  
              fi;
              
              if IsString( i[ 2 ] ) then
                  
                  Add( entry_list, ToDoListEntry( input_list, obj2, i[ 2 ], [ ValueGlobal( desc_string ), obj1 ] ) );
                  
              elif IsFunction( i[ 2 ] ) then
                  
                  Add( entry_list, ToDoListEntry( input_list, i[ 2 ] ) );
                  
              elif IsList( i[ 2 ] ) and Length( i[ 2 ] ) = 2 then
                  
                  Add( entry_list, ToDoListEntry( input_list, obj2, i[ 2 ][ 1 ], i[ 2 ][ 2 ] ) );
                  
              else
                  
                  Error( "Wrong input syntax" );
                  
              fi;
              
          else
              
              Error( "Wrong input syntax" );
              
          fi; 
          
      od;
      
        Perform( entry_list, AddToToDoList );
        
    end;
    
    return ToDoListEntry( generator, install_function );
    
end );

##
InstallMethod( ToDoListEntry,
               "installs several entries",
               [ IsList, IsList ],
               
  function( source, targetlist )
    local entry, i, entry_list, target, description;
    
    entry_list := [ ];
    
    for i in targetlist do
        
        if IsList( i ) and Length( i ) = 2 and IsString( i[ 1 ] ) then
            
            target := i[ 2 ];
            
            description := i[ 1 ];
            
        else
            
            target := i;
            
            Unbind( description );
            
        fi;
        
        if IsList( target ) then
            
            entry := CallFuncList( ToDoListEntry, Concatenation( [ source ], target ) );
            
        else
            
            entry := ToDoListEntry( source, target );
            
        fi;
        
        if IsBound( description ) then
            
            SetDescriptionOfImplication( entry, description );
            
        fi;
        
        Add( entry_list, entry );
        
    od;
    
    return entry_list;
    
end );