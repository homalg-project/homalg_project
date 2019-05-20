SetPackageInfo( rec(

PackageName := "IO_ForHomalg",

Subtitle := "IO capabilities for the homalg project",

Version := "2019.01.01",

Date := ~.Version{[ 1 .. 10 ]},
Date := Concatenation( ~.Date{[ 9, 10 ]}, "/", ~.Date{[ 6, 7 ]}, "/", ~.Date{[ 1 .. 4 ]} ),

License := "GPL-2.0-or-later",

Persons := [
  rec(
    LastName      := "Bächler",
    FirstNames    := "Thomas",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "thomas@momo.math.rwth-aachen.de",
    WWWHome       := "http://wwwb.math.rwth-aachen.de/~thomas/",
    PostalAddress := Concatenation( [
                       "Thomas Bächler\n",
                       "Lehrstuhl B fuer Mathematik, RWTH Aachen\n",
                       "Templergraben 64\n",
                       "52062 Aachen\n",
                       "Germany" ] ),
    Place         := "Aachen",
    Institution   := "RWTH Aachen University"
  ),
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Mohamed",
    LastName := "Barakat",
    WWWHome := "https://mohamed-barakat.github.io",
    Email := "mohamed.barakat@uni-siegen.de",
    PostalAddress := Concatenation(
               "Walter-Flex-Str. 3\n",
               "57068 Siegen\n",
               "Germany" ),
    Place := "Siegen",
    Institution := "University of Siegen",
  ),
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Sebastian",
    LastName := "Gutsche",
    WWWHome := "https://algebra.mathematik.uni-siegen.de/gutsche/",
    Email := "gutsche@mathematik.uni-siegen.de",
    PostalAddress := Concatenation(
               "Department Mathematik\n",
               "Universität Siegen\n",
               "Walter-Flex-Straße 3\n",
               "57068 Siegen\n",
               "Germany" ),
    Place := "Siegen",
    Institution := "University of Siegen",
  ),
  rec(
    LastName      := "Neunhöffer",
    FirstNames    := "Max",
    IsAuthor      := true,
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
  
],

Status := "deposited",
PackageWWWHome := "http://homalg-project.github.io/homalg_project/IO_ForHomalg/",
ArchiveFormats := ".tar.gz .zip",
ArchiveURL     := Concatenation( "https://github.com/homalg-project/homalg_project/releases/download/IO_ForHomalg-", ~.Version, "/IO_ForHomalg-", ~.Version ),
README_URL     := Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),

AbstractHTML := 
"The <span class=\"pkgname\">IO_ForHomalg</span> package launches the command-line-interface of an external computer algebra system\
 and connects it to <span class=\"pkgname\">homalg</span> using an Input/Output stream",
PackageDoc := rec(
  BookName  := "IO_ForHomalg",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "IO capabilities for the homalg project",
  Autoload  := false
),


Dependencies := rec(
  GAP := ">=4.7",
  NeededOtherPackages := [ [ "IO", ">= 2.3" ], [ "HomalgToCAS", ">= 2009.06.18" ] ],
  SuggestedOtherPackages := [ [ "GAPDoc", ">= 1.0" ] ],
  ExternalConditions := []
                      
),

AvailabilityTest := function()
    return true;
  end,

Autoload := false,


Keywords := [ "IO", "streams" ]

));
