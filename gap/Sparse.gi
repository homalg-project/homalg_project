############################################################################
##
##  Sparse.gi                  Gauss package                  Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B fÅ¸r Mathematik, RWTH Aachen
##
##  Implementation stuff for performing algorithms on sparse matrices.
##  Also includes the documentation of these algorithms.
##
#############################################################################

##  <#GAPDoc Label="EchelonMat">
##  <ManSection Label="echelonmat">
##  <Meth Arg="mat" Name="EchelonMat"/>
##  <Returns>a record that contains information about an echelonized
##  form of the matrix <A>mat</A>.<P/>
##  The components of this record are<P/>
##  `vectors'<P/>
##      the reduced row echelon / hermite form of the matrix <A>mat</A>
##      without zero rows.<P/>
##  `heads'<P/>
##      list that contains at position &lt;i&gt;, if nonzero, the
##      number of the row for that the pivot element is in column &lt;i&gt;.
##  </Returns>
##  <Description>
##  computes the reduced row echelon form RREF of a dense or sparse matrix
##  <A>mat</A> over a field,
##  or the hermite form of a sparse matrix <A>mat</A> over <M>&ZZ; / &lt; p^n ></M>.
##  <Example><![CDATA[
##  gap> M := [[0,0,0,1,0],[0,1,1,1,1],[1,1,1,1,0]] * One( GF(2) );;
##  gap> Display(M);
##   . . . 1 .
##   . 1 1 1 1
##   1 1 1 1 .
##  gap> EchelonMat(M);
##  rec( heads := [ 1, 2, 0, 3, 0 ],
##       vectors := [ <a GF2 vector of length 5>,
##                    <a GF2 vector of length 5>,
##                    <a GF2 vector of length 5> ] )
##  gap> Display( last.vectors );
##   1 . . . 1
##   . 1 1 . 1
##   . . . 1 .
##  gap> SM := SparseMatrix( M );
##  <a 3 x 5 sparse matrix over GF(2)>
##  gap> EchelonMat( SM );
##  rec( heads := [ 1, 2, 0, 3, 0 ],
##       vectors := <a 3 x 5 sparse matrix over GF(2)> )
##  gap> Display(last.vectors);
##   1 . . . 1
##   . 1 1 . 1
##   . . . 1 .
##  gap> SM := SparseMatrix( [[7,4,5],[0,0,6],[0,4,4]] * One( Integers mod 8 ) );
##  <a 3 x 3 sparse matrix over (Integers mod 8)>
##  gap> Display( SM );
##   7 4 5
##   . . 6
##   . 4 4
##  gap> EchelonMat( SM );
##  rec( heads := [ 1, 2, 3 ],
##       vectors := <a 3 x 3 sparse matrix over (Integers mod 8)> )
##  gap> Display( last.vectors );
##   1 . 1
##   . 4 .
##   . . 2      
##  ]]></Example>
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
##  <Returns>a record that contains information about an echelonized
##  form of the matrix <A>mat</A>.<P/>
##  The components of this record are<P/>
##  `vectors'<P/>
##      the reduced row echelon / hermite form of the matrix
##      <A>mat</A> without zero rows.<P/>
##  `heads'<P/>
##      list that contains at position &lt;i&gt;, if nonzero, the
##      number of the row for that the pivot element is in column &lt;i&gt;.<P/>
##  `coeffs'<P/>
##      the transformation matrix needed to obtain the RREF from <A>mat</A>.<P/>
##  `relations'<P/>
##      the kernel of the matrix <A>mat</A> if ring(<A>mat</A>) is a field.
##      Otherwise these are only the obvious row relations of <A>mat</A>,
##      there might be more kernel vectors - &see; <Ref Func="KernelMat" Style="Number"/>.
##  </Returns>
##  <Description>
##  computes the reduced row echelon form RREF of a dense or sparse matrix
##  <A>mat</A> over a field,
##  or the hermite form of a sparse matrix <A>mat</A> over <M>&ZZ; / &lt; p^n &gt;</M>.
##  In either case, the transformation matrix <M>T</M> is calculated
##  as the row union of `coeffs' and `relations'.
##  <Example><![CDATA[
##  gap> M := [[1,0,1],[1,1,0],[1,0,1],[1,1,0],[1,1,1]] * One( GF(2) );;
##  gap> EchelonMatTransformation( M );
##  rec( heads := [ 1, 2, 3 ],
##       vectors := [ <a GF2 vector of length 3>,
##                    <a GF2 vector of length 3>,
##                    <a GF2 vector of length 3> ],
##       coeffs := [ <a GF2 vector of length 5>,
##                   <a GF2 vector of length 5>,
##                   <a GF2 vector of length 5> ],
##       relations := [ <a GF2 vector of length 5>,
##                      <a GF2 vector of length 5> ] )
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
##  rec( heads := [ 1, 2, 3 ],
##       vectors := <a 3 x 3 sparse matrix over GF(2)>,
##       coeffs := <a 3 x 5 sparse matrix over GF(2)>,
##       relations := <a 2 x 5 sparse matrix over GF(2)> )
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
##  ]]></Example>
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

