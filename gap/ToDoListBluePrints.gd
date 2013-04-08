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