#############################################################################
##
##  SparseMatrix.gi             Gauss package                 Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B fÅ¸r Mathematik, RWTH Aachen
##
##  Implementation stuff for Gauss with sparse matrices.
##
#############################################################################

##
DeclareRepresentation( "IsSparseMatrixRep",
        IsSparseMatrix, [ "nrows", "ncols", "indices", "entries", "ring" ] );

##
DeclareRepresentation( "IsSparseMatrixGF2Rep",
        IsSparseMatrix, [ "nrows", "ncols", "indices", "ring" ] );

##
BindGlobal( "TheFamilyOfSparseMatrices",
        NewFamily( "TheFamilyOfSparseMatrices" ) );

##
BindGlobal( "TheTypeSparseMatrix",
        NewType( TheFamilyOfSparseMatrices, IsSparseMatrixRep ) );

##
BindGlobal( "TheTypeSparseMatrixGF2",
        NewType( TheFamilyOfSparseMatrices, IsSparseMatrixGF2Rep ) );

##  <#GAPDoc Label="SparseMatrix">
##  <ManSection >
##  <Func Arg="mat[, R]" Name="SparseMatrix" Label="constructor using gap matrices" />
##  <Returns>a sparse matrix over the ring <A>R</A></Returns>
##  <Func Arg="nrows, ncols, indices" Name="SparseMatrix" Label="constructor using indices" />
##  <Returns>a sparse matrix over GF(2)</Returns>
##  <Func Arg="nrows, ncols, indices, entries[, R]" Name="SparseMatrix" Label="constructor using indices and entries" />
##  <Returns>a sparse matrix over the ring <A>R</A></Returns>
##  <Description>
##  The sparse matrix constructor.
##  In the one-argument form the SparseMatrix constructor converts a &GAP; matrix
##  to a sparse matrix. If not provided the base ring <A>R</A> is found automatically.
##  For the multi-argument form <A>nrows</A> and <A>ncols</A> are the dimensions
##  of the matrix. <A>indices</A> must be a list of length <A>nrows</A> containing
##  lists of the column indices of the matrix in ascending order.
##
##  <Example><![CDATA[
##  gap> M := [ [ 0 , 1 ], [ 3, 0 ] ] * One( GF(2) );
##  [ [ 0*Z(2), Z(2)^0 ], [ Z(2)^0, 0*Z(2) ] ]
##  gap> SM := SparseMatrix( M );
##  <a 2 x 2 sparse matrix over GF(2)>
##  gap> IsSparseMatrix( SM );
##  true
##  gap> Display( SM );
##   . 1
##   1 .
##  gap> SN := SparseMatrix( 2, 2, [ [ 2 ], [ 1 ] ] );
##  <a 2 x 2 sparse matrix over GF(2)>
##  gap> SN = SM;
##  true
##  gap> SN := SparseMatrix( 2, 3,
##  >                   [ [ 2 ], [ 1, 3 ] ],
##  >                   [ [ 1 ], [ 3, 2 ] ] * One( GF(5) ) );
##  <a 2 x 3 sparse matrix over GF(5)>
##  gap> Display( SN );
##   . 1 .
##   3 . 2
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( SparseMatrix,
  function( arg )
    local nargs, M, nrows, ncols, i, j, indices, entries, ring;
    
    nargs := Length( arg );
    
    if IsRing( arg[ nargs ] ) then
        ring := arg[ nargs ];
        nargs := nargs - 1;
    fi;
    
    if nargs = 3 then
        return Objectify( TheTypeSparseMatrixGF2, rec( nrows := arg[1], ncols := arg[2], indices := arg[3], ring := GF(2) ) );
    elif nargs = 4 then
        if not IsBound( ring ) then
            ring := FindRing( arg[4] );
        fi;
        return Objectify( TheTypeSparseMatrix, rec( nrows := arg[1], ncols := arg[2], indices := arg[3], entries := arg[4], ring := ring ) );
    elif nargs = 5 then
        return Objectify( TheTypeSparseMatrix, rec( nrows := arg[1], ncols := arg[2], indices := arg[3], entries := arg[4], ring := arg[5] ) );
    fi;
    
    
    if nargs > 1 then
        Error( "wrong number of arguments! SparseMatrix expects nrows, ncols, indices, [entries], [ring]!" ); 
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
    
    if not IsBound( ring ) then
        ring := FindRing( List( M, i -> Filtered( i, j -> not IsZero(j) ) ) );
    fi;
    
    if ring = GF(2) then
        indices := List( [ 1 .. nrows ], i -> Filtered( [ 1 .. ncols ], j -> IsOne( M[i][j] ) ) );
        return SparseMatrix( nrows, ncols, indices );
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
    
    return SparseMatrix( nrows, ncols, indices, entries, ring );
    
  end
);
  
