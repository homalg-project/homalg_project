DeclareOperation( "EchelonMatTransformationDestructive",
        [ IsMatrix ] );

DeclareOperation( "EchelonMatTransformation",
        [ IsMatrix ] );

DeclareOperation( "EchelonMatDestructive",
        [ IsMatrix ] );

DeclareOperation( "EchelonMat",
        [ IsMatrix ] );


InstallMethod( EchelonMatTransformation,
        "generic method for matrices",
        [ IsMatrix ],
  function( mat )
    local copymat, v, vc, f;
    copymat := [];
    f := DefaultFieldOfMatrix(mat);
    for v in mat do
        vc := ShallowCopy(v);
        ConvertToVectorRepNC(vc,f);
        Add(copymat, vc);
    od;
    return EchelonMatTransformationDestructive( copymat );
end);

InstallMethod( EchelonMatTransformationDestructive,
        "generic method for matrices",
        [ IsMatrix and IsMutable ],
  function( mat )
    local zero,      # zero of the field of <mat>
          nrows,     # number of rows in <mat>
          ncols,     # number of columns in <mat>
          vectors,   # list of basis vectors
          heads,     # list of pivot positions in 'vectors'
          i,         # loop over rows
          j,         # loop over columns
          T,         # transformation matrix
          coeffs,    # list of coefficient vectors for 'vectors'
          relations, # basis vectors of the null space of 'mat'
          row, head, x, row2, rank, list;
    
    nrows := Length( mat );
    ncols := Length( mat[1] );
    
    zero  := Zero( mat[1][1] );
    
    heads   := ListWithIdenticalEntries( ncols, 0 );
    vectors := [];
    
    T         := IdentityMat( nrows, zero );
    coeffs    := [];
    relations := [];
    
    for i in [ 1 .. nrows ] do
        
        row := mat[i];
        row2 := T[i];
        
        # Reduce the row with the known basis vectors.
        for j in [ 1 .. ncols ] do
            head := heads[j];
            if head <> 0 then
                x := - row[j];
                if x <> zero then
                    AddRowVector( row2, coeffs[ head ],  x );
                    AddRowVector( row,  vectors[ head ], x );
                fi;
            fi;
        od;
        
        
        j:= PositionNot( row, zero );
        if j <= ncols then
            
            # We found a new basis vector.
            x:= Inverse( row[j] );
            if x = fail then
                TryNextMethod();
            fi;
            Add( coeffs,  row2 * x );
            Add( vectors, row  * x );
            heads[j]:= Length( vectors );
            
        #else
        #    Add( relations, row2 );
        fi;
        
    od;
    
    # gauss upwards:
    
    rank := Length( Filtered( heads, x->x<>0 ) );
    
    for j in [ncols,ncols-1..1] do
        head := heads[j];
        if head <> 0 then
            for i in Filtered( [1..head-1], x -> not x in heads{[j+1..ncols]} ) do
                row := vectors[i];
                row2 := coeffs[i];
                x := - row[j];
                if x <> zero then
                    AddRowVector( row2, coeffs[head], x );
                    AddRowVector( row, vectors[head], x );
                fi;
            od;
        fi;
    od;
    
    #exchange rows:
    
    list := Filtered( heads, x->x<>0 );
    
    vectors := vectors{list};
    
    coeffs{[1..rank]} := coeffs{list};
    
    return [ vectors, coeffs ];

end );

##
InstallMethod( EchelonMat,
        "generic method for matrices",
        [ IsMatrix ],
  function( mat )
    local copymat, v, vc, f;
    copymat := [];
    f := DefaultFieldOfMatrix(mat);
    for v in mat do
        vc := ShallowCopy(v);
        ConvertToVectorRepNC(vc,f);
        Add(copymat, vc);
    od;
    return EchelonMatDestructive( copymat );
end);

##
InstallMethod( EchelonMatDestructive,
        "generic method for matrices",
        [ IsMatrix and IsMutable ],
        function( mat )
    local zero,      # zero of the field of <mat>
          nrows,     # number of rows in <mat>
          ncols,     # number of columns in <mat>
          vectors,   # list of basis vectors
          heads,     # list of pivot positions in 'vectors'
          i,         # loop over rows
          j,         # loop over columns
          row, head, x, row2, rank, list;
    
    nrows := Length( mat );
    ncols := Length( mat[1] );
    
    zero  := Zero( mat[1][1] );
    
    heads   := ListWithIdenticalEntries( ncols, 0 );
    vectors := [];
    
    for i in [ 1 .. nrows ] do
        
        row := mat[i];
        
        # Reduce the row with the known basis vectors.
        for j in [ 1 .. ncols ] do
            head := heads[j];
            if head <> 0 then
                x := - row[j];
                if x <> zero then
                    AddRowVector( row,  vectors[ head ], x );
                fi;
            fi;
        od;
        
        
        j:= PositionNot( row, zero );
        if j <= ncols then
            
            # We found a new basis vector.
            x:= Inverse( row[j] );
            if x = fail then
                TryNextMethod();
            fi;
            Add( vectors, row  * x );
            heads[j]:= Length( vectors );
            
        fi;
        
    od;
    
    # gauss upwards:
    
    rank := Length( Filtered( heads, x->x<>0 ) );
    
    for j in [ncols,ncols-1..1] do
        head := heads[j];
        if head <> 0 then
            for i in Filtered( [1..head-1], x -> not x in heads{[j+1..ncols]} ) do
                row := vectors[i];
                x := - row[j];
                if x <> zero then
                    AddRowVector( row, vectors[head], x );
                fi;
            od;
        fi;
    od;
    
    #exchange rows:
    
    list := Filtered( heads, x->x<>0 );
    
    vectors := vectors{list};
    
    return vectors;
    
end );
