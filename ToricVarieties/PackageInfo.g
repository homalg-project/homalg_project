SetPackageInfo( rec(

PackageName := "ToricVarieties",

Subtitle := "A package to handle toric varieties",

Version :=  Maximum( [
  "2018.10.12", ## Sebas' version
## this line prevents merge conflicts
  "2015.03.31", ## Mohamed's version
## this line prevents merge conflicts
  "2017.03.31", ## Martins version
## this line prevents merge conflicts
  "2015.11.06", ## Homepage update version, to be removed
] ),

Date := ~.Version{[ 1 .. 10 ]},
Date := Concatenation( ~.Date{[ 9, 10 ]}, "/", ~.Date{[ 6, 7 ]}, "/", ~.Date{[ 1 .. 4 ]} ),

License := "GPL-2.0-or-later",

Persons := [
rec(
    LastName      := "Gutsche",
    FirstNames    := "Sebastian",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "sebastian.gutsche@rwth-aachen.de",
    WWWHome       := "http://wwwb.math.rwth-aachen.de/~gutsche/",
    PostalAddress := Concatenation( [
                       "Sebastian Gutsche\n",
                       "Lehrstuhl B fuer Mathematik, RWTH Aachen\n",
                       "Templergraben 64\n",
                       "52062 Aachen\n",
                       "Germany" ] ),
    Place         := "Aachen",
    Institution   := "RWTH Aachen University"
  ),
rec(
    LastName      := "Bies",
    FirstNames    := "Martin",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "martin.bies@alumni.uni-heidelberg.de",
    PostalAddress := Concatenation( [
                        "Physique Théorique et Mathématique \n",
                        "Université Libre de Bruxelles \n",
                        "Campus Plaine - CP 231 \n",
                        "Building NO - Level 6 - Office O.6.111 \n",
                        "1050 Brussels \n",
                        "Belgium" ] ), 
    Place         := "Brussels",
    Institution   := "ULB Brussels"
  ),
],

Status := "deposited",
PackageWWWHome := "http://homalg-project.github.io/homalg_project/ToricVarieties/",
ArchiveFormats := ".tar.gz .zip",
ArchiveURL     := Concatenation( "https://github.com/homalg-project/homalg_project/releases/download/ToricVarieties-", ~.Version, "/ToricVarieties-", ~.Version ),
README_URL     := Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),

AbstractHTML := 
  Concatenation( "ToricVarieties provides data structures to handle toric varieties by their commutative algebra ",
                 "structure and by their combinatorics. For combinatorics, it uses the Convex package.",
                 " Its goal is to provide a suitable framework to work with toric varieties." ),

               
PackageDoc := rec(
  BookName  := "ToricVarieties",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "A package to compute properties of toric varieties",
  Autoload  := false
),


Dependencies := rec(
  GAP := ">=4.7",
  NeededOtherPackages := [ [ "NConvex", ">= 2017.01.01" ],
                           #[ "Convex", ">= 2015.11.06" ],
                           [ "GradedRingForHomalg", ">=2015.12.04" ],
                           [ "Modules", ">=2016.01.20" ],
                           [ "GradedModules", ">=2015.12.04" ],
                           [ "ToolsForHomalg", ">=2016.02.17" ],
                           [ "AutoDoc", ">=2016.02.16" ],
                           [ "NormalizInterface", ">=0.9.8" ],
                           [ "CddInterface", ">= 2017.04.02" ],
                           [ "4ti2Interface", ">= 2015.11.06" ],
                           ],
  SuggestedOtherPackages := [ [ "ToricIdeals", ">=2011.01.01" ] ],
  ExternalConditions := []
                      
),

AvailabilityTest := function()
  
    return true;
  end,


Autoload := false,


Keywords := [ "Toric geometry", "Toric varieties", "Divisors", "Geometry"],

AutoDoc := rec(
    TitlePage := rec(
        Copyright := """
This package may be distributed under the terms and conditions
of the GNU Public License Version 2 or (at your option) any later version.
"""
    ),
),

));
