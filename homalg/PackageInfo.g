# SPDX-License-Identifier: GPL-2.0-or-later
# homalg: A homological algebra meta-package for computable Abelian categories
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#

SetPackageInfo( rec(

PackageName := "homalg",
Subtitle := "A homological algebra meta-package for computable Abelian categories",
Version := "2024.01-01",
Date := "2024-01-10",
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
    IsMaintainer := false,
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
],

Status := "deposited",

# BEGIN URLS
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/homalg_project",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://homalg-project.github.io/pkg/homalg",
PackageInfoURL  := "https://homalg-project.github.io/homalg_project/homalg/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/homalg_project/homalg/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/homalg_project/releases/download/homalg-", ~.Version, "/homalg-", ~.Version ),
# END URLS

ArchiveFormats := ".tar.gz .zip",

AbstractHTML := 
  "A homological algebra meta-package for computable Abelian categories",
PackageDoc := rec(
  BookName  := "homalg",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "A homological algebra meta-package for computable Abelian categories",
),


Dependencies := rec(
  GAP := ">= 4.12.1",
  NeededOtherPackages := [
                   [ "ToolsForHomalg", ">=2012.10.27" ],
                   [ "GAPDoc", ">= 1.0" ] ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := []
                      
),

AvailabilityTest := function()
    return true;
  end,

TestFile := "tst/testall.g",

Keywords := ["homological", "filtration", "bicomplex", "spectral sequence", "Grothendieck", "functor"],

AutoDoc := rec(
    TitlePage := rec(
        Copyright := Concatenation(
            "&copyright; 2007-2015 by Mohamed Barakat and Markus Lange-Hegermann\n\n",
            "This package may be distributed under the terms and conditions ", 
            "of the GNU Public License Version 2 or (at your option) any later version.\n"
            ), 
        Acknowledgements := """
  <Alt Not="Text"><URL Text="Max Neunhöffer">https://www.arangodb.com/speakers/max-neunhoeffer/</URL></Alt>
  <Alt Only="Text">Max Neunhöffer</Alt> not only taught me the
  philosophy of object-oriented programming in &GAP4;, but also to
  what extent this philosophy is still unique among programming
  languages (&see; <Ref Sect="WhyGAP4" Text="Why GAP4?"/>).

  He, <Alt Not="Text"><URL Text="Frank
  Lübeck">http://www.math.rwth-aachen.de/~Frank.Luebeck/</URL></Alt><Alt Only="Text">Frank
  Lübeck</Alt>, and
  <Alt Not="Text"><URL Text="Thomas
  Breuer">http://www.math.rwth-aachen.de/~Thomas.Breuer/</URL></Alt>
  <Alt Only="Text">Thomas Breuer</Alt> patiently answered trillions of
  specific questions, even those I was too lazy to look up in the
  excellent <Alt Only="HTML"><Ref Chap="Preface" Text="reference manual"
  BookName="Reference"/></Alt><Alt Only="Text">
  programming tutorial</Alt><Alt Only="LaTeX"><URL Text="reference manual">http://www.gap-system.org/Manuals/doc/ref/chap0.html</URL></Alt>.
  
  Without their continuous and tireless help and advice, not only this
  package but the <Alt Only="Text">&homalg; project</Alt> as a whole
  <Alt Not="Text"><URL Text="homalg
  project">https://homalg-project.github.io/homalg_project/</URL></Alt> would
  have remained on my todo list. <P/>
 
  A lot of <Alt Only="HTML"><Ref Text="ideas" Label="intro"/></Alt>
  <Alt Not="HTML">ideas</Alt> that make up this package and the whole
  &homalg; project came out of intensive discussions
  with <Alt Only="Text">Daniel Robertz</Alt>
  <Alt Not="Text"><URL Text="Daniel
  Robertz">https://www.plymouth.ac.uk/staff/daniel-robertz</URL></Alt> during
  our early collaboration, where we developed our philosophy of a meta
  package for homological algebra and <Alt Only="Text">implemented</Alt>
  <Alt Not="Text"><URL Text="implemented">https://algebra.mathematik.uni-siegen.de/barakat/homalg_in_maple/</URL></Alt>
  it in &Maple;.
  This &Maple; package &homalg; is <Alt Only="Text">now part of</Alt><Alt Not="Text">
  <URL Text="now part of">https://github.com/homalg-project/homalg_project/tree/master/RingsForHomalg/maple</URL></Alt> the GAP package &RingsForHomalg;. <P/>
  
  In the fall of 2007 I began collaborating
  with <Alt Only="Text">Simon Görtzen</Alt>
  <Alt Not="Text"><URL Text="Simon
  Görtzen">https://www.linkedin.com/in/simongoertzen/</URL></Alt> to
  further pursue and extend these <Alt Only="HTML"><Ref Text="ideas"
  Sect="Ring dictionaries" BookName="Modules"/></Alt>
  <Alt Not="HTML">ideas</Alt> preparing the transition to &GAP4;. With
  his help &homalg; became an extendable multi-package project. <P/>
  
  Max Neunhöffer convinced me to use his wonderful &IO; package to
  start communicating with external computer algebra systems. This was
  crucial to remedy the yet missing support for important rings in
  &GAP;. Max provided the first piece of code to access the computer
  algebra system &Singular;. This was the starting point of the
  packages &HomalgToCAS; and &IO_ForHomalg;, which were further abstracted
  by Simon and myself enabling &homalg; to communicate with virtually any external
  (computer algebra) system. <P/>
  
  <Alt Not="Text"><URL Text="Thomas
  Bächler">https://www.researchgate.net/scientific-contributions/50557632_Thomas_Baechler</URL></Alt>
  <Alt Only="Text">Thomas Bächler</Alt> wrote the package
  &MapleForHomalg; to directly access &Maple; via its
  &C;-interface. It offers an alternative to the package
  &IO_ForHomalg;, which requires &Maple;'s terminal
  interface <C>cmaple</C>. <P/>
  
  The basic support for &Sage; was added by Simon, and the support for
  &Singular; was initiated by
  <Alt Only="Text">Markus Lange-Hegermann</Alt>
  <Alt Not="Text"><URL Text="Markus
  Lange-Hegermann">https://www.th-owl.de/eecs/fachbereich/team/markus-lange-hegermann/</URL></Alt>
  and continued by him and Simon, while
  <Alt Only="Text">Markus Kirschmer</Alt>
  <Alt Not="Text"><URL Text="Markus
  Kirschmer">http://www.math.rwth-aachen.de/~Markus.Kirschmer/</URL></Alt>
  contributed the complete support for &MAGMA;. This formed the
  beginning of the &RingsForHomalg; package. Recently, Daniel added
  the support for &Macaulay2;. <P/>
  
  My concerns about how to handle the garbage collection in the
  external computer algebra systems were evaporated with the idea of
  Thomas Breuer using the so-called <Alt Only="Text">weak
  pointers</Alt><Alt Only="LaTeX"><URL Text="weak
  pointers">http://www.gap-system.org/Manuals/doc/ref/chap86.html</URL></Alt>
  <Alt Only="HTML"><Ref Chap="Weak Pointers" Text="weak pointers"
  BookName="Reference"/></Alt> in &GAP4; to keep track of all the
  external objects that became obsolete for &homalg;. This idea took
  shape in a discussion with him and Frank Lübeck and finally found
  its way into the package &HomalgToCAS;. <P/>
  
  My gratitude to all with whom I worked together to develop extension
  packages and those who developed their own packages within the
  &homalg; project (&see; Appendix <Ref Sect="homalg-Project"/>).
  Without their contributions the package &homalg; would have remained
  a core without a body:
  
  <List>
    <Item><URL Text="Thomas Bächler">https://www.researchgate.net/scientific-contributions/50557632_Thomas_Baechler</URL></Item>
    <Item>Barbara Bremer</Item>
    <Item><URL Text="Thomas Breuer">http://www.math.rwth-aachen.de/~Thomas.Breuer/</URL></Item>
    <Item>Anna Fabiańska</Item>
    <Item><URL Text="Simon Görtzen">https://www.linkedin.com/in/simongoertzen/</URL></Item>
    <Item><URL Text="Markus Kirschmer">http://www.math.rwth-aachen.de/~Markus.Kirschmer/</URL></Item>
    <Item><URL Text="Markus Lange-Hegermann">https://www.th-owl.de/eecs/fachbereich/team/markus-lange-hegermann/</URL></Item>
    <Item><URL Text="Frank Lübeck">http://www.math.rwth-aachen.de/~Frank.Luebeck/</URL></Item>
    <Item><URL Text="Max Neunhöffer">https://www.arangodb.com/speakers/max-neunhoeffer/</URL></Item>
    <Item><URL Text="Daniel Robertz">https://www.plymouth.ac.uk/staff/daniel-robertz</URL></Item>
  </List>
  
  I would also like to thank <Alt Only="Text">Alban Quadrat</Alt>
  <Alt Not="Text"><URL Text="Alban
  Quadrat">https://who.rocq.inria.fr/Alban.Quadrat/</URL></Alt>
  for supporting the &homalg; project and for all the wonderful
  discussions we had. At several places in the code I was happy to add
  the comment: <Q>I learned this from Alban</Q>.
  
  <Par></Par>
  
  My teacher <Alt Not="Text"><URL Text="Wilhelm
  Plesken">https://www.researchgate.net/profile/Wilhelm_Plesken</URL></Alt>
  <Alt Only="Text">Wilhelm Plesken</Alt> remains an inexhaustible source of
  extremely broad and deep knowledge. Thank you for being such a
  magnificent person. <P/>
  
  This manual was created using the GAPDoc package of Max Neunhöffer
  and Frank Lübeck. <P/>

  Last but not least, thanks
  to <E>Miriam</E>, <E>Josef</E>, <E>Jonas</E>, and <E>Irene</E> for
  the endless love and support.
  
  <P/>
  <P/>
  Mohamed Barakat
                    """
    )
),

));
