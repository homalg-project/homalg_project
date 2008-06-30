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
	  row_entries,
          factor,
	  a;
    
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
            x := Gcdex( Int( e ), char ).coeff1;
            Add( vectors.indices, indices[ row_indices[ min[1] ] ] );
            Add( vectors.entries, entries[ row_indices[ min[1] ] ] * x );
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
	    a := Difference( [1..head-1], heads{[j+1..ncols]} );
            for i in a do
                row_indices := vectors.indices[i];
                p := PositionSet( row_indices, j );
                if p <> fail then
                    row_entries := vectors.entries[i];
                    x := row_entries[p];
                    factor := - QuoInt( Int( x ), Int( e ) );
                    if factor <> 0 then
                        m := MultRow( vectors.indices[ head ], vectors.entries[ head ], factor );
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
          list_of_rows,
          factor,
	  a;
    
    
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
            x := Gcdex( Int( e ), char ).coeff1;
            
            Add( coeffs.indices, T.indices[ row_indices[ min[1] ] ] );
            Add( coeffs.entries, T.entries[ row_indices[ min[1] ] ] * x );
            Add( vectors.indices, indices[ row_indices[ min[1] ] ] );
            Add( vectors.entries, entries[ row_indices[ min[1] ] ] * x );

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
    
    #add relations --- THIS IS NOT ALWAYS THE KERNEL BECAUSE OF ZERODIVISORS (compare KernelMat) ---:
    relations.indices := T.indices{ list_of_rows };
    relations.entries := T.entries{ list_of_rows };
    
    # gauss upwards:
    
    list := Filtered( heads, x -> x <> 0 );
    rank := Length( list );
    
    for j in [ncols,ncols-1..1] do
        head := heads[j];
        if head <> 0 then
            e := vectors.entries[ head ][1];
	    a := Difference( [1..head-1], heads{[j+1..ncols]} );
            for i in a do
                row_indices := vectors.indices[i];
                p := PositionSet( row_indices, j );
                if p <> fail then
                    row_entries := vectors.entries[i];
                    x := row_entries[p];
                    factor := - QuoInt( Int( x ), Int( e ) );
                    if factor <> 0 then
                        m := MultRow( vectors.indices[ head ], vectors.entries[ head ], factor );
                        AddRow( m.indices, m.entries, row_indices, row_entries );
                        m := MultRow( coeffs.indices[ head ], coeffs.entries[ head ], factor );
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
          char,
          i,
          j,
          e,
          k,
          x,
          p,
          m,
          row1_indices,
          row1_entries,
          row2_indices,
          factor;
    
    nrows1 := mat!.nrows;
    nrows2 := N!.nrows;
    
    if nrows1 = 0 or nrows2 = 0 then
        return rec( reduced_matrix := mat );
    fi;
    
    ncols := mat!.ncols;
    if ncols <> N!.ncols then
        return fail;
    elif ncols = 0 then
        return rec( reduced_matrix := mat );
    fi;
    
    M := CopyMat( mat );
    
    char := Characteristic( M!.ring );
    
    for i in [ 1 .. nrows2 ] do
        row2_indices := N!.indices[i];
        if Length( row2_indices ) > 0 then
            j := row2_indices[1];
            e := N!.entries[i][1];
            for k in [ 1 .. nrows1 ] do
                row1_indices := M!.indices[k];
                row1_entries := M!.entries[k];
                p := PositionSet( row1_indices, j );
		if p <> fail then
                   x := row1_entries[p];
                   factor := - QuoInt( Int( x ), Int( e ) );
                   if factor <> 0 then
                       m := MultRow( row2_indices, N!.entries[i], factor );
                       AddRow( m.indices, m.entries, row1_indices, row1_entries );
                   fi;
                fi;
            od;
        fi;
    od;
    
    return rec( reduced_matrix := M );

end);