##  <#GAPDoc Label="ConvertSparseMatrixToMatrix">
##  <ManSection >
##  <Meth Arg="sm" Name="ConvertSparseMatrixToMatrix" />
##  <Returns>a &GAP; matrix, [], or a list of empty lists</Returns>
##  <Description>
##  This function converts the sparse matrix <A>sm</A> into a &GAP; matrix.
##  In case of <C>nrows(sm)=0</C> or <C>ncols(sm)=0</C> the return value is the
##  empty list or a list of empty lists, respectively.
##  <Example><![CDATA[
##  gap> M := [ [ 0 , 1 ], [ 3, 0 ] ] * One( GF(3) );
##  [ [ 0*Z(3), Z(3)^0 ], [ 0*Z(3), 0*Z(3) ] ]
##  gap> SM := SparseMatrix( M );
##  <a 2 x 2 sparse matrix over GF(3)>
##  gap> N := ConvertSparseMatrixToMatrix( SM );
##  [ [ 0*Z(3), Z(3)^0 ], [ 0*Z(3), 0*Z(3) ] ]
##  gap> M = N;
##  true
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##    
InstallMethod( ConvertSparseMatrixToMatrix,
        [ IsSparseMatrix ],
  function( SM )
    local indices, entries, i, j, ring, M;
    if SM!.nrows = 0 then
	return [ ];
    elif SM!.ncols = 0 then
        return List( [ 1 .. SM!.nrows ], i -> [] );
    fi;
    
    ring := SM!.ring;
    
    if ring = "unknown" then
        ring := Rationals;
    fi;
    
    indices := SM!.indices;
    entries := SM!.entries;

    M := NullMat( SM!.nrows, SM!.ncols, ring );
    
    for i in [ 1 .. SM!.nrows ] do
        for j in [ 1 .. Length( indices[i] ) ] do
            M[ i ][ indices[i][j] ] := entries[i][j];
        od;
    od;
    
    return M;
    
  end
  
);
  
##  <#GAPDoc Label="CopyMat">
##  <ManSection >
##  <Meth Arg="sm" Name="CopyMat" />
##  <Returns>a shallow copy of the sparse matrix <A>sm</A></Returns>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( CopyMat,
        [ IsSparseMatrix ],
  function( M )
    local indices, entries, i;
    indices := [];
    entries := [];
    for i in [ 1 .. M!.nrows ] do
        indices[i] := ShallowCopy( M!.indices[i] );
        entries[i] := ShallowCopy( M!.entries[i] );
    od;
    return SparseMatrix( M!.nrows, M!.ncols, indices, entries, M!.ring );
  end
);
  
##  <#GAPDoc Label="GetEntry">
##  <ManSection >
##  <Meth Arg="sm, i, j" Name="GetEntry" />
##  <Returns>a ring element.</Returns>
##  <Description>
##  This returns the entry <C>sm[i,j]</C> of the sparse matrix <A>sm</A>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( GetEntry,
        [ IsSparseMatrix, IsInt, IsInt ],
  function( M, i, j )
    local p;
    p := PositionSet( M!.indices[i], j );
    if p = fail then
        return Zero( M!.ring );
    else
        return M!.entries[i][p];
    fi;
  end
);
  
