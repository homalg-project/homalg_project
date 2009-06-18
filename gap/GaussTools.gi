############################################################################
##
##  GaussTools.gi         GaussForHomalg package          Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Homalg Table for calculating in Gauss with dense and sparse matrices
##
#############################################################################

####################################
#
# global variables:
#
####################################

# add IsSparseMatrix to the list of types of homalg internal matrix types:
if IsBound( HOMALG.OtherInternalMatrixTypes ) then
    Add( HOMALG.OtherInternalMatrixTypes, IsSparseMatrix );
else
    HOMALG.OtherInternalMatrixTypes := [ IsSparseMatrix ];
fi;
##

InstallValue( CommonHomalgTableForGaussTools,
        
        # most of these functions just call the corresponding operation
        # in the Gauss package, check there in case of questions
        
        rec(

##  <#GAPDoc Label="ZeroMatrix">
##  <ManSection>
##  <Func Arg="C" Name="ZeroMatrix"/>
##  <Returns>a sparse matrix</Returns>
##  <Description>
##  This returns a sparse matrix with the same dimensions and base
##  ring as the &homalg; matrix <A>C</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
               ZeroMatrix :=
                 function( C )
                   local R;
                   R := HomalgRing( C );
                   
                   return SparseZeroMatrix( NrRows( C ), NrColumns( C ), R!.ring );
                   
                 end,
##  <#GAPDoc Label="IdentityMatrix">
##  <ManSection>
##  <Func Arg="C" Name="IdentityMatrix"/>
##  <Returns>a sparse matrix</Returns>
##  <Description>
##  This returns a sparse <M>n \times n</M> identity matrix with the
##  same ring as the &homalg; matrix <A>C</A>, <M>n</M> being the
##  number of rows of <A>C</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>             
               IdentityMatrix :=
                 function( C )
                   local R;
                   R := HomalgRing( C );
                   
                   return SparseIdentityMatrix( NrRows( C ), R!.ring );
                   
                 end,
##  <#GAPDoc Label="CopyMatrix">
##  <ManSection>
##  <Func Arg="C" Name="CopyMatrix"/>
##  <Returns>a sparse matrix</Returns>
##  <Description>
##  This returns a sparse matrix which is a shallow copy of the
##  sparse matrix stored in the <C>Eval</C> attribute of the
##  &homalg; matrix <A>C</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
               CopyMatrix :=
                 function( C )
                   return CopyMat( Eval( C ) );
                 end,
##  <#GAPDoc Label="ImportMatrix">
##  <ManSection>
##  <Func Arg="M, R" Name="ImportMatrix"/>
##  <Returns>a sparse matrix</Returns>
##  <Description>
##  This returns the sparse version of the &GAP; matrix <A>M</A>
##  over the ring <A>R</A>. It prevents &homalg; from calling sparse matrix
##  algorithms on dense &GAP; matrices. Note that this is not a
##  "standard" tool but neccessary because of the new data type.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
               ImportMatrix :=
                 function( M, R )
                   return SparseMatrix( M, R );
                 end,
##  <#GAPDoc Label="ExportMatrix">
##  <ManSection>
##  <Func Arg="M" Name="ExportMatrix"/>
##  <Returns>a dense matrix</Returns>
##  <Description>
##  This returns the dense version of the matrix <A>M</A>.
##  Note that this is not a "standard" tool but neccessary
##  because of the new data type.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
               ExportMatrix :=
                 function( M )
                   return ConvertSparseMatrixToMatrix( M );
                 end,
##  <#GAPDoc Label="Involution">
##  <ManSection>
##  <Func Arg="M" Name="Involution"/>
##  <Returns>a sparse matrix</Returns>
##  <Description>
##  This returns a sparse matrix which is the transpose of the
##  sparse matrix stored in the <C>Eval</C> attribute of the
##  &homalg; matrix <A>M</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
               # for a general ring (field) the involution is just the transposed matrix
               Involution :=
                 function( M )
                   
                   return TransposedSparseMat( Eval( M ) );
                   
                 end,
##  <#GAPDoc Label="CertainRows">
##  <ManSection>
##  <Func Arg="M, plist" Name="CertainRows"/>
##  <Returns>a sparse matrix</Returns>
##  <Description>
##  This returns the rows in <A>plist</A> of the sparse matrix stored
##  in the <C>Eval</C> attribute of the &homalg; matrix <A>M</A> as
##  a new matrix.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>               
               CertainRows :=
                 function( M, plist )
                   
                   return CertainRows( Eval( M ), plist );
                   
                 end,
##  <#GAPDoc Label="CertainColumns">
##  <ManSection>
##  <Func Arg="M, plist" Name="CertainColumns"/>
##  <Returns>a sparse matrix</Returns>
##  <Description>
##  This returns the columns in <A>plist</A> of the sparse matrix stored
##  in the <C>Eval</C> attribute of the &homalg; matrix <A>M</A> as
##  a new matrix.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
               CertainColumns :=
                 function( M, plist )
                   
                   return CertainColumns( Eval( M ), plist );
                   
                 end,
##  <#GAPDoc Label="UnionOfRows">
##  <ManSection>
##  <Func Arg="A, B" Name="UnionOfRows"/>
##  <Returns>a sparse matrix</Returns>
##  <Description>
##  This returns the sparse matrix created by concatenating the rows of
##  the sparse matrices stored in the <C>Eval</C> attributes of the &homalg;
##  matrices <A>A</A> and <A>B</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>               
               UnionOfRows :=
                 function( A, B )
                   
                   return UnionOfRows( Eval( A ), Eval( B ) );
                   
                 end,
##  <#GAPDoc Label="UnionOfColumns">
##  <ManSection>
##  <Func Arg="A, B" Name="UnionOfColumns"/>
##  <Returns>a sparse matrix</Returns>
##  <Description>
##  This returns the sparse matrix created by concatenating the columns of
##  the sparse matrices stored in the <C>Eval</C> attributes of the &homalg;
##  matrices <A>A</A> and <A>B</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>               
               UnionOfColumns :=
                 function( A, B )
                   
                   return UnionOfColumns( Eval( A ), Eval( B ) );
                   
                 end,
##  <#GAPDoc Label="DiagMat">
##  <ManSection>
##  <Func Arg="e" Name="DiagMat"/>
##  <Returns>a sparse matrix</Returns>
##  <Description>
##  This method takes a list <A>e</A> of &homalg; matrices and returns
##  the sparse block matrix of the matrices stored in the <C>Eval</C>
##  attributes of the matrices in <A>e</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
               DiagMat :=
                 function( e )
                   
                   return SparseDiagMat( List( e, Eval ) );
                   
                 end,
##  <#GAPDoc Label="KroneckerMat">
##  <ManSection>
##  <Func Arg="A, B" Name="KroneckerMat"/>
##  <Returns>a sparse matrix</Returns>
##  <Description>
##  This returns the sparse Kronecker matrix of the matrices stored in the
##  <C>Eval</C> attributes of the &homalg; matrices <A>A</A> and <A>B</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
               KroneckerMat :=
                 function( A, B )
                   
                   return SparseKroneckerProduct( Eval( A ), Eval( B ) );
                   
                 end,
##  <#GAPDoc Label="Compose">
##  <ManSection>
##  <Func Arg="A, B" Name="Compose"/>
##  <Returns>a sparse matrix</Returns>
##  <Description>
##  This returns the matrix product of the sparse matrices stored in the
##  <C>Eval</C> attributes of the &homalg; matrices <A>A</A> and <A>B</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
               Compose :=
                 function( A, B )
                   
                   return Eval( A ) * Eval( B );
                   
                 end,
##  <#GAPDoc Label="NrRows">
##  <ManSection>
##  <Func Arg="C" Name="NrRows"/>
##  <Returns>an integer</Returns>
##  <Description>
##  This returns the number of rows of the sparse matrix stored in the
##  <C>Eval</C> attribute of the &homalg; matrix <A>C</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>               
               NrRows :=
                 function( C )
                   
                   return nrows( Eval( C ) );
                   
                 end,
##  <#GAPDoc Label="NrColumns">
##  <ManSection>
##  <Func Arg="C" Name="NrColumns"/>
##  <Returns>an integer</Returns>
##  <Description>
##  This returns the number of columns of the sparse matrix stored in the
##  <C>Eval</C> attribute of the &homalg; matrix <A>C</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>               
               NrColumns :=
                 function( C )
                   
                   return ncols( Eval( C ) );
                   
                 end,
##  <#GAPDoc Label="IsZeroMatrix">
##  <ManSection>
##  <Func Arg="C" Name="IsZeroMatrix"/>
##  <Returns><B>true</B> or <B>false</B></Returns>
##  <Description>
##  This returns <B>true</B> if the sparse matrix stored in the <C>Eval</C>
##  attribute of the &homalg; matrix <A>C</A> is a zero matrix,
##  and <B>false</B> otherwise.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>                 
               IsZeroMatrix :=
                 function( M )
                   
                   return IsSparseZeroMatrix( Eval( M ) );
                   
                 end,
##  <#GAPDoc Label="IsIdentityMatrix">
##  <ManSection>
##  <Func Arg="C" Name="IsIdentityMatrix"/>
##  <Returns><B>true</B> or <B>false</B></Returns>
##  <Description>
##  This returns <B>true</B> if the sparse matrix stored in the <C>Eval</C>
##  attribute of the &homalg; matrix <A>C</A> is an identity matrix,
##  and <B>false</B> otherwise.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>               
               IsIdentityMatrix :=
                 function( M )
                   
		   return IsSparseIdentityMatrix( Eval( M ) );
                   
                 end,
##  <#GAPDoc Label="IsDiagonalMatrix">
##  <ManSection>
##  <Func Arg="C" Name="IsDiagonalMatrix"/>
##  <Returns><B>true</B> or <B>false</B></Returns>
##  <Description>
##  This returns <B>true</B> if the sparse matrix stored in the <C>Eval</C>
##  attribute of the &homalg; matrix <A>C</A> is a diagonal matrix,
##  and <B>false</B> otherwise.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>               
               IsDiagonalMatrix :=
                 function( M )
                   
                   return IsSparseDiagonalMatrix( Eval( M ) );
                   
                 end,
##  <#GAPDoc Label="ZeroRows">
##  <ManSection>
##  <Func Arg="C" Name="ZeroRows"/>
##  <Returns>a list</Returns>
##  <Description>
##  This returns the list of zero rows of the sparse matrix stored in
##  the <C>Eval</C> attribute of the &homalg; matrix <A>C</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>               
               ZeroRows :=
                 function( C )

                   return SparseZeroRows( Eval( C ) );
                   
                 end,
##  <#GAPDoc Label="ZeroColumns">
##  <ManSection>
##  <Func Arg="C" Name="ZeroColumns"/>
##  <Returns>a list</Returns>
##  <Description>
##  This returns the list of zero columns of the sparse matrix stored in
##  the <C>Eval</C> attribute of the &homalg; matrix <A>C</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
               ZeroColumns :=
                 function( C )

                   return SparseZeroColumns( Eval( C ) );
                   
                 end,

        )
 );
