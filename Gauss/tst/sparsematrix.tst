gap> LoadPackage( "Gauss", false );
true
gap> m := SparseMatrix(1,1,[[1]]);
<a 1 x 1 sparse matrix over GF(2)>
gap> Print(m+m,"\n");
SparseMatrix( 1, 1, [ [  ] ], GF(2) )
gap> Print(m+m+m,"\n");
SparseMatrix( 1, 1, [ [ 1 ] ], GF(2) )
gap> Print(m*m,"\n");
SparseMatrix( 1, 1, [ [ 1 ] ], GF(2) )

# Test SparseMatrix works with ranges
gap> m := SparseMatrix(3,3,[[1..3],[1,3..3],[1,2,3]]);
<a 3 x 3 sparse matrix over GF(2)>
gap> Print(m+m,"\n");
SparseMatrix( 3, 3, [ [  ], [  ], [  ] ], GF(2) )
gap> Print(m+m+m,"\n");
SparseMatrix( 3, 3, [ [ 1, 2, 3 ], [ 1, 3 ], [ 1, 2, 3 ] ], GF(2) )
gap> Print(m*m,"\n");
SparseMatrix( 3, 3, [ [ 1, 3 ], [  ], [ 1, 3 ] ], GF(2) )
