# SPDX-License-Identifier: GPL-2.0-or-later
# GradedRingForHomalg: Endow Commutative Rings with an Abelian Grading
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "GradedRingForHomalg",
Subtitle := "Endow Commutative Rings with an Abelian Grading",
Version := "2024.07-01",
Date := "2024-07-09",
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
    LastName      := "Kirschmer",
    FirstNames    := "Markus",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "markus.kischmer@math.rwth-aachen.de",
    WWWHome       := "http://www.math.rwth-aachen.de/~Markus.Kirschmer/",
    PostalAddress := Concatenation( [
                       "Markus Kirschmer\n",
                       "Lehrstuhl D fuer Mathematik, RWTH Aachen\n",
                       "Templergraben 64\n",
                       "52062 Aachen\n",
                       "Germany" ] ),
    Place         := "Aachen",
    Institution   := "RWTH Aachen University"
  ),
  rec(
    LastName      := "Jambor",
    FirstNames    := "Sebastian",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "sebastian.jambor@rwth-aachen.de",
    WWWHome       := "http://wwwb.math.rwth-aachen.de/~sebastian/",
    PostalAddress := Concatenation( [
                       "Sebastian Jambor\n",
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
  rec(
    LastName      := "Robertz",
    FirstNames    := "Daniel",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "daniel@momo.math.rwth-aachen.de",
    WWWHome       := "http://wwwb.math.rwth-aachen.de/~daniel/",
    PostalAddress := Concatenation( [
                       "Daniel Robertz\n",
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
PackageWWWHome  := "https://homalg-project.github.io/pkg/GradedRingForHomalg",
PackageInfoURL  := "https://homalg-project.github.io/homalg_project/GradedRingForHomalg/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/homalg_project/GradedRingForHomalg/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/homalg_project/releases/download/GradedRingForHomalg-", ~.Version, "/GradedRingForHomalg-", ~.Version ),
# END URLS

ArchiveFormats := ".tar.gz .zip",

AbstractHTML := "This package is part of the homalg-project and manages graded rings.",

PackageDoc := rec(
  BookName  := "GradedRingForHomalg",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Endow Commutative Rings with an Abelian Grading",
),


Dependencies := rec(
  GAP := ">= 4.12.1",
  NeededOtherPackages := [
                   [ "MatricesForHomalg", ">= 2023.08-01" ],
                   [ "HomalgToCAS", ">= 2023.08-01" ],
                   [ "RingsForHomalg", ">= 2023.08-01" ],
                   [ "Modules", ">= 2023.08-01" ],
                   [ "homalg", ">=2011.08.16" ],
                   [ "GAPDoc", ">= 1.0" ] ],
  SuggestedOtherPackages := [
                   [  "NConvex", "2020.03.02" ],
                   [  "4ti2Interface", "2019.09.03" ] ],
  ExternalConditions := []
                      
),

AvailabilityTest := function()
    return true;
  end,

TestFile := "tst/testall.g",

Keywords := [ "homological algebra", "graded ring" ]

));