##  <#GAPDoc Label="SetEntry">
##  <ManSection >
##  <Meth Arg="sm, i, j, elm" Name="SetEntry" />
##  <Returns>nothing.</Returns>
##  <Description>
##  This sets the entry <C>sm[i,j]</C> of the sparse matrix <A>sm</A> to <A>elm</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( SetEntry,
        [ IsSparseMatrix, IsInt, IsInt, IsRingElement ],
  function( M, i, j, e )
    local ring, pos, res;
    ring := M!.ring;
    if not e in ring then
        Error( "the element has to be in ", ring, "!" );
    fi;
    pos := PositionSorted( M!.indices[i], j );
    if IsBound( M!.indices[i][pos] ) and M!.indices[i][pos] = j then
        if e = Zero( ring ) then
            Remove( M!.indices[i], pos );
            Remove( M!.entries[i], pos );
        else
            M!.entries[i][pos] := e;
        fi;
    else
	if e <> Zero( ring ) then
            Add( M!.indices[i], j, pos );
            Add( M!.entries[i], e, pos );
        fi;
    fi;
  end
);

##  <#GAPDoc Label="AddToEntry">
##  <ManSection >
##  <Meth Arg="sm, i, j, elm" Name="AddToEntry" />
##  <Returns><K>true</K> or a ring element</Returns>
##  <Description>
##  AddToEntry adds the element <A>elm</A> to the sparse matrix <A>sm</A> at the
##  <A>(i,j)</A>-th position. This is a Method with a side effect which
##  returns true if you tried to add zero or the sum of <C>sm[i,j]</C> and
##  <A>elm</A> otherwise. Please use this method whenever possible.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( AddToEntry,
        [ IsSparseMatrix, IsInt, IsInt, IsRingElement ],
  function( M, i, j, e )
    local ring, pos, res;
    ring := M!.ring;
    if not e in ring then
        Error( "the element has to be in ", ring, "!" );
    fi;
    if e = Zero( ring ) then
        return true;
    fi;
    pos := PositionSorted( M!.indices[i], j );
    if IsBound( M!.indices[i][pos] ) and M!.indices[i][pos] = j then
        res := M!.entries[i][pos] + e;
        if res = Zero( ring ) then
            Remove( M!.indices[i], pos );
            Remove( M!.entries[i], pos );
        else
            M!.entries[i][pos] := res;
        fi;
	return res;
    else
        Add( M!.indices[i], j, pos );
        Add( M!.entries[i], e, pos );
        return e;
    fi;
  end
);

###############################
## View and Display methods: ##
###############################
  
##
InstallMethod( ViewObj,
        [ IsSparseMatrix ],
  function( M )
    Print( "<a ", M!.nrows, " x ", M!.ncols, " sparse matrix over ", M!.ring, ">" );
  end
);
  
  
##
InstallMethod( Display,
        [ IsSparseMatrix ],
  function( M )
    local str, ws, i, last, j;
    if M!.nrows = 0 or M!.ncols = 0 then
        Print( "(an empty ", M!.nrows, " x ", M!.ncols, " matrix)" );
    elif Characteristic( M!.ring ) = 0 or ( HasDegreeOverPrimeField( M!.ring ) and DegreeOverPrimeField( M!.ring ) > 1 ) then
        Display( ConvertSparseMatrixToMatrix( M ) );
    else
        str := "";
        ws := ListWithIdenticalEntries( Length( String( Int( - One( M!.ring ) ) ) ), ' ' );
        for i in [ 1 .. M!.nrows ] do
            last := 0;
            for j in [ 1 .. Length( M!.indices[i] ) ] do
		str := Concatenation( str, Concatenation( ListWithIdenticalEntries( M!.indices[i][j] - 1 - last, Concatenation( ws, "." ) ) ), ws{ [ 1 .. Length( ws ) + 1 - Length( String( Int( M!.entries[i][j] ) ) ) ] }, String( Int( M!.entries[i][j] ) ) );
                last := M!.indices[i][j];
            od;
            str := Concatenation( str, Concatenation( ListWithIdenticalEntries( M!.ncols - last, Concatenation( ws, "." ) ) ), "\n" );
        od;
        Print( str );    
    fi;
  end
);
  
