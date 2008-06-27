############################################################################
##
##  Sparse.gi                  Gauss package                  Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B fÅ¸r Mathematik, RWTH Aachen
##
##  Implementation stuff for performing algorithms on sparse matrices.
##
#############################################################################

##  <#GAPDoc Label="EchelonMat">
##  <ManSection>
##  <Meth Arg="mat" Name="EchelonMat" />
##  <Returns>a record that contains information about a echelonized form of the matrix <mat>.<P/>
##  The components of this record are<P/>
##  `vectors'<P/>
##      the reduced row echelon / hermite form of the matrix <A>mat</A> without zero rows.<P/>
##  `heads'<P/>
##      list that contains at position <i>, if nonzero, the number of the row for that the pivot element is in column <i>.
##  </Returns>
##  <Description>
##  computes the reduced row echelon form RREF of a dense or sparse matrix <A>mat</A> over a field,<P/>
##  or the hermite form of a sparse matrix <A>mat</A> over <M>Z / < p^n * Z ></M>.
##  <Example>
##  gap> M := RandomMat( 3, 5, GF(2) );
##  <a 3x5 matrix over GF2>
##  gap> Display(M);
##   . . . 1 .
##   . 1 1 1 1
##   1 1 1 1 .
##  gap> EchelonMat(M);
##  rec( heads := [ 1, 2, 0, 3, 0 ], vectors := [ <a GF2 vector of length 5>, <a GF2 vector of length 5>, <a GF2 vector of length 5> ] )
##  gap> Display( last.vectors );
##   1 . . . 1
##   . 1 1 . 1
##   . . . 1 .
##  gap> SM := SparseMatrix( M );
##  <a 3 x 5 sparse matrix over GF(2)>
##  gap> EchelonMat( SM );
##  rec( heads := [ 1, 2, 0, 3, 0 ], vectors := <a 3 x 5 sparse matrix over GF(2)> )
##  gap> Display(last.vectors);
##   1 . . . 1
##   . 1 1 . 1
##   . . . 1 .
##  gap> SM := SparseMatrix( [ [ 7, 4, 5 ], [ 0, 0, 6 ], [ 0, 4, 4 ] ] * One( Integers mod 8 ) );
##  <a 3 x 3 sparse matrix over (Integers mod 8)>
##  gap> Display( SM );
##   7 4 5
##   . . 6
##   . 4 4
##  gap> EchelonMat( SM );
##  rec( heads := [ 1, 2, 3 ], vectors := <a 3 x 3 sparse matrix over (Integers mod 8)> )
##  gap> Display( last.vectors );
##   1 . 1
##   . 4 .
##   . . 2      
##  </Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( EchelonMat,
        "method for sparse matrices",
        [ IsSparseMatrix ],
  function( mat )
    if IsField( mat!.ring ) then
        return EchelonMatDestructive( CopyMat( mat ) );
    else
        return HermiteMatDestructive( CopyMat( mat ) );
    fi;
  end
);

