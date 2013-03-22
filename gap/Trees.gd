#############################################################################
##
##  Trees.gd                                 ToolsForHomalg package
##
##  Copyright 2007-2013, Mohamed Barakat, University of Kaiserslautern
##                       Sebastian Gutsche, RWTH-Aachen University
##                  Markus Lange-Hegermann, RWTH-Aachen University
##
##  Trees for use in ToDoLists.
##
#############################################################################

DeclareCategoryWithDocumentation( "IsTree",
                                  IsObject,
                                  [ "The category of trees. A tree may have a content, a list of successors,",
                                    "a predecessor and it knows if it is a leave of a tree or not." ],
                                  "tree",
                                  [ "Trees", "Trees" ]
                                );

DeclareAttributeWithDocumentation( "Content",
                                   IsTree,
                                   [ "The content of the tree.",
                                     "May be any object." ],
                                   "object",
                                   [ "Trees", "Trees" ]
                                 );

DeclareFilter( "IsSentinel" );

DeclareOperationWithDocumentation( "ListOfSuccessors",
                                   [ IsTree ],
                                   [ "Returns the list of successors of a tree." ],
                                   "a list of trees",
                                   [ "Trees", "Trees" ]
                                 );

DeclareOperationWithDocumentation( "Predecessor",
                                   [ IsTree ],
                                   [ "Returns the predecessor of a tree, or fail if there is none." ],
                                   "a tree or fail",
                                   [ "Trees", "Trees" ]
                                 );

DeclareOperationWithDocumentation( "ListOfSentinels",
                                   [ IsTree ],
                                   [ "Returns a list of leaves of the tree." ],
                                   "a list",
                                   [ "Trees", "Trees" ]
                                 );

DeclareOperationWithDocumentation( "RemoveHead",
                                   [ IsTree ],
                                   [ "Returns the first successor of the tree, and adds all other successors of the",
                                     "tree to the tree that is returned.",
                                     "If the tree is a leave, it returns an empty tree.",
                                     "If the tree is empty, it returns the tree itself." ],
                                   "a tree",
                                   [ "Trees", "Trees" ]
                                 );

DeclareOperationWithDocumentation( "Tree",
                                    [ ],
                                    [ "Returns an empty tree." ],
                                    "a tree",
                                    [ "Trees", "Trees" ]
                                  );

DeclareOperationWithDocumentation( "Tree",
                                    [ IsObject ],
                                    [ "Returns a tree with argument <A>obj</A>." ],
                                    "a tree",
                                    "obj",
                                    [ "Trees", "Trees" ]
                                  );

DeclareOperationWithDocumentation( "Add",
                                   [ IsTree, IsTree ],
                                   [ "Adds the [list of] tree[s] <A>new_tree</A> as successor to the tree <A>tree</A>." ],
                                   "nothing",
                                   "tree,new_tree",
                                   [ "Trees", "Trees" ]
                                 );

DeclareOperation( "Add",
                  [ IsTree, IsList ] );

DeclareOperationWithDocumentation( "ContentListFromSentinelToHead",
                                   [ IsTree ],
                                   [ "Returns a list of the contents of the trees from the leave <A>sent</A>",
                                     "up to the content of the head of the tree." ],
                                   "a list",
                                   "sent",
                                   [ "Trees", "Trees" ]
                                 );

DeclareOperationWithDocumentation( "PostOrder",
                                   [ IsTree ],
                                   [ "Returns the contents of the nodes of the tree in post-order." ],
                                   "a list",
                                   [ "Trees", "Trees" ]
                                 );