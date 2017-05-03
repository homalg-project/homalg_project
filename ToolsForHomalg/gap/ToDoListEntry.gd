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

DeclareFilter( "HasSetAttributeOfObject", IsToDoListEntry );

DeclareProperty( "RemoveContrapositions", IsToDoListEntry );

DeclareFilter( "PreconditionsDefinitelyNotFulfilled", IsToDoListEntry );


#! @Description
#!  Adds the ToDo-list entry <A>E</A> to the
#!  ToDo-lists of it's source objects and creates a new one, if this is needed.
#!  This function might be called with lists of entries
#! @Arguments E
#! @ChapterInfo ToDo-list, ToDo-list entries
DeclareOperation( "AddToToDoList",
                  [ IsToDoListEntry ] );


DeclareOperation( "AddToToDoList",
                  [ IsList ] );

#! @Description
#!  Returns the a list of source parts of the ToDo-list entry <A>entry</A>.
#!  This is a triple of an object, a name of a filter/attribute, and a value to which
#!  the attribute has to be set to activate the entry
#! @Returns a list
#! @Arguments entry
#! @ChapterInfo ToDo-list, ToDo-list entries
DeclareOperation( "SourcePart",
                  [ IsToDoListEntry ] );

#! @Description
#!  Returns the target part of the ToDo-list entry <A>entry</A>.
#!  This is a triple of an object, a name of a filter/attribute, and a value to which the
#!  specific filter/attribute should be set.
#!  The third entry of the list might also be a function to which return value the
#!  attribute is set.
#! @Returns a list
#! @Arguments entry
#! @ChapterInfo ToDo-list, ToDo-list entries
DeclareOperation( "TargetPart",
                  [ IsToDoListEntry ] );

#! @Description
#!  Processes a ToDo-list entry, i.e. sets the information given in TargetPart
#!  if the definitions in SourcePart are fulfilled.
#!  Returns a function if the entry could be processed, false if not, and fail if
#!  SourcePart or TargetPart weren't availible anymore.
#! @Returns a boolean
#! @ChapterInfo ToDo-list, ToDo-list entries
DeclareOperation( "ProcessAToDoListEntry",
                  [ IsToDoListEntry ] );

#! @Description
#!  The first argument must be a list consisting of two, three or four-tuples
#!  where the first entry must be the object to which the attribute
#!  given as a string in the second entry must be known to process this entry.
#!  The second entry can also be a list of strings, in that case all the
#!  attributes given as names must be known.
#!  Also, in this case, only two entries in this tuple are allowed.
#!  The third part can be a value or a list, consisting of a function followed
#!  by arguments which will be computed by the time the attribute given
#!  as second entry becomes known to the first entry.
#!  If the second part is only a string, and there is a third entry in the tuple
#!  the attribute is compared to the third entry.
#!  One can set a comparating function as fourth entry, which must
#!  take two entries and return false or true.
#!  If the value of the attribute matches the (computed)
#!  value in the third entry for all members of the list in the first argument
#!  the attribute given as third argument, also by name, of the second argument
#!  is set to the value of the fourth argument.
#!  This can also be a list which has to be computed, or a function,
#!  which retun value is used in this case.
#! @Returns a ToDoListEntry
#! @ChapterInfo ToDo-list, ToDo-list entries
DeclareOperation( "ToDoListEntry",
                  [ IsList, IsObject, IsString, IsObject ] );

#! @Description
#!  The first argument is a list of three-tubles like above.
#!  Once all preconditions become fulfilled
#!  the function given as second argument is launched.
#! @Returns a ToDoListEntry
#! @ChapterInfo ToDo-list, ToDo-list entries
DeclareOperation( "ToDoListEntry",
                  [ IsList, IsFunction ] );

#! @Description
#!  If the given value of the target part is the return value of a function
#!  this command sets the target value of the entry to a function.
#!  This is done to keep proof tracking availible.
#! @Returns nothing
#! @Arguments entry,value
#! @ChapterInfo ToDo-list, ToDo-list entries
DeclareOperation( "SetTargetValueObject",
                  [ IsToDoListEntry, IsObject ] );

#! @Description
#!  If the target object, i.e. the first entry of the target part, was given as
#!  a function, this method can set this entry to the return value computed in
#!  ProcessToDoListEntry. This happens atomatically, do not worry about it.
#! @Returns nothing
#! @Arguments entry,obj
#! @ChapterInfo ToDo-list, ToDo-list entries
DeclareOperation( "SetTargetObject",
                  [ IsToDoListEntry, IsObject ] );

#! @Description
#!  Creates a ToDoListEntry which also installs a contraposition.
#!  The arguments <A>source_prop</A> and <A>target</A> need to be
#!  strings which name a property, and <A>sval</A> and
#!  <A>tval</A> need to be
#!  boolean values, i.e. true or false.
#! @Returns a ToDoListEntry
#! @Arguments sobj,source_prop,sval,tobj,target,tval
#! @ChapterInfo ToDo-list, ToDo-list entries
DeclareOperation( "ToDoListEntryWithContraposition",
                  [ IsObject, IsString, IsBool, IsObject, IsString, IsBool ] );

#! @Description
#!  Has to be set to a string, which describes the reason for the conclusion.
#!  If the ToDo-list entry is displayed, the given string will be displayed with a
#!  because before it.
#! @Returns a list
#! @ChapterInfo ToDo-list, ToDo-list entries
DeclareAttribute( "DescriptionOfImplication",
                  IsToDoListEntry );

#! @Description
#!  Creates a ToDoListEntry for two equal
#!  attributes, which means that both values of the two attributes
#!  will be propagated in both directions.
#! @Returns a ToDoListEntry
#! @ChapterInfo ToDo-list, ToDo-list entries
DeclareOperation( "ToDoListEntryForEqualAttributes",
                  [ IsObject, IsString, IsObject, IsString ] );

#! @Description
#!  Creates a ToDoListEntry for two equivalent
#!  attributes, which means that both values of the two attributes
#!  will be propagated in both directions.
#!  Please note that this one does NOT implement contrapositions.
#! @Returns a ToDoListEntry
#! @ChapterInfo ToDo-list, ToDo-list entries
DeclareOperation( "ToDoListEntryForEquivalentAttributes",
                  [ IsObject, IsString, IsObject, IsObject, IsString, IsObject ] );


DeclareAttribute( "TrowProofTrackingObject",
                  IsToDoListEntry );

DeclareGlobalFunction( "ToDoLists_Process_Entry_Part" );

DeclareOperation( "ToDoLists_Move_To_Target_ToDo_List",
                  [ IsToDoListEntry ] );

DeclareOperation( "ToDoList_Is_Sane_Entry",
                  [ IsToDoListEntry ] );

DeclareGlobalFunction( "ToolsForHomalg_ProcessToDoListEquivalencesAndContrapositions" );

DeclareGlobalFunction( "ToolsForHomalg_RemoveContrapositionFromBothToDoLists" );

DeclareGlobalFunction( "ToolsForHomalg_CheckASourcePart" );
