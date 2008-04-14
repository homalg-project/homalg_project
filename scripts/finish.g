g:=[]; h:=[]; H:=[]; k:=Dimension(ss);
H[1]:=[0];
Q:=[];Y:=[];

for i in [1..(k-1)] do
  g[i]:=HomalgGeneratorsForLeftModule(M[i],R);
  Y[i]:=M[i+1];
  Print("MatrixOfRelations for Syzygies: ", NrRows(Y[i]), " x ", NrColumns(Y[i]),"\n");
  h[i]:=HomalgGeneratorsForLeftModule(SyzygiesBasisOfRows(Y[i]));
  Print("Computing the Quotient...\n");
  Q[i]:=h[i]/g[i];
  Print("MatrixOfRelations: ", NrRelations(Q[i]), " x ", NrGenerators(Q[i]), "\n");
  Print( "Computing BetterGenerators...\n" );
  BetterGenerators(Q[i]);
  Print("MatrixOfRelations: ", NrRelations(Q[i]), " x ", NrGenerators(Q[i]), "\n");
  ElementaryDivisorsOfLeftModule(Q[i]);;
  Print("------------------------------------------------>>  ");
  Display(Q[i]);
od;
