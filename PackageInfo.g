


SetPackageInfo( rec(

PackageName := "ToricVarieties",

Subtitle := "A package to handle toric varieties",

Version :=  Maximum( [
  "2012.12.18", ## Sebas' version
] ),

Date := ~.Version{[ 1 .. 10 ]},
Date := Concatenation( ~.Date{[ 9, 10 ]}, "/", ~.Date{[ 6, 7 ]}, "/", ~.Date{[ 1 .. 4 ]} ),

ArchiveURL := Concatenation( "http://wwwb.math.rwth-aachen.de/~gutsche/gap_packages/ToricVarieties/ToricVarieties-", ~.Version ),

ArchiveFormats := ".tar.gz",



Persons := [
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
],

Status := "deposited",


README_URL := 
  "http://wwwb.math.rwth-aachen.de/~gutsche/gap_packages/ToricVarieties/README.ToricVarieties",
PackageInfoURL := 
   "http://wwwb.math.rwth-aachen.de/~gutsche/gap_packages/ToricVarieties/PackageInfo.g",

AbstractHTML := 
  Concatenation( "ToricVarieties provides data structures to handle toric varieties by their commutative algebra ",
                 "structure and by their combinatorics. For combinatorics, it uses the Convex package.",
                 " Its goal is to provide a suitable framework to work with toric varieties." ),

PackageWWWHome := "http://wwwb.math.rwth-aachen.de/~gutsche/gap_packages/ToricVarieties",
               
PackageDoc := rec(
  BookName  := "ToricVarieties",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "A package to compute properties of toric varieties",
  Autoload  := false
),


Dependencies := rec(
  GAP := ">=4.5",
  NeededOtherPackages := [ [ "Convex", ">= 2012.04.03" ],
                           [ "GradedRingForHomalg", ">=2011.01.01" ],
                           [ "GradedModules", ">=2012.03.09" ] ],
  SuggestedOtherPackages := [ [ "ToricIdeals", ">=2011.01.01" ] ],
  ExternalConditions := []
                      
),

AvailabilityTest := function()
  
    return true;
  end,

BannerString := Concatenation( 
  "----------------------------------------------------------------\n",
  "Loading  ToricVarieties ", ~.Version, "\n",
  "by ", ~.Persons[1].FirstNames, " ", ~.Persons[1].LastName,
        " (", ~.Persons[1].WWWHome, ")\n",
  "Type:\n",
  "  ?ToricVarieties:           ## for the contents of the manual\n",
  "  ?ToricVarieties:x          ## for chapter/section/topic x\n",
  "----------------------------------------------------------------\n" ),


Autoload := false,


Keywords := [ "Toric geometry", "Toric varieties", "Divisors", "Geometry"]

));


