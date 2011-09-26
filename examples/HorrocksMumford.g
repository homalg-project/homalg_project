##  <#GAPDoc Label="HorrocksMumford">
##  <Subsection Label="HorrocksMumford">
##  <Heading>Horrocks Mumford bundle</Heading>
##  This example computes the global sections module of the Horrocks-Mumford bundle.
##  <Example><![CDATA[
##  gap> LoadPackage( "GradedRingForHomalg" );;
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "x0..x4";;
##  gap> S := GradedRing( R );;
##  gap> A := KoszulDualRing( S, "e0..e4" );;
##  gap> LoadPackage( "GradedModules" );;
##  gap> mat := HomalgMatrix( "[ \
##  > e1*e4, e2*e0, e3*e1, e4*e2, e0*e3, \
##  > e2*e3, e3*e4, e4*e0, e0*e1, e1*e2  \
##  > ]",
##  > 2, 5, A );
##  <A 2 x 5 matrix over a graded ring>
##  gap> phi := GradedMap( mat, "free", "free", "left", A );;
##  gap> IsMorphism( phi );
##  true
##  gap> M := GuessModuleOfGlobalSectionsFromATateMap( 2, phi );
##  #I  GuessModuleOfGlobalSectionsFromATateMap uses unproven assumptions.
##   Do not trust the result.
##  <A graded left module presented by yet unknown relations for 19 generators>
##  gap> IsPure( M );
##  true
##  gap> Rank( M );
##  2 
##  gap> Display( BettiDiagram( Resolution( M ) ) );
##   total:  19 35 20  2
##  --------------------
##       3:   4  .  .  .
##       4:  15 35 20  .
##       5:   .  .  .  2
##  --------------------
##  degree:   0  1  2  3
##  gap> Display( BettiDiagram( TateResolution( M, -4, 6 ) ) );
##  total:   37  14  10   5   2   5  10  14  37 100 210   ?   ?   ?   ?
##  ----------|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
##      4:   35   4   .   .   .   .   .   .   .   .   .   0   0   0   0
##      3:    *   2  10  10   5   .   .   .   .   .   .   .   0   0   0
##      2:    *   *   .   .   .   .   2   .   .   .   .   .   .   0   0
##      1:    *   *   *   .   .   .   .   .   5  10  10   2   .   .   0
##      0:    *   *   *   *   .   .   .   .   .   .   .   4  35 100 210
##  ----------|---|---|---|---|---|---|---|---|---|---|---|---|---V---|
##  twist:   -8  -7  -6  -5  -4  -3  -2  -1   0   1   2   3   4   5   6
##  -------------------------------------------------------------------
##  Euler:    ?   ?   ?   ?  -5   0   2   0  -5 -10 -10   2  35 100 210
##  gap> M;
##  <A graded reflexive rank 2 left module presented by 94 relations for 19 genera\
##  tors>
##  gap> P := ElementOfGrothendieckGroup( M );
##  ( 2*O_{P^4} - 1*O_{P^3} - 4*O_{P^2} - 2*O_{P^1} ) -> P^4
##  gap> P!.DisplayTwistedCoefficients := true;
##  true
##  gap> P;
##  ( 2*O(-3) - 10*O(-2) + 15*O(-1) - 5*O(0) ) -> P^4
##  gap> chi := HilbertPolynomial( M );
##  1/12*t^4+2/3*t^3-1/12*t^2-17/3*t-5
##  gap> c := ChernPolynomial( M );
##  ( 2 | 1-h+4*h^2 ) -> P^4
##  gap> ChernPolynomial( M * S^3 );
##  ( 2 | 1+5*h+10*h^2 ) -> P^4
##  gap> ch := ChernCharacter( M );
##  [ 2-t-7*t^2/2!+11*t^3/3!+17*t^4/4! ] -> P^4
##  gap> HilbertPolynomial( ch );
##  1/12*t^4+2/3*t^3-1/12*t^2-17/3*t-5
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

LoadPackage( "GradedRingForHomalg" );;

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x0..x4";;

S := GradedRing( R );;

A := KoszulDualRing( S, "e0..e4" );;

LoadPackage( "GradedModules" );;

## [EFS, Example 7.3]:
## A famous Beilinson monad was discovered by Horrocks and Mumford [HM]:

mat := HomalgMatrix( "[ \
e1*e4, e2*e0, e3*e1, e4*e2, e0*e3, \
e2*e3, e3*e4, e4*e0, e0*e1, e1*e2  \
]",
2, 5, A );

phi := GradedMap( mat, "free", "free", "left", A );;
IsMorphism( phi );

M := GuessModuleOfGlobalSectionsFromATateMap( 2, phi );

IsPure( M );

Rank( M );

Display( BettiDiagram( Resolution( M ) ) );

Display( BettiDiagram( TateResolution( M, -4, 6 ) ) );

chi := HilbertPolynomial( M );

c := ChernPolynomial( M );

ch := ChernCharacter( M );

Assert( 0, HilbertPolynomial( ch ) = chi );
