LoadPackage( "AutoDoc" );
LoadPackage( "Modules" );

dir := DirectoriesPackageLibrary("Modules","");
# files with relative paths to the package directory
files := AUTODOC_FindMatchingFiles( dir,
    ["gap", "examples", "examples/doc" ],
    [ "g", "gi", "gd" ] );
# files with full paths
files := List(files, x -> Filename(dir,x));

docdir := DirectoriesPackageLibrary("Modules","doc");
example_tree := ExtractExamples( docdir, "ModulesForHomalg.xml", files, "All" );
testresult := RunExamples( example_tree, rec( compareFunction := "uptowhitespace" ) );

if testresult then
  Print("#I  No errors detected while testing\n");
  QUIT_GAP(0);
else
  Print("#I  Errors detected while testing\n");
  QUIT_GAP(1);
fi;
