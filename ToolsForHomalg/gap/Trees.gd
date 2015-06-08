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

#! @Chapter Trees
#!  The trees are used in ToDoLists.
#!  They are a technical feature, and fairly general, so they also can be used somewhere else.

#! @Description
#!  The category of trees. A tree may have a content, a list of successors,
#!  a predecessor and it knows if it is a leave of a tree or not.
#! @ChapterInfo Trees, Trees
DeclareCategory( "IsTree",
                 IsObject );

#! @Description
#!  The content of the tree.
#!  May be any object.
#! @Returns object
#! @ChapterInfo Trees, Trees
DeclareAttribute( "Content",
                  IsTree );

DeclareFilter( "IsSentinel" );

#! @Description
#!  Returns the list of successors of a tree.
#! @Returns a list of trees
#! @ChapterInfo Trees, Trees
DeclareOperation( "ListOfSuccessors",
                  [ IsTree ] );

#! @Description
#!  Returns the predecessor of a tree, or fail if there is none.
#! @Returns a tree or fail
#! @ChapterInfo Trees, Trees
DeclareOperation( "Predecessor",
                  [ IsTree ] );

#! @Description
#!  Returns a list of leaves of the tree.
#! @Returns a list
#! @ChapterInfo Trees, Trees
DeclareOperation( "ListOfSentinels",
                  [ IsTree ] );

#! @Description
#!  Returns the first successor of the tree, and adds all other successors of the
#!  tree to the tree that is returned.
#!  If the tree is a leave, it returns an empty tree.
#!  If the tree is empty, it returns the tree itself.
#! @Returns a tree
#! @ChapterInfo Trees, Trees
DeclareOperation( "RemoveHead",
                  [ IsTree ] );

#! @Description
#!  Returns an empty tree.
#! @Returns a tree
#! @ChapterInfo Trees, Trees
DeclareOperation( "Tree",
                  [ ] );

#! @Description
#!  Returns a tree with argument <A>obj</A>.
#! @Returns a tree
#! @Arguments obj
#! @ChapterInfo Trees, Trees
DeclareOperation( "Tree",
                  [ IsObject ] );

#! @Description
#!  Adds the [list of] tree[s] <A>new_tree</A> as successor to the tree <A>tree</A>.
#! @Returns nothing
#! @Arguments tree,new_tree
#! @ChapterInfo Trees, Trees
DeclareOperation( "Add",
                  [ IsTree, IsTree ] );


DeclareOperation( "Add",
                  [ IsTree, IsList ] );

#! @Description
#!  Returns a list of the contents of the trees from the leave <A>sent</A>
#!  up to the content of the head of the tree.
#! @Returns a list
#! @Arguments sent
#! @ChapterInfo Trees, Trees
DeclareOperation( "ContentListFromSentinelToHead",
                  [ IsTree ] );

#! @Description
#!  Returns the contents of the nodes of the tree in post-order.
#! @Returns a list
#! @ChapterInfo Trees, Trees
DeclareOperation( "PostOrder",
                  [ IsTree ] );