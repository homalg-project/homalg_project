Read( "todo_list_showcase_definitions.g" );

A := ToDoListTestObject( "A" );

B := ToDoListTestObject( "B", A );

C := ToDoListTestObject( "C", B );

D := ToDoListTestObject( "D" );

G := ToDoListTestObject( "G" );

F := ToDoListTestObject( "F" );

AddToToDoList( ToDoListEntry( [ [ D, "IsTypeA", [ IsObject, D ] ], [ G, "IsTypeA", true ] ], F, "IsTypeA", true ) );

H := ToDoListTestObject( "H" );

AddToToDoList( ToDoListEntry( [ [ H, "IsTypeA", true ], [ F, "IsTypeA", true ] ], function() Print( "Hallo" ); end ) );

K := ToDoListTestObject( "K" );

L := ToDoListTestObject( "L" );

entry := ToDoListEntryForEqualAttributes( L, "IsTypeA", K, "IsTypeA" );

SetDescriptionOfImplication( entry, "Hallo" );

AddToToDoList( entry );

M := ToDoListTestObject( "M" );
N := ToDoListTestObject( "N" );
O := ToDoListTestObject( "O" );

ToDoListEntryBlueprint( IsTypeB, [ [ ToDoList_this_object, "IsTypeA", true ] ], [ function() Print( "Hallo" ); end ] );
