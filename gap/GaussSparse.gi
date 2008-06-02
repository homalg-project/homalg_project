#############################################################################
##
##  GaussSparse.gi               Gauss package                Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B fÅ¸r Mathematik, RWTH Aachen
##
##  Implementation stuff for performing Gauss algorithms on sparse matrices.
##
#############################################################################

########################################################
## Gaussian Algorithms:
########################################################

##
InstallMethod( EchelonMat,
        "method for sparse matrices",
        [ IsSparseMatrix ],
  function( mat )
    return EchelonMatDestructive( CopyMat( mat ) );
  end
);

##
InstallMethod( EchelonMatDestructive,
        "generic method for matrices",
        [ IsSparseMatrix ],
  function( mat )
    local nrows,     # number of rows in <mat>
          ncols,     # number of columns in <mat>
          indices,
          entries,
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
	  row_entries,
	  p;
	  
    
    nrows := mat!.nrows;
    ncols := mat!.ncols;
    
    indices := mat!.indices;
    entries := mat!.entries;
    
    heads   := ListWithIdenticalEntries( ncols, 0 );
    vectors := rec( indices := [], entries := [] );
    
    for i in [ 1 .. nrows ] do
        
        row_indices := indices[i];
        
        # Reduce the row with the known basis vectors.
        for j in [ 1 .. ncols ] do
            head := heads[j];
            if head <> 0 then
                p := PositionSet( row_indices, j );
                if p <> fail then
                    row_entries := entries[i];
                    x := - row_entries[p];
                    AddRow( vectors.indices[ head ], vectors.entries[ head ] * x, row_indices, row_entries );
                fi;
            fi;
        od;
        
        if Length( row_indices ) > 0 then
            j := row_indices[1];
            row_entries := entries[i];
            # We found a new basis vector.
            x := Inverse( row_entries[1] );
            if x = fail then
                TryNextMethod();
            fi;
            Add( vectors.indices, row_indices );
            Add( vectors.entries, row_entries * x );
            heads[j]:= Length( vectors.indices );
        fi;
        
    od;
    
    # gauss upwards:
    
    list := Filtered( heads, x->x<>0 );
    rank := Length( list );
    
    for j in [ncols,ncols-1..1] do
        head := heads[j];
        if head <> 0 then
            for i in Filtered( [1..head-1], x -> not x in heads{[j+1..ncols]} ) do
                row_indices := vectors.indices[i];
                p := PositionSet( row_indices, j );
                if p <> fail then
                    row_entries := vectors.entries[i];
                    x := - row_entries[p];
                    AddRow( vectors.indices[ head ], vectors.entries[ head ] * x, row_indices, row_entries );
                fi;
            od;
        fi;
    od;
    
    #order rows:
    
    vectors.indices := vectors.indices{list};
    vectors.entries := vectors.entries{list};
    
    list := Filtered( [1..ncols], j -> heads[j] <> 0 );
    heads{list} := [1..rank]; #just for compatibility, vectors are ordered already
    
    return rec( heads := heads,
                vectors := SparseMatrix( rank, ncols, vectors.indices, vectors.entries, mat!.field ) );
    
  end
);

##
InstallMethod( EchelonMatTransformation,
        "method for sparse matrices",
        [ IsSparseMatrix ],
  function( mat )
    return EchelonMatTransformationDestructive( CopyMat( mat ) );
  end
);

##
InstallMethod( EchelonMatTransformationDestructive,
        "method for sparse matrices",
        [ IsSparseMatrix ],
  function( mat )
    local nrows,     # number of rows in <mat>
          ncols,     # number of columns in <mat>
          indices,
          entries,
          vectors,   # list of basis vectors
          heads,     # list of pivot positions in 'vectors'
          coeffs,
          relations,
          field,
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
          row_entries,
          p,
          e;
    
    nrows := mat!.nrows;
    ncols := mat!.ncols;
    
    indices := mat!.indices;
    entries := mat!.entries;
    
    heads   := List( [ 1 .. ncols ], i -> 0 );
    vectors := rec( indices := [], entries := [] );
    coeffs := rec( indices := [], entries := [] );
    relations := rec( indices := [], entries := [] );
    
    field := mat!.field;
    
    if field = "unknown" then
        field := Rationals;
    fi;
    
    T := rec( indices := List( [ 1 .. nrows ], i -> [i] ), entries := List( [ 1 .. nrows ], i -> [ One( field ) ] ) );
    
    for i in [ 1 .. nrows ] do
        
        row_indices := indices[i];
        
        # Reduce the row with the known basis vectors.
        for j in [ 1 .. ncols ] do
            head := heads[j];
            if head <> 0 then
                p := PositionSet( row_indices, j );
                if p <> fail then
                    row_entries := entries[i];
                    x := - row_entries[p];
                    AddRow( coeffs.indices[ head ], coeffs.entries[ head ] * x, T.indices[i], T.entries[i] );
                    AddRow( vectors.indices[ head ], vectors.entries[ head ] * x, row_indices, row_entries );
                fi;
            fi;
        od;
        
        if Length( row_indices ) > 0 then
            j := row_indices[1];
            row_entries := entries[i];
            # We found a new basis vector.
            x := Inverse( row_entries[1] );
            if x = fail then
                TryNextMethod();
            fi;
            Add( coeffs.indices, T.indices[ i ] );
            Add( coeffs.entries, T.entries[ i ] * x );
            Add( vectors.indices, row_indices );
            Add( vectors.entries, row_entries * x );
            heads[j]:= Length( vectors.indices );
        else
            Add( relations.indices, T.indices[ i ] );
            Add( relations.entries, T.entries[ i ] );
        fi;
        
    od;
    
    # gauss upwards:
    
    list := Filtered( heads, x->x<>0 );
    rank := Length( list );
    
    for j in [ncols,ncols-1..1] do
        head := heads[j];
        if head <> 0 then
            for i in Filtered( [1..head-1], x -> not x in heads{[j+1..ncols]} ) do
                row_indices := vectors.indices[i];
                p := PositionSet( row_indices, j );
                if p <> fail then
                    row_entries := vectors.entries[i];
                    x := - row_entries[p];
                    AddRow( coeffs.indices[ head ], coeffs.entries[ head ] * x, coeffs.indices[i], coeffs.entries[i] );
                    AddRow( vectors.indices[ head ], vectors.entries[ head ] * x, row_indices, row_entries );
                fi;
            od;
        fi;
    od;
    
    #order rows:
    
    vectors.indices := vectors.indices{list};
    vectors.entries := vectors.entries{list};
    
    coeffs.indices := coeffs.indices{list};
    coeffs.entries := coeffs.entries{list};
    
    list := Filtered( [1..ncols], j -> heads[j] <> 0 );
    heads{list} := [1..rank]; #just for compatibility, vectors are ordered already
    
    return rec( heads := heads,
                vectors := SparseMatrix( rank, ncols, vectors.indices, vectors.entries, field ),
                coeffs := SparseMatrix( rank, nrows, coeffs.indices, coeffs.entries, field ),
                relations := SparseMatrix( nrows - rank, nrows, relations.indices, relations.entries, field ) );
    
  end
);

