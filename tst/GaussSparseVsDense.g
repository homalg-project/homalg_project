# test file for the Gaussian algorithms, both with dense and sparse

LoadPackage( "Gauss" );

M := RandomMat( 7, 12, GF( 2 ) );
N := RandomMat( 3, 12, GF( 2 ) );

SM := SparseMatrix( M );
REF := EchelonMat( N ).vectors;
SREF := SparseMatrix( REF );

Print( "\n------------------------------------\n");

Print( "- M:\n" );
Display( M );

Print( "* EchelonMat dense:\n" );
Display( EchelonMat( M ).vectors );

Print( "* EchelonMat sparse:\n" );
Display( EchelonMat( SM ).vectors );

Print( "@ EchelonMatTransformation dense:\n" );
Display( Concatenation( EchelonMatTransformation( M ).coeffs, EchelonMatTransformation( M ).relations ) );

Print( "@ EchelonMatTransformation sparse:\n" );
Display( UnionOfRows( EchelonMatTransformation( SM ).coeffs, EchelonMatTransformation( SM ).relations ) );

Print( "- REF:\n" );
Display( REF );

Print( "# ReduceMatWithEchelonMat dense:\n" );
Display( ReduceMatWithEchelonMat( M, REF ) );

Print( "# ReduceMatWithEchelonMat sparse:\n" );
Display( ReduceMatWithEchelonMat( SM, SREF ) );

Print( "^ KernelMat dense:\n" );
Display( KernelMat( M ).relations );

Print( "^ KernelMat sparse:\n" );
Display( KernelMat( SM ).relations );

Print( "------------------------------------\n\n");