##
InstallMethod( PrintObj,
        [ IsSparseMatrix ],
  function( M )
    Print( "SparseMatrix( ", M!.nrows, ", ", M!.ncols, ", ", M!.indices, ", ", M!.entries, ", ", M!.ring, " )" );
  end
);
  

###############################
  
##
InstallMethod( FindRing,
        [ IsList ],
  function( entries )
    local found_ring, i, ring;
    found_ring := false;
    i := 1;
    while found_ring = false and i <= Length( entries ) do
        if IsBound( entries[i][1] ) then
            ring := DefaultRing( entries[i][1] );
            found_ring := true;
        fi;
        i := i + 1;
    od;
    if found_ring = true then
        return ring;
    else
        return "unknown";
    fi;
  end
);

##  <#GAPDoc Label="SparseZeroMatrix">
##  <ManSection >
##  <Func Arg="nrows[, ring]" Name="SparseZeroMatrix" Label="constructor using number of rows" />
##  <Returns>a sparse &lt;<A>nrows</A> x <A>nrows</A>&gt; zero matrix over the ring <A>ring</A></Returns>
##  <Func Arg="nrows, ncols[, ring]" Name="SparseZeroMatrix" Label="constructor using number of rows and columns"/>
##  <Returns>a sparse &lt;<A>nrows</A> x <A>ncols</A>&gt; zero matrix over the ring <A>ring</A></Returns>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( SparseZeroMatrix,
  function( arg )
    local nargs, ring;
    
    nargs := Length( arg );
    
    if IsRing( arg[ nargs ] ) or arg[ nargs ] = "unknown" then
        ring := arg[ Length( arg ) ];
        nargs := nargs - 1;
    else
        ring := "unknown";
    fi;

    if ring = GF(2) then
        if nargs = 1 then
            return SparseMatrix( arg[1], arg[1], List( [ 1 .. arg[1] ], i -> [] ) );
        elif nargs = 2 then
            return SparseMatrix( arg[1], arg[2], List( [ 1 .. arg[1] ], i -> [] ) );
        fi;
    elif nargs = 1 then
        return SparseMatrix( arg[1], arg[1], List( [ 1 .. arg[1] ], i -> [] ), List( [ 1 .. arg[1] ], i -> [] ), ring );
    elif nargs = 2 then
        return SparseMatrix( arg[1], arg[2], List( [ 1 .. arg[1] ], i -> [] ), List( [ 1 .. arg[1] ], i -> [] ), ring );
    fi;
    
    Error( "wrong number of arguments in SparseZeroMatrix!" );
    
  end
);

##  <#GAPDoc Label="SparseIdentityMatrix">
##  <ManSection >
##  <Func Arg="dim[, ring]" Name="SparseIdentityMatrix" />
##  <Returns>a sparse &lt;<A>dim</A> x <A>dim</A>&gt; identity matrix over the ring <A>ring</A>.
##  If no ring is specified (one should try to avoid this if possible)
##  the Rationals are the default ring.</Returns>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( SparseIdentityMatrix,
  function( arg )
    local nargs, ring, indices, entries;
    
    nargs := Length( arg );
    
    if IsRing( arg[ nargs ] ) then
        ring := arg[ Length( arg ) ];
        nargs := nargs - 1;
    else
        ring := Rationals;
    fi;
    
    if nargs = 1 then
        indices := List( [ 1 .. arg[1] ], i -> [i] );
        if ring = GF(2) then
            return SparseMatrix( arg[1], arg[1], indices );
        else
            entries := List( [ 1 .. arg[1] ], i -> [ One( ring ) ] );
            return SparseMatrix( arg[1], arg[1], indices, entries, ring );
        fi;
    else
        Error( "wrong number of arguments in SparseIdentityMatrix!" );;
    fi;
    
  end

);

##
InstallMethod( \=,
        [ IsSparseMatrix, IsSparseMatrix ],
  function( A, B )
    return A!.nrows = B!.nrows and
           A!.ncols = B!.ncols and
           A!.ring = B!.ring and
           A!.indices = B!.indices and
           A!.entries = B!.entries;
  end
);

