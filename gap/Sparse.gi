#############################################################################
##
##  Sparse.gi              Gauss package                      Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for Gauss with sparse matrices.
##
#############################################################################

##
DeclareRepresentation( "IsSparseMatrixRep",
        IsSparseMatrix, [ "nrows", "ncols", "indices", "entries" ] );

##
BindGlobal( "TheFamilyOfSparseMatrices",
        NewFamily( "TheFamilyOfSparseMatrices" ) );

##
BindGlobal( "TheTypeSparseMatrix",
        NewType( TheFamilyOfSparseMatrices, IsSparseMatrixRep ) );

##
InstallGlobalFunction( SparseMatrix,
  function( arg )
    local nargs, M, nrows, ncols, i, j, indices, entries;
    
    nargs := Length( arg );
    
    if nargs = 4 then
        return Objectify( TheTypeSparseMatrix, rec( nrows := arg[1], ncols := arg[2], indices := arg[3], entries := arg[4] ) );
    elif nargs > 1 then
        Error( "wrong number of arguments! SparseMatrix expects nrows, ncols, indices, entries!" ); 
    elif not IsList( arg[ 1 ] ) then
        Error( "SparseMatrix constructor with 1 argument expects a Matrix or List!" );
    fi;
    
    M := arg[1];
    
    nrows := Length( M );
    
    if nrows = 0 then
        return SparseMatrix( 0, 0, [], [] );
    fi;
    
    ncols := Length( M[1] );
    
    if ncols = 0 then
        return SparseMatrix( nrows, 0, [], [] );
    fi;
    
    indices := [];
    entries := [];
    
    for i in [ 1..nrows ] do
        indices[i] := [];
        entries[i] := [];
        for j in [ 1..ncols ] do
            if not IsZero( M[i][j] ) then
                Add( indices[i], j );
                Add( entries[i], M[i][j] );
            fi;
        od;
    od;
    
    return SparseMatrix( nrows, ncols, indices, entries );
    
    end
);

##    
InstallMethod( ConvertSparseMatrixToMatrix,
        [ IsSparseMatrix ],
  function( SM )
    local indices, entries, found_field, i, j, field, M;
    if SM!.nrows = 0 then
	return [ ];
    elif SM!.ncols = 0 then
        return ListWithIdenticalEntries( SM!.nrows, [] );
    fi;
    indices := SM!.indices;
    entries := SM!.entries;
    found_field := false;
    for i in [ 1 .. SM!.nrows ] do
        for j in [ 1 .. Length( indices[i] ) ] do
            if found_field = false then
                field := Field( entries[i][j] );
                M := NullMat( SM!.nrows, SM!.ncols, field );
                found_field := true;
            fi;
            M[ i ][ indices[i][j] ] := entries[i][j];
        od;
    od;
    
    return M;
  end
  
);
  
##
InstallMethod( AddRow,
        [ IsList, IsList, IsList, IsList ],
  function( row1_indices, row1_entries, row2_indices, row2_entries )
    local m, zero, j, i, index1, index2;
    
    m := Length( row1_indices );
    
    if m = 0 then
        return rec( indices := row2_indices, entries := row2_entries );
    fi;
    
    zero := Zero( row1_entries[1] );
    
    i := 1;
    j := 1;
    
    while i <= m do
        if j > Length( row2_indices ) then
            Append( row2_indices, row1_indices{[ i .. m ]} );
            Append( row2_entries, row1_entries{[ i .. m ]} );
            break;
        fi;
        
        index1 := row1_indices[i];
        index2 := row2_indices[j];
        
        if index1 > index2 then
            j := j + 1;
        elif index1 < index2 then
            Add( row2_indices, index1, j );
            Add( row2_entries, row1_entries[i], j );
            i := i + 1;
        elif index1 = index2 then
            row2_entries[j] := row2_entries[j] + row1_entries[i];
            if row2_entries[j] = zero then
                Remove( row2_entries, j );
                Remove( row2_indices, j );
            fi;
            i := i + 1;
        fi;
    od;
    
    return rec( indices := row2_indices, entries := row2_entries );
    
  end
  
);
  
##
InstallMethod( EchelonMat,
        "method for sparse matrices",
        [ IsSparseMatrix ],
        function( mat )
    local copy_indices, copy_entries, i;
    copy_indices := [];
    copy_entries := [];
    for i in [ 1 .. mat!.nrows ] do
        copy_indices[i] := ShallowCopy( mat!.indices[i] );
	copy_entries[i] := ShallowCopy( mat!.entries[i] );
    od;
    return EchelonMatDestructive( SparseMatrix( mat!.nrows, mat!.ncols, copy_indices, copy_entries ) );
end);

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
          row, head, x, row2, rank, list,
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
                vectors := SparseMatrix( rank, ncols, vectors.indices, vectors.entries ) );
    
