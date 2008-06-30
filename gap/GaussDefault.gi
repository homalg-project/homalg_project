#############################################################################
##
##  GaussDefault.gi           GaussForHomalg package          Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for the Gauss package.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( CommonHomalgTableForGaussDefault,
        
  rec(
      ## Must only then be provided by the RingPackage in case the default
      ## "service" function does not match the Ring
    
    #this uses ReduceMat from the Gauss Package to reduce A with B
    DecideZeroRows :=
    function( A, B )
      local R, M;
      R := HomalgRing( A );
      M := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), R );
      SetEval( M, ReduceMat( Eval( A ), Eval ( B ) ).reduced_matrix );
      return M;
    end,
      
    #this uses ReduceMatTransformation from the Gauss Package to reduce A with B to M and return T such that M = A + T * B
    DecideZeroRowsEffectively :=
    function( A, B, T )
      local R, M;
      R := HomalgRing( A );
      M := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), R );
      RMT := ReduceMatTransformation( Eval( A ), Eval( B ) );
      SetEval( M, RMT.reduced_matrix );
      SetEval( T, RMT.transformation );
      return M;
    end,
        
    #this uses KernelMat from the Gauss Package to compute Syzygies
    SyzygiesGeneratorsOfRows :=
    function( arg )
      local M, R, syz, N;
      M := arg[1];
      R := HomalgRing( M );
      if Length( arg ) > 1 and IsHomalgMatrix( arg[2] ) then
          syz := KernelMat( Eval( UnionOfRows( M, arg[2] ) ), [1..NrRows( M )] ).relations;
      else
          syz := KernelMat( Eval( M ) ).relations;
      fi;
      N := HomalgVoidMatrix( nrows( syz ), NrRows( M ), R );
      SetEval( N, syz );
      return N;
    end,
    
    #this just calls TriangularBasisOfRows, which computes the RREF using EchelonMat from the Gauss Package
    BasisOfRowModule :=
    function( M )
      return TriangularBasisOfRows( M );
    end,
  )
);