##  <#GAPDoc Label="TransposedSparseMat">
##  <ManSection >
##  <Meth Arg="sm" Name="TransposedSparseMat" />
##  <Returns>the transposed matrix of the sparse matrix <A>sm</A></Returns>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( TransposedSparseMat,
        [ IsSparseMatrix ],
  function( M )
    local T, i, j;
    T := SparseZeroMatrix( M!.ncols, M!.nrows, M!.ring );
    for i in [ 1 .. M!.nrows ] do
        for j in [ 1 .. Length( M!.indices[i] ) ] do
            Add( T!.indices[ M!.indices[i][j] ], i );
            Add( T!.entries[ M!.indices[i][j] ], M!.entries[i][j] );
        od;
    od;

    return T;
    
  end
);

##  <#GAPDoc Label="CertainRows">
##  <ManSection >
##  <Meth Arg="sm, list" Name="CertainRows" />
##  <Returns>the submatrix <C>sm{[list]}</C> as a sparse matrix</Returns>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( CertainRows,
        [ IsSparseMatrix, IsList ],
  function( M, L )
    return SparseMatrix( Length( L ), M!.ncols, M!.indices{ L }, M!.entries{ L }, M!.ring );
  end
);

##  <#GAPDoc Label="CertainColumns">
##  <ManSection >
##  <Meth Arg="sm, list" Name="CertainColumns" />
##  <Returns>the submatrix <C>sm{[1..nrows(sm)]}{[list]}</C> as a sparse matrix</Returns>
##  </ManSection>
##  <#/GAPDoc>
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
    
    return SparseMatrix( M!.nrows, Length( L ), indices, entries, M!.ring );
    
  end
);

##  <#GAPDoc Label="UnionOfRows">
##  <ManSection >
##  <Meth Arg="A, B" Name="UnionOfRows" />
##  <Returns>the row union of the sparse matrices <A>A</A> and <A>B</A></Returns>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( UnionOfRows,
        [ IsSparseMatrix, IsSparseMatrix ],
  function( A, B )
    return SparseMatrix( A!.nrows + B!.nrows, A!.ncols, Concatenation( A!.indices, B!.indices ), Concatenation( A!.entries, B!.entries ), A!.ring );
  end
);

##  <#GAPDoc Label="UnionOfColumns">
##  <ManSection >
##  <Meth Arg="A, B" Name="UnionOfColumns" />
##  <Returns>the column union of the sparse matrices <A>A</A> and <A>B</A></Returns>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( UnionOfColumns,
        [ IsSparseMatrix, IsSparseMatrix ],
  function( A, B )
    return SparseMatrix( A!.nrows, A!.ncols + B!.ncols, List( [ 1 .. A!.nrows ], i -> Concatenation( A!.indices[i], B!.indices[i] + A!.ncols ) ), List( [ 1 .. A!.nrows ], i -> Concatenation( A!.entries[i], B!.entries[i] ) ), A!.ring );
  end
);

##  <#GAPDoc Label="SparseDiagMat">
##  <ManSection >
##  <Func Arg="list" Name="SparseDiagMat" />
##  <Returns>the block diagonal matrix composed of the
##  sparse matrices in <A>list</A></Returns>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( SparseDiagMat,
  function( e )
    if Length( e ) = 1 then
        return e[1];
    elif Length( e ) > 2 then
        return SparseDiagMat( Concatenation( [ SparseDiagMat( e{[1,2]} ) ], e{[ 3 .. Length( e ) ]} ) );
    else
        if IsSparseMatrixGF2Rep( e[1] ) then
            return SparseMatrix( e[1]!.nrows + e[2]!.nrows, e[1]!.ncols + e[2]!.ncols, Concatenation( e[1]!.indices, e[2]!.indices + e[1]!.ncols ) );
        else
            return SparseMatrix( e[1]!.nrows + e[2]!.nrows, e[1]!.ncols + e[2]!.ncols, Concatenation( e[1]!.indices, e[2]!.indices + e[1]!.ncols ), Concatenation( e[1]!.entries, e[2]!.entries ), e[1]!.ring );
        fi;
    fi;
  end
);

