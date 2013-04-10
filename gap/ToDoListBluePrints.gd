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
                                   [  "The first argument is the <A>indicator</A>.",
                                      "It is a list of sources like in ToDoListEntry.",
                                      "Each entry <A>SP</A> has to be a threetuple.",
                                      "First entry of <A>SP</A> has to an object, for",
                                      "which the second entry of <A>SP</A>, which has",
                                      "to be the name of an attribute, must become known.",
                                      "Once the attribute is known to the object,",
                                      "it will be compared to the third entry of the list.",
                                      "This can be a value, which is compared directly",
                                      "a function, which is launched and its return value is compared,",
                                      "or a list, consisting of a function and arguments, so the",
                                      "return value of the function with given arguments is compared.",
                                      "If there is no third entry in <A>SP</A>, it is only looked",
                                      "up if the value is known. Once all entries in <A>indicator</A>",
                                      "are processed like this, and all returned true in the comparasion,",
                                      "a list of ToDoListEntryForEqualAttributes is installed.",
                                      "They are installed for the two entries of the list <A>objects</A>",
                                      "which can either be the objects itself or a list",
                                      "containing a function and arguments, which return",
                                      "value is used. For each entry in <A>attributes</A> such",
                                      "an entry is installed. Such an entry can be the",
                                      "name of an attribute, if both objects",
                                      "in <A>objects</A> should share the value",
                                      "between attributes with the same name, or a list",
                                      "of two names, if the attributes do not have",
                                      "the same name." ],
                                   "a todo list entry",
                                   "indicator, objects, attributes",
                                   [ "ToDo-list", "Blueprints" ] );

DeclareOperationWithDocumentation( "ToDoListEntryToMaintainFollowingAttributes",
                                   [ IsList, IsList, IsList ],
                                   [ "This function creates a ToDoListEntry which can",
                                     "install several ToDoListEntries.",
                                     "The first two arguments, <A>indicator</A> and <A>objects</A>",
                                     "except that there will be only ToDoListEntries",
                                     "installed between the two objects in <A>objects</A>.",
                                     "Each entry in <A>attributes</A> can either be a string",
                                     "which means that the attribute with the given name will be set",
                                     "from the first to the second object in <A>objects</A>",
                                     "once it is known.",
                                     "The third argument <A>attributes</A> is a list of attributes",
                                     "that will be propagated by ToDoListEntries.",
                                     "Each entry <A>TP</A> can either be a list consisting of",
                                     "a DescriptionOfImplication string and one of the following",
                                     "or just one of the following lists:",
                                     "It can be a string, which means that the Attribute",
                                     "with the given name will be propagated from the first to",
                                     "the second object.",
                                     "It can be a list, consisting of two entries, where the first entry",
                                     "is a list of sources like in ToDoListEntry",
                                     "and the second might be a function",
                                     "which will be launched once the first part is fulfilled.",
                                     "It can also be a threetuple which will serve",
                                     "as second to fourth argument of ToDoListEntry.",
                                     "Or it can be a string, which will set the attribute named",
                                     "like this of the first object to the one named in the second object"
                                  ],
                                   "a todo list entry",
                                   "indicator, objects, attributes",
                                   [ "ToDo-list", "Blueprints" ] );

DeclareOperationWithDocumentation( "ToDoListEntry",
                                   [ IsList, IsList ],
                                   [ "This function allows to create more than one",
                                     "ToDoListEntry with identical list of sources at one time.",
                                     "First argument is a list of sources like in the other ToDoListEntry functions",
                                     "Second argument is a list of threetuples,",
                                     "which serve as second to fourth argument of ToDoListEntry",
                                     "or a function, which serves as second argument for ToDoListEntry",
                                     "or a tuple with a description string and one of the above."
                                  ],
                                   "a todo list entry",
                                   "source, target_list",
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
                                   [ "This function installs an immediate method",
                                     "which can install ToDoListEntryToMaintainEqualAttributes.",
                                     "First argument must be a filter, and once the filter becomes true",
                                     "the ToDoListEntryToMaintainEqualAttributes is",
                                     "installed with the second to fourth argument",
                                     "as first to third.",
                                     "In those attributes, at any point,",
                                     "the variable ToDoList_this_object",
                                     "can be used. When the entry is installed",
                                     "This will be replaced with the object to which the",
                                     "filters became known, i.e. the one which triggered the",
                                     "immediate method."
                                  ],
                                   "nothing",
                                   "filter, indicator, objects, attributes",
                                   [ "ToDo-list", "Blueprints" ] );

DeclareOperationWithDocumentation( "ToDoListEntryToMaintainFollowingAttributesBlueprint",
                                   [ IsObject, IsList, IsList, IsList ],
                                   [ "The same as ToDoListEntryToMaintainEqualAttributesBlueprint",
                                     "for ToDoListEntryToMaintainFollowingAttributes"
                                  ],
                                   "nothing",
                                   [ "ToDo-list", "Blueprints" ] );

DeclareOperationWithDocumentation( "ToDoListEntryBlueprint",
                                   [ IsObject, IsList, IsList ],
                                   [ "The same as ToDoListEntryToMaintainEqualAttributesBlueprint",
                                     "for ToDoListEntry"
                                  ],
                                   "nothing",
                                   [ "ToDo-list", "Blueprints" ] );

DeclareAttribute( "InstallBlueprints",
                  IsObject );
