# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHomalg: Special methods and knowledge propagation tools
#
# Declarations
#

DeclareCategory( "IsToDoListWeakPointer",
                 IsComponentObjectRep );

DeclareOperation( "ToDoListWeakPointer",
                  [ IsList ] );

DeclareOperation( "RecoverWholeList",
                  [ IsToDoListWeakPointer ] );

DeclareOperation( "IsCompleteWeakPointerList",
                  [ IsToDoListWeakPointer ] );

DeclareOperation( "\[\]\:\=",
                  [ IsToDoListWeakPointer, IsInt, IsObject ] );

DeclareOperation( "\[\]",
                  [ IsToDoListWeakPointer, IsInt ] );

DeclareGlobalFunction( "TODOLIST_WEAK_POINTER_REPLACE" );

DeclareGlobalFunction( "TODOLIST_WEAK_POINTER_RECOVER" );
