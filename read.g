#############################################################################
##
##  read.g                                            ToolsForHomalg package
##
##  Copyright 2007-2012, Mohamed Barakat, University of Kaiserslautern
##                       Sebastian Gutsche, RWTH-Aachen University
##                  Markus Lange-Hegermann, RWTH-Aachen University
##
##  Reading the implementation part of the ToolsForHomalg package.
##
#############################################################################

if not ( IsBound( LOADED_ToolsForHomalg_implementation ) and
         LOADED_ToolsForHomalg_implementation = true ) then

## init
ReadPackage( "ToolsForHomalg", "gap/ToolsForHomalg.gi" );

fi;
ReadPackage( "ToolsForHomalg", "gap/ToDoListEntry.gi" );
ReadPackage( "ToolsForHomalg", "gap/ToDoLists.gi" );