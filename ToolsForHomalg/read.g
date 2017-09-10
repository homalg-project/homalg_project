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

## init
ReadPackage( "ToolsForHomalg", "gap/ToolsForHomalg.gi" );

ReadPackage( "ToolsForHomalg", "gap/ToDoListEntry.gi" );

ReadPackage( "ToolsForHomalg", "gap/ToDoListBluePrints.gi" );

ReadPackage( "ToolsForHomalg", "gap/ToDoLists.gi" );


ReadPackage( "ToolsForHomalg", "gap/Trees.gi" );

ReadPackage( "ToolsForHomalg", "gap/ToDoListWeakPointer.gi" );

ReadPackage( "ToolsForHomalg", "gap/GenericView.gi" );

ReadPackage( "ToolsForHomalg", "gap/InstallViews.gi" );

if IsBound( MakeThreadLocal ) then
    Perform(
            [
             "TODO_LISTS",
             ],
            MakeThreadLocal );
fi;
