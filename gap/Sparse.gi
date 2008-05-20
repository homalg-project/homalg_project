#############################################################################
##
##  Sparse.gi              Gauss package                      Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for Gauss with sparse matrices.
##
#############################################################################

##
DeclareRepresentation( "IsSparseMatrixRep",
        IsSparseMatrix, [ "nrows", "ncols", "indices", "entries", "field" ] );

##
BindGlobal( "TheFamilyOfSparseMatrices",
        NewFamily( "TheFamilyOfSparseMatrices" ) );

##
BindGlobal( "TheTypeSparseMatrix",
        NewType( TheFamilyOfSparseMatrices, IsSparseMatrixRep ) );

##
InstallGlobalFunction( SparseMatrix,
  function( arg )
    local nargs, M, nrows, ncols, i, j, indices, entries, field;
    
    nargs := Length( arg );
    
    if nargs = 5 then
        return Objectify( TheTypeSparseMatrix, rec( nrows := arg[1], ncols := arg[2], indices := arg[3], entries := arg[4], field := arg[5] ) );
    elif nargs = 4 then
        return Objectify( TheTypeSparseMatrix, rec( nrows := arg[1], ncols := arg[2], indices := arg[3], entries := arg[4], field := FindField( arg[4] ) ) );
    elif nargs > 1 then
        Error( "wrong number of arguments! SparseMatrix expects nrows, ncols, indices, entries, [field]!" ); 
    elif not IsList( arg[ 1 ] ) then
        Error( "SparseMatrix constructor with 1 argument expects a (dense) Matrix or List!" );
    fi;
    
    M := arg[1];
    
    nrows := Length( M );
    
    if nrows = 0 then
        return SparseMatrix( 0, 0, [], [], "unknown" );
    fi;
    
    ncols := Length( M[1] );
    
    if ncols = 0 then
        return SparseMatrix( nrows, 0, List( [ 1 .. nrows ], i -> [] ), List( [ 1 .. nrows ], i -> [] ), "unknown" );
    fi;
    
    indices := [];
    entries := [];
    
    field := Field( M[1][1] );
    
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
    
    return SparseMatrix( nrows, ncols, indices, entries, field );
    
    end
);

##    
InstallMethod( ConvertSparseMatrixToMatrix,
        [ IsSparseMatrix ],
  function( SM )
    local indices, entries, i, j, field, M;
    if SM!.nrows = 0 then
	return [ ];
    elif SM!.ncols = 0 then
        return List( [ 1 .. SM!.nrows ], i -> [] );
    fi;
    
    field := SM!.field;
    
    if field = "unknown" then
        field := Rationals;
    fi;
    
    indices := SM!.indices;
    entries := SM!.entries;

    M := NullMat( SM!.nrows, SM!.ncols, field );
    
    for i in [ 1 .. SM!.nrows ] do
        for j in [ 1 .. Length( indices[i] ) ] do
            M[ i ][ indices[i][j] ] := entries[i][j];
        od;
    od;
    
    return M;
    
  end
  
);
  
##
InstallMethod( CopyMat, #FIXME: several algorithms need to use this method instead of copying independently
        [ IsSparseMatrix ],
  function( M )
    local indices, entries, i;
    indices := [];
    entries := [];
    for i in [ 1 .. M!.nrows ] do
        indices[i] := ShallowCopy( M!.indices[i] );
        entries[i] := ShallowCopy( M!.entries[i] );
    od;
    return SparseMatrix( M!.nrows, M!.ncols, indices, entries, M!.field );
  end
);

##
InstallMethod( GetEntry,
        [ IsSparseMatrix, IsInt, IsInt ],
  function( M, i, j )
    local p;
    p := PositionSet( M!.indices[i], j );
    if p = fail then
        return Zero( M!.field );
    else
        return M!.entries[i][p];
    fi;
  end
);

##
InstallMethod( Display,
        [ IsSparseMatrix ],
  function( M )
    Display( ConvertSparseMatrixToMatrix( M ) );
    return;
  end
);

