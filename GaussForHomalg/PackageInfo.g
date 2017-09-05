SetPackageInfo( rec(

PackageName := "GaussForHomalg",

Subtitle := "Gauss functionality for the homalg project",

Version := "2017.09.01",

Date := ~.Version{[ 1 .. 10 ]},
Date := Concatenation( ~.Date{[ 9, 10 ]}, "/", ~.Date{[ 6, 7 ]}, "/", ~.Date{[ 1 .. 4 ]} ),





Persons := [
  rec( 
    LastName      := "Goertzen",
    FirstNames    := "Simon",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "simon.goertzen@rwth-aachen.de",
    WWWHome       := "http://wwwb.math.rwth-aachen.de/goertzen",
    PostalAddress := Concatenation( [
                       "Simon Goertzen\n",
                       "Lehrstuhl B fuer Mathematik, RWTH Aachen\n",
                       "Templergraben 64\n",
                       "52062 Aachen\n",
                       "Germany" ] ),
    Place         := "Aachen",
    Institution   := "RWTH Aachen University"
  ),
  rec(
    LastName      := "Barakat",
    FirstNames    := "Mohamed",
    IsAuthor      := false,
    IsMaintainer  := true,
    Email         := "barakat@mathematik.uni-kl.de",
    WWWHome       := "http://www.mathematik.uni-kl.de/~barakat/",
    PostalAddress := Concatenation( [
                       "Department of Mathematics\n",
                       "University of Kaiserslautern\n",
                       "67653 Kaiserslautern\n",
                       "Germany" ] ),
    Place         := "Kaiserslautern",
    Institution   := "University of Kaiserslautern"
  ),
  
],

Status := "deposited",
PackageWWWHome := "http://homalg-project.github.io/homalg_project/GaussForHomalg/",
ArchiveFormats := ".tar.gz .zip",
ArchiveURL     := Concatenation( "https://github.com/homalg-project/homalg_project/releases/download/GaussForHomalg-", ~.Version, "/GaussForHomalg-", ~.Version ),
README_URL     := Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),

AbstractHTML := 
"The <span class=\"pkgname\">GaussForHomalg</span> package provides Gauss functionality for\
 <span class=\"pkgname\">homalg</span> using the package <span class=\"pkgname\">Gauss</span>",
PackageDoc := rec(
  BookName  := "GaussForHomalg",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Gauss functionality for the homalg project",
  Autoload  := false
),


Dependencies := rec(
  GAP := ">=4.7",
  NeededOtherPackages := [
                [ "Gauss", ">= 2009.10.07" ],
                [ "MatricesForHomalg", ">= 2013.06.26" ],
                [ "GAPDoc", ">= 1.0" ] ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := []
                      
),

AvailabilityTest := function()
    return true;
  end,

Autoload := false,


Keywords := ["GaussForHomalg", "homalg", "Gauss" ]

));


