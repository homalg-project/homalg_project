LoadPackage( "ToolsForHomalg" );

DeclareProperty( "IsPrintGraphTestObject",
                 IsObject );

attribute_graph := CreatePrintingGraph( IsObject and IsPrintGraphTestObject );

#FIXME: This syntax is shit.
AddRelationToGraph( attribute_graph, [ [ [ "IsProp1", "prop1", "all" ] ], [ [ "IsProp2", "prop2" ] ] ] );

AddRelationToGraph( attribute_graph, [ [ [ "IsProp3" ], [ "IsProp4", "all" ] ], [ [ "IsProp5", "prop5" ] ] ] );

InstallPrintFunctionsOutOfPrintingGraph( attribute_graph );

DeclareProperty( "IsProp1", IsObject );

DeclareProperty( "IsProp2", IsObject );

DeclareProperty( "IsProp3", IsObject );

DeclareProperty( "IsProp4", IsObject );

DeclareProperty( "IsProp5", IsObject );

S := SymmetricGroup( 2 );

SetIsPrintGraphTestObject( S, true );

SetIsProp1( S, true );

SetIsProp3( S, true );
