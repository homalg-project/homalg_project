LoadPackage( "AutoDoc" );
LoadPackage( "HomalgToCAS" );

dir := DirectoryCurrent( );
files := AUTODOC_FindMatchingFiles( dir,
    ["gap", "examples", "examples/doc" ],
    [ "g", "gi", "gd" ] );
files := List(files, x -> Concatenation("../", x));

example_tree := ExtractExamples( Directory("doc/"), "HomalgToCAS.xml", files, "All" );
RunExamples( example_tree, rec( compareFunction := "uptowhitespace" ) );

QUIT;