##  <#GAPDoc Label="ReduceMat">
##  <ManSection>
##  <Meth Arg="A, B" Name="ReduceMat" />
##  <Returns>a record with a single component `reduced_matrix' := M.
##  M is created by reducing <A>A</A> with <A>B</A>, where <A>B</A> must
##  be in Echelon/Hermite form. M will have the same dimensions as <A>A</A>.</Returns>
##  <Description>
##  <Example><![CDATA[
##  gap> M := [[0,0,0,1,0],[0,1,1,1,1],[1,1,1,1,0]] * One( GF(2) );;
##  gap> Display(M);
##   . . . 1 .
##   . 1 1 1 1
##   1 1 1 1 .
##  gap> N := [[1,1,0,0,0],[0,0,1,0,1]] * One( GF(2) );;
##  gap> Display(N);
##   1 1 . . .
##   . . 1 . 1
##  gap> ReduceMat(M,N);
##  rec( reduced_matrix := [ <a GF2 vector of length 5>,
##                           <a GF2 vector of length 5>,
##                           <a GF2 vector of length 5> ] )
##  gap> Display(last.reduced_matrix);
##   . . . 1 .
##   . 1 . 1 .
##   . . . 1 1
##  gap> SM := SparseMatrix(M); SN := SparseMatrix(N);
##  <a 3 x 5 sparse matrix over GF(2)>
##  <a 2 x 5 sparse matrix over GF(2)>
##  gap> ReduceMat(SM,SN);
##  rec( reduced_matrix := <a 3 x 5 sparse matrix over GF(2)> )
##  gap> Display(last.reduced_matrix);
##   . . . 1 .
##   . 1 . 1 .
##   . . . 1 1
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
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

##  <#GAPDoc Label="ReduceMatTransformation">
##  <ManSection>
##  <Meth Arg="A, B" Name="ReduceMatTransformation" />
##  <Returns>a record with a component `reduced_matrix' := M.
##  M is created by reducing <A>A</A> with <A>B</A>, where <A>B</A> must
##  be in Echelon/Hermite form. M will have the same dimensions as <A>A</A>.
##  In addition to the (identical) output as ReduceMat this record also
##  includes the component `transformation', which stores the row operations
##  that were needed to reduce <A>A</A> with <A>B</A>. This differs from "normal"
##  transformation matrices because only rows of <A>B</A> had to be moved.
##  Therefore, the transformation matrix solves M = A + T * B.</Returns>
##  <Description>
##  <Example><![CDATA[
##  gap> M := [[0,0,0,1,0],[0,1,1,1,1],[1,1,1,1,0]] * One( GF(2) );;
##  gap> Display(M);
##   . . . 1 .
##   . 1 1 1 1
##    1 1 1 1 .
##  gap> N := [[1,1,0,0,0],[0,0,1,0,1]] * One( GF(2) );;
##  gap> Display(N);
##   1 1 . . .
##   . . 1 . 1
##  gap> ReduceMatTransformation(M,N);
## rec( reduced_matrix := [ <a GF2 vector of length 5>,
##                          <a GF2 vector of length 5>,
##                          <a GF2 vector of length 5> ],
##      transformation := [ <a GF2 vector of length 2>,
##                          <a GF2 vector of length 2>,
##                          <a GF2 vector of length 2> ] )
##  gap> Display(last.reduced_matrix);
##   . . . 1 .
##   . 1 . 1 .
##   . . . 1 1
##  gap> Display(last.transformation);
##   . .
##   . 1
##   1 1
##  gap> Display( M + last.transformation * N );
##   . . . 1 .
##   . 1 . 1 .
##   . . . 1 1 
##  gap> SM := SparseMatrix(M); SN := SparseMatrix(N);
##  <a 3 x 5 sparse matrix over GF(2)>
##  <a 2 x 5 sparse matrix over GF(2)>
##  gap> ReduceMatTransformation(SM,SN);
##  rec( reduced_matrix := <a 3 x 5 sparse matrix over GF(2)>,
##       transformation := <a 3 x 2 sparse matrix over GF(2)> )
##  gap> Display(last.reduced_matrix);
##   . . . 1 .
##   . 1 . 1 .
##   . . . 1 1
##  gap> Display(last.transformation);
##   . .
##   . 1
##   1 1
##  gap> Display( SM + last.transformation * SN );
##   . . . 1 .
##   . 1 . 1 .
##   . . . 1 1
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( ReduceMatTransformation,
        "for sparse matrices over a ring, second argument must be in REF",
        [ IsSparseMatrix, IsSparseMatrix ],
  function( mat, N )
    if IsField( mat!.ring ) then
        return ReduceMatWithEchelonMatTransformation( mat, N );
    else
        return ReduceMatWithHermiteMatTransformation( mat, N );
    fi;
  end
);

