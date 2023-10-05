# SPDX-License-Identifier: GPL-2.0-or-later
# ExamplesForHomalg: Examples for the GAP Package homalg
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#

SetPackageInfo( rec(

PackageName := "ExamplesForHomalg",
Subtitle := "Examples for the GAP Package homalg",
Version := "2023.10-01",
Date := "2023-10-05",
License := "GPL-2.0-or-later",

Persons := [
  rec(
    FirstNames := "Mohamed",
    LastName := "Barakat",
    IsAuthor := true,
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
    FirstNames    := "Markus",
    LastName      := "Lange-Hegermann",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "markus.lange-hegermann@hs-owl.de",
    WWWHome       := "https://www.th-owl.de/eecs/fachbereich/team/markus-lange-hegermann/",
    PostalAddress := Concatenation( [
                       "Markus Lange-Hegermann\n",
                       "Hochschule Ostwestfalen-Lippe\n",
                       "Liebigstraße 87\n",
                       "32657 Lemgo\n",
                       "Germany" ] ),
    Place         := "Aachen",
    Institution   := "Hochschule Ostwestfalen-Lippe"
  ),
],

Status := "deposited",

# BEGIN URLS
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/homalg_project",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://homalg-project.github.io/pkg/ExamplesForHomalg",
PackageInfoURL  := "https://homalg-project.github.io/homalg_project/ExamplesForHomalg/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/homalg_project/ExamplesForHomalg/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/homalg_project/releases/download/ExamplesForHomalg-", ~.Version, "/ExamplesForHomalg-", ~.Version ),
# END URLS

ArchiveFormats := ".tar.gz .zip",

AbstractHTML := 
"The <span class=\"pkgname\">ExamplesForHomalg</span> package provides example scripts for the\
 <span class=\"pkgname\">homalg</span> package that can be used with several computer algebra systems",
PackageDoc := rec(
  BookName  := "ExamplesForHomalg",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Examples for the GAP Package homalg",
),


Dependencies := rec(
  GAP := ">= 4.12.1",
  NeededOtherPackages := [
                [ "MatricesForHomalg", ">= 2023.10-01" ],
                [ "HomalgToCAS", ">= 2023.08-01" ],
                [ "RingsForHomalg", ">= 2023.09-01" ],
                [ "Modules", ">= 2023.10-01" ],
                [ "homalg", ">= 2015.06.01" ],
                [ "GaussForHomalg", ">=2023.08-01" ],
                [ "GAPDoc", ">= 1.1" ] ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := []
                      
),

AvailabilityTest := function()
    return true;
  end,

TestFile := "tst/testall.g",

Keywords := [ "examples", "homalg" ],

AutoDoc := rec(
    TitlePage := rec(
        Copyright := Concatenation(
            "&copyright; 2008-2015 by Mohamed Barakat, Simon Goertzen, Markus Lange-Hegermann\n\n",
            "This package may be distributed under the terms and conditions ",
            "of the GNU Public License Version 2 or (at your option) any later version.\n"
            )
    )
),

));
