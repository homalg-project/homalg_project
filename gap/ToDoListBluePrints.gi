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
              
              Add( entry_list, ToDoListEntryForEqualProperties( obj1, i[ 1 ], obj2, i[ 2 ] ) );
              
          elif IsString( i ) then
              
              Add( entry_list, ToDoListEntryForEqualProperties( obj1, i, obj2, i ) );
              
          fi;
          
      od;
      
      Perform( entry_list, AddToToDoList );
      
    end;
    
    return ToDoListEntry( generator, install_function );
    
end );