##
InstallMethod( FindField,
        [ IsList ],
  function( entries )
    local found_field, i, field;
    found_field := false;
    i := 1;
    while found_field = false and i <= Length( entries ) do
        if IsBound( entries[i][1] ) then
            field := Field( entries[i][1] );
            found_field := true;
        fi;
        i := i + 1;
    od;
    
    if found_field = true then
        return field;
    else
        return "unknown";
    fi;
    
  end
  
);
  
##
InstallGlobalFunction( SparseZeroMatrix,
  function( arg )
    local nargs, field;
    
    nargs := Length( arg );
    
    if IsField( arg[ nargs ] ) or arg[ nargs ] = "unknown" then
        field := arg[ Length( arg ) ];
        nargs := nargs - 1;
    else
        field := "unknown";
    fi;

    if nargs = 1 then
        return SparseMatrix( arg[1], arg[1], List( [ 1 .. arg[1] ], i -> [] ), List( [ 1 .. arg[1] ], i -> [] ), field );
    elif nargs = 2 then
        return SparseMatrix( arg[1], arg[2], List( [ 1 .. arg[1] ], i -> [] ), List( [ 1 .. arg[1] ], i -> [] ), field );
    else
        return fail;
    fi;
    
  end
);

##
InstallGlobalFunction( SparseIdentityMatrix,
  function( arg )
    local nargs, field, indices, entries;
    
    nargs := Length( arg );
    
    if IsField( arg[ nargs ] ) then
        field := arg[ Length( arg ) ];
        nargs := nargs - 1;
    else
        field := Rationals;
    fi;
    
    if nargs = 1 then
        indices := List( [ 1 .. arg[1] ], i -> [i] );
        entries := List( [ 1 .. arg[1] ], i -> [ One( field ) ] );
        return SparseMatrix( arg[1], arg[1], indices, entries, field );
    else
        return fail;
    fi;
    
  end

);

##
InstallMethod( \=,
        [ IsSparseMatrix, IsSparseMatrix ],
  function( A, B )
    return A!.nrows = B!.nrows and
           A!.ncols = B!.ncols and
           A!.indices = B!.indices and
           A!.entries = B!.entries;
  end
);

##
InstallMethod( TransposedSparseMat,
        [ IsSparseMatrix ],
  function( M )
    local T, i, j;
    T := SparseZeroMatrix( M!.ncols, M!.nrows, M!.field );
    for i in [ 1 .. M!.nrows ] do
        for j in [ 1 .. Length( M!.indices[i] ) ] do
            Add( T!.indices[ M!.indices[i][j] ], i );
            Add( T!.entries[ M!.indices[i][j] ], M!.entries[i][j] );
        od;
    od;

    return T;
    
  end
);

##
InstallMethod( CertainRows,
        [ IsSparseMatrix, IsList ],
  function( M, L )
    return SparseMatrix( Length( L ), M!.ncols, M!.indices{ L }, M!.entries{ L }, M!.field );
  end
);
  
##
InstallMethod( CertainColumns,
        [ IsSparseMatrix, IsList ],
  function( M, L )
    local indices, entries, list, i, j, column, p;
    indices := List( [ 1 .. M!.nrows ], i -> [] );
    entries := List( [ 1 .. M!.nrows ], i -> [] );
    
    for i in [ 1 .. M!.nrows ] do
        for j in [ 1 .. Length( L ) ] do
            column := L[j];
            p := PositionSet( M!.indices[i], column);
	    if p <> fail then
                Add( indices[i], j );
                Add( entries[i], M!.entries[i][p] );
            fi;
        od;
    od;
    
    return SparseMatrix( M!.nrows, Length( L ), indices, entries, M!.field );
    
  end
);
  
##
InstallMethod( UnionOfRows,
        [ IsSparseMatrix, IsSparseMatrix ],
  function( A, B )
    return SparseMatrix( A!.nrows + B!.nrows, A!.ncols, Concatenation( A!.indices, B!.indices ), Concatenation( A!.entries, B!.entries ), A!.field );
  end
);
  
##
InstallMethod( UnionOfColumns,
        [ IsSparseMatrix, IsSparseMatrix ],
  function( A, B )
    return SparseMatrix( A!.nrows, A!.ncols + B!.ncols, List( [ 1 .. A!.nrows ], i -> Concatenation( A!.indices[i], B!.indices[i] + A!.ncols ) ), List( [ 1 .. A!.nrows ], i -> Concatenation( A!.entries[i], B!.entries[i] ) ), A!.field );
  end
);