##
InstallMethod( ReduceMatWithEchelonMat,
        "for sparse matrices over a field, second argument must be in REF",
        [ IsSparseMatrix, IsSparseMatrix ],
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
          row1_entries,
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
                row1_entries := M!.entries[k];
                p := PositionSet( row1_indices, j );
		if p <> fail then
                    x := - row1_entries[p];
                    AddRow( row2_indices, N!.entries[i] * x, row1_indices, row1_entries );
                fi;
            od;
        fi;
    od;
    
    return M;

end);

##
InstallGlobalFunction( KernelMatSparse,
  function( arg )
    local M;
    
    M := CopyMat( arg[1] );
    
    if Length( arg ) = 1 then
        return KernelMatDestructive( M, [ 1 .. M!.nrows ] );
    elif Length( arg ) > 1 then
        return KernelMatDestructive( M, arg[2] );
    fi;
    
end );
                                                                                                                                                                          
##
InstallMethod( KernelMatDestructive,
        "method for sparse matrices",
        [ IsSparseMatrix, IsList ],
  function( mat, L )
    local nrows,
          ncols,
          indices,
          entries,
          vectors,
          heads,
          coeffs,
          relations,
          field,
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
          row_entries,
          p,
          e;
    
    nrows := mat!.nrows;
    ncols := mat!.ncols;    
    indices := mat!.indices;
    entries := mat!.entries;    
    heads   := List( [ 1 .. ncols ], i -> 0 );
    vectors := rec( indices := [], entries := [] );
    coeffs := rec( indices := [], entries := [] );
    relations := rec( indices := [], entries := [] );
    
    field := mat!.field;
    
    if field = "unknown" then
        field := Rationals;
    fi;
    
    T := rec( indices := List( [ 1 .. nrows ] , i -> [] ), entries := List( [ 1 .. nrows ], i -> [] ) );
    for i in [ 1 .. Length( L ) ] do
        T.indices[L[i]] := [i];
        T.entries[L[i]] := [ One( field ) ];
    od;
    
    for i in [ 1 .. nrows ] do
	row_indices := indices[i];        
        # Reduce the row with the known basis vectors.
        for j in [ 1 .. ncols ] do
            head := heads[j];
            if head <> 0 then
                p := PositionSet( row_indices, j );
                if p <> fail then
                    row_entries := entries[i];
                    x := - row_entries[p];
                    AddRow( vectors.indices[ head ], vectors.entries[ head ] * x, row_indices, row_entries );
                    AddRow( coeffs.indices[ head ], coeffs.entries[ head ] * x, T.indices[i], T.entries[i] );
                fi;
            fi;
        od;
        if Length( row_indices ) > 0 then
            j := row_indices[1];
            row_entries := entries[i];
            # We found a new basis vector.
            x := Inverse( row_entries[1] );
            if x = fail then
                TryNextMethod();
            fi;
            Add( vectors.indices, row_indices );
            Add( vectors.entries, row_entries * x );
            heads[j]:= Length( vectors.indices );
            Add( coeffs.indices, T.indices[ i ] );
            Add( coeffs.entries, T.entries[ i ] * x );
        else
            Add( relations.indices, T.indices[ i ] );
            Add( relations.entries, T.entries[ i ] );
        fi;
    od;
    
    return rec( relations := SparseMatrix( Length( relations.indices ), Length( L ), relations.indices, relations.entries, field ) );
    
end );


