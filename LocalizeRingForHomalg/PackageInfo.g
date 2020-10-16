SetPackageInfo( rec(

PackageName := "LocalizeRingForHomalg",

Subtitle := "A Package for Localization of Polynomial Rings",

Version := Maximum( [ ##To prevent merge conflicts
  "2020.04-30", ## Markus' version
## this line prevents merge conflicts
  "2019.09-02", ## Mohamed's version
## this line prevents merge conflicts
  "2019.08-01", ## Max's version
## this line prevents merge conflicts
  "2013.07-15", ## Vinay's version
## this line prevents merge conflicts
  "2013.11-11", ## Sebas' version
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
PackageWWWHome  := "https://homalg-project.github.io/homalg_project/LocalizeRingForHomalg",
PackageInfoURL  := "https://homalg-project.github.io/homalg_project/LocalizeRingForHomalg/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/homalg_project/LocalizeRingForHomalg/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/homalg_project/releases/download/LocalizeRingForHomalg-", ~.Version, "/LocalizeRingForHomalg-", ~.Version ),
# END URLS

ArchiveFormats := ".tar.gz .zip",

AbstractHTML := "This package is part of the homalg-project and allows localization of a (computable) commutative ring at a (finitely generated) maximal ideal.",

PackageDoc := rec(
  BookName  := "LocalizeRingForHomalg",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "A Package for Localization of Polynomial Rings",
  Autoload  := false
),


Dependencies := rec(
  GAP := ">=4.7",
  NeededOtherPackages := [
                   [ "MatricesForHomalg", ">= 2020.06.27" ],
                   [ "HomalgToCAS", ">= 2020.06.27" ],
                   [ "Modules", ">= 2020.02.05" ],
                   [ "GAPDoc", ">= 1.0" ]
                   ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := []
                      
),

AvailabilityTest := function()
    return true;
  end,


Autoload := false,


Keywords := [ "homological algebra", "local ring", "submodule membership problem", "syzygies", "Mora" ]

));
