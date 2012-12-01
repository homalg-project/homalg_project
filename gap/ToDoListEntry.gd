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

##################################
##
## Methods and properties
##
##################################

NewFilter( "IsDone" );

NewFilter( "PreconditionsDefinitelyNotFulfilled" );

DeclareOperation( "SourcePart",
                  [ IsToDoListEntry ] );

DeclareOperation( "TargetPart",
                  [ IsToDoListEntry ] );

DeclareOperation( "ProcessAToDoListEntry",
                  [ IsToDoListEntry ] );

DeclareOperation( "AreCompatible",
                  [ IsToDoListEntry, IsToDoListEntry ] );

DeclareOperation( "ToDoListEntryWithWeakPointers",
                  [ IsObject, IsString, IsObject, IsObject, IsString, IsObject ] );

DeclareOperation( "ToDoListEntryWithPointers",
                  [ IsObject, IsString, IsObject, IsObject, IsString, IsObject ] );

DeclareOperation( "ToDoListEntryForEquivalentProperties",
                  [ IsObject, IsString, IsObject, IsString ] );

DeclareOperation( "JoinToDoListEntries",
                  [ IsList ] );

DeclareAttribute( "GenesisOfToDoListEntry",
                  IsToDoListEntry );
