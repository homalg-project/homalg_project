SetPackageInfo( rec(

PackageName := "RingsForHomalg",

Subtitle := "Dictionaries of external rings",

Version := Maximum( [
  "2019.12.08", ## Mohamed's version
## this line prevents merge conflicts
  "2018.12.02", ## Markus L-H's version
## this line prevents merge conflicts
  "2017.04.17", ## Markus K's version
## this line prevents merge conflicts
  "2011.12.13", ## Andreas's version
## this line prevents merge conflicts
  "2019.09.01", ## Sebas' version
## this line prevents merge conflicts
  "2013.07.16", ## Vinay's version
## this line prevents merge conflicts
"2015.11.06", ## Homepage update version, to be removed
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
    LastName      := "Kirschmer",
    FirstNames    := "Markus",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "markus.kirschmer@math.rwth-aachen.de",
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
  rec(
    LastName      := "Neunhöffer",
    FirstNames    := "Max",
    IsAuthor      := false,
    IsMaintainer  := false,
    Email         := "neunhoef@mcs.st-and.ac.uk",
    WWWHome       := "http://www-groups.mcs.st-and.ac.uk/~neunhoef/",
    PostalAddress := Concatenation( [
                       "Max Neunhöffer\n",
                       "School of Mathematics and Statistics \n",
                       "Mathematical Institute \n",
                       "North Haugh\n",
                       "St Andrews, Fife KY16 9SS \n",
                       "Scotland, UK" ] ),
    Place         := "St Andrews",
    Institution   := "St Andrews University"
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
  rec(
    LastName      := "Schönemann",
    FirstNames    := "Hans",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "hannes@mathematik.uni-kl.de",
    WWWHome       := "http://www.mathematik.uni-kl.de/~hannes/",
    PostalAddress := Concatenation( [
                       "Department of Mathematics\n",
                       "University of Kaiserslautern\n",
                       "67653 Kaiserslautern\n",
                       "Germany" ] ),
    Place         := "Kaiserslautern",
    Institution   := "University of Kaiserslautern"
  ),
  rec(
    LastName      := "Steenpaß",
    FirstNames    := "Andreas",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "steenpass@mathematik.uni-kl.de",
    PostalAddress := Concatenation( [
                       "Department of Mathematics\n",
                       "University of Kaiserslautern\n",
                       "67653 Kaiserslautern\n",
                       "Germany" ] ),
    Place         := "Kaiserslautern",
    Institution   := "University of Kaiserslautern"
  ),
  rec(
    LastName      := "Wagh",
    FirstNames    := "Vinay",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "waghoba@gmail.com",
    WWWHome       := "http://www.iitg.ernet.in/vinay.wagh/",
    PostalAddress := Concatenation( [
                       "E-102, Department of Mathematics,\n",
                       "Indian Institute of Technology Guwahati,\n",
                       "Guwahati, Assam, India.\n",
                       "PIN: 781 039.\n",
                       "India" ] ),
    Place         := "Guwahati",
    Institution   := "Indian Institute of Technology Guwahati"
  ),
  
],

Status := "deposited",
SourceRepository := rec( 
  Type := "git", 
  URL := "https://github.com/homalg-project/homalg_project"
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome := "https://homalg-project.github.io/homalg_project/RingsForHomalg/",
ArchiveFormats := ".tar.gz .zip",
ArchiveURL     := Concatenation( "https://github.com/homalg-project/homalg_project/releases/download/RingsForHomalg-", ~.Version, "/RingsForHomalg-", ~.Version ),
README_URL     := Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),

AbstractHTML := 
"The <span class=\"pkgname\">RingsForHomalg</span> package provides small dictionaries for \
 <span class=\"pkgname\">homalg</span> to speak (as much as needed of) the languages \
 of Singular, Macaulay2, MAGMA, Sage, and Maple",
PackageDoc := rec(
  BookName  := "RingsForHomalg",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Dictionaries of external rings for the homalg project",
  Autoload  := false
),


Dependencies := rec(
  GAP := ">=4.7",
  NeededOtherPackages := [
                   [ "MatricesForHomalg", ">= 2019.09.01" ],
                   [ "HomalgToCAS", ">= 2019.09.01" ],
                   [ "GaussForHomalg", ">= 2019.09.01" ],
                   [ "GAPDoc", ">= 1.0" ]
                   ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := []
                      
),

AvailabilityTest := function()
    return true;
  end,

Autoload := false,


Keywords := [ "rings", "ideal membership problem", "syzygies", "homalgTable" ]

));


