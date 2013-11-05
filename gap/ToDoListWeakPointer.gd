#############################################################################
##
##                                                    ToolsForHomalg package
##
##  Copyright 2007-2013, Mohamed Barakat, University of Kaiserslautern
##                       Sebastian Gutsche, RWTH-Aachen University
##                  Markus Lange-Hegermann, RWTH-Aachen University
##
##
#############################################################################

DeclareCategory( "IsToDoListWeakPointer",
                 IsObject );

DeclareOperation( "ToDoListWeakPointer",
                  [ IsList ] );

DeclareOperation( "RecoverWholeList",
                  [ IsToDoListWeakPointer ] );

DeclareOperation( "IsComplete",
                  [ IsToDoListWeakPointer ] );

DeclareGlobalFunction( "TODOLIST_WEAK_POINTER_REPLACE" );

DeclareGlobalFunction( "TODOLIST_WEAK_POINTER_RECOVER" );
