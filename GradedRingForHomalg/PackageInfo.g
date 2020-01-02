SetPackageInfo( rec(

PackageName := "GradedRingForHomalg",

Subtitle := "Endow Commutative Rings with an Abelian Grading",

Version := Maximum( [
  "2020.01.02", ## Mohamed's version
## this line prevents merge conflicts
  "2014.08.27", ## Markus' version
## this line prevents merge conflicts
  "2019.03.21", ## Kamal's version
## this line prevents merge conflicts
  "2019.08.01", ## Max's version
## this line prevents merge conflicts
  "2011.05.05", ## Sebastian's version
## this line prevents merge conflicts
  "2015.12.04", ## Sebas' version
## this line prevents merge conflicts
  "2013.02.07", ## Markus' Kirschmer version
## this line prevents merge conflicts
  "2019.06.04", ## Martin's version
## this line prevents merge conflicts
  "2019.03.20", ## Sepp's version
## this line prevents merge conflicts
  "2019.08.07", ## Fabian's version
] ),

Date := ~.Version{[ 1 .. 10 ]},
Date := Concatenation( ~.Date{[ 9, 10 ]}, "/", ~.Date{[ 6, 7 ]}, "/", ~.Date{[ 1 .. 4 ]} ),

License := "GPL-2.0-or-later",

Persons := [
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
    FirstNames := "Sebastian",
    LastName := "Gutsche",
    IsAuthor := true,
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
  rec(
    LastName      := "Kirschmer",
    FirstNames    := "Markus",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "markus.kischmer@math.rwth-aachen.de",
    WWWHome       := "http://www.math.rwth-aachen.de/~Markus.Kirschmer/",
    PostalAddress := Concatenation( [
                       "Markus Kirschmer\n",
                       "Lehrstuhl D fuer Mathematik, RWTH Aachen\n",
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
    FirstNames    := "Markus",
    LastName      := "Lange-Hegermann",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "markus.lange-hegermann@hs-owl.de",
    WWWHome       := "https://www.hs-owl.de/fb5/fachbereich/fachgebiete/md/team/prof-dr-markus-lange-hegermann.html",
    PostalAddress := Concatenation( [
                       "Markus Lange-Hegermann\n",
                       "Hochschule Ostwestfalen-Lippe\n",
                       "Liebigstraße 87\n",
                       "32657 Lemgo\n",
                       "Germany" ] ),
    Place         := "Aachen",
    Institution   := "Hochschule Ostwestfalen-Lippe"
  ),
  rec(
    LastName      := "Robertz",
    FirstNames    := "Daniel",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "daniel@momo.math.rwth-aachen.de",
    WWWHome       := "http://wwwb.math.rwth-aachen.de/~daniel/",
    PostalAddress := Concatenation( [
                       "Daniel Robertz\n",
                       "Lehrstuhl B fuer Mathematik, RWTH Aachen\n",
                       "Templergraben 64\n",
                       "52062 Aachen\n",
                       "Germany" ] ),
    Place         := "Aachen",
    Institution   := "RWTH Aachen University"
  ),
  
],

Status := "deposited",
SourceRepository := rec( 
  Type := "git", 
  URL := "https://github.com/homalg-project/homalg_project"
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome := "https://homalg-project.github.io/homalg_project/GradedRingForHomalg/",
ArchiveFormats := ".tar.gz .zip",
ArchiveURL     := Concatenation( "https://github.com/homalg-project/homalg_project/releases/download/GradedRingForHomalg-", ~.Version, "/GradedRingForHomalg-", ~.Version ),
README_URL     := Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),


AbstractHTML := "This package is part of the homalg-project and manages graded rings.",

PackageDoc := rec(
  BookName  := "GradedRingForHomalg",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "A homalg based Package for Graded Rings",
  Autoload  := false
),


Dependencies := rec(
  GAP := ">=4.7",
  NeededOtherPackages := [
                   [ "MatricesForHomalg", ">= 2020.01.02" ],
                   [ "HomalgToCAS", ">= 2018.12.11" ],
                   [ "RingsForHomalg", ">= 2018.12.11" ],
                   [ "Modules", ">= 2018.02.04" ],
                   [ "homalg", ">=2011.08.16" ],
                   [ "GAPDoc", ">= 1.0" ] ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := []
                      
),

AvailabilityTest := function()
    return true;
  end,

Autoload := false,


Keywords := [ "homological algebra", "graded ring" ]

));