##
InstallMethod( SparseDiagMat,
        [ IsList ],
  function( e )
    if Length( e ) = 1 then
        return e[1];
    elif Length( e ) > 2 then
        return SparseDiagMat( SparseDiagMat( e{[1,2]} ), e{[ 3 .. Length( e ) ]} );
    else
        return SparseMatrix( e[1]!.nrows + e[2]!.nrows, e[1]!.ncols + e[2]!.ncols, Concatenation( e[1]!.indices, e[2]!.indices + e[1]!.ncols ), Concatenation( e[1]!.entries, e[2]!.entries ) );
    fi;
  end
);

##
InstallMethod( \*,
        [ IsRingElement, IsSparseMatrix ],
  function( a, A )
    if IsZero( a ) then
        return SparseZeroMatrix( A!.nrows, A!.ncols, A!.field );
    else
        return SparseZeroMatrix( A!.nrows, A!.ncols, A!.indices, A!.entries * a, A!.field );
    fi;
  end
);
  
##
InstallMethod( \+,
        [ IsSparseMatrix, IsSparseMatrix ],
  function( A, B )
    local C, i;
    C := CopyMat( A );
    for i in [ 1 .. C!.nrows ] do
        AddRow( C!.indices[i], C!.entries[i], B!.indices[i], B!.entries[i] );
    od;
    return C;
  end
);

##
InstallMethod( nrows,
        [ IsSparseMatrix ],
  function( M )
    return M!.nrows;
  end
);
  
##
InstallMethod( ncols,
        [ IsSparseMatrix ],
  function( M )
    return M!.ncols;
  end
);

##
InstallMethod( IsSparseZeroMatrix,
        [ IsSparseMatrix ],
  function( M )
    return List( [ 1 .. Length( M!.indices ) ], i -> Length( M!.indices[i] ) ) = List( [ 1 .. Length( M!.indices ) ], i -> 0 );
  end
);

##
InstallMethod( IsSparseIdentityMatrix,
        [ IsSparseMatrix ],
  function( M )
    local one, i;
    one := One( M!.field );
    for i in [ 1 .. M!.nrows ] do
        if M!.indices[i] <> [i] or M!.entries[i] <> [ one ] then
            return false;
        fi;
    od;
    return true;
  end
);
  
##
InstallMethod( IsSparseDiagonalMatrix,
        [ IsSparseMatrix ],
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
InstallMethod( SparseZeroRows,
        [ IsSparseMatrix ],
  function( M )
    return Filtered( [ 1 .. M!.nrows ], i -> Length( M!.indices[i] ) = 0 );
  end
);

##


##
InstallMethod( AddRow, #with desired side effect!
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

  
  
  
  
  
  
  
  
########################################################
## Gaussian Algorithms:
########################################################

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
    return EchelonMatDestructive( SparseMatrix( mat!.nrows, mat!.ncols, copy_indices, copy_entries, mat!.field ) );
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
                vectors := SparseMatrix( rank, ncols, vectors.indices, vectors.entries, mat!.field ) );
    
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
    return EchelonMatTransformationDestructive( SparseMatrix( mat!.nrows, mat!.ncols, copy_indices, copy_entries, mat!.field ) );
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
    
    field := mat!.field;
    
    if field = "unknown" then
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
                vectors := SparseMatrix( rank, ncols, vectors.indices, vectors.entries, field ),
                coeffs := SparseMatrix( rank, nrows, coeffs.indices, coeffs.entries, field ),
                relations := SparseMatrix( nrows - rank, nrows, relations.indices, relations.entries, field ) );
    
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
    
    return SparseMatrix( nrows1, ncols, M.indices, M.entries, mat!.field );

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
        return KernelMatDestructive( SparseMatrix( M!.nrows, M!.ncols, copy_indices, copy_entries, M!.field ), [ 1 .. M!.nrows ] );
    elif Length( arg ) > 1 then
        return KernelMatDestructive( SparseMatrix( M!.nrows, M!.ncols, copy_indices, copy_entries, M!.field ), arg[2] );
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

