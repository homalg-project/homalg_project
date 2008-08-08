#############################################################################
##
##  SparseMatrixGF2.gi          Gauss package                 Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for Gauss with sparse matrices over GF(2).
##
#############################################################################

##    
InstallMethod( ConvertSparseMatrixToMatrix,
        [ IsSparseMatrixGF2Rep ],
  function( SM )
    local indices, i, j, ring, M;
    if SM!.nrows = 0 then
	return [ ];
    elif SM!.ncols = 0 then
        return List( [ 1 .. SM!.nrows ], i -> [] );
    fi;
    
    ring := GF(2);
    
    indices := SM!.indices;

    M := NullMat( SM!.nrows, SM!.ncols, ring );
    
    for i in [ 1 .. SM!.nrows ] do
        for j in [ 1 .. Length( indices[i] ) ] do
            M[ i ][ indices[i][j] ] := One( ring );
        od;
    od;
    
    return M;
    
  end
  
);
  
##
InstallMethod( CopyMat,
        [ IsSparseMatrixGF2Rep ],
  function( M )
    local indices, i;
    indices := [];
    for i in [ 1 .. M!.nrows ] do
        indices[i] := ShallowCopy( M!.indices[i] );
    od;
    return SparseMatrix( M!.nrows, M!.ncols, indices, GF(2) );
  end
);

##
InstallMethod( GetEntry,
        [ IsSparseMatrixGF2Rep, IsInt, IsInt ],
  function( M, i, j )
    local p;
    p := PositionSet( M!.indices[i], j );
    if p = fail then
        return Zero( GF(2) );
    else
        return One( GF(2) );
    fi;
  end
);

##
InstallMethod( SetEntry,
        [ IsSparseMatrixGF2Rep, IsInt, IsInt, IsRingElement ],
  function( M, i, j, e )
    local ring, pos;
    ring := GF(2);
    if not e in ring then
        Error( "the element has to be in ", ring, "!" );
    fi;
    pos := PositionSorted( M!.indices[i], j );
    if IsBound( M!.indices[i][pos] ) and M!.indices[i][pos] = j then
        if e = Zero( ring ) then
            Remove( M!.indices[i], pos );
        fi;
    else
        if e <> Zero( ring ) then
            Add( M!.indices[i], j, pos );
        fi;
    fi;
  end
);

##
InstallMethod( AddToEntry,
        [ IsSparseMatrixGF2Rep, IsInt, IsInt, IsRingElement ],
  function( M, i, j, e )
    local ring, pos;
    ring := GF(2);
    if not e in ring then
        Error( "the element has to be in ", ring, "!" );
    fi;
    if e = Zero( ring ) then
        return true;
    fi;
    pos := PositionSorted( M!.indices[i], j );
    if IsBound( M!.indices[i][pos] ) and M!.indices[i][pos] = j then
        Remove( M!.indices[i], pos );
        return Zero( ring );
    else
        Add( M!.indices[i], j, pos );
        return One( ring );
    fi;
  end
);

##
InstallOtherMethod( AddToEntry,
        [ IsSparseMatrixGF2Rep, IsInt, IsInt ],
  function( M, i, j )
    return AddToEntry( M, i, j, One( GF(2) ) );
  end
);

##
InstallMethod( Display,
        [ IsSparseMatrixGF2Rep ],
  function( M )
    local str, ws, last, i, j;
    if M!.nrows = 0 or M!.ncols = 0 then
        str := Concatenation( "<a ", String( M!.nrows ), " x ", String( M!.ncols ), " matrix over GF(2)>\n" );
    else
        str := "";
        ws := " ";
        for i in [ 1 .. M!.nrows ] do
            last := 0;
            for j in [ 1 .. Length( M!.indices[i] ) ] do
		str := Concatenation( str, Concatenation( ListWithIdenticalEntries( M!.indices[i][j] - 1 - last, Concatenation( ws, "." ) ) ), ws, "1" );
                last := M!.indices[i][j];
            od;
            str := Concatenation( str, Concatenation( ListWithIdenticalEntries( M!.ncols - last, Concatenation( ws, "." ) ) ), "\n" );
        od;
    fi;
    Print( str );
    return;
  end
);

##
InstallMethod( PrintObj,
        [ IsSparseMatrixGF2Rep ],
  function( M )
    Print( "SparseMatrix( ", M!.nrows, ", ", M!.ncols, ", ", M!.indices, ", ", M!.ring, " )" );
  end
);
  
  
  
  
##
InstallMethod( \=,
        [ IsSparseMatrixGF2Rep, IsSparseMatrixGF2Rep ],
  function( A, B )
    return A!.nrows = B!.nrows and
           A!.ncols = B!.ncols and
           A!.indices = B!.indices;
  end
);
  
##
InstallMethod( TransposedSparseMat,
        [ IsSparseMatrixGF2Rep ],
  function( M )
    local T, i, j;
    T := SparseZeroMatrix( M!.ncols, M!.nrows, GF(2) );
    for i in [ 1 .. M!.nrows ] do
        for j in [ 1 .. Length( M!.indices[i] ) ] do
            Add( T!.indices[ M!.indices[i][j] ], i );
        od;
    od;

    return T;
    
  end
);

