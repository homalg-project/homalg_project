#############################################################################
##
##  GaussSparseTest.gi           Gauss package                Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for performing Gauss algorithms on sparse matrices.
##
#############################################################################

##
InstallMethod( KernelEchelonMatDestructiveTest,
        "method for sparse matrices",
        [ IsSparseMatrix, IsList ],
  function( mat, L )
    local nrows,
          ncols,
          ring,
          i,
          T,
          list,
	  column_of_M_iterator,
	  l,
	  product,
	  len,
	  lastfound,
	  inv,
	  row_indices,
	  row_entries;
    
    nrows := mat!.nrows;
    ncols := mat!.ncols;    
    
    ring := mat!.ring;
    
    if ring = "unknown" then
        ring := Rationals;
    fi;
    
    T := rec( indices := List( [ 1 .. nrows ] , i -> [] ), entries := List( [ 1 .. nrows ], i -> [] ) );
    for i in [ 1 .. Length( L ) ] do
        T.indices[L[i]] := [i];
        T.entries[L[i]] := [ One( ring ) ];
    od;
    
    T := SparseMatrix( nrows, nrows, T!.indices, T!.entries, ring );
    
    for column_of_M_iterator in [ 1 .. ncols ] do
        
        l := Length( T!.indices );
        
        product := T * CertainColumns( mat, [column_of_M_iterator] );
            
        list := Filtered( [ 1 .. l ], i -> product!.indices[i] <> [] );
        
        len := Length( list );
        
        if len > 0 then
            lastfound := list[len];
            inv := - Inverse( product!.entries[lastfound][1] );
            row_indices := T!.indices[lastfound];
            row_entries := T!.entries[lastfound] * inv;
            for i in list{[1 .. len-1]} do
                AddRow( row_indices, row_entries * product!.entries[i][1], T!.indices[i], T!.entries[i] );
            od;
            T := CertainRows( T, Concatenation( [ 1 .. lastfound - 1 ], [ lastfound + 1 .. l ] ) );
        fi;
    od;
    
    return rec( relations := T );
    
end );

InstallMethod( KernelEchelonMatDestructiveTest,
        "method for sparse matrices",
        [ IsSparseMatrix ],
        mat -> KernelEchelonMatDestructive( mat, [ 1 .. nrows( mat ) ] )
);

##
InstallMethod( KernelEchelonMatDestructiveTest,
        "method for sparse matrices",
        [ IsSparseMatrixGF2Rep, IsList ],
        function( mat, L )
    local nrows,
          ncols,
          ring,
          i,
          T,
          list,
          column_of_M_iterator,
          l,
          product,
          len,
          lastfound,
          inv,
          row_indices,
          row_entries;
    
    nrows := mat!.nrows;
    ncols := mat!.ncols;
    
    ring := mat!.ring;
    
    if ring = "unknown" then
        ring := Rationals;
    fi;
    
    T := rec( indices := List( [ 1 .. nrows ] , i -> [] ) );
    for i in [ 1 .. Length( L ) ] do
        T.indices[L[i]] := [i];
    od;
    
    T := SparseMatrix( nrows, nrows, T!.indices );
    
    for column_of_M_iterator in [ 1 .. ncols ] do
        
        l := Length( T!.indices );
        
        product := T * CertainColumns( mat, [column_of_M_iterator] );
        
        list := Filtered( [ 1 .. l ], i -> product!.indices[i] <> [] );
        
        len := Length( list );
        
        if len > 0 then
            lastfound := list[len];
            row_indices := T!.indices[lastfound];
            for i in list{[1 .. len-1]} do
                T!.indices[i] := AddRow( row_indices, T!.indices[i] );
            od;
            T := CertainRows( T, Concatenation( [ 1 .. lastfound - 1 ], [ lastfound + 1 .. l ] ) );
        fi;
    od;
    
    return rec( relations := T );
    
end );
