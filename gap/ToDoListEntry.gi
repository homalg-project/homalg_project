#############################################################################
##
##  ToDoListEntry.gi                                 ToolsForHomalg package
##
##  Copyright 2007-2012, Mohamed Barakat, University of Kaiserslautern
##                       Sebastian Gutsche, RWTH-Aachen University
##                  Markus Lange-Hegermann, RWTH-Aachen University
##
##  Entries for ToDo-Lists.
##
#############################################################################

DeclareRepresentation( "IsToDoListEntryRep",
                       IsToDoListEntry and IsAttributeStoringRep );

DeclareRepresentation( "IsToDoListEntryWithWeakPointersRep",
                       IsToDoListEntryRep );

DeclareRepresentation( "IsToDoListEntryWithPointersRep",
                       IsToDoListEntryRep );

DeclareRepresentation( "IsToDoListEntryForEquivalentPropertiesRep",
                       IsToDoListEntryRep );

BindGlobal( "TheFamilyOfToDoListEntries",
        NewFamily( "TheFamilyOfToDoListEntries" ) );

BindGlobal( "TheTypeToDoListEntryWithWeakPointers",
        NewType( TheFamilyOfToDoListEntries,
                IsToDoListEntryWithWeakPointersRep ) );

BindGlobal( "TheTypeToDoListEntryWithPointers",
        NewType( TheFamilyOfToDoListEntries,
                IsToDoListEntryWithPointersRep ) );

BindGlobal( "TheTypeToDoListEntryForEquivalentProperties ",
        NewType( TheFamilyOfToDoListEntries,
                IsToDoListEntryForEquivalentPropertiesRep ) );