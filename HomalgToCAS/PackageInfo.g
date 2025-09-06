# SPDX-License-Identifier: GPL-2.0-or-later
# HomalgToCAS: A window to the outer world
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#

SetPackageInfo( rec(

PackageName := "HomalgToCAS",
Subtitle := "A window to the outer world",
Version := "2025.08-01",
Date := "2025-09-06",
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
    LastName      := "Breuer",
    FirstNames    := "Thomas",
    IsAuthor      := false,
    IsMaintainer  := false,
    Email         := "sam@math.rwth-aachen.de",
    WWWHome       := "http://www.math.rwth-aachen.de/~Thomas.Breuer/",
    PostalAddress := Concatenation( [
                       "Thomas Breuer\n",
                       "Lehrstuhl D fuer Mathematik, RWTH Aachen\n",
                       "Templergraben 64\n",
                       "52062 Aachen\n",
                       "Germany" ] ),
    Place         := "Aachen",
    Institution   := "RWTH Aachen University"
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
    LastName      := "Lübeck",
    FirstNames    := "Frank",
    IsAuthor      := false,
    IsMaintainer  := false,
    Email         := "frank.luebeck@math.rwth-aachen.de",
    WWWHome       := "http://www.math.rwth-aachen.de/~Frank.Luebeck/",
    PostalAddress := Concatenation( [
                       "Frank Lübeck\n",
                       "Lehrstuhl D fuer Mathematik, RWTH Aachen\n",
                       "Templergraben 64\n",
                       "52062 Aachen\n",
                       "Germany" ] ),
    Place         := "Aachen",
    Institution   := "RWTH Aachen University"
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
PackageWWWHome  := "https://homalg-project.github.io/pkg/HomalgToCAS",
PackageInfoURL  := "https://homalg-project.github.io/homalg_project/HomalgToCAS/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/homalg_project/HomalgToCAS/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/homalg_project/releases/download/HomalgToCAS-", ~.Version, "/HomalgToCAS-", ~.Version ),
# END URLS

ArchiveFormats := ".tar.gz .zip",

AbstractHTML := "The <span class=\"pkgname\">HomalgToCAS</span> package provides the first layer of abstraction \
 needed for <span class=\"pkgname\">homalg</span> to access external computer algebra systems",
PackageDoc := rec(
  BookName  := "HomalgToCAS",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "A window to the outer world",
),


Dependencies := rec(
  GAP := ">= 4.12.1",
  NeededOtherPackages := [
                [ "ToolsForHomalg", ">= 2023.11-01" ],
                [ "MatricesForHomalg", ">= 2023.08-01" ],
                [ "GAPDoc", ">= 1.0" ]
                ],
  SuggestedOtherPackages := [
                [ "IO", ">= 2.3" ],
  ],
  ExternalConditions := []
                      
),

AvailabilityTest := function()
    return true;
  end,

TestFile := "tst/testall.g",

Keywords := [ "homalgExternalObject", "CreateHomalgExternalRing", "HomalgExternalRingElement", "IsHomalgExternalMatrixRep", "LaunchCAS", "TerminateCAS", "homalgSendBlocking" ],

AutoDoc := rec(
    TitlePage := rec(
        Copyright := Concatenation(
            "&copyright; 2007-2015 by Mohamed Barakat, Thomas Breuer, Simon Görtzen, and Frank Lübeck.\n\n",
            "This package may be distributed under the terms and conditions ",
            "of the GNU Public License Version 2 or (at your option) any later version.\n"
            ),
        Acknowledgements := """
             We are very much indebted to Max Neunhöffer who provided the first
             piece of code around which the package &IO_ForHomalg; was built. The
             package &HomalgToCAS; provides a further abstraction layer preparing
             the communication.
                    """
    )
),

));