##
InstallMethod( \*,
        [ IsRingElement, IsSparseMatrix ],
  function( a, A )
    local i, m;
    if IsZero( a ) then
        return SparseZeroMatrix( A!.nrows, A!.ncols, A!.ring );
    elif IsUnit( A!.ring, a ) then
        return SparseMatrix( A!.nrows, A!.ncols, A!.indices, A!.entries * a, A!.ring );
    else
        for i in [ 1 .. A!.nrows ] do
            m := MultRow( A!.indices[ i ], A!.entries[ i ], a );
            A!.indices[i] := m.indices;
            A!.entries[i] := m.entries;
        od;
    fi;
  end
);
  
##
InstallMethod( \*,
        [ IsSparseMatrix, IsSparseMatrix ],
  function( A, B )
    local C, i, j, rownr, m;
    if A!.ncols <> B!.nrows or A!.ring <> B!.ring then
        return fail;
    fi;
    C := SparseZeroMatrix( A!.nrows, B!.ncols, A!.ring );
    for i in [ 1 .. C!.nrows ] do
        for j in [ 1 .. Length( A!.indices[i] ) ] do
            rownr := A!.indices[i][j];
	    m := MultRow( B!.indices[ rownr ], B!.entries[ rownr ], A!.entries[i][j] );
            AddRow( m.indices, m.entries, C!.indices, C!.entries, i );
        od;
    od;
    return C;
  end
);

##
InstallMethod( \+,
        [ IsSparseMatrix, IsSparseMatrix ],
  function( A, B )
    local C, i;
    C := CopyMat( A );
    for i in [ 1 .. C!.nrows ] do
        AddRow( B!.indices[i], B!.entries[i], C!.indices, C!.entries, i );
    od;
    return C;
  end
);

##
InstallMethod( \-,
        [ IsSparseMatrix, IsSparseMatrix ],
  function( A, B )
    return A + ( - One( B!.ring ) ) * B;
  end
);
  

##  <#GAPDoc Label="Nrows">
##  <ManSection >
##  <Meth Arg="sm" Name="Nrows" />
##  <Returns>the number of rows of the sparse matrix <A>sm</A>.
##  This should be preferred to the equivalent <C>sm!.nrows</C>.</Returns>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Nrows,
        [ IsSparseMatrix ],
  function( M )
    return M!.nrows;
  end
);

##  <#GAPDoc Label="Ncols">
##  <ManSection >
##  <Meth Arg="sm" Name="Ncols" />
##  <Returns>the number of columns of the sparse matrix <A>sm</A>.
##  This should be preferred to the equivalent <C>sm!.ncols</C>.</Returns>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Ncols,
        [ IsSparseMatrix ],
  function( M )
    return M!.ncols;
  end
);

##  <#GAPDoc Label="IndicesOfSparseMatrix">
##  <ManSection >
##  <Meth Arg="sm" Name="IndicesOfSparseMatrix" />
##  <Returns>the indices of the sparse matrix <A>sm</A> as a ListList.
##  This should be preferred to the equivalent <C>sm!.indices</C>.</Returns>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( IndicesOfSparseMatrix,
        [ IsSparseMatrix ],
  function( M )
    return M!.indices;
  end
);

##  <#GAPDoc Label="EntriesOfSparseMatrix">
##  <ManSection >
##  <Meth Arg="sm" Name="EntriesOfSparseMatrix" />
##  <Returns>the entries of the sparse matrix <A>sm</A> as a ListList of ring elements.
##  This should be preferred to the equivalent <C>sm!.entries</C> and has the additional
##  advantage of working for sparse matrices over GF(2) which do not have any entries.</Returns>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( EntriesOfSparseMatrix,
        [ IsSparseMatrix ],
  function( M )
    if IsSparseMatrixGF2Rep( M ) then
        return List( M!.indices, row -> ListWithIdenticalEntries( Length( row ), One( GF(2) ) ) );
    else
        return M!.entries;
    fi;
  end
);

