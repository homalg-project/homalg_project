# SPDX-License-Identifier: GPL-2.0-or-later
# Modules: A homalg based package for the Abelian category of finitely presented modules over computable rings
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#

SetPackageInfo( rec(

PackageName := "Modules",
Subtitle := "A homalg based package for the Abelian category of finitely presented modules over computable rings",
Version := "2024.12-01",
Date := "2024-12-22",
License := "GPL-2.0-or-later",

Persons := [
  rec(
    LastName      := "Bächler",
    FirstNames    := "Thomas",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "thomas@momo.math.rwth-aachen.de",
    WWWHome       := "http://wwwb.math.rwth-aachen.de/~thomas/",
    PostalAddress := Concatenation( [
                       "Thomas Bächler\n",
                       "Lehrstuhl B für Mathematik\n",
                       "RWTH Aachen\n",
                       "Templergraben 64\n",
                       "52062 Aachen\n",
                       "Germany" ] ),
    Place         := "Aachen",
    Institution   := "RWTH Aachen"
  ),
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
    LastName      := "Diebold",
    FirstNames    := "Florian",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "diebold@mathematik.uni-kl.de",
    PostalAddress := Concatenation( [
                       "Department of Mathematics\n",
                       "University of Kaiserslautern\n",
                       "67653 Kaiserslautern\n",
                       "Germany" ] ),
    Place         := "Kaiserslautern",
    Institution   := "University of Kaiserslautern"
  ),
  rec(
    FirstNames := "Sebastian",
    LastName := "Gutsche",
    IsAuthor := true,
    IsMaintainer := false,
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
  rec(
    LastName      := "Wagh",
    FirstNames    := "Vinay",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "waghoba@gmail.com",
    WWWHome       := "http://www.iitg.ernet.in/vinay.wagh/",
    PostalAddress := Concatenation( [
                       "E-102, Department of Mathematics,\n",
                       "Indian Institute of Technology Guwahati,\n",
                       "Guwahati, Assam, India.\n",
                       "PIN: 781 039.\n",
                       "India" ] ),
    Place         := "Guwahati",
    Institution   := "Indian Institute of Technology Guwahati"
  ),
  
],

Status := "deposited",

# BEGIN URLS
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/homalg_project",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://homalg-project.github.io/pkg/Modules",
PackageInfoURL  := "https://homalg-project.github.io/homalg_project/Modules/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/homalg_project/Modules/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/homalg_project/releases/download/Modules-", ~.Version, "/Modules-", ~.Version ),
# END URLS

ArchiveFormats := ".tar.gz .zip",

AbstractHTML := 
  "The <span class=\"pkgname\">Modules</span> package provides ring independent homological algebra functionality for the abelian category of finitely presented modules over computable rings",
PackageDoc := rec(
  BookName  := "Modules",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "A homalg based package for the Abelian category of finitely presented modules over computable rings",
),


Dependencies := rec(
  GAP := ">= 4.12.1",
  NeededOtherPackages := [
                   [ "MatricesForHomalg", ">=2023.10-01" ],
                   [ "ToolsForHomalg", ">=2013.04.12" ],
                   [ "homalg", ">=2022.02-01" ],
                   [ "GaussForHomalg", ">=2023.08-01" ],
                   [ "GAPDoc", ">= 1.0" ] ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := []
                      
),

AvailabilityTest := function()
    return true;
  end,

TestFile := "tst/testall.g",

Keywords := ["modules", "module homomorphisms", "functor", "ext", "tor"],

AutoDoc := rec(
    TitlePage := rec(
        Copyright := Concatenation(
            "&copyright; 2007-2015 by Mohamed Barakat and Markus Lange-Hegermann\n\n",
            "This package may be distributed under the terms and conditions ", 
            "of the GNU Public License Version 2 or (at your option) any later version.\n"
            ), 
        Acknowledgements := "We are very much indebted to Alban Quadrat."
    )
),

));
