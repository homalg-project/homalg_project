#############################################################################
##
##  init.g                                            ToolsForHomalg package
##
##  Copyright 2007-2012, Mohamed Barakat, University of Kaiserslautern
##                       Sebastian Gutsche, RWTH-Aachen University
##                  Markus Lange-Hegermann, RWTH-Aachen University
##
##  Reading the declaration part of the ToolsForHomalg package.
##
#############################################################################

## init
ReadPackage( "ToolsForHomalg", "gap/ToolsForHomalg.gd" );

ReadPackage( "ToolsForHomalg", "gap/ToDoListEntry.gd" );
ReadPackage( "ToolsForHomalg", "gap/ToDoLists.gd" );

ReadPackage( "ToolsForHomalg", "gap/Trees.gd" );

## This is a workaround since GAP (<=4.4.12) does not load
## the implementation parts of the different packages
## in the same order as the declaration parts;
## I hope this becomes obsolete in the future
LOADED_ToolsForHomalg_implementation := true;

ReadPackage( "ToolsForHomalg", "gap/ToolsForHomalg.gi" );
