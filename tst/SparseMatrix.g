## test file for the IsSparseMatrix category of sparse matrices

LoadPackage( "Gauss" );

rows := 4;
cols := 3;
field := GF(2);

certain_rows := [ 1, 3, 3 ];
certain_cols := [ 3, 2 ];

M := RandomMat( rows, cols, field );

SM := SparseMatrix( M );

if nrows( SM ) <> rows or ncols( SM ) <> cols then
    Error( "matrix dimension error!" );
fi;

MM := ConvertSparseMatrixToMatrix( SM );

if M <> MM then
    Error( "ConvertSparseMatrixToMatrix mismatch!" );
fi;

SM2 := CopyMat( SM );

if SM <> SM2 then
    Error( "CopyMat or '=' error!" );
fi;

L := List( [ 1 .. 4 ], i -> List( [ 1 .. 3 ], j -> GetEntry( SM, i, j ) ) );

if L <> M then
    Error( "GetEntry error!" );
fi;

if not IsSparseZeroMatrix( SparseZeroMatrix( rows, cols, field ) ) then
    Error( "(Is)SparseZeroMatrix error!" );
fi;

if not IsSparseIdentityMatrix( SparseIdentityMatrix( rows, field ) ) then
    Error( "(Is)SparseIdentityMatrix error!" );
fi;

if TransposedMat( M ) <> ConvertSparseMatrixToMatrix( TransposedSparseMat( SM ) ) then
    Error( "TransposedSparseMat error!");
fi;

if M{certain_rows} <> ConvertSparseMatrixToMatrix( CertainRows( SM, certain_rows ) ) then
    Error( "CertainRows error!" );
fi;

if M{[1..rows]}{certain_cols} <> ConvertSparseMatrixToMatrix( CertainColumns( SM, certain_cols ) ) then
    Error( "CertainColumns error!" );
fi;

if M{ Concatenation( [ 1 .. rows ], [ 1 .. rows ] ) } <> ConvertSparseMatrixToMatrix( UnionOfRows( SM, SM ) ) then
    Error( "UnionOfRows error!" );
fi;

if M{[1 .. rows ]}{ Concatenation( [ 1 .. cols ], [ 1 .. cols ] ) } <> ConvertSparseMatrixToMatrix( UnionOfColumns( SM, SM ) ) then
    Error( "UnionOfColumns error!" );
fi;

if M * TransposedMat( M ) <> ConvertSparseMatrixToMatrix( SM * TransposedSparseMat( SM ) ) then
    Error( "'*' (matrix composition) error!" );
fi;

if not IsSparseZeroMatrix( SM + SM ) then
    Error( "'+' (matrix addition) error!" );
fi;

if SparseZeroRows( SparseZeroMatrix( rows, cols, field ) ) <> [ 1 .. rows ] then
    Error( "SparseZeroRows error!" );
fi;

## not checked here:
#(Is)SparseDiagMat
# a * M
# AddRow (but this is checked indirectly with Gaussian algorithms)

Print( "***all checks successful!***\n" );
