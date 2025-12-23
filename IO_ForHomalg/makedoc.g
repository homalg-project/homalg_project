# SPDX-License-Identifier: GPL-2.0-or-later
# IO_ForHomalg: IO capabilities for the homalg project
#
# This file is a script which compiles the package manual.
#
if fail = LoadPackage( "AutoDoc", "2025.12.19" ) then
    
    Error( "AutoDoc version 2025.12.19 or newer is required." );
    
fi;

AutoDoc( rec(
    extract_examples := rec(
        units := "Single",
    ),
    gapdoc := rec(
        LaTeXOptions := rec(
            LateExtraPreamble := """
            """,
        ),
    ),
    scaffold := rec(
        entities := rec( homalg := "homalg", CAP := "CAP" ),
        MainPage := false,
    ),
) );

QUIT;
