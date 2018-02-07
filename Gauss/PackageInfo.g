SetPackageInfo( rec(

PackageName := "Gauss",

Subtitle := "Extended Gauss functionality for GAP",

Version := "2018.02.05",

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
    WWWHome       := "http://wwwb.math.rwth-aachen.de/~barakat/",
    PostalAddress := Concatenation( [
                       "Mohamed Barakat\n",
                       "Department of Mathematics\n",
                       "University of Kaiserslautern\n",
                       "67653 Kaiserslautern\n",
                       "Germany" ] ),
    Place         := "Aachen",
    Institution   := "University of Kaiserslautern"
  ),
    rec(
    LastName      := "Gutsche",
    FirstNames    := "Sebastian",
    IsAuthor      := false,
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
PackageWWWHome := "http://homalg-project.github.io/homalg_project/Gauss/",
ArchiveFormats := ".tar.gz .zip",
ArchiveURL     := Concatenation( "https://github.com/homalg-project/homalg_project/releases/download/Gauss-", ~.Version, "/Gauss-", ~.Version ),
README_URL     := Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),

AbstractHTML := 
"The <span class=\"pkgname\">Gauss</span> package provideds extended Gauss functionality for <span class=\"pkgname\">GAP</span>",
PackageDoc := rec(
  BookName  := "Gauss",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Extended Gauss functionality for GAP",
  Autoload  := false
),

Dependencies := rec(
  GAP := ">=4.8",
  NeededOtherPackages := [ ],
  SuggestedOtherPackages := [ [ "GAPDoc", ">= 1.0" ] ],
  ExternalConditions := []
                      
),

AvailabilityTest := function()
  if (not("gauss" in SHOW_STAT())) and
     (Filename(DirectoriesPackagePrograms("gauss"), "gauss.so") = fail) then
    LogPackageLoadingMessage( PACKAGE_INFO, "Gauss C-module was not compiled!", "Gauss" );
    LogPackageLoadingMessage( PACKAGE_INFO, "Gauss will work, but slower.", "Gauss" );
  fi;
  return true;
end,

Autoload := false,


Keywords := ["Gauss", "RREF", "sparse" ]

));

