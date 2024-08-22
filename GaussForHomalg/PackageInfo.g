# SPDX-License-Identifier: GPL-2.0-or-later
# GaussForHomalg: Gauss functionality for the homalg project
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#

SetPackageInfo( rec(

PackageName := "GaussForHomalg",
Subtitle := "Gauss functionality for the homalg project",
Version := "2024.08-01",
Date := "2024-08-22",
License := "GPL-2.0-or-later",

Persons := [
  rec( 
    FirstNames    := "Simon",
    LastName      := "Görtzen",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "simon.goertzen@rwth-aachen.de",
    WWWHome       := "https://www.linkedin.com/in/simongoertzen/",
    PostalAddress := Concatenation( [
                       "Simon Görtzen\n",
                       "Lehrstuhl B fuer Mathematik, RWTH Aachen\n",
                       "Templergraben 64\n",
                       "52062 Aachen\n",
                       "Germany" ] ),
    Place         := "Aachen",
    Institution   := "RWTH Aachen University"
  ),
  rec(
    FirstNames := "Mohamed",
    LastName := "Barakat",
    IsAuthor := false,
    IsMaintainer := true,
    Email := "mohamed.barakat@uni-siegen.de",
    WWWHome := "https://mohamed-barakat.github.io",
    PostalAddress := Concatenation(
               "Walter-Flex-Str. 3\n",
               "57072 Siegen\n",
               "Germany" ),
    Place := "Siegen",
    Institution := "University of Siegen",
  ),
],

Status := "deposited",

# BEGIN URLS
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/homalg_project",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://homalg-project.github.io/pkg/GaussForHomalg",
PackageInfoURL  := "https://homalg-project.github.io/homalg_project/GaussForHomalg/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/homalg_project/GaussForHomalg/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/homalg_project/releases/download/GaussForHomalg-", ~.Version, "/GaussForHomalg-", ~.Version ),
# END URLS

ArchiveFormats := ".tar.gz .zip",

AbstractHTML := 
"The <span class=\"pkgname\">GaussForHomalg</span> package provides Gauss functionality for\
 <span class=\"pkgname\">homalg</span> using the package <span class=\"pkgname\">Gauss</span>",
PackageDoc := rec(
  BookName  := "GaussForHomalg",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Gauss functionality for the homalg project",
),


Dependencies := rec(
  GAP := ">= 4.12.1",
  NeededOtherPackages := [
                [ "ToolsForHomalg", ">= 2023.11-01" ],
                [ "Gauss", ">= 2021.04-01" ],
                [ "MatricesForHomalg", ">= 2023.10-01" ],
                [ "GAPDoc", ">= 1.0" ] ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := []
                      
),

AvailabilityTest := function()
    return true;
  end,

TestFile := "tst/testall.g",

Keywords := ["GaussForHomalg", "homalg", "Gauss" ],

AutoDoc := rec(
    TitlePage := rec(
        Copyright := Concatenation(
            "&copyright; 2007-2013 by Simon Goertzen<P/>\n\n",
            "This package may be distributed under the terms and conditions ", 
            "of the GNU Public License Version 2 or (at your option) any later version.\n"
            ), 
        Abstract := Concatenation( 
            "This document explains the primary uses of the &GaussForHomalg; package. ", 
            "Included in this manual is a documented list of ",  
            "the most important methods and functions you will need.",
            "<P/>\n"
            ), 
        Acknowledgements := Concatenation( 
            "Many thanks to Mohamed Barakat ",
            "and the Lehrstuhl B für Mathematik at RWTH Aachen University in ",
            "general for their support. It should be noted that &GaussForHomalg; ",
            "is dependant on the &GAP; &MatricesForHomalg; package by M. Barakat et al. ",
            "<Cite Key=\"homalg-package\"/>, as well as the &Gauss; package by myself ",
            "<Cite Key=\"Gauss\"/>. This should be clear as &GaussForHomalg; presents a ",
            "link between these two packages. ",
            "This manual was created with the help of the &GAPDoc; ",
            "package by M. Neunhöffer and F. Lübeck <Cite Key=\"GAPDoc\"/>."
            )
    )
),

));
