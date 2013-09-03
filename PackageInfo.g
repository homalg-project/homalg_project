


SetPackageInfo( rec(

PackageName := "4ti2Interface",

Subtitle := "A link to 4ti2",

Version := Maximum( [
  "2013.09.03", ## Sebas' version
] ),

Date := ~.Version{[ 1 .. 10 ]},
Date := Concatenation( ~.Date{[ 9, 10 ]}, "/", ~.Date{[ 6, 7 ]}, "/", ~.Date{[ 1 .. 4 ]} ),

ArchiveURL := Concatenation( "http://wwwb.math.rwth-aachen.de/~gutsche/gap_packages/4ti2Interface/4ti2Interface-", ~.Version ),

ArchiveFormats := ".tar.gz",



Persons := [
  rec(
    LastName      := "Gutsche",
    FirstNames    := "Sebastian",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "gutsche@mathematik.uni-kl.de",
    WWWHome       := "http://wwwb.math.rwth-aachen.de/~gutsche/",
    PostalAddress := Concatenation( [
                       "Department of Mathematics\n",
                       "University of Kaiserslautern\n",
                       "67653 Kaiserslautern\n",
                       "Germany" ] ),
    Place         := "Kaiserslautern",
    Institution   := "University of Kaiserslautern"
  ),
  
],

Status := "dev",


#README_URL := 
#  "http://wwwb.math.rwth-aachen.de/~gutsche/gap_packages/4ti2Interface/README.4ti2Interface",
#PackageInfoURL := 
#  "http://wwwb.math.rwth-aachen.de/~gutsche/gap_packages/4ti2Interface/PackageInfo.g",

#AbstractHTML := 
#  "The <span class=\"pkgname\">4ti2Interface</span> package provides an interface to 4ti2",
PackageWWWHome := "http://wwwb.math.rwth-aachen.de/~gutsche/gap_packages/4ti2Interface",
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
  GAP := ">=4.5",
  NeededOtherPackages := [ [ "io", ">=4.2" ] ],
  SuggestedOtherPackages := [ [ "AutoDoc", ">=2013.08.22" ]  ],
  ExternalConditions := []
                      
),

AvailabilityTest := function()
    return true;
  end,

Autoload := false,


Keywords := [  ]

));

