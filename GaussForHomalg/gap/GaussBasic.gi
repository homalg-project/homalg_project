#############################################################################
##
##  GaussBasic.gi             GaussForHomalg package          Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for the Gauss package.
##
#############################################################################

##
InstallMethod( MyEval, "to circumvent the Eval(M)!.matrix problem",
        [ IsHomalgInternalMatrixRep ],
  function( M )
    local m;
    m := Eval( M );
    if IsSparseMatrix( m ) then
        return m;
    fi;
    return m!.matrix;
  end
);

##
InstallMethod( SetMyEval, "to circumvent the Eval(M)!.matrix problem",
        [ IsHomalgInternalMatrixRep, IsSparseMatrix ],
  function( M, m )
    SetEval( M, m );
  end
);

##
InstallMethod( SetMyEval, "to circumvent the Eval(M)!.matrix problem",
        [ IsHomalgInternalMatrixRep, IsList ],
  function( M, m )
    SetEval( M, homalgInternalMatrixHull( m ) );
  end
);

##
InstallMethod( UnionOfRowsOp, "for dense GAP matrices",
        [ IsList, IsList ],
  function( M, N )
    return Concatenation( M, N );
  end
);
		

####################################
#
# global variables:
#
####################################

InstallValue( CommonHomalgTableForGaussBasic,
        
  rec(
      ## Must only then be provided by the RingPackage in case the default
      ## "service" function does not match the Ring
    
##  <#GAPDoc Label="DecideZeroRows">
##  <ManSection>
##  <Func Arg="A, B" Name="DecideZeroRows"/>
##  <Returns>a &homalg; matrix</Returns>
##  <Description>
##  This returns the &homalg; matrix you get by row reducing the &homalg;
##  matrix <A>A</A> with the &homalg; matrix <A>B</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
    #this uses ReduceMat from the Gauss Package to reduce A with B
    DecideZeroRows :=
      function( A, B )
        return HomalgMatrix( ReduceMat( MyEval( A ), MyEval( B ) ).reduced_matrix, NrRows( A ), NrColumns( A ), HomalgRing( A ) );
      end,
      
##  <#GAPDoc Label="DecideZeroRowsEffectively">
##  <ManSection>
##  <Func Arg="A, B, T" Name="DecideZeroRowsEffectively"/>
##  <Returns>a &homalg; matrix <A>M</A></Returns>
##  <Description>
##  This returns the &homalg; matrix <A>M</A> you get by row reducing the &homalg;
##  matrix <A>A</A> with the &homalg; matrix <A>B</A>. The transformation
##  matrix is stored in the void &homalg; matrix <A>T</A> as a side effect.
##  The matrices satisfy <M>M = A + T * B</M>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
    #this uses ReduceMatTransformation from the Gauss Package to reduce A with B to M and return T such that M = A + T * B
    DecideZeroRowsEffectively :=
      function( A, B, T )
        local RMT;
        RMT := ReduceMatTransformation( MyEval( A ), MyEval( B ) );
        SetMyEval( T, RMT.transformation );
        ResetFilterObj( T, IsVoidMatrix );
        return HomalgMatrix( RMT.reduced_matrix, NrRows( A ), NrColumns( A ), HomalgRing( A ) );
      end,
    
##  <#GAPDoc Label="SyzygiesGeneratorsOfRows">
##  <ManSection>
##  <Func Arg="M" Name="SyzygiesGeneratorsOfRows"/>
##  <Returns>a &homalg; matrix</Returns>
##  <Description>
##  This returns the row syzygies of the &homalg;
##  matrix <A>M</A>, again as a &homalg; matrix.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
    #this uses KernelMat from the Gauss Package to compute Syzygies
    SyzygiesGeneratorsOfRows :=
      function( M )
        local syz;
        syz := KernelMat( MyEval( M ) ).relations;
        return HomalgMatrix( syz, Nrows( syz ), NrRows( M ), HomalgRing( M ) );
      end,
    
##  <#GAPDoc Label="RelativeSyzygiesGeneratorsOfRows">
##  <ManSection>
##  <Func Arg="M, N" Name="RelativeSyzygiesGeneratorsOfRows"/>
##  <Returns>a &homalg; matrix</Returns>
##  <Description>
##  The row syzygies of <A>M</A> are returned,
##  but now the computation interpretes the rows of the &homalg;
##  matrix <A>N</A> as additional zero relations.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
    #this uses KernelMat from the Gauss Package to compute Syzygies
    RelativeSyzygiesGeneratorsOfRows :=
      function( M, N )
        local syz;
        syz := KernelMat( MyEval( UnionOfRowsOp( M, N ) ), [ 1 .. NrRows( M ) ] ).relations;
        return HomalgMatrix( syz, Nrows( syz ), NrRows( M ), HomalgRing( M ) );
      end,
    
  )
);
