#############################################################################
##
##  HermiteSparse.gi              Gauss package               Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B fÅ¸r Mathematik, RWTH Aachen
##
##  Implementation stuff for performing Hermite algorithms on sparse matrices.
##
#############################################################################

########################################################
## Hermite Algorithms:
########################################################

##
InstallMethod( HermiteMatDestructive,
        "generic method for matrices",
        [ IsSparseMatrix ],
  function( mat )
    local nrows,     # number of rows in <mat>
          ncols,     # number of columns in <mat>
          indices,
          entries,
          vectors,   # list of basis vectors
          heads,     # list of pivot positions in 'vectors'
	  char,      # characteristic of the Ring
	  column,    # loop over columns
          i,         # loop over rows
          j,         # loop over columns
          min,
          g,
          e,
          head,
          x,
          m,
          list,
          rank,
          p,
          list_of_rows,
	  row_indices,
	  row_entries;
    
    nrows := mat!.nrows;
    ncols := mat!.ncols;
    
    indices := mat!.indices;
    entries := mat!.entries;
    
    heads   := ListWithIdenticalEntries( ncols, 0 );
    vectors := rec( indices := [], entries := [] );
    
    char := Characteristic( mat!.ring );
    
    if Length( PrimePowersInt( char ) ) > 2 then
        Error( "only Z / p^n * Z is supported right now!" );
    fi;
    
    list_of_rows := [ 1 .. nrows ];
    
    for column in [ 1 .. ncols ] do
    
        #find the basis vector with leftmost nonzero as-close-to-unit-as-possible entry
        row_indices := Filtered( list_of_rows, i -> Length( indices[i] ) > 0 and indices[i][1] = column );
        
        if Length( row_indices ) > 0 then
            i := 1;
            min := [ i, Gcd( Int( entries[ row_indices[i] ][ 1 ] ), char ) ];
            while i < Length( row_indices ) and min[2] > 1 do
                i := i + 1;
                g := Gcd( Int( entries[ row_indices[i] ][ 1 ] ), char );
                if min[2] > g then
                    min := [ i, g ];
                fi;
            od;
            #we found a new basis vector.
            e := entries[ row_indices[ min[1] ] ][ 1 ];
            if IsUnit( e ) then
                x := Inverse( e );
                Add( vectors.indices, indices[ row_indices[ min[1] ] ] );
                Add( vectors.entries, entries[ row_indices[ min[1] ] ] * x );
            else
                Add( vectors.indices, indices[ row_indices[ min[1] ] ] );
                Add( vectors.entries, entries[ row_indices[ min[1] ] ] );
            fi;
            heads[column] := Length( vectors.indices );
            list_of_rows := Difference( list_of_rows, [ row_indices[ min[1] ] ] );
            
            #reduce the other rows with the newfound basis vector.
            head := heads[column];
            e := vectors.entries[head][1];
            for i in [ 1 .. Length( row_indices ) ] do
                if i <> min[1] then
                    x := - entries[ row_indices[i] ][1] / e;
                    m := MultRow( vectors.indices[head], vectors.entries[head], x );
                    AddRow( m.indices, m.entries, indices[ row_indices[i] ], entries[ row_indices[i] ] );
                fi;
            od;    
        fi;
        
    od;
    
    # gauss upwards:
    
    list := Filtered( heads, x->x<>0 );
    rank := Length( list );
    
    for j in [ncols,ncols-1..1] do
        head := heads[j];
        if head <> 0 then
            e := vectors.entries[ head ][1];
            for i in Filtered( [1..head-1], x -> not x in heads{[j+1..ncols]} ) do
                row_indices := vectors.indices[i];
                p := PositionSet( row_indices, j );
                if p <> fail then
                    row_entries := vectors.entries[i];
                    x := row_entries[p];
                    if Gcd( Int( e ), char ) <= Gcd( Int( x ), char ) then
                        m := MultRow( vectors.indices[ head ], vectors.entries[ head ], -x/e );
                        AddRow( m.indices, m.entries, row_indices, row_entries );
                    fi;
                fi;
            od;
        fi;
    od;
    
    return rec( heads := heads,
                vectors := SparseMatrix( rank, ncols, vectors.indices, vectors.entries, mat!.ring ) );
  end
);

