


SetPackageInfo( rec(

PackageName := "GradedModules",

Subtitle := "A homalg based package for the Abelian category of finitely presented graded modules over computable graded rings",

Version := Maximum( [
  "2014.08.27", ## Markus' version
## this line prevents merge conflicts
  "2017.05.10", ## Mohamed's version
## this line prevents merge conflicts
  "2011.05.05", ## Sebastian's version
## this line prevents merge conflicts
  "2014.07.25", ## Sepp's version
## this line prevents merge conflicts
  "2015.12.04", ## Sebas' version
## this line prevents merge conflicts
  "2014.04.09", ## Max' version
## this line prevents merge conflicts
"2015.11.06", ## Homepage update version, to be removed
] ),

Date := ~.Version{[ 1 .. 10 ]},
Date := Concatenation( ~.Date{[ 9, 10 ]}, "/", ~.Date{[ 6, 7 ]}, "/", ~.Date{[ 1 .. 4 ]} ),





Persons := [
  rec(
    LastName      := "Barakat",
    FirstNames    := "Mohamed",
    IsAuthor      := true,
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
    LastName      := "Lange-Hegermann",
    FirstNames    := "Markus",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "markus.lange.hegermann@rwth-aachen.de",
    WWWHome       := "http://wwwb.math.rwth-aachen.de/~markus/",
    PostalAddress := Concatenation( [
                       "Markus Lange-Hegermann\n",
                       "Lehrstuhl B fuer Mathematik, RWTH Aachen\n",
                       "Templergraben 64\n",
                       "52062 Aachen\n",
                       "Germany" ] ),
    Place         := "Aachen",
    Institution   := "RWTH Aachen University"
  ),
  rec(
    LastName      := "Lorenz",
    FirstNames    := "Arne",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "arne.lorenz@rwth-aachen.de",
    WWWHome       := "http://wwwb.math.rwth-aachen.de/~arne/",
    PostalAddress := Concatenation( [
                       "Arne Lorenz\n",
                       "Lehrstuhl B fuer Mathematik, RWTH Aachen\n",
                       "Templergraben 64\n",
                       "52062 Aachen\n",
                       "Germany" ] ),
    Place         := "Aachen",
    Institution   := "RWTH Aachen University"
  ),
  rec(
    LastName      := "Motsak",
    FirstNames    := "Oleksandr",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "motsak@mathematik.uni-kl.de",
    WWWHome       := "http://www.mathematik.uni-kl.de/~motsak/",
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
PackageWWWHome := "http://homalg-project.github.io/homalg_project/GradedModules/",
ArchiveFormats := ".tar.gz .zip",
ArchiveURL     := Concatenation( "https://github.com/homalg-project/homalg_project/releases/download/GradedModules-", ~.Version, "/GradedModules-", ~.Version ),
README_URL     := Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),


AbstractHTML :=
  "This homalg based package realizes the computability of the Abelian category of finitely presented graded modules over a computable graded ring",
PackageDoc := rec(
  BookName  := "GradedModules",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "A homalg based package for the Abelian category of finitely presented graded modules over computable graded rings",
  Autoload  := false
),


Dependencies := rec(
  GAP := ">=4.7",
  NeededOtherPackages := [
                   [ "ToolsForHomalg", ">= 2014.12.08" ],
                   [ "MatricesForHomalg", ">= 2013.10.27" ],
                   [ "HomalgToCAS", ">= 2011.10.05" ],
                   [ "RingsForHomalg", ">= 2013.04.16" ],
                   [ "GradedRingForHomalg", ">= 2013.10.27" ],
                   [ "Modules", ">= 2013.10.27" ],
                   [ "homalg", ">= 2013.06.23" ],
                   [ "GAPDoc", ">= 1.0" ] ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := []
                      
),

AvailabilityTest := function()
    return true;
  end,

Autoload := false,


Keywords := ["modules", "graded modules", "graduation", "multi-graded modules", "Tate resolution"]

));


