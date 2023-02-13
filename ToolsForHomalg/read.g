# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHomalg: Special methods and knowledge propagation tools
#
# Reading the implementation part of the package.
#

## init
ReadPackage( "ToolsForHomalg", "gap/ToolsForHomalg.gi" );

ReadPackage( "ToolsForHomalg", "gap/ToDoListEntry.gi" );

ReadPackage( "ToolsForHomalg", "gap/ToDoListBluePrints.gi" );

ReadPackage( "ToolsForHomalg", "gap/ToDoLists.gi" );


ReadPackage( "ToolsForHomalg", "gap/Trees.gi" );

ReadPackage( "ToolsForHomalg", "gap/ToDoListWeakPointer.gi" );

ReadPackage( "ToolsForHomalg", "gap/LazyArrays.gi" );

ReadPackage( "ToolsForHomalg", "gap/LazyHLists.gi" );

ReadPackage( "ToolsForHomalg", "gap/ListsWithAttributes.gi" );

ReadPackage( "ToolsForHomalg", "gap/ZFunctions.gi" );

ReadPackage( "ToolsForHomalg", "gap/GenericView.gi" );

ReadPackage( "ToolsForHomalg", "gap/InstallViews.gi" );

if IsBound( MakeThreadLocal ) then
    Perform(
            [
             "TODO_LISTS",
             ],
            MakeThreadLocal );
fi;

if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) then
    ReadPackage( "ToolsForHomalg", "gap/Julia.gi" );
fi;
