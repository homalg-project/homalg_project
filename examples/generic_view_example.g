LoadPackage( "ToolsForHomalg" );

DeclareProperty( "IsPrintGraphTestObject",
                 IsObject );

attribute_graph := CreatePrintingGraph( IsObject and IsPrintGraphTestObject );

#FIXME: This syntax is shit.
AddRelationToGraph( attribute_graph,
                    rec( Source := rec(
                                        Conditions := "IsProp1",
                                        PrintString := "prop1",
                                        TypeOfView := "ViewObj" ),
                         Range := rec(
                                       Conditions := "IsProp2",
                                       PrintString := "prop2" ) ) );

AddRelationToGraph( attribute_graph,
                    rec( Source := [ rec(
                                          Conditions := "IsProp3" ),
                                     rec(
                                          Conditions := "IsProp4",
                                          TypeOfView := "all",
                                          ComputeLevel := "all" ) ],
                         Range := rec(
                                       Conditions := "IsProp5",
                                       PrintString := "prop5" ) ) );

InstallPrintFunctionsOutOfPrintingGraph( attribute_graph );

DeclareProperty( "IsProp1", IsObject );

DeclareProperty( "IsProp2", IsObject );

DeclareProperty( "IsProp3", IsObject );

DeclareProperty( "IsProp4", IsObject );

DeclareProperty( "IsProp5", IsObject );

# InstallMethod( IsProp4,
#                [ IsObject ],
#                
#   function( arg )
#     return true;
# end );
# 
# S := SymmetricGroup( 2 );
# 
# SetIsPrintGraphTestObject( S, true );
# 
# SetIsProp1( S, true );
# 
# SetIsProp3( S, true );
