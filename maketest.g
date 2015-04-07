LoadPackage( "ToricVarieties" );
LoadPackage( "IO_ForHomalg" );

HOMALG_IO.show_banners := false;

HOMALG_IO.suppress_PID := true;

HOMALG_IO.use_common_stream := true;

Read( "ListOfDocFiles.g" );
example_tree := ExtractExamples( DirectoriesPackageLibrary( "ToricVarieties", "doc" )[1]![1], "ToricVarieties.xml", list, 500 );
RunExamples( example_tree, rec( compareFunction := "uptowhitespace" ) );
GAPDocManualLab( "ToricVarieties" );
QUIT;
