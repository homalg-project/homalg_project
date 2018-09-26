
SetPackageInfo( rec(

PackageName := "PolymakeInterface",

Subtitle := "A package to provide algorithms for fans and cones of polymake to other packages",

Version :=  Maximum( [
  "2018.09.25", ## Sebas' version
## this line prevents merge conflicts
"25/09/2018", ## Homepage update version, to be removed
] ),

Date := ~.Version{[ 1 .. 10 ]},
Date := Concatenation( ~.Date{[ 9, 10 ]}, "/", ~.Date{[ 6, 7 ]}, "/", ~.Date{[ 1 .. 4 ]} ),




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
PackageWWWHome := "http://homalg-project.github.io/homalg_project/PolymakeInterface/",
ArchiveFormats := ".tar.gz .zip",
ArchiveURL     := Concatenation( "https://github.com/homalg-project/homalg_project/releases/download/PolymakeInterface-", ~.Version, "/PolymakeInterface-", ~.Version ),
README_URL     := Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),

  
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
  GAP := ">=4.7",
  NeededOtherPackages := [ [ "GAPDoc", ">=1.5" ], [ "AutoDoc", ">=2012.01.01" ] ],
  SuggestedOtherPackages := [],
  ExternalConditions := [ [ "polymake", "http://www.polymake.org" ] ]
                      
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