##  <#GAPDoc Label="RingOfDefinition">
##  <ManSection >
##  <Meth Arg="sm" Name="RingOfDefinition" />
##  <Returns>the base ring of the sparse matrix <A>sm</A>.
##  This should be preferred to the equivalent <C>sm!.ring</C>.</Returns>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( RingOfDefinition,
        [ IsSparseMatrix ],
  function( M )
    return M!.ring;
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
    one := One( M!.ring );
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
InstallMethod( SparseKroneckerProduct,
        [ IsSparseMatrix, IsSparseMatrix ],
        function( A, B )
    local indices, entries, i1, i2, rowindex, j1, j2, prod;
    
    indices := [];
    entries := [];
    
    for i1 in [ 1 .. A!.nrows ] do
        for i2 in [ 1 .. B!.nrows ] do
            rowindex := ( i1 - 1 ) * B!.nrows + i2;
	    indices[ rowindex ] := [];
            entries[ rowindex ] := [];
            for j1 in [ 1 .. Length( A!.indices[i1] ) ] do
                for j2 in [ 1.. Length( B!.indices[i2] ) ] do
                    prod := A!.entries[i1][j1] * B!.entries[i2][j2];
                    if not IsZero( prod ) then
                        Add( indices[ rowindex ], ( A!.indices[i1][j1] - 1 ) * B!.ncols + B!.indices[i2][j2] );
                        Add( entries[ rowindex ], prod );
                    fi;
                od;
            od;
        od;
    od;
    
    return SparseMatrix( A!.nrows * B!.nrows, A!.ncols * B!.ncols, indices, entries, A!.ring );
    
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
InstallMethod( SparseZeroColumns,
        [ IsSparseMatrix ],
  function( M )
    return Difference( [ 1 .. M!.ncols ], Union( M!.indices ) );
  end
);
  

##
InstallMethod( MultRow, #no side effect!
        [ IsList, IsList, IsRingElement ],
  function( indices, entries, x )
    local prod, list;
    if IsUnit( x ) then
        return rec( indices := indices, entries := entries * x );
    else
        prod := entries * x;
        list := Filtered( [ 1 .. Length( prod ) ], i -> not IsZero( prod[i] ) );
        return rec( indices := indices{ list }, entries := prod{ list } );
    fi;
  end
);
  
InstallOtherMethod(AddRow,[IsList,IsList,IsList,IsList,IsInt],
        function (row1_indices, row1_entries, p_sum_indices, p_sum_entries, i)
    # (row1_indices, row1_entries) is row1
    # (p_sum_indices[i], p_sum_entries[i]) is row2
    # modifies p_sum_indices[i] and p_sum_entriesi[] to make them equal row1 + row2
    local pos1, pos2, len1, len2, row2_indices, row2_entries, sum_indices, sum_entries, index1, index2, s;
    
    len1 := Length(row1_indices);
    if len1 = 0 then return; fi;
    row2_indices := p_sum_indices[i]; row2_entries := p_sum_entries[i];
    len2 := Length(row2_indices);
    pos1 := 1;
    pos2 := 1;
    
    p_sum_indices[i] := []; sum_indices := p_sum_indices[i];
    p_sum_entries[i] := []; sum_entries := p_sum_entries[i];
    
    while true do
        if pos1 > len1 then
            Append(sum_indices, row2_indices{[pos2..len2]});
            Append(sum_entries, row2_entries{[pos2..len2]});
            return;
        fi;
        if pos2 > len2 then
            Append(sum_indices, row1_indices{[pos1..len1]});
            Append(sum_entries, row1_entries{[pos1..len1]});
            return;
        fi;
        index1 := row1_indices[pos1];
        index2 := row2_indices[pos2];    
        
        if index1 > index2 then
            Add(sum_indices, index2);
            Add(sum_entries, row2_entries[pos2]);
            pos2 := pos2 + 1;
        elif index1 < index2 then
            Add(sum_indices, index1);
            Add(sum_entries, row1_entries[pos1]);
            pos1 := pos1 + 1;
        else
            s := row1_entries[pos1] + row2_entries[pos2];
            if not IsZero(s) then
                Add(sum_indices, index1);
                Add(sum_entries, s);
            fi;
            pos1 := pos1 + 1;
            pos2 := pos2 + 1;
        fi;
    od;
end);

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


