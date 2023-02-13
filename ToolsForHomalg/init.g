# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHomalg: Special methods and knowledge propagation tools
#
# Reading the declaration part of the package.
#

## init
ReadPackage( "ToolsForHomalg", "gap/ToolsForHomalg.gd" );

ReadPackage( "ToolsForHomalg", "gap/ToDoListEntry.gd" );

ReadPackage( "ToolsForHomalg", "gap/ToDoListBluePrints.gd" );

ReadPackage( "ToolsForHomalg", "gap/ToDoLists.gd" );

ReadPackage( "ToolsForHomalg", "gap/Trees.gd" );

ReadPackage( "ToolsForHomalg", "gap/ToDoListWeakPointer.gd" );

ReadPackage( "ToolsForHomalg", "gap/GenericView.gd" );

ReadPackage( "ToolsForHomalg", "gap/CachingObjects.gd" );

ReadPackage( "ToolsForHomalg", "gap/CachingObjects.gi" );

ReadPackage( "ToolsForHomalg", "gap/LazyArrays.gd" );

ReadPackage( "ToolsForHomalg", "gap/LazyHLists.gd" );

ReadPackage( "ToolsForHomalg", "gap/ListsWithAttributes.gd" );

ReadPackage( "ToolsForHomalg", "gap/ZFunctions.gd" );

if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) then
    ReadPackage( "ToolsForHomalg", "gap/Julia.gd" );
fi;
