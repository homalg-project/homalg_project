#############################################################################
##
##  GaussDefault.gi           RingsForHomalg package          Simon Goertzen
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
      
    DecideZeroRows :=
    function( A, B )
      local R, N;
     
      R := HomalgRing( A );
      N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), R );
      SetEval( N, ReduceMatWithEchelonMat( Eval( A ), Eval ( B ) ) );
      ResetFilterObj( N, IsVoidMatrix );
      return N;
    
    end,
  
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
      ResetFilterObj( N, IsVoidMatrix );
      return N;
      
    end,
    
    BasisOfRowModule :=
    function( M )
      return TriangularBasisOfRows( M );
    end,
  )
);
