# SPDX-License-Identifier: GPL-2.0-or-later
# SCO: SCO - Simplicial Cohomology of Orbifolds
#
# This file is a script which compiles the package manual and prints overfull hbox warnings.
#
if fail = LoadPackage( "AutoDoc", "2025.12.19" ) then
    
    Error( "AutoDoc version 2025.12.19 or newer is required." );
    
fi;

AutoDoc( rec(
    dir := "doc_tmp/",
    gapdoc := rec(
        LaTeXOptions := rec(
            LateExtraPreamble := """
                % Many thanks to https://tex.stackexchange.com/questions/22466/how-to-convince-fancyvrb-to-give-overfull-warnings/534486#534486
                \makeatletter
                \def\FV@ListProcessLine#1{%
                  \hbox to \hsize{%
                    \kern\leftmargin
                    \hbox to \linewidth{%
                      \FV@LeftListNumber
                      \FV@LeftListFrame
                      \FancyVerbFormatLine{#1}\hfil % change \hss to \hfil
                      \FV@RightListFrame
                      \FV@RightListNumber}%
                    \hss}}
                \makeatother
            """,
        ),
    ),
    scaffold := rec(
        entities := rec( homalg := "homalg", CAP := "CAP" ),
        MainPage := false,
    ),
) );

QUIT;
