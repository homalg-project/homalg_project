#############################################################################
##
##  ToDoListEntry.gd                                 ToolsForHomalg package
##
##  Copyright 2007-2012, Mohamed Barakat, University of Kaiserslautern
##                       Sebastian Gutsche, RWTH-Aachen University
##                  Markus Lange-Hegermann, RWTH-Aachen University
##
##  Entries for ToDo-Lists.
##
#############################################################################

DeclareCategory( "IsToDoListEntry",
                 IsObject );

DeclareGlobalVariable( "TODO_LIST_ENTRIES" );

##################################
##
## Methods and properties
##
##################################

DeclareFilter( "IsProcessedEntry", IsToDoListEntry );

DeclareProperty( "RemoveContrapositions", IsToDoListEntry );

DeclareFilter( "PreconditionsDefinitelyNotFulfilled", IsToDoListEntry );


DeclareOperationWithDocumentation( "AddToToDoList",
                                   [ IsToDoListEntry ],
                                   [ "Adds the ToDo-list entry <A>E</A> to the",
                                     "ToDo-lists of it's source objects and creates a new one, if this is needed." ],
                                   [  ],
                                   "E",
                                   [ "ToDo-list", "ToDo-list_entries" ] );

DeclareOperationWithDocumentation( "SourcePart",
                                   [ IsToDoListEntry ],
                                   [ "Returns the a list of source parts of the ToDo-list entry <A>entry</A>.",
                                     "This is a triple of an object, a name of a filter/attribute, and a value to which",
                                     "the attribute has to be set to activate the entry" ],
                                   "a list",
                                   "entry",
                                   [ "ToDo-list", "ToDo-list_entries" ]
                                 );

DeclareOperationWithDocumentation( "TargetPart",
                                  [ IsToDoListEntry ],
                                  [ "Returns the target part of the ToDo-list entry <A>entry</A>.",
                                    "This is a triple of an object, a name of a filter/attribute, and a value to which the",
                                    "specific filter/attribute should be set.",
                                    "The third entry of the list might also be a function to which return value the",
                                    "attribute is set." ],
                                  "a list",
                                  "entry",
                                  [ "ToDo-list", "ToDo-list_entries" ]
                                );

DeclareOperationWithDocumentation( "ProcessAToDoListEntry",
                                   [ IsToDoListEntry ],
                                   [ "Processes a ToDo-list entry, i.e. sets the information given in TargetPart",
                                     "if the definitions in SourcePart are fulfilled.",
                                     "Returns a function if the entry could be processed, false if not, and fail if",
                                     "SourcePart or TargetPart weren't availible anymore." ],
                                   "a boolean",
                                   [ "ToDo-list", "ToDo-list_entries" ]
                                 );

DeclareOperationWithDocumentation( "ToDoListEntry",
                                   [ IsList, IsObject, IsString, IsObject ],
                                   [ "The first argument must be a list consisting of three-tuples",
                                     "where the first entry must be the object to which the attribute",
                                     "given as a string in the second entry must be known to process this entry.",
                                     "The third part can be a value or a list, consisting of a function followed",
                                     "by arguments which will be computed by the time the attribute given",
                                     "as second entry becomes known to the first entry.",
                                     "If the value of the attribute matches the (computed)",
                                     "value in the third entry for all members of the list in the first argument",
                                     "the attribute given as third argument, also by name, of the second argument",
                                     "is set to the value of the fourth argument.",
                                     "This can also be a list which has to be computed, or a function,",
                                     "which retun value is used in this case."
                                  ],
                                   "a ToDoListEntry",
                                   [ "ToDo-list", "ToDo-list_entries" ]
                                 );

DeclareOperationWithDocumentation( "ToDoListEntry",
                                   [ IsList, IsFunction ],
                                   [ "The first argument is a list of three-tubles like above.",
                                     "Once all preconditions become fulfilled",
                                     "the function given as second argument is launched." ],
                                   "a ToDoListEntry",
                                   [ "ToDo-list", "ToDo-list_entries" ]
                                  );

DeclareOperationWithDocumentation( "SetTargetValueObject",
                                   [ IsToDoListEntry, IsObject ],
                                   [ "If the given value of the target part is the return value of a function",
                                     "this command sets the target value of the entry to a function.",
                                     "This is done to keep proof tracking availible." ],
                                   "nothing",
                                   "entry,value",
                                   [ "ToDo-list", "ToDo-list_entries" ]
                                );

DeclareOperationWithDocumentation( "SetTargetObject",
                                   [ IsToDoListEntry, IsObject ],
                                   [ "If the target object, i.e. the first entry of the target part, was given as",
                                     "a function, this method can set this entry to the return value computed in",
                                     "ProcessToDoListEntry. This happens atomatically, do not worry about it." ],
                                   "nothing",
                                   "entry,obj",
                                   [ "ToDo-list", "ToDo-list_entries" ]
                                );

DeclareOperationWithDocumentation( "ToDoListEntryWithContraposition",
                                    [ IsObject, IsString, IsBool, IsObject, IsString, IsBool ],
                                    [ "Creates a ToDoListEntry which also installs a contraposition.",
                                      "The arguments <A>source_prop</A> and <A>target_prop</A> need to be",
                                      "strings that name a property, and <A>sval</A> and <A>tval</A> need to be",
                                      "boolean values, i.e. true or false." ],
                                    "a ToDoListEntry",
                                    "sobj,source_prop,sval,tobj,target_prop,tval",
                                    [ "ToDo-list", "ToDo-list_entries" ]
                );

DeclareAttributeWithDocumentation( "DescriptionOfImplication",
                                   IsToDoListEntry,
                                   [ "Has to be set to a string, which describes the reason for the conclusion.",
                                     "If the ToDo-list entry is displayed, the given string will be displayed with a",
                                     "because before it." ],
                                     "a list",
                                     [ "ToDo-list", "ToDo-list_entries" ]
                                  );

DeclareOperationWithDocumentation( "ToDoListEntryForEqualAttributes",
                                   [ IsObject, IsString, IsObject, IsString ],
                                   [ "Creates a ToDoListEntry for two equal",
                                     "attributes, which means that both values of the two attributes",
                                     "will be propagated in both directions." ],
                                   "a ToDoListEntry",
                                   [ "ToDo-list", "ToDo-list_entries" ]
                                 );

DeclareOperationWithDocumentation( "ToDoListEntryForEquivalentAttributes",
                                   [ IsObject, IsString, IsObject, IsObject, IsString, IsObject ],
                                   [ "Creates a ToDoListEntry for two equivalent",
                                     "attributes, which means that both values of the two attributes",
                                     "will be propagated in both directions.",
                                     "Please note that this one does NOT implement contrapositions."
                                   ],
                                   "a ToDoListEntry",
                                   [ "ToDo-list", "ToDo-list_entries" ]
                                 );

DeclareAttribute( "TrowProofTrackingObject",
                  IsToDoListEntry );

DeclareGlobalFunction( "ToDoLists_Process_Entry_Part" );

DeclareOperation( "ToDoLists_Move_To_Target_ToDo_List",
                  [ IsToDoListEntry ] );

DeclareGlobalFunction( "ToolsForHomalg_ProcessToDoListEquivalenciesAndContrapositions" );

DeclareGlobalFunction( "ToolsForHomalg_RemoveContrapositionFromBothToDoLists" );
