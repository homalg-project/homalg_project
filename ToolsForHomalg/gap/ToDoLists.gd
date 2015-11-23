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

DeclareInfoClass( "InfoToDoList" );
SetInfoLevel( InfoToDoList, 1 );

#! @Description
#!  This is the category of ToDo-lists.
#!  Every ToDo-list is an object of this category,
#!  which basically contains the ToDo-lists.
#! @ChapterInfo ToDo-list, Category
DeclareCategory( "IsToDoList",
                 IsObject );

DeclareFilter( "HasSomethingToDo", IsObject );


##########################################
##
##  Properties & Attributes
##
##########################################

#! @Description
#!  Creates a new empty ToDo-list.
#! @Returns nothing
#! @ChapterInfo ToDo-list, Constructor
DeclareOperation( "NewToDoList",
                  [  ] );

#! @Description
#!  Gets a ToDo-list entry, which is a pair of a list of strings and a weak pointer object,
#!  and processes it. If the action was done, it returns true, if not, it returns false, and it returns
#!  fail if the action is not possible anymore due to deleted objects.
#! @Returns a boolean
#! @ChapterInfo ToDo-list, This is the magic
DeclareGlobalFunction( "Process_A_ToDo_List_Entry" );




##########################################
##
## Methods for all objects
##
##########################################

#! @Description
#!  Returns the ToDo-list of an object, or creates a new one.
#! @Returns A ToDo-list
#! @ChapterInfo ToDo-list, Methods for all objects
DeclareAttribute( "ToDoList",
                  IsObject );

#! @Description
#!  This is the magic! This attribute is never set. Creating an ToDo-list entry installs
#!  an ImmediateMethod for this attribute for the specific category of the object to which
#!  ToDo-list is added, and the filter the entry contains.
#!  It is then triggert if the filters become applicable, so the ToDo-list is processed
#! @Returns nothing
#! @Arguments A
#! @ChapterInfo ToDo-list, This is the magic
DeclareAttribute( "ProcessToDoList",
                  IsObject );

DeclareOperation( "ProcessToDoList_Real",
                  [ IsObject, IsObject ] );

#! @Chapter ToDo-list
#! @Section Proof tracking
#!  This is a way to track proofs from ToDoLists.
#!  Not only for debugging, but also for knowing how things work together.

#! @Description
#!  If the object <A>obj</A> has the attribute <A>name</A>,
#!  and its value is <A>val</A>, and the knowledge has
#!  been obtained trough ToDoList-entries,
#!  this method traces the way the property was set,
#!  and returns a tree which describes the full way of how the attribute became known.
#! @Returns a tree
#! @Arguments obj,name,val
#! @ChapterInfo ToDo-list, Proof tracking
DeclareOperation( "TraceProof",
                  [ IsObject, IsString, IsObject ] );


DeclareGlobalFunction( "ToolsForHomalg_ToDoList_TaceProof_RecursivePart" );

###########################################
##
## Tool Methods
##
###########################################

DeclareGlobalVariable( "TODO_LISTS" );

DeclareFilter( "CanHaveAToDoList", IsObject );

DeclareProperty( "MaintenanceMethodForToDoLists", IsObject );

#! @Description
#!  This operation activates ToDoLists for the argument.
#! @Returns nothing
#! @ChapterInfo ToDo-list, Maintainance
DeclareOperation( "ActivateToDoList",
                  [ IsObject ] );

#! @Description
#!  This operation activates ToDoLists for all objects.
#! @Returns nothing
#! @ChapterInfo ToDo-list, Maintainance
DeclareOperation( "ActivateToDoList",
                  [ ] );

#! @Description
#!  This operation deactivates ToDoLists for the argument.
#! @Returns nothing
#! @ChapterInfo ToDo-list, Maintainance
DeclareOperation( "DeactivateToDoList",
                  [ IsObject ] );

#! @Description
#!  This operation deactivates ToDoLists for all objects.
#!  Note that it is not possible to activate ToDoList for a single object
#!  while they are not activated.
#!  ToDoListEntries will yet be stored for all objects that can have ToDoLists.
#!  All objects created while ToDoLists are deactivated have by default no ToDoList.
#! @Returns nothing
#! @ChapterInfo ToDo-list, Maintainance
DeclareOperation( "DeactivateToDoList",
                  [ ] );

DeclareGlobalFunction( "TraceProof_Position" );

#! @Description
#!  Stores the result of Where( 100 ) in an entry
#!  if the entry is triggered. This is not activated
#!  by default, since it might slow down the system.
#! @Returns nothing
#! @ChapterInfo ToDo-list, Maintainance
DeclareGlobalFunction( "ActivateWhereInfosInEntries" );

#! @Description
#!  Deactives the storage of the result of Where( 100 )
#!  if an entry is triggered. This is the default.
#! @Returns nothing
#! @ChapterInfo ToDo-list, Maintainance
DeclareGlobalFunction( "DeactivateWhereInfosInEntries" );
