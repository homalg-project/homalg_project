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
InstallMethod( nrows, "for dense GAP matrices",
        [ IsList ],
  function( M )
    return Length( M );
  end
);

##
InstallMethod( UnionOfRows, "for dense GAP matrices",
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
    
    #this uses ReduceMat from the Gauss Package to reduce A with B
    DecideZeroRows :=
    function( A, B )
      local R;
      R := HomalgRing( A );
      return HomalgMatrix( ReduceMat( MyEval( A ), MyEval( B ) ).reduced_matrix, NrRows( A ), NrColumns( A ), R );
    end,
      
    #this uses ReduceMatTransformation from the Gauss Package to reduce A with B to M and return T such that M = A + T * B
    DecideZeroRowsEffectively :=
    function( A, B, T )
      local R, RMT;
      R := HomalgRing( A );
      RMT := ReduceMatTransformation( MyEval( A ), MyEval( B ) );
      SetMyEval( T, RMT.transformation );
      ResetFilterObj( T, IsVoidMatrix );
      return HomalgMatrix( RMT.reduced_matrix, NrRows( A ), NrColumns( A ), R );
    end,
    
    #this uses KernelMat from the Gauss Package to compute Syzygies
    SyzygiesGeneratorsOfRows :=
    function( arg )
      local M, R, syz;
      M := arg[1];
      R := HomalgRing( M );
      if Length( arg ) > 1 and IsHomalgMatrix( arg[2] ) then
          syz := KernelMat( MyEval( UnionOfRows( M, arg[2] ) ), [1..NrRows( M )] ).relations;
      else
          syz := KernelMat( MyEval( M ) ).relations;
      fi;
      return HomalgMatrix( syz, nrows( syz ), NrRows( M ), R );
    end,
    
  )
);