##
InstallMethod( CertainRows,
        [ IsSparseMatrixGF2Rep, IsList ],
  function( M, L )
    return SparseMatrix( Length( L ), M!.ncols, M!.indices{ L }, GF(2) );
  end
);
  
##
InstallMethod( CertainColumns,
        [ IsSparseMatrixGF2Rep, IsList ],
  function( M, L )
    local indices, list, i, j, column, p;
    indices := List( [ 1 .. M!.nrows ], i -> [] );
    
    for i in [ 1 .. M!.nrows ] do
        for j in [ 1 .. Length( L ) ] do
            column := L[j];
            p := PositionSet( M!.indices[i], column);
	    if p <> fail then
                Add( indices[i], j );
            fi;
        od;
    od;
    
    return SparseMatrix( M!.nrows, Length( L ), indices, GF(2) );
    
  end
);
  
##
InstallMethod( UnionOfRows,
        [ IsSparseMatrixGF2Rep, IsSparseMatrixGF2Rep ],
  function( A, B )
    return SparseMatrix( A!.nrows + B!.nrows, A!.ncols, Concatenation( A!.indices, B!.indices ), GF(2) );
  end
);
  
##
InstallMethod( UnionOfColumns,
        [ IsSparseMatrixGF2Rep, IsSparseMatrixGF2Rep ],
  function( A, B )
    return SparseMatrix( A!.nrows, A!.ncols + B!.ncols, List( [ 1 .. A!.nrows ], i -> Concatenation( A!.indices[i], B!.indices[i] + A!.ncols ) ) );
  end
);

##
InstallMethod( \*,
        [ IsRingElement, IsSparseMatrixGF2Rep ],
  function( a, A )
    local i, m;
    if IsZero( a ) then
        return SparseZeroMatrix( A!.nrows, A!.ncols, GF(2) );
    else #a = 1
        return A;
    fi;
  end
);
  
##
InstallMethod( \*,
        [ IsSparseMatrixGF2Rep, IsSparseMatrixGF2Rep ],
  function( A, B )
    local C, i, j, rownr, m;
    if A!.ncols <> B!.nrows then
        return fail;
    fi;
    C := SparseZeroMatrix( A!.nrows, B!.ncols, GF(2) );
    for i in [ 1 .. C!.nrows ] do
        for j in [ 1 .. Length( A!.indices[i] ) ] do
            rownr := A!.indices[i][j];
            C!.indices[i] := AddRow( B!.indices[rownr], C!.indices[i] );
        od;
    od;
    return C;
  end
);

##
InstallMethod( \+,
        [ IsSparseMatrixGF2Rep, IsSparseMatrixGF2Rep ],
  function( A, B )
    local C, i;
    C := CopyMat( A );
    for i in [ 1 .. C!.nrows ] do
        C!.indices[i] := AddRow( B!.indices[i], C!.indices[i] );
    od;
    return C;
  end
);

##
InstallMethod( IsSparseIdentityMatrix,
        [ IsSparseMatrixGF2Rep ],
  function( M )
    local i;
    for i in [ 1 .. M!.nrows ] do
        if M!.indices[i] <> [i] then
            return false;
        fi;
    od;
    return true;
  end
);
  

##
InstallMethod( SparseKroneckerProduct,
        [ IsSparseMatrix, IsSparseMatrix ],
        function( A, B )
    local indices, i1, i2, rowindex, j1, j2, prod;
    
    indices := [];
    
    for i1 in [ 1 .. A!.nrows ] do
        for i2 in [ 1 .. B!.nrows ] do
            rowindex := ( i1 - 1 ) * B!.nrows + i2;
            indices[ rowindex ] := [];
            for j1 in [ 1 .. Length( A!.indices[i1] ) ] do
                for j2 in [ 1.. Length( B!.indices[i2] ) ] do
                    Add( indices[ rowindex ], ( A!.indices[i1][j1] - 1 ) * B!.ncols + B!.indices[i2][j2] );
                od;
            od;
        od;
    od;
    
    return SparseMatrix( A!.nrows * B!.nrows, A!.ncols * B!.ncols, indices, A!.ring );
    
  end
);

##
InstallOtherMethod( AddRow, #warning: this method does not have a side effect like the other AddRow!
        [ IsList, IsList ],
  function( row1, row2 )
    return SYMMETRIC_DIFFERENCE_SETS( row1, row2 );
  end
);

##
#InstallOtherMethod( AddRow, #old method, with desired side effect!
#        [ IsList, IsList ],
#  function( row1_indices,  row2_indices )
#    local m, j, i, index1, index2;
#    
#    m := Length( row1_indices );
#    
#    if m = 0 then
#        return rec( indices := row2_indices );
#    fi;
#    
#    i := 1;
#    j := 1;
#    
#    while i <= m do
#        if j > Length( row2_indices ) then
#            Append( row2_indices, row1_indices{[ i .. m ]} );
#            break;
#        fi;
#        
#        index1 := row1_indices[i];
#        index2 := row2_indices[j];
#        
#        if index1 > index2 then
#            j := j + 1;
#        elif index1 < index2 then
#            Add( row2_indices, index1, j );
#            i := i + 1;
#        else #index1 = index2
#            Remove( row2_indices, j );
#            i := i + 1;
#        fi;
#    od;
#    
#    return rec( indices := row2_indices );
#    
#  end
#  
#);
