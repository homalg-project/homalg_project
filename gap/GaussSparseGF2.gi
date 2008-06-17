#############################################################################
##
##  GaussSparseGF2.gi            Gauss package                Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B fÅ¸r Mathematik, RWTH Aachen
##
##  Implementation stuff for performing Gauss alg. on sparse GF(2) matrices.
##
#############################################################################

########################################################
## Gaussian Algorithms:
########################################################

##
InstallMethod( EchelonMatDestructive,
        "generic method for matrices",
        [ IsSparseMatrixGF2Rep ],
  function( mat )
    local nrows,     # number of rows in <mat>
          ncols,     # number of columns in <mat>
          indices,
          vectors,   # list of basis vectors
          heads,     # list of pivot positions in 'vectors'
          i,         # loop over rows
          j,         # loop over columns
          row,
          head,
          x,
          row2,
          rank,
          list,
	  row_indices,
	  p,
	  a;
    
    
    nrows := mat!.nrows;
    ncols := mat!.ncols;
    
    indices := mat!.indices;
    
    heads   := ListWithIdenticalEntries( ncols, 0 );
    vectors := rec( indices := [] );
    
    for i in [ 1 .. nrows ] do
        
        row_indices := indices[i];
        
        # Reduce the row with the known basis vectors.
        for j in [ 1 .. ncols ] do
            head := heads[j];
            if head <> 0 then
                p := PositionSet( row_indices, j );
                if p <> fail then
                    AddRow( vectors.indices[ head ], row_indices  );
                fi;
            fi;
        od;
        
        if Length( row_indices ) > 0 then
            j := row_indices[1];
            # We found a new basis vector.
            Add( vectors.indices, row_indices );
            heads[j]:= Length( vectors.indices );
        fi;
        
    od;
    
    # gauss upwards:
    
    list := Filtered( heads, x -> x <> 0 );
    rank := Length( list );
    
    for j in [ ncols, ncols - 1 .. 1 ] do
        head := heads[j];
        if head <> 0 then
            a := Difference( [1..head-1], heads{[j+1..ncols]} );
            for i in a do
                row_indices := vectors.indices[i];
                p := PositionSet( row_indices, j );
                if p <> fail then
                    AddRow( vectors.indices[ head ], row_indices );
                fi;
            od;
        fi;
    od;
    
    #order rows:
    
    vectors.indices := vectors.indices{list};
    
    list := Filtered( [ 1 .. ncols ], j -> heads[j] <> 0 );
    heads{list} := [ 1 .. rank ]; #just for compatibility, vectors are ordered already
    
    return rec( heads := heads,
                vectors := SparseMatrix( rank, ncols, vectors.indices ) );
    
  end
);

##
InstallMethod( EchelonMatTransformationDestructive,
        "method for sparse matrices",
        [ IsSparseMatrixGF2Rep ],
  function( mat )
    local nrows,     # number of rows in <mat>
          ncols,     # number of columns in <mat>
          indices,
          vectors,   # list of basis vectors
          heads,     # list of pivot positions in 'vectors'
          coeffs,
          relations,
          ring,
          i,         # loop over rows
          j,         # loop over columns
          T,
          row,
          head,
          x,
          row2,
          rank,
          list,
          row_indices,
          p;
    
    nrows := mat!.nrows;
    ncols := mat!.ncols;
    
    indices := mat!.indices;
    
    heads   := List( [ 1 .. ncols ], i -> 0 );
    vectors := rec( indices := [] );
    coeffs := rec( indices := [] );
    relations := rec( indices := [] );
    
    T := rec( indices := List( [ 1 .. nrows ], i -> [i] ) );
    
    for i in [ 1 .. nrows ] do
        
        row_indices := indices[i];
        
        # Reduce the row with the known basis vectors.
        for j in [ 1 .. ncols ] do
            head := heads[j];
            if head <> 0 then
                p := PositionSet( row_indices, j );
                if p <> fail then
                    AddRow( coeffs.indices[ head ], T.indices[i] );
                    AddRow( vectors.indices[ head ], row_indices );
                fi;
            fi;
        od;
        
        if Length( row_indices ) > 0 then
            j := row_indices[1];
            # We found a new basis vector.
            Add( coeffs.indices, T.indices[ i ] );
            Add( vectors.indices, row_indices );
            heads[j]:= Length( vectors.indices );
        else
            Add( relations.indices, T.indices[ i ] );
        fi;
        
    od;
    
    # gauss upwards:
    
    list := Filtered( heads, x -> x <> 0 );
    rank := Length( list );
    
    for j in [ ncols, ncols - 1 .. 1 ] do
        head := heads[j];
        if head <> 0 then
            a := Difference( [1..head-1], heads{[j+1..ncols]} );
            for i in a  do
                row_indices := vectors.indices[i];
                p := PositionSet( row_indices, j );
                if p <> fail then
                    AddRow( coeffs.indices[ head ], coeffs.indices[i] );
                    AddRow( vectors.indices[ head ], row_indices );
                fi;
            od;
        fi;
    od;
    
    #order rows:
    
    vectors.indices := vectors.indices{list};
    
    coeffs.indices := coeffs.indices{list};
    
    list := Filtered( [1..ncols], j -> heads[j] <> 0 );
    heads{list} := [ 1 .. rank ]; #just for compatibility, vectors are ordered already
    
    return rec( heads := heads,
                vectors := SparseMatrix( rank, ncols, vectors.indices ),
                coeffs := SparseMatrix( rank, nrows, coeffs.indices ),
                relations := SparseMatrix( nrows - rank, nrows, relations.indices ) );
    
  end
);

