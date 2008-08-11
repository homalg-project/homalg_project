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

               ZeroMatrix :=
                 function( C )
                   local R;
                   R := HomalgRing( C );
                   
                   return SparseZeroMatrix( NrRows( C ), NrColumns( C ), R!.ring );
                   
                 end,
             
               IdentityMatrix :=
                 function( C )
                   local R;
                   R := HomalgRing( C );
                   
                   return SparseIdentityMatrix( NrRows( C ), R!.ring );
                   
                 end,
               
               CopyMatrix :=
                 function( C )
                   return CopyMat( Eval( C ) );
                 end,
                   
               # this enables Homalg to prevent calling sparse algorithms on GAP dense matrices
               ConvertMatrix :=
                 function( M, R )
                   return SparseMatrix( M, R );
                 end,
                   
               # for a general ring (field) the involution is just the transposed matrix
               Involution :=
                 function( M )
                   
                   return TransposedSparseMat( Eval( M ) );
                   
                 end,
               
               CertainRows :=
                 function( M, plist )
                   
                   return CertainRows( Eval( M ), plist );
                   
                 end,
               
               CertainColumns :=
                 function( M, plist )
                   
                   return CertainColumns( Eval( M ), plist );
                   
                 end,
               
               UnionOfRows :=
                 function( A, B )
                   
                   return UnionOfRows( Eval( A ), Eval( B ) );
                   
                 end,
               
               UnionOfColumns :=
                 function( A, B )
                   
                   return UnionOfColumns( Eval( A ), Eval( B ) );
                   
                 end,
               
               DiagMat :=
                 function( e )
                   
                   return SparseDiagMat( List( e, Eval ) );
                   
                 end,
               
               KroneckerMat :=
                 function( A, B )
                   
                   return SparseKroneckerProduct( Eval( A ), Eval( B ) );
                   
                 end,
               
               Compose :=
                 function( A, B )
                   
                   return Eval( A ) * Eval( B );
                   
                 end,
               
               NrRows :=
                 function( C )
                   
                   return nrows( Eval( C ) );
                   
                 end,
               
               NrColumns :=
                 function( C )
                   
                   return ncols( Eval( C ) );
                   
                 end,
                 
               IsZeroMatrix :=
                 function( M )
                   
                   return IsSparseZeroMatrix( Eval( M ) );
                   
                 end,
               
               IsIdentityMatrix :=
                 function( M )
                   
		   return IsSparseIdentityMatrix( Eval( M ) );
                   
                 end,
               
               IsDiagonalMatrix :=
                 function( M )
                   
                   return IsSparseDiagonalMatrix( Eval( M ) );
                   
                 end,
               
               ZeroRows :=
                 function( C )

                   return SparseZeroRows( Eval( C ) );
                   
                 end,

               ZeroColumns :=
                 function( C )

                   return SparseZeroColumns( Eval( C ) );
                   
                 end,

        )
 );
