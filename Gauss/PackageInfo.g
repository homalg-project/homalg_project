# SPDX-License-Identifier: GPL-2.0-or-later
# Gauss: Extended Gauss functionality for GAP
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#

SetPackageInfo( rec(

PackageName := "Gauss",
Subtitle := "Extended Gauss functionality for GAP",
Version := "2024.11-01",
Date := "2024-12-03",
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
  rec(
    FirstNames := "Sebastian",
    LastName := "Gutsche",
    IsAuthor := false,
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
],

Status := "deposited",

# BEGIN URLS
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/homalg_project",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://homalg-project.github.io/pkg/Gauss",
PackageInfoURL  := "https://homalg-project.github.io/homalg_project/Gauss/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/homalg_project/Gauss/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/homalg_project/releases/download/Gauss-", ~.Version, "/Gauss-", ~.Version ),
# END URLS

ArchiveFormats := ".tar.gz .zip",

AbstractHTML := 
"The <span class=\"pkgname\">Gauss</span> package provideds extended Gauss functionality for <span class=\"pkgname\">GAP</span>",
PackageDoc := rec(
  BookName  := "Gauss",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Extended Gauss functionality for GAP",
),

Dependencies := rec(
  GAP := ">= 4.12.1",
  NeededOtherPackages := [ ],
  SuggestedOtherPackages := [ [ "GAPDoc", ">= 1.0" ] ],
  ExternalConditions := []
                      
),

AvailabilityTest := function()
  if not IsKernelExtensionAvailable("gauss") then
    LogPackageLoadingMessage( PACKAGE_INFO, "Gauss C-module was not compiled!", "Gauss" );
    LogPackageLoadingMessage( PACKAGE_INFO, "Gauss will work, but slower.", "Gauss" );
  fi;
  return true;
end,

TestFile := "tst/testall.g",

Keywords := ["Gauss", "RREF", "sparse" ],

AutoDoc := rec(
    TitlePage := rec(
        Copyright := Concatenation(
            "&copyright; 2007-2013 by Simon Goertzen<P/>\n\n",
            "This package may be distributed under the terms and conditions ", 
            "of the GNU Public License Version 2 or (at your option) any later version.\n"
            ), 
        Abstract := Concatenation( 
            "This document explains the primary uses of the &Gauss; package. ", 
            "Included is a documented list of the most important methods ",  
            "and functions needed to work with sparse matrices and the ",  
            "algorithms provided by the &Gauss; package. ",  
            "<P/>\n"
            ), 
        Acknowledgements := Concatenation( 
            "The &Gauss; package would not have been possible without the helpful contributions by ",
            "<List><Item>Max Neunhöffer, University of St Andrews, and</Item>", 
            "<Item>Mohamed Barakat, Lehrstuhl B für Mathematik, RWTH Aachen.</Item></List>",
            "Many thanks to these two and the Lehrstuhl B für Mathematik in general. ",
            "It should be noted that the &GAP; algorithms for ",
            "<C>SemiEchelonForm</C> and other methods formed an important and ",
            "informative basis for the development of the extended Gaussian ",
            "algorithms. This manual was created with the help of the &GAPDoc; ",
            "package by F. Lübeck and M. Neunhöffer <Cite Key=\"GAPDoc\"/>."
            )
    )
),

));
