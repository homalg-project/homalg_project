Read( "../examples/homalg.g" );
Read( "../examples/singular_C_vs_c.g" );
Read( "../examples/Coefficients.g" );

files := [
          "gap_ZZ.g",
          "magma_ZZ.g",
          "maple_ZZ.g",
          ## "sage_ZZ.g", ## Sage 9.0: the interface is broken
          "magma_Qx.g",
          "maple_Qx.g",
          ## "sage_Qx.g" ## Sage 4.1.1: no Hermite normal form implemented yet
          ## "singular_Qx.g" ## Singular 3-0-4: buggy Smith normal form of non-quadratic matrices
          ];

for f in files do

    Read( f );
    
    ByASmallerPresentation( W );
    
    B := BasisOfModule( W );
    
    Display( B );
    Display( W );
    
    Print( "\n--------------------------------\n" );
    
od;
