#
# 4ti2Interface
#
# This file runs package tests. It is also referenced in the package
# metadata in PackageInfo.g.
#

options := rec(
    exitGAP := true,
    testOptions := rec(
        compareFunction := "uptowhitespace"
    ),
);

LoadPackage( "4ti2Interface" );

TestDirectory( DirectoriesPackageLibrary( "4ti2Interface", "tst" ), options );

FORCE_QUIT_GAP( 1 ); # if we ever get here, there was an error
