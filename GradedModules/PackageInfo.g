SetPackageInfo( rec(

PackageName := "GradedModules",

Subtitle := "A homalg based package for the Abelian category of finitely presented graded modules over computable graded rings",

Version := Maximum( [
  "2020.04-30", ## Mohamed's version
## this line prevents merge conflicts
  "2020.02-05", ## Markus' version
## this line prevents merge conflicts
  "2019.08-01", ## Max's version
## this line prevents merge conflicts
  "2011.05-05", ## Sebastian's version
## this line prevents merge conflicts
  "2014.07-25", ## Sepp's version
## this line prevents merge conflicts
  "2015.12-04", ## Sebas' version
## this line prevents merge conflicts
  "2014.04-09", ## Max' version
## this line prevents merge conflicts
  "2020.10-02", ## Fabian's version
] ),

Date := "16/10/2020",

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
    WWWHome       := "https://www.th-owl.de/eecs/fachbereich/team/markus-lange-hegermann/",
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

# BEGIN URLS
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/homalg_project",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://homalg-project.github.io/homalg_project/GradedModules",
PackageInfoURL  := "https://homalg-project.github.io/homalg_project/GradedModules/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/homalg_project/GradedModules/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/homalg_project/releases/download/GradedModules-", ~.Version, "/GradedModules-", ~.Version ),
# END URLS

ArchiveFormats := ".tar.gz .zip",

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
                   [ "MatricesForHomalg", ">= 2020.02.05" ],
                   [ "HomalgToCAS", ">= 2011.10.05" ],
                   [ "RingsForHomalg", ">= 2020.04.17" ],
                   [ "GradedRingForHomalg", ">= 2020.02.05" ],
                   [ "Modules", ">= 2020.02.05" ],
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
