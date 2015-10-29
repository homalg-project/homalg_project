


SetPackageInfo( rec(

PackageName := "LocalizeRingForHomalg",

Subtitle := "A Package for Localization of Polynomial Rings",

Version := Maximum( [ ##To prevent merge conflicts
  "2014.08.27", ## Markus' version
## this line prevents merge conflicts
  "2015.09.30", ## Mohamed's version
## this line prevents merge conflicts
  "2013.07.15", ## Vinay's version
## this line prevents merge conflicts
  "2013.11.11", ## Sebas' version
## this line prevents merge conflicts
"2015.10.29", ## Homepage update version, to be removed
] ),

Date := ~.Version{[ 1 .. 10 ]},
Date := Concatenation( ~.Date{[ 9, 10 ]}, "/", ~.Date{[ 6, 7 ]}, "/", ~.Date{[ 1 .. 4 ]} ),





Persons := [
  rec(
    LastName      := "Barakat",
    FirstNames    := "Mohamed",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "barakat@mathematik.uni-kl.de",
    WWWHome       := "http://www.mathematik.uni-kl.de/~barakat/",
    PostalAddress := Concatenation( [
                       "Department of Mathematics\n",
                       "University of Kaiserslautern\n",
                       "67653 Kaiserslautern\n",
                       "Germany" ] ),
    Place         := "Kaiserslautern",
    Institution   := "University of Kaiserslautern"
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
PackageWWWHome := "http://homalg-project.github.io/homalg_project/LocalizeRingForHomalg/",
ArchiveFormats := ".tar.gz",
ArchiveURL     := Concatenation( ~.PackageWWWHome, "LocalizeRingForHomalg-", ~.Version ),
README_URL     := Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),


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
  GAP := ">=4.4",
  NeededOtherPackages := [
                   [ "MatricesForHomalg", ">= 2013.10.25" ],
                   [ "HomalgToCAS", ">= 2013.07.12" ],
                   [ "Modules", ">= 2013.06.06" ],
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