##
InstallMethod( ReduceMatWithHermiteMatTransformation,
        "for sparse matrices over a ring, second argument must be in REF",
        [ IsSparseMatrix, IsSparseMatrix ],
  function( mat, N )
    local nrows1,
          ncols,
          nrows2,
	  r,
          one,
	  char,
          M,
	  T,
          i,
          j,
          e,
          k,
          x,
          p,
          m,
          row1_indices,
          row1_entries,
          row2_indices,
          factor;
    
    nrows1 := mat!.nrows;
    nrows2 := N!.nrows;
    r := mat!.ring;
    one := One( r );
    char := Characteristic( r );
    
    T := SparseZeroMatrix( nrows1, nrows2, r );
    
    if nrows1 = 0 or nrows2 = 0 then
        return rec( reduced_matrix := mat, transformation := T );
    fi;
    
    ncols := mat!.ncols;
    if ncols <> N!.ncols then
        return fail;
    elif ncols = 0 then
        return rec( reduced_matrix := mat, transformation := T );
    fi;
    
    M := CopyMat( mat );
    
    T := SparseZeroMatrix( nrows1, nrows2, r );
    
    for i in [ 1 .. nrows2 ] do
        row2_indices := N!.indices[i];
        if Length( row2_indices ) > 0 then
            j := row2_indices[1];
            e := N!.entries[i][1];
            for k in [ 1 .. nrows1 ] do
                row1_indices := M!.indices[k];
                row1_entries := M!.entries[k];
                p := PositionSet( row1_indices, j );
                if p <> fail then
                    x := row1_entries[p];
                    factor := - QuoInt( Int( x ), Int( e ) );
                    if factor <> 0 then
                        m := MultRow( row2_indices, N!.entries[i], factor );
                        AddRow( m.indices, m.entries, row1_indices, row1_entries );
			Add( T!.indices[k], i );
			Add( T!.entries[k], one * factor );
                    fi;
                fi;
            od;
        fi;
    od;
    
    return rec( reduced_matrix := M, transformation := T );
    
  end
);


##
InstallMethod( KernelHermiteMatDestructive,
        "method for sparse matrices",
        [ IsSparseMatrix, IsList ],
  function( mat, L )
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
          pp,
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
          list_of_rows,
          len,
          factor,
          row;
    
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
    
    pp := PrimePowersInt( char );    
    if Length( pp ) > 2 then
        Error( "only Z / p^n * Z is supported right now!" );
    fi;
    
    list_of_rows := [ 1 .. nrows ];
    
    T := rec( indices := List( [ 1 .. nrows ] , i -> [] ), entries := List( [ 1 .. nrows ], i -> [] ) );
    for i in [ 1 .. Length( L ) ] do
        T.indices[L[i]] := [i];
        T.entries[L[i]] := [ One( ring ) ];
    od;
    
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
            x := Gcdex( Int( e ), char ).coeff1;
            
            Add( coeffs.indices, T.indices[ row_indices[ min[1] ] ] );
            Add( coeffs.entries, T.entries[ row_indices[ min[1] ] ] * x );
            Add( vectors.indices, indices[ row_indices[ min[1] ] ] );
            Add( vectors.entries, entries[ row_indices[ min[1] ] ] * x );
            
            heads[column] := Length( vectors.indices );
            
	    #check for "hidden" kernel relations
            if min[2] > 1 then
                len := heads[column];
                #Print( "we have a basis vector with a non-unit pivot:  #", len, "!\n" );
                m := MultRow( coeffs.indices[len], coeffs.entries[len], char / min[2] );
                T.indices[ row_indices[ min[1] ] ] := m.indices;
                T.entries[ row_indices[ min[1] ] ] := m.entries;
                m := MultRow( vectors.indices[len], vectors.entries[len], char / min[2] );
                indices[ row_indices[ min[1] ] ] := m.indices;
                entries[ row_indices[ min[1] ] ] := m.entries;
                # is the row a multiple of a non-unit? THIS DOESNT WORK: i.e. [[2,1],[0,1]] over Z/4Z
                #if min[2] > 1 then
                #    Print( "found a hidden kernel relation in basis vector #", Length( vectors.indices ), "!\n" );
                #    # row is multiple of min[2]
                #    # therefore row * (char / min[2] ) = 0
                #    # but is the relations_row * this <> 0 ?
                #    row := coeffs.entries[ Length( coeffs.entries ) ];
                #    # you could run another min check, but it's easier to just multiply the row and check afterwards
                #    m := MultRow( coeffs.indices[ Length( coeffs.indices ) ], row, char / min[2] );
                #    if m.indices <> [] then
                #        Add( relations.indices, m.indices );
                #        Add( relations.entries, m.entries );
                #    fi;
                #fi;
            else
                list_of_rows := Difference( list_of_rows, [ row_indices[ min[1] ] ] );
            fi;
	    
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
    relations.indices := Concatenation( relations.indices, T.indices{ list_of_rows } );
    relations.entries := Concatenation( relations.entries, T.entries{ list_of_rows } );
    
    return rec( relations := SparseMatrix( Length( relations.indices ), Length( L ), relations.indices, relations.entries, ring ) );
    
  end
);


