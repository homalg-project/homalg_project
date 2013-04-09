#############################################################################
##
##  ToDoListBluePrints.gd                              ToolsForHomalg package
##
##  Copyright 2007-2012, Mohamed Barakat, University of Kaiserslautern
##                       Sebastian Gutsche, RWTH-Aachen University
##                  Markus Lange-Hegermann, RWTH-Aachen University
##
##  Blueprints for ToDo-Lists.
##
#############################################################################

DeclareOperationWithDocumentation( "ToDoListEntryToMaintainEqualAttributes",
                                   [ IsList, IsList, IsList ],
                                   [ "" ],
                                   "a todo list entry",
                                   "indicator, objects, attributes",
                                   [ "ToDo-list", "Blueprints" ] );

DeclareOperationWithDocumentation( "ToDoListEntryToMaintainFollowingAttributes",
                                   [ IsList, IsList, IsList ],
                                   [ "" ],
                                   "a todo list entry",
                                   [ "ToDo-list", "Blueprints" ] );

DeclareOperationWithDocumentation( "ToDoListEntry",
                                   [ IsList, IsList ],
                                   [ "" ],
                                   "a todo list entry",
                                   [ "ToDo-list", "Blueprints" ] );

DeclareGlobalVariableWithDocumentation( "ToDoList_this_object",
                                        [ "Represents the objects for which the blueprint is",
                                          "created in the arguments" ],
                                        [ "ToDo-list", "Blueprints" ]
                                      );

DeclareGlobalFunction( "ToDoLists_remove_this_object_recursive" );

DeclareGlobalFunction( "ToDoLists_install_blueprint_immediate_method" );

DeclareOperationWithDocumentation( "ToDoListEntryToMaintainEqualAttributesBlueprint",
                                   [ IsObject, IsList, IsList, IsList ],
                                   [ "" ],
                                   "nothing",
                                   "filter, indicator, objects, attributes",
                                   [ "ToDo-list", "Blueprints" ] );

DeclareOperationWithDocumentation( "ToDoListEntryToMaintainFollowingAttributesBlueprint",
                                   [ IsObject, IsList, IsList, IsList ],
                                   [ "" ],
                                   "nothing",
                                   [ "ToDo-list", "Blueprints" ] );

DeclareOperationWithDocumentation( "ToDoListEntryBlueprint",
                                   [ IsObject, IsList, IsList ],
                                   [ "" ],
                                   "nothing",
                                   [ "ToDo-list", "Blueprints" ] );

DeclareAttribute( "InstallBlueprints",
                  IsObject );