end );

##
InstallMethod( EchelonMatTransformation,
        "method for sparse matrices",
        [ IsSparseMatrix ],
        function( mat )
    local copy_indices, copy_entries, i;
    copy_indices := [];
    copy_entries := [];    
    for i in [ 1 .. mat!.nrows ] do
        copy_indices[i] := ShallowCopy( mat!.indices[i] );
        copy_entries[i] := ShallowCopy( mat!.entries[i] );
    od;
    return EchelonMatTransformationDestructive( SparseMatrix( mat!.nrows, mat!.ncols, copy_indices, copy_entries ) );
end);

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
          row, head, x, row2, rank, list,
          row_indices,
          row_entries,
          p,
          e;
    
    nrows := mat!.nrows;
    ncols := mat!.ncols;
    
    indices := mat!.indices;
    entries := mat!.entries;
    
    heads   := ListWithIdenticalEntries( ncols, 0 );
    vectors := rec( indices := [], entries := [] );
    coeffs := rec( indices := [], entries := [] );
    relations := rec( indices := [], entries := [] );
    
    i := 1;
    
    while not IsBound( field ) and i <= nrows  do
        if indices[i] <> [] then
            field := Field( entries[i][1] );
        fi;
        i := i + 1;
    od;
    
    if not IsBound( field) then
        field := Rationals;
    fi;
    
    T := rec( indices := List( [ 1 .. nrows ], i -> [i] ), entries := ListWithIdenticalEntries( nrows, [ One( field ) ] ) );
    
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
                    AddRow( coeffs.indices[ head ], coeffs.indices[ head ] * x, T.indices[i], T.entries[i] );
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
                    AddRow( coeffs.indices[ head ], coeffs.indices[ head ] * x, T.indices[i], T.entries[i] );
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
                vectors := SparseMatrix( rank, ncols, vectors.indices, vectors.entries ),
                coeffs := SparseMatrix( rank, nrows, coeffs.indices, coeffs.entries ),
                relations := SparseMatrix( nrows - rank, nrows, relations.indices, relations.entries ) );
    
end );

##
InstallMethod( ReduceMatWithEchelonMat,
        "for sparse matrices over a field, second argument must be in REF",
        [ IsSparseMatrix, IsSparseMatrix ],
        function( mat, N )
    local nrows1, ncols, nrows2, M, i, j, k, x, p, row1_indices, row1_entries, row2_indices;
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
    
    M := rec( indices := [], entries := [] );
    for i in [ 1 .. nrows1 ] do
        M.indices[i] := ShallowCopy( mat!.indices[i] );
	M.entries[i] := ShallowCopy( mat!.entries[i] );
    od;
    
    
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
    
    return SparseMatrix( nrows1, ncols, M.indices, M.entries );

end);

##
InstallGlobalFunction( KernelMatSparse,
  function( arg )
    local M, copy_indices, copy_entries, i;
    copy_indices := [];
    copy_entries := [];
    
    M := arg[1];
    
    for i in [ 1 .. M!.nrows ] do
        copy_indices[i] := ShallowCopy( M!.indices[i] );
        copy_entries[i] := ShallowCopy( M!.entries[i] );
    od;                                                                                                                                                                    
    
    if Length( arg ) = 1 then
        return KernelMatDestructive( SparseMatrix( M!.nrows, M!.ncols, copy_indices, copy_entries ), [ 1 .. M!.nrows ] );
    elif Length( arg ) > 1 then
        return KernelMatDestructive( SparseMatrix( M!.nrows, M!.ncols, copy_indices, copy_entries ), arg[2] );
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
          row, head, x, row2, rank, list,
          row_indices,
          row_entries,
          p,
          e;
    
    nrows := mat!.nrows;
    ncols := mat!.ncols;    
    indices := mat!.indices;
    entries := mat!.entries;    
    heads   := ListWithIdenticalEntries( ncols, 0 );
    vectors := rec( indices := [], entries := [] );
    coeffs := rec( indices := [], entries := [] );
    relations := rec( indices := [], entries := [] );
    i := 1;
    while not IsBound( field ) and i <= nrows  do
        if indices[i] <> [] then
            field := Field( entries[i][1] );
        fi;
        i := i + 1;
    od;
    
    if not IsBound( field) then
        field := Rationals;
    fi;
    
    T := rec( indices := ListWithIdenticalEntries( nrows, [ ] ), entries := ListWithIdenticalEntries( nrows, [ ] ) );
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
    
    return rec( relations := SparseMatrix( Length( relations.indices ), Length( L ), relations.indices, relations.entries ) );
    
end );

