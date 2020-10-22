SetPackageInfo( rec(

PackageName := "ToolsForHomalg",

Subtitle := "Special methods and knowledge propagation tools",

Version := Maximum( [
  "2020.09-06", ## Mohamed's version
## this line prevents merge conflicts
  "2011.09-12", ## Markus' version
## this line prevents merge conflicts
  "2018.05-22", ## Sebas' version
## this line prevents merge conflicts
  "2020.10-03", ## Fabian's version
## this line prevents merge conflicts
  "2020.09-02", ## Kamal's version
## this line prevents merge conflicts

] ),

Date := "22/10/2020",

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
    LastName      := "Lange-Hegermann",
    FirstNames    := "Markus",
    IsAuthor      := true,
    IsMaintainer  := true,
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
  
],

Status := "deposited",

# BEGIN URLS
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/homalg_project",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://homalg-project.github.io/homalg_project/ToolsForHomalg",
PackageInfoURL  := "https://homalg-project.github.io/homalg_project/ToolsForHomalg/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/homalg_project/ToolsForHomalg/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/homalg_project/releases/download/ToolsForHomalg-", ~.Version, "/ToolsForHomalg-", ~.Version ),
# END URLS

ArchiveFormats := ".tar.gz .zip",

AbstractHTML := 
  "The <span class=\"pkgname\">ToolsForHomalg</span> package provides GAP extensions for the homalg project",




PackageDoc := rec(
  BookName  := "ToolsForHomalg",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Provides special methods and knowledge propagation tools",
  Autoload  := false
),


Dependencies := rec(
  GAP := ">=4.7",
  NeededOtherPackages := [
                   [ "GAPDoc", ">= 1.0" ],
                   [ "AutoDoc", ">=2013.11.10" ],
                   [ "IO", ">=4.5.1" ],
                   ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := []
                      
),

AvailabilityTest := function()
    return true;
  end,


Autoload := false,


Keywords := [  ]

));