##  <#GAPDoc Label="KernelMat">
##  <ManSection Label="kernelmat">
##  <Func Arg="M" Name="KernelMat"/>
##  <Returns>a record with a single component `relations'.</Returns>
##  <Description>
##  If <A>M</A> is a matrix over a field this is the same output as
##  <Ref Meth="EchelonMatTransformation"/> provides in the
##  `relations' component, but with less memory and CPU usage.
##  If the base ring of <A>M</A> is a non-field, the Kernel might
##  have additional generators, which are added to the output.
##  <Example><![CDATA[
##  gap> M := [[2,1],[0,2]];
##  [ [ 2, 1 ], [ 0, 2 ] ]
##  gap> SM := SparseMatrix( M * One( GF(3) ) );
##  <a 2 x 2 sparse matrix over GF(3)>
##  gap> KernelMat(SM);
##  rec( relations := <a 0 x 2 sparse matrix over GF(3)> )
##  gap> SN := SparseMatrix( M * One( Integers mod 4 ) );
##  <a 2 x 2 sparse matrix over (Integers mod 4)>
##  gap> KernelMat(SN);
##  rec( relations := <a 1 x 2 sparse matrix over (Integers mod 4)> )
##  gap> Display(last.relations);
##   2 1
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
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

##  <#GAPDoc Label="Rank">
##  <ManSection>
##  <Meth Arg="sm[, boundary]" Name="Rank" />
##  <Returns>the rank of the sparse matrix <A>sm</A>. Only works for fields.</Returns>
##  <Description>
##  Computes the rank of a sparse matrix. If the optional argument
##  <A>boundary</A> is provided, some algorithms take into account
##  the fact that Rank(<A>sm</A>) &lt;= <A>boundary</A>, thus
##  possibly terminating earlier.
##  <Example><![CDATA[
##  gap> M := SparseDiagMat( ListWithIdenticalEntries( 10,\
##             SparseMatrix( [[1,1],[1,1]] * One( GF(5) ) ) ) );
##  <a 20 x 20 sparse matrix over GF(5)>
##  gap> Display(M);
##   1 1 . . . . . . . . . . . . . . . . . .
##   1 1 . . . . . . . . . . . . . . . . . .
##   . . 1 1 . . . . . . . . . . . . . . . .
##   . . 1 1 . . . . . . . . . . . . . . . .
##   . . . . 1 1 . . . . . . . . . . . . . .
##   . . . . 1 1 . . . . . . . . . . . . . .
##   . . . . . . 1 1 . . . . . . . . . . . .
##   . . . . . . 1 1 . . . . . . . . . . . .
##   . . . . . . . . 1 1 . . . . . . . . . .
##   . . . . . . . . 1 1 . . . . . . . . . .
##   . . . . . . . . . . 1 1 . . . . . . . .
##   . . . . . . . . . . 1 1 . . . . . . . .
##   . . . . . . . . . . . . 1 1 . . . . . .
##   . . . . . . . . . . . . 1 1 . . . . . .
##   . . . . . . . . . . . . . . 1 1 . . . .
##   . . . . . . . . . . . . . . 1 1 . . . .
##   . . . . . . . . . . . . . . . . 1 1 . .
##   . . . . . . . . . . . . . . . . 1 1 . .
##   . . . . . . . . . . . . . . . . . . 1 1
##   . . . . . . . . . . . . . . . . . . 1 1
##  gap> Rank(M);
##  10
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Rank,
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
        "method for sparse matrices with upper boundary",
        [ IsSparseMatrix, IsInt ],
  function( mat, upper_boundary )
    if IsField( mat!.ring ) then
        return RankDestructive( CopyMat( mat ), Minimum( upper_boundary, mat!.ncols ) );
    else
        Error( "no Rank method for matrices over ", mat!.ring, "!" );
    fi;
  end
);
