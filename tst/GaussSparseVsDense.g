# test file for the Gaussian algorithms, both with dense and sparse

LoadPackage( "Gauss" );

M := RandomMat( 7, 12, GF( 2 ) );
N := RandomMat( 3, 12, GF( 2 ) );

SM := SparseMatrix( M );
REF := EchelonMat( N ).vectors;
SREF := SparseMatrix( REF );

if not IsSparseZeroMatrix( SparseMatrix( EchelonMat( M ).vectors ) + EchelonMat( SM ).vectors ) then
    Error( "EchelonMat mismatch!" );
fi;

if not IsSparseZeroMatrix( SparseMatrix( EchelonMatTransformation( M ).vectors ) + EchelonMatTransformation( SM ).vectors ) then
    Error( "EchelonMatTransformation.vectors mismatch!" );
fi;

if not IsSparseZeroMatrix( SparseMatrix( Concatenation( EchelonMatTransformation( M ).coeffs, EchelonMatTransformation( M ).relations ) ) + UnionOfRows( EchelonMatTransformation( SM ).coeffs, EchelonMatTransformation( SM ).relations ) ) then
    Error( "EchelonMatTransformation.(coeffs && relations ) mismatch!" );
fi;

if not IsSparseZeroMatrix( SparseMatrix( ReduceMatWithEchelonMat( M, REF ) ) + ReduceMatWithEchelonMat( SM, SREF ) ) then
    Error( "ReduceMatWithEchelonMat mismatch!" );
fi;

if not IsSparseZeroMatrix( SparseMatrix( KernelMat( M ).relations ) + KernelMat( SM ).relations ) then
    Error( "KernelMat mismatch!" );
fi;

Print( "***all checks successful!***\n" );

