Read( "todo_list_showcase_definitions.g" );

A := ToDoListTestObject( "A" );

B := ToDoListTestObject( "B", A );

C := ToDoListTestObject( "C", B );

D := ToDoListTestObject( "D" );

G := ToDoListTestObject( "G" );

F := ToDoListTestObject( "F" );

AddToToDoList( ToDoListEntryWithListOfSources( [ [ D, "IsTypeA", true ], [ G, "IsTypeA", true ] ], F, "IsTypeA", true ) );

H := ToDoListTestObject( "H" );

AddToToDoList( ToDoListEntryWhichLaunchesAFunction( [ [ H, "IsTypeA", true ], [ F, "IsTypeA", true ] ], function() Print( "Hallo" ); end ) );