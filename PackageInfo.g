
SetPackageInfo( rec(

PackageName := "PolymakeInterface",

Subtitle := "A package to provide algorithms for fans and cones of polymake to other packages",

Version :=  Maximum( [
  "2012.08.30", ## Sebas' version
] ),

Date := "30/08/2012",

ArchiveURL := Concatenation( "http://wwwb.math.rwth-aachen.de/~gutsche/gap_packages/PolymakeInterface/PolymakeInterface-", ~.Version ),
ArchiveFormats := ".tar.gz",



Persons := [
 rec(
    LastName      := "Baechler",
    FirstNames    := "Thomas",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "thomas@momo.math.rwth-aachen.de",
    PostalAddress := Concatenation( [
                       "Thomas Baechler\n",
                       "Lehrstuhl B für Mathematik\n",
                       "RWTH Aachen\n",
                       "Templergraben 64\n",
                       "52062 Aachen\n",
                       "Germany" ] ),
    Place         := "Aachen",
    Institution   := "RWTH Aachen"
  ),
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
],

Status := "dev",


README_URL := 
  "http://wwwb.math.rwth-aachen.de/~gutsche/gap_packages/PolymakeInterface/README.PolymakeInterface",
PackageInfoURL := 
  "http://wwwb.math.rwth-aachen.de/~gutsche/gap_packages/PolymakeInterface/PackageInfo.g",
  
AbstractHTML := 
      Concatenation( "PolymakeInterface is an GAP-Package that provides a link to the callable library ",
                   "of the CAS polymake. It is not supposed to do any work by itself, but to provide ",
                   "the methods in polymake to GAP. ",
                   "All the functions in this package are supposed to be capsuled by functions ",
                   "in the Convex package, which provides needed structures and datatypes. ",
                   "Also the functions the have nicer names. ",
                   "This fact also causes that there are no doumentations for functions in this package. ",
                   "To get an overview about the supported functions, one might look at the polymake_main.cpp file ",
                   "or simply message the author. ",
                   "Working with this package alone without Convex is not recommended." ),

PackageWWWHome := "http://wwwb.math.rwth-aachen.de/~gutsche/gap_packages/PolymakeInterface/",
               
PackageDoc := rec(
  BookName  := "PolymakeInterface",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "An Interface to polymake",
  Autoload  := false
),


Dependencies := rec(
  GAP := ">=4.5",
  NeededOtherPackages := [ [ "GAPDoc", ">=1.5" ] ],
  SuggestedOtherPackages := [],
  ExternalConditions := []
                      
),

AvailabilityTest := function()
    
    return true;
  end,

BannerString := Concatenation( 
  "----------------------------------------------------------------\n",
  "Loading  PolymakeInterface ", ~.Version, "\n",
  "by ", ~.Persons[1].FirstNames, " ", ~.Persons[1].LastName,
  "   ", ~.Persons[2].FirstNames, " ", ~.Persons[2].LastName,
        " (", ~.Persons[2].WWWHome, ")\n",
  "----------------------------------------------------------------\n",
  "---------polymake Header:---------------------------------------\n",
  "Welcome to polymake version 2.12, released on March 19, 2012\n",
  "Copyright (c) 1997-2012\n",
  "Ewgenij Gawrilow, Michael Joswig (TU Darmstadt)\n",
  "http://www.polymake.org\n",
  "----------------------------------------------------------------\n"),

Autoload := false,


Keywords := []

));