##  <#GAPDoc Label="EchelonMatTransformation">
##  <ManSection>
##  <Meth Arg="mat" Name="EchelonMatTransformation" />
##  <Returns>a record that contains information about a echelonized form of the matrix <mat>.<P/>
##  The components of this record are<P/>
##  `vectors'<P/>
##      the reduced row echelon / hermite form of the matrix <A>mat</A> without zero rows.<P/>
##  `heads'<P/>
##      list that contains at position <i>, if nonzero, the number of the row for that the pivot element is in column <i>.
##  `coeffs'<P/>
##      the transformation matrix needed to obtain the RREF from <A>mat</A>.<P/>
##  `relations'<P/>
##      the kernel of the matrix <A>mat</A> if ring(<A>mat</A>) is a field. Otherwise these are only the obvious relations between the rows of <A>mat</A>, there might be more - compare to KernelMat ).<P/>
##  </Returns>
##  <Description>
##  computes the reduced row echelon form RREF of a dense or sparse matrix <A>mat</A> over a field,<P/>
##  or the hermite form of a sparse matrix <A>mat</A> over <M>Z / < p^n * Z ></M>.<P/>
##  In either case, the transformation matrix <M>T</M> is calcualated as the row union of `coeffs' and `relations'.
##  <Example>
##  gap> M := RandomMat( 5, 3, GF(2) );
##  <a 5x3 matrix over GF2>
##  gap> EchelonMatTransformation( M );
##  rec( heads := [ 1, 2, 3 ], vectors := [ <a GF2 vector of length 3>, <a GF2 vector of length 3>, <a GF2 vector of length 3> ], coeffs := [ <a GF2 vector of length 5>, <a GF2 vector of length 5>, <a GF2 vector of length 5> ], relations := [ <a GF2 vector of length 5>, <a GF2 vector of length 5> ] )
##  gap> Display(last.vectors);
##   1 . .
##   . 1 .
##   . . 1
##  gap> Display(last.coeffs);
##   1 1 . . 1
##   1 . . . 1
##   . 1 . . 1
##  gap> Display(last.relations);
##   1 . 1 . .
##   . 1 . 1 .
##  gap> Display( Concatenation( last.coeffs, last.relations ) * M );
##   1 . .
##   . 1 .
##   . . 1
##   . . .
##   . . .
##  gap> SM := SparseMatrix( M );
##  <a 5 x 3 sparse matrix over GF(2)>
##  gap> EchelonMatTransformation( SM );
##  rec( heads := [ 1, 2, 3 ], vectors := <a 3 x 3 sparse matrix over GF(2)>, coeffs := <a 3 x 5 sparse matrix over GF(2)>, relations := <a 2 x 5 sparse matrix over GF(2)> )
##  gap> Display(last.vectors);
##   1 . .
##   . 1 .
##   . . 1
##  gap> Display(last.coeffs);
##   1 1 . . 1
##   1 . . . 1
##   . 1 . . 1
##  gap> Display(last.relations);
##   1 . 1 . .
##   . 1 . 1 .
##  gap> Display( UnionOfRows( last.coeffs, last.relations ) * SM );
##   1 . .
##   . 1 .
##   . . 1
##   . . .
##   . . .
##  </Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( EchelonMatTransformation,
        "method for sparse matrices",
        [ IsSparseMatrix ],
  function( mat )
    if IsField( mat!.ring ) then
        return EchelonMatTransformationDestructive( CopyMat( mat ) );
    else
        return HermiteMatTransformationDestructive( CopyMat( mat ) );
    fi;
  end
);

##
InstallMethod( ReduceMat,
        "for sparse matrices over a ring, second argument must be in REF",
        [ IsSparseMatrix, IsSparseMatrix ],
  function( mat, N )
    if IsField( mat!.ring ) then
        return ReduceMatWithEchelonMat( mat, N );
    else
        return ReduceMatWithHermiteMat( mat, N );
    fi;
  end
);

##
InstallGlobalFunction( KernelMatSparse,
  function( arg )
    local M;
    
    M := CopyMat( arg[1] );
    
    if IsField( M!.ring ) and Length( arg ) = 1 then
        return KernelEchelonMatDestructive( M, [ 1 .. M!.nrows ] );
    elif IsField( M!.ring ) and Length( arg ) > 1 then
        return KernelEchelonMatDestructive( M, arg[2] );
    elif Length( arg ) = 1 then
        return KernelHermiteMatDestructive( M, [ 1 .. M!.nrows ] );
    elif Length( arg ) > 1 then
        return KernelHermiteMatDestructive( M, arg[2] );
    fi;
    
  end
);

##
InstallOtherMethod( Rank,
        "method for sparse matrices",
        [ IsSparseMatrix ],
  function( mat )
    if mat!.ring = GF(2) then
        return Length( RankOfIndicesListList( mat!.indices ).vectors );
    elif IsField( mat!.ring ) then
        return RankDestructive( CopyMat( mat ), mat!.ncols );
    else
        Error( "no Rank method for matrices over ", mat!.ring, "!" );
    fi;
  end
);

##
InstallOtherMethod( Rank,
        "method for sparse matrices",
        [ IsSparseMatrix, IsInt ],
  function( mat, upper_boundary )
    if IsField( mat!.ring ) then
        return RankDestructive( CopyMat( mat ), Minimum( upper_boundary, mat!.ncols ) );
    else
        Error( "no Rank method for matrices over ", mat!.ring, "!" );
    fi;
  end
);
