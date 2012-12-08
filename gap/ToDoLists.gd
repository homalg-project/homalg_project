#############################################################################
##
##  ToDoLists.gd                                 ToolsForHomalg package
##
##  Copyright 2007-2012, Mohamed Barakat, University of Kaiserslautern
##                       Sebastian Gutsche, RWTH-Aachen University
##                  Markus Lange-Hegermann, RWTH-Aachen University
##
##  Declarations for ToDo-Lists.
##
#############################################################################

DeclareCategoryWithDocumentation( "IsToDoList",
                                  IsObject,
                                  [ "This is the category of ToDo-lists.",
                                    "Every ToDo-list is an object of this category,",
                                    "which basically contains the ToDo-lists." ],
                                  [ "ToDo-list", "Category" ]
                                 );

DeclareFilter( "HasSomethingToDo", IsObject );


##########################################
##
##  Properties & Attributes
##
##########################################

DeclareOperationWithDocumentation( "NewToDoList",
                                   [ ],
                                   "Creates a new empty ToDo-list.",
                                   [  ]
                                 );


DeclareGlobalFunctionWithDocumentation( "Process_A_ToDo_List_Entry",
                                        [ "Gets a ToDo-list entry, which is a pair of a list of strings and a weak pointer object,",
                                          "and processes it. If the action was done, it returns true, if not, it returns false, and it returns",
                                          "fail if the action is not possible anymore due to deleted objects." ],
                                        "a boolean" );



##########################################
##
## Methods for all objects
##
##########################################

DeclareOperationWithDocumentation( "AddToToDoList",
                                   [ IsToDoListEntry ],
                                   [ "Adds the ToDo-list entry <A>E</A> to the",
                                     "ToDo-list of <A>M</A> and creates a new one, if this is needed." ],
                                   [  ],
                                   "E",
                                   [ "ToDo-list", "Methods_for_all_objects" ] );

DeclareAttributeWithDocumentation( "ToDoList",
                                   IsObject,
                                   "Returns the ToDo-list of an object, or creates a new one.",
                                   "A ToDo-list",
                                   [ "ToDo-list", "Methods_for_all_objects" ]
                                 );

DeclareAttributeWithDocumentation( "ProcessToDoList",
                                   IsObject,
                                   [ "This is the magic! This attribute is never set. Creating an ToDo-list entry installs",
                                     "an ImmediateMethod for this attribute for the specific category of the object to which",
                                     "ToDo-list is added, and the filter the entry contains.",
                                     "It is then triggert if the filters become applicable, so the ToDo-list is processed" ],
                                   "nothing",
                                   "A",
                                   [ "ToDo-list", "This_is_the_magic" ] );

DeclareOperation( "ProcessToDoList_Real",
                  [ IsObject ] );

## FIXME: Documentation.
DeclareOperation( "TraceProof",
                  [ IsObject, IsString, IsObject ] );

DeclareOperation( "TraceProof",
                  [ IsList, IsObject, IsString, IsObject ] );