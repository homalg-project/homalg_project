
SetPackageInfo( rec(

PackageName := "PolymakeInterface",

Subtitle := "A package to provide algorithms for fans and cones of polymake to other packages",

Version :=  Maximum( [
  "2013.07.29", ## Sebas' version
] ),

Date := ~.Version{[ 1 .. 10 ]},
Date := Concatenation( ~.Date{[ 9, 10 ]}, "/", ~.Date{[ 6, 7 ]}, "/", ~.Date{[ 1 .. 4 ]} ),

ArchiveURL := Concatenation( "http://wwwb.math.rwth-aachen.de/~gutsche/gap_packages/PolymakeInterface/PolymakeInterface-", ~.Version ),
ArchiveFormats := ".tar.gz",



Persons := [
 rec(
    LastName      := "Baechler",
    FirstNames    := "Thomas",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "thomas@momo.math.rwth-aachen.de",
    WWWHome       := "http://wwwb.math.rwth-aachen.de/~thomas/",
    PostalAddress := Concatenation( [
                       "Thomas Baechler\n",
                       "Lehrstuhl B fuer Mathematik\n",
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

Status := "deposited",


README_URL := 
  "http://wwwb.math.rwth-aachen.de/~gutsche/gap_packages/PolymakeInterface/README.PolymakeInterface",
PackageInfoURL := 
  "http://wwwb.math.rwth-aachen.de/~gutsche/gap_packages/PolymakeInterface/PackageInfo.g",
  
AbstractHTML := 
      Concatenation( "PolymakeInterface is a GAP-Package that provides a link to the callable library ",
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
  NeededOtherPackages := [ [ "GAPDoc", ">=1.5" ], [ "AutoDoc", ">=2012.01.01" ] ],
  SuggestedOtherPackages := [],
  ExternalConditions := [ [ "polymake", ">=2.12" ] ]
                      
),

AvailabilityTest := function()
    
    return true;
  end,
  
AvailabilityTest := function()
  if Filename(DirectoriesPackagePrograms("PolymakeInterface"), "polymake_main.so") = fail then
    LogPackageLoadingMessage( PACKAGE_WARNING,
              [ "PolymakeInterface is not compiled properly.",
                "Please look at the installation chapter of the documentation",
                "of the PolymakeInterface package." ] );
    return fail;
  fi;
  return true;
end,


BannerString := Concatenation( 
  "----------------------------------------------------------------\n",
  "Loading  PolymakeInterface ", ~.Version, "\n",
  "by ", ~.Persons[1].FirstNames, " ", ~.Persons[1].LastName,"\n",
  "   ", ~.Persons[2].FirstNames, " ", ~.Persons[2].LastName,
        " (", ~.Persons[2].WWWHome, ")\n",
  "----------------------------------------------------------------\n",
  "---------polymake Header:---------------------------------------\n",
  "Welcome to polymake\n",
  "Copyright (c) 1997-2012\n",
  "Ewgenij Gawrilow, Michael Joswig (TU Darmstadt)\n",
  "http://www.polymake.org\n",
  "----------------------------------------------------------------\n"),

Autoload := false,


Keywords := []

));


