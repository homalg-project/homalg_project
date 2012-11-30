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


##########################################
##
##  Properties & Attributes
##
##########################################

DeclareOperationWithDocumentation( "NewToDoList",
                                   [ ],
                                   "Creates a new empty ToDo-list.",
                                   [  ],
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
                                   [ IsObject, IsString, IsObject, IsObject, IsString, IsObject ],
                                   [ "Adds a property to the ToDo-list of the object <A>A</A>",
                                     "When the attribute <A>B</A> becomes known to <A>A</A>",
                                     "and equals (comparing is done with \'=\') <A>C</A>, the",
                                     "attribute <A>E</A> of the object <A>D</A> is set to <A>F</A>.",
                                     "All pointers to objects here are weak, except to the first,",
                                     "which points to the ToDo-list anyway.",
                                     "The filter HasToDo will be set to true for <A>A</A>",
                                     "also, if <A>A</A> does not have a ToDo-list already,",
                                     "one will be created." ],
                                   [  ],
                                   "A,B,C,D,E,F",
                                   [ "ToDo-list", "Methods_for_all_objects" ] );

DeclareAttributeWithDocumentation( "ToDoList",
                                   [ IsObject ],
                                   [ "Returns the ToDo-list of an object, or creates a new one." ],
                                   [ "A ToDo-list" ],
                                   [ "ToDo-list", "Methods_for_all_objects" ]
                                 );

NewFilter( "HasSomethingToDo" );

DeclareAttributeWithDocumentation( "ProcessToDoList",
                                   IsObject,
                                   [ "This is the magic! This attribute is never set. Once it's immediate method is called",
                                     "(which happens if the object <A>A</A> HasSomethingToDo), the ToDo-list is processed" ],
                                   "nothing",
                                   "A",
                                   [ "ToDo-list", "This_is_the_magic" ] );