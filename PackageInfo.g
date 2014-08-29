


SetPackageInfo( rec(

PackageName := "Convex",

Subtitle := "A package for fan combinatorics",

Version :=  Maximum( [
  "2014.08.29", ## Sebas' version
] ),

Date := ~.Version{[ 1 .. 10 ]},
Date := Concatenation( ~.Date{[ 9, 10 ]}, "/", ~.Date{[ 6, 7 ]}, "/", ~.Date{[ 1 .. 4 ]} ),

ArchiveURL := 
          Concatenation( "http://wwwb.math.rwth-aachen.de/~gutsche/gap_packages/Convex/Convex-", ~.Version ),

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
  "http://wwwb.math.rwth-aachen.de/~gutsche/gap_packages/Convex/README.Convex",
PackageInfoURL := 
  "http://wwwb.math.rwth-aachen.de/~gutsche/gap_packages/Convex/PackageInfo.g",

AbstractHTML := 
  Concatenation( "Convex provides structures and algorithms for convex geometry. It can handle convex, ",
                 "fans and polytopes. Not only the structures are provided, but also a collection of ",
                 "algorithms to handle those objects. Basically, it provides convex geometry to GAP. ",
                 "It is capable of communicating with the CAS polymake via the package PolymakeInterface",
                 " and also provides several methods by itself." ),

PackageWWWHome := "http://wwwb.math.rwth-aachen.de/~gutsche/gap_packages/Convex/",
               
PackageDoc := rec(
  BookName  := "Convex",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "A package to provide convex geometry functions to GAP.",
  Autoload  := false
),


Dependencies := rec(
  GAP := ">=4.5",
  NeededOtherPackages := [ [ "Modules", ">=2011.08.01" ] ],
  SuggestedOtherPackages := [ [ "PolymakeInterface", ">=2014.08.28" ] ],
  ExternalConditions := []
                      
),

AvailabilityTest :=
function()
    
    if not IsPackageMarkedForLoading( "PolymakeInterface", ">=0" ) then
        
        LogPackageLoadingMessage( PACKAGE_WARNING,
        [
           "You are running Convex without PolymakeInterface/polymake.\n",
           "Some restrictions to the input apply:\n",
           "- Cones are supposed to be pointed.\n",
           "- Cones have to be created by ray generators.\n",
           "- Fans have to be created by maximal cones.\n",
           "- Polytopes have to be given by vertices or a reduced set of inequalities.\n"
        ] );
        
    fi;
    
    return true;
    
end,

# BannerString := Concatenation( 
#   "----------------------------------------------------------------\n",
#   "Loading  Convex ", ~.Version, "\n",
#   "by ", ~.Persons[1].FirstNames, " ", ~.Persons[1].LastName,
#         " (", ~.Persons[1].WWWHome, ")\n",
#   "Type:\n",
#   "  ?Convex:                   ## for the contents of the manual\n",
#   "  ?Convex:x                  ## for chapter/section/topic x\n",
#   "----------------------------------------------------------------\n" ),

Autoload := false,


Keywords := [ "Fan", "Cone", "Polytope", "Convex geometry" ]

));