##
InstallMethod( ReduceMatWithEchelonMat,
        "for sparse matrices over a ring, second argument must be in REF",
        [ IsSparseMatrixGF2Rep, IsSparseMatrixGF2Rep ],
  function( mat, N )
    local nrows1,
          ncols,
          nrows2,
          M,
          i,
          j,
          k,
          x,
          p,
          row1_indices,
          row2_indices;
    
    nrows1 :=  mat!.nrows;
    nrows2 := N!.nrows;
    
    if nrows1 = 0 or nrows2 = 0 then
        return mat;
    fi;
    
    ncols := mat!.ncols;
    if ncols <> N!.ncols then
        return fail;
    elif ncols = 0 then
        return mat;
    fi;
    
    M := CopyMat( mat );
    
    for i in [ 1 .. nrows2 ] do
        row2_indices := N!.indices[i];
        if Length( row2_indices ) > 0 then
            j := row2_indices[1];
            for k in [ 1 .. nrows1 ] do
                row1_indices := M!.indices[k];
                p := PositionSet( row1_indices, j );
		if p <> fail then
                    AddRow( row2_indices, row1_indices );
                fi;
            od;
        fi;
    od;
    
    return M;

end);

##
InstallMethod( KernelEchelonMatDestructive,
        "method for sparse matrices",
        [ IsSparseMatrixGF2Rep, IsList ],
  function( mat, L )
    local nrows,
          ncols,
          indices,
          vectors,
          heads,
          coeffs,
          relations,
          i,
          j,
          T,
          row,
          head,
          x,
          row2,
          rank,
          list,
          row_indices,
          p;
    
    nrows := mat!.nrows;
    ncols := mat!.ncols;    
    indices := mat!.indices;
    heads   := List( [ 1 .. ncols ], i -> 0 );
    vectors := rec( indices := [] );
    coeffs := rec( indices := [] );
    relations := rec( indices := [] );
    
    T := rec( indices := List( [ 1 .. nrows ] , i -> [] ) );
    for i in [ 1 .. Length( L ) ] do
        T.indices[L[i]] := [i];
    od;
    
    for i in [ 1 .. nrows ] do
	row_indices := indices[i];        
        # Reduce the row with the known basis vectors.
        for j in [ 1 .. ncols ] do
            head := heads[j];
            if head <> 0 then
                p := PositionSet( row_indices, j );
                if p <> fail then
                    AddRow( vectors.indices[ head ], row_indices );
                    AddRow( coeffs.indices[ head ], T.indices[i] );
                fi;
            fi;
        od;
        if Length( row_indices ) > 0 then
            j := row_indices[1];
            # We found a new basis vector.
            Add( vectors.indices, row_indices );
            heads[j]:= Length( vectors.indices );
            Add( coeffs.indices, T.indices[ i ] );
        else
            Add( relations.indices, T.indices[ i ] );
        fi;
    od;
    
    return rec( relations := SparseMatrix( Length( relations.indices ), Length( L ), relations.indices ) );
    
  end
);

##
InstallMethod( RankDestructive,
        "method for sparse matrices",
        [ IsSparseMatrixGF2Rep, IsInt ],
  function( mat, upper_boundary )
    local nrows,
          ncols,
          indices,
          vectors,
          heads,
          coeffs,
          relations,
          ring,
          i,
          j,
          T,
          row,
          head,
          x,
          row2,
          rank,
          list,
          row_indices,
          p;
    
    nrows := mat!.nrows;
    ncols := mat!.ncols;
    indices := mat!.indices;
    heads   := List( [ 1 .. ncols ], i -> 0 );
    vectors := rec( indices := [] );
    
    for i in [ 1 .. nrows ] do
        row_indices := indices[i];
        # Reduce the row with the known basis vectors.
        for j in [ 1 .. ncols ] do
            head := heads[j];
            if head <> 0 then
                p := PositionSet( row_indices, j );
                if p <> fail then
                    AddRow( vectors.indices[ head ], row_indices );
                fi;
            fi;
        od;
        if Length( row_indices ) > 0 then
            j := row_indices[1];
            # We found a new basis vector.
            Add( vectors.indices, row_indices );
            heads[j]:= Length( vectors.indices );
	    if heads[j] = upper_boundary then
                return upper_boundary;
            fi;
        fi;
    od;
    
    return Length( vectors.indices );
    
  end
);


