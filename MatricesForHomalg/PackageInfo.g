SetPackageInfo( rec(

PackageName := "MatricesForHomalg",

Subtitle := "Matrices for the homalg project",

Version := Maximum( [
  "2020.09-05", ## Mohamed's version
## this line prevents merge conflicts
  "2020.10-03", ## Fabian's version
## this line prevents merge conflicts
  "2020.02-05", ## Markus' version
## this line prevents merge conflicts
  "2019.09-01", ## Max' version
## this line prevents merge conflicts
  "2019.12-03", ## Sebas' version
## this line prevents merge conflicts
  "2017.07-01", ## Vinay's version
## this line prevents merge conflicts
  "2013.08-26", ## Martin's version
## this line prevents merge conflicts
  "2019.06-04", ## Florian's version
## this line prevents merge conflicts
  "2020.09-06", ## Sepp's version
## this line prevents merge conflicts
  "2020.10-04", ## Kamal's version
] ),

Date := "24/10/2020",

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
    LastName      := "Leuner",
    FirstNames    := "Martin",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "leuner@momo.math.rwth-aachen.de",
    WWWHome       := "http://wwwb.math.rwth-aachen.de/Mitarbeiter/leuner.php",
    PostalAddress := Concatenation( [
                       "Martin Leuner\n",
                       "Lehrstuhl B fuer Mathematik, RWTH Aachen\n",
                       "Templergraben 64\n",
                       "52062 Aachen\n",
                       "Germany" ] ),
    Place         := "Aachen",
    Institution   := "RWTH Aachen University"
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

# BEGIN URLS
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/homalg_project",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://homalg-project.github.io/homalg_project/MatricesForHomalg",
PackageInfoURL  := "https://homalg-project.github.io/homalg_project/MatricesForHomalg/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/homalg_project/MatricesForHomalg/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/homalg_project/releases/download/MatricesForHomalg-", ~.Version, "/MatricesForHomalg-", ~.Version ),
# END URLS

ArchiveFormats := ".tar.gz .zip",

AbstractHTML := 
  "The <span class=\"pkgname\">MatricesForHomalg</span> package provides lazy evaluated matrices with clever operations for the homalg project",
PackageDoc := rec(
  BookName  := "MatricesForHomalg",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Lazy evaluated matrices with clever operations for the homalg project",
  Autoload  := false
),


Dependencies := rec(
  GAP := ">=4.7",
  NeededOtherPackages := [
                   [ "ToolsForHomalg", ">= 2018.12.15" ],
                   [ "utils", ">= 0.54" ],
                   [ "GAPDoc", ">= 1.0" ] ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := []
                      
),

AvailabilityTest := function()
    return true;
  end,

Autoload := false,


Keywords := [ "rings", "ring elements", "matrices", "lazy evaluated matrices", "clever operations for matrices", "submodule membership problem", "syzygies" ]

));
