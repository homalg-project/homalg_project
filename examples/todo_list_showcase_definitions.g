LoadPackage( "ToolsForHomalg" );


DeclareCategory( "IsToDoListTestObject",
                 IsObject );

DeclareRepresentation( "IsToDoListTestObjectRep",
                       IsToDoListTestObject and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfToDoListTestObjects",
        NewFamily( "TheFamilyOfToDoListTestObjects" ) );

BindGlobal( "TheTypeToDoListTestObject",
        NewType( TheFamilyOfToDoListTestObjects,
                IsToDoListTestObjectRep ) );

DeclareOperation( "ToDoListTestObject",
                  [ IsString ] );

DeclareOperation( "ToDoListTestObject",
                  [ IsString, IsToDoListTestObject ] );

DeclareProperty( "IsTypeA",
                 IsToDoListTestObject );

##
InstallMethod( ToDoListTestObject,
               "without arguments",
               [ IsString ],
               
  function( nam )
    local obj;
    
    obj := rec( name := nam );
    
    ObjectifyWithAttributes( obj, TheTypeToDoListTestObject );
    
    return obj;
    
end );

##
InstallMethod( ToDoListTestObject,
               "without arguments",
               [ IsString, IsToDoListTestObject ],
               
  function( nam, parent )
    local obj;
    
    obj := rec( name := nam );
    
    ObjectifyWithAttributes( obj, TheTypeToDoListTestObject );
    
    AddToToDoList( ToDoListEntryWithPointers( parent, "IsTypeA", true, obj, "IsTypeA", true ) );
    
    return obj;
    
end );

##
InstallMethod( ViewObj,
               "for test obj",
               [ IsToDoListTestObject ],
               
  function( obj )
    
    Print( Concatenation( "<", obj!.name, ">" ) );
    
end );

##
InstallMethod( Display,
               "for test obj",
               [ IsToDoListTestObject ],
               
  function( obj )
    
    Print( Concatenation( obj!.name, ".\n" ) );
    
end );

##
InstallMethod( \=,
               "for test obj",
               [ IsToDoListTestObject, IsToDoListTestObject ],
               
  IsIdenticalObj
  
);
