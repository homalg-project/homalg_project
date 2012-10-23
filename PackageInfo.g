


SetPackageInfo( rec(

PackageName := "Convex",

Subtitle := "A package for fan combinatorics",

Version :=  Maximum( [
  "2012.10.23", ## Sebas' version
] ),

Date := "23/10/2012",

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
  SuggestedOtherPackages := [ [ "PolymakeInterface", ">=2012.10.23" ] ],
  ExternalConditions := []
                      
),

AvailabilityTest :=
function()
    
    if LoadPackage( "PolymakeInterface" ) = fail then
        
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

BannerString := Concatenation( 
  "----------------------------------------------------------------\n",
  "Loading  Convex ", ~.Version, "\n",
  "by Sebastian Gutsche\n",
  "----------------------------------------------------------------\n" ),

Autoload := false,


Keywords := [ "Fan", "Cone", "Polytope", "Convex geometry" ]

));


