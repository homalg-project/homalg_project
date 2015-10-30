

SetPackageInfo( rec(

PackageName := "SCO",

Subtitle := "SCO - Simplicial Cohomology of Orbifolds",

Version := "2015.10.29",

Date := ~.Version{[ 1 .. 10 ]},
Date := Concatenation( ~.Date{[ 9, 10 ]}, "/", ~.Date{[ 6, 7 ]}, "/", ~.Date{[ 1 .. 4 ]} ),





Persons := [
  rec( 
    LastName      := "Görtzen",
    FirstNames    := "Simon",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "simon.goertzen@rwth-aachen.de",
    WWWHome       := "http://wwwb.math.rwth-aachen.de/goertzen",
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
PackageWWWHome := "http://homalg-project.github.io/homalg_project/SCO/",
ArchiveFormats := ".tar.gz",
ArchiveURL     := Concatenation( ~.PackageWWWHome, "SCO-", ~.Version ),
README_URL     := Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),


AbstractHTML := 
"The <span class=\"pkgname\">SCO</span> package provides functionality to compute simplicial cohomology of orbifolds",
PackageDoc := rec(
  BookName  := "SCO",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "SCO - Simplicial Cohomology of Orbifolds",
  Autoload  := true
),


Dependencies := rec(
  GAP := ">=4.4",
  NeededOtherPackages := [ [ "MatricesForHomalg", ">= 2011.08.10" ], [ "Modules", ">= 2011.06.29" ], [ "GAPDoc", ">= 1.0" ] ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := []
                      
),

AvailabilityTest := function()
    return true;
  end,


Autoload := false,


Keywords := ["homology", "cohomology", "orbifold", "groupoid", "simplicial", "triangulation" ]

));