##
InstallMethod( HermiteMatTransformationDestructive,
        "method for sparse matrices",
        [ IsSparseMatrix ],
  function( mat )
    local nrows,     # number of rows in <mat>
          ncols,     # number of columns in <mat>
          indices,
          entries,
          vectors,   # list of basis vectors
          heads,     # list of pivot positions in 'vectors'
          char,      # characteristic of the Ring
          column,    # loop over columns
          coeffs,
          relations,
          ring,
          i,         # loop over rows
          j,         # loop over columns
          min,
          g,
          e,
          T,
          head,
          x,
          m,
          rank,
          list,
          row_indices,
          row_entries,
          p,
          list_of_rows;
    
    
    nrows := mat!.nrows;
    ncols := mat!.ncols;
    
    indices := mat!.indices;
    entries := mat!.entries;
    
    heads   := List( [ 1 .. ncols ], i -> 0 );
    vectors := rec( indices := [], entries := [] );
    coeffs := rec( indices := [], entries := [] );
    relations := rec( indices := [], entries := [] );
    
    ring := mat!.ring;
    
    char := Characteristic( ring );
    
    if Length( PrimePowersInt( char ) ) > 2 then
        Error( "only Z / p^n * Z is supported right now!" );
    fi;
    
    T := rec( indices := List( [ 1 .. nrows ], i -> [i] ), entries := List( [ 1 .. nrows ], i -> [ One( ring ) ] ) );
    
    list_of_rows := [ 1 .. nrows ];
    
    for column in [ 1 .. ncols ] do
        
        #find the basis vector with leftmost nonzero as-close-to-unit-as-possible entry
        row_indices := Filtered( list_of_rows, i -> Length( indices[i] ) > 0 and indices[i][1] = column );
        if Length( row_indices ) > 0 then
            i := 1;
            min := [ i, Gcd( Int( entries[ row_indices[i] ][ 1 ] ), char ) ];
            while i < Length( row_indices )
              and min[2] > 1 do
                i := i + 1;
                g := Gcd( Int( entries[ row_indices[i] ][ 1 ] ), char );
                if min[2] > g then
                    min := [ i, g ];
                fi;
            od;
            #we found a new basis vector.
              e := entries[ row_indices[ min[1] ] ][ 1 ];
            if
              IsUnit( e ) then
                x := Inverse( e );
                Add( coeffs.indices, T.indices[ row_indices[ min[1] ] ] );
                Add( coeffs.entries, T.entries[ row_indices[ min[1] ] ] * x );
                Add( vectors.indices, indices[ row_indices[ min[1] ] ] );
                Add( vectors.entries, entries[ row_indices[ min[1] ] ] * x );
            else
                Add( coeffs.indices, T.indices[ row_indices[ min[1] ] ] );
                Add( coeffs.entries, T.entries[ row_indices[ min[1] ] ] );
                Add( vectors.indices, indices[ row_indices[ min[1] ] ] );
                Add( vectors.entries, entries[ row_indices[ min[1] ] ] );
            fi;
            heads[column] := Length( vectors.indices );
            list_of_rows := Difference( list_of_rows, [ row_indices[ min[1] ] ] );
            
            #reduce the other rows with the newfound basis vector.
            head := heads[column];
            e := vectors.entries[head][1];
            for i in [ 1 .. Length( row_indices ) ] do
                if i <> min[1] then
                    x := - entries[ row_indices[i] ][1] / e;
                    m := MultRow( vectors.indices[head], vectors.entries[head], x );
                    AddRow( m.indices, m.entries, indices[ row_indices[i] ], entries[ row_indices[i] ] );
                    m := MultRow( coeffs.indices[head], coeffs.entries[head], x );
                    AddRow( m.indices, m.entries, T.indices[ row_indices[i] ], T.entries[ row_indices[i] ] );
                fi;
            od;
        fi;
        
    od;
    
    #add kernel relations:
    relations.indices := T.indices{ list_of_rows };
    relations.entries := T.entries{ list_of_rows };
    
    # gauss upwards:
    
    list := Filtered( heads, x -> x <> 0 );
    rank := Length( list );
    
    for j in [ncols,ncols-1..1] do
        head := heads[j];
        if head <> 0 then
            e := vectors.entries[ head ][1];
            for i in Filtered( [1..head-1], x -> not x in heads{[j+1..ncols]} ) do
                row_indices := vectors.indices[i];
                p := PositionSet( row_indices, j );
                if p <> fail then
                    row_entries := vectors.entries[i];
                    x := row_entries[p];
                    if Gcd( Int( e ), char ) <= Gcd( Int( x ), char ) then
                        m := MultRow( vectors.indices[ head ], vectors.entries[ head ], -x/e );
                        AddRow( m.indices, m.entries, row_indices, row_entries );
                        m := MultRow( coeffs.indices[ head ], coeffs.entries[ head ], -x/e );
                        AddRow( m.indices, m.entries, coeffs.indices[i], coeffs.entries[i] );
                    fi;
                fi;
            od;
        fi;
    od;
    
    return rec( heads := heads,
                vectors := SparseMatrix( rank, ncols, vectors.indices, vectors.entries, ring ),
                coeffs := SparseMatrix( rank, nrows, coeffs.indices, coeffs.entries, ring ),
                relations := SparseMatrix( nrows - rank, nrows, relations.indices, relations.entries, ring ) );
  end
);

##
InstallMethod( ReduceMatWithHermiteMat,
        "for sparse matrices over a ring, second argument must be in REF",
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
InstallMethod( KernelHermiteMatDestructive,
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
    
    ring := mat!.ring;
    
    if ring = "unknown" then
        ring := Rationals;
    fi;
    
    T := rec( indices := List( [ 1 .. nrows ] , i -> [] ), entries := List( [ 1 .. nrows ], i -> [] ) );
    for i in [ 1 .. Length( L ) ] do
        T.indices[L[i]] := [i];
        T.entries[L[i]] := [ One( ring ) ];
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
    
    return rec( relations := SparseMatrix( Length( relations.indices ), Length( L ), relations.indices, relations.entries, ring ) );
    
end );


