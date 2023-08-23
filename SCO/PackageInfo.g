# SPDX-License-Identifier: GPL-2.0-or-later
# SCO: SCO - Simplicial Cohomology of Orbifolds
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#

SetPackageInfo( rec(

PackageName := "SCO",
Subtitle := "SCO - Simplicial Cohomology of Orbifolds",
Version := "2023.08-01",
Date := "2023-08-23",
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
    WWWHome := "https://mohamed-barakat.github.io",
    Email := "mohamed.barakat@uni-siegen.de",
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
PackageWWWHome  := "https://homalg-project.github.io/pkg/SCO",
PackageInfoURL  := "https://homalg-project.github.io/homalg_project/SCO/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/homalg_project/SCO/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/homalg_project/releases/download/SCO-", ~.Version, "/SCO-", ~.Version ),
# END URLS

ArchiveFormats := ".tar.gz .zip",

AbstractHTML := 
"The <span class=\"pkgname\">SCO</span> package provides functionality to compute simplicial cohomology of orbifolds",
PackageDoc := rec(
  BookName  := "SCO",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "SCO - Simplicial Cohomology of Orbifolds",
),


Dependencies := rec(
  GAP := ">= 4.12.1",
  NeededOtherPackages := [
                   [ "GAPDoc", ">= 1.0" ],
                   [ "MatricesForHomalg", ">= 2023.08-01" ],
                   [ "Modules", ">= 2011.06.29" ],
                   ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := []
),

AvailabilityTest := function()
    return true;
  end,

TestFile := "tst/testall.g",

Keywords := ["homology", "cohomology", "orbifold", "groupoid", "simplicial", "triangulation" ],

AutoDoc := rec(
    TitlePage := rec(
        Copyright := Concatenation(
            "&copyright; 2007-2011 by Simon Goertzen<P/>\n\n",
            "This package may be distributed under the terms and conditions ", 
            "of the GNU Public License Version 2 or (at your option) any later version.\n"
            ), 
        Abstract := """
             This document explains the primary uses of the &SCO;
             package. Included in this manual is a documented list of
             the most important methods and functions you will
             need. For the theoretical basis of this package please
             refer to my diploma thesis and the corresponding paper
             (work in progress; <Cite Key="Goe"/>).
                    """, 
        Acknowledgements := """
             The &SCO; package would not have been possible
             without the theoretical work by I. Moerdijk and D. A. Pronk
             concerning  simplicial cohomology of orbifolds <Cite
             Key="mps"/>. Many thanks to these two, as well as Mohamed Barakat
             and the Lehrstuhl B für Mathematik at RWTH Aachen University in
             general. It should be noted that &SCO; in its current functionality
             is dependent on the &GAP; package &homalg; by M. Barakat <Cite
             Key="homalg-package"/>, as it relies on &homalg; to do the actual
             computations. This manual was created with the help of the &GAPDoc;
             package by M. Neunhöffer and F. Lübeck.
               """
    )
),

));
