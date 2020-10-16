SetPackageInfo( rec(

PackageName := "4ti2Interface",

Subtitle := "A link to 4ti2",

Version := Maximum( [
  "2019.06-02", ## Sebas' version
## this line prevents merge conflicts
  "2020.07-19", ## Kamal's version
## this line prevents merge conflicts
  "2020.05-11", ## Mohamed's version
## this line prevents merge conflicts
  "2020.10-02", ## Fabian's version
] ),

Date := "16/10/2020",

License := "GPL-2.0-or-later",

Persons := [
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
],

Status := "deposited",

# BEGIN URLS
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/homalg_project",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://homalg-project.github.io/homalg_project/4ti2Interface",
PackageInfoURL  := "https://homalg-project.github.io/homalg_project/4ti2Interface/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/homalg_project/4ti2Interface/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/homalg_project/releases/download/4ti2Interface-", ~.Version, "/4ti2Interface-", ~.Version ),
# END URLS

ArchiveFormats := ".tar.gz .zip",

AbstractHTML := 
  "The <span class=\"pkgname\">4ti2Interface</span> package provides an interface to 4ti2",
PackageDoc := rec(
  BookName  := "4ti2Interface",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "An interface to 4ti2.",
  Autoload  := false
),


Dependencies := rec(
  GAP := ">=4.7",
  NeededOtherPackages := [ [ "io", ">=4.2" ] ],
  SuggestedOtherPackages := [ [ "AutoDoc", ">=2013.08.22" ]  ],
  ExternalConditions := [ [ "4ti2", "https://4ti2.github.io/" ] ],
),

AvailabilityTest := function()
  local 4ti2_binaries, bool;
    
    4ti2_binaries := [ "groebner",
                       "hilbert",
                       "zsolve",
                       "graver" ];
    
    bool :=
      ForAll( 4ti2_binaries,
              name ->
              ( not Filename(DirectoriesSystemPrograms(), name ) = fail ) or
              ( not Filename(DirectoriesSystemPrograms(), Concatenation( "4ti2-", name ) ) = fail ) );
    
    if not bool then
        LogPackageLoadingMessage( PACKAGE_WARNING,
                [ "At least one of the 4ti2 binaries",
                  JoinStringsWithSeparator( 4ti2_binaries, ", " ),
                  "is not installed on your system.",
                  "4ti2 can be downloaded from https://4ti2.github.io/" ] );
    fi;
    
    return bool;
    
end,

Autoload := false,


Keywords := [  ]

));
