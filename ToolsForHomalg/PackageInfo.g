# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHomalg: Special methods and knowledge propagation tools
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "ToolsForHomalg",
Subtitle := "Special methods and knowledge propagation tools",
Version := "2025.05-01",
Date := "2025-05-02",
License := "GPL-2.0-or-later",

Persons := [
  rec(
    FirstNames := "Mohamed",
    LastName := "Barakat",
    IsAuthor := true,
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
  rec(
    FirstNames := "Sebastian",
    LastName := "Gutsche",
    IsAuthor := true,
    IsMaintainer := true,
    WWWHome := "https://sebasguts.github.io",
    Email := "gutsche@mathematik.uni-siegen.de",
    PostalAddress := Concatenation(
               "Department Mathematik\n",
               "Universität Siegen\n",
               "Walter-Flex-Straße 3\n",
               "57072 Siegen\n",
               "Germany" ),
    Place := "Siegen",
    Institution := "University of Siegen",
  ),
  rec(
    LastName      := "Lange-Hegermann",
    FirstNames    := "Markus",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "markus.lange.hegermann@rwth-aachen.de",
    WWWHome       := "http://wwwb.math.rwth-aachen.de/~markus/",
    PostalAddress := Concatenation( [
                       "Markus Lange-Hegermann\n",
                       "Lehrstuhl B fuer Mathematik, RWTH Aachen\n",
                       "Templergraben 64\n",
                       "52062 Aachen\n",
                       "Germany" ] ),
    Place         := "Aachen",
    Institution   := "RWTH Aachen University"
  ),
  
],

Status := "deposited",

# BEGIN URLS
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/homalg_project",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://homalg-project.github.io/pkg/ToolsForHomalg",
PackageInfoURL  := "https://homalg-project.github.io/homalg_project/ToolsForHomalg/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/homalg_project/ToolsForHomalg/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/homalg_project/releases/download/ToolsForHomalg-", ~.Version, "/ToolsForHomalg-", ~.Version ),
# END URLS

ArchiveFormats := ".tar.gz .zip",

AbstractHTML := 
  "The <span class=\"pkgname\">ToolsForHomalg</span> package provides GAP extensions for the homalg project",




PackageDoc := rec(
  BookName  := "ToolsForHomalg",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Special methods and knowledge propagation tools",
),


Dependencies := rec(
  GAP := ">= 4.12.1",
  NeededOtherPackages := [],
  SuggestedOtherPackages := [],
  ExternalConditions := []
                      
),

AvailabilityTest := function()
    return true;
  end,


TestFile := "tst/testall.g",

Keywords := [  ]

));
