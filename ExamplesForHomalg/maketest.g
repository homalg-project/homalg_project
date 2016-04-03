LoadPackage( "AutoDoc" );
LoadPackage( "ExamplesForHomalg" );
LoadPackage( "IO_ForHomalg" );
HOMALG_IO.show_banners := false;
HOMALG_IO.use_common_stream := true;

dir := DirectoryCurrent( );
files := AUTODOC_FindMatchingFiles( dir,
    ["gap", "examples", "examples/doc" ],
    [ "g", "gi", "gd" ] );
files := List(files, x -> Concatenation("../", x));

example_tree := ExtractExamples( Directory("doc/"), "ExamplesForHomalg.xml", files, "All" );
RunExamples( example_tree, rec( compareFunction := "uptowhitespace" ) );

QUIT;
