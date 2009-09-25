#############################################################################
##
##  ResidueClassRingTools.gi    homalg package               Mohamed Barakat
##
##  Copyright 2007-2009 Mohamed Barakat, Universität des Saarlandes
##
##  Implementation stuff for homalg residue class rings.
##
#############################################################################

####################################
#
# global variables:
#
####################################

##
InstallValue( CommonHomalgTableForResidueClassRingsTools,

        rec(
               IsZero := r -> IsZero( DecideZero( Eval( r ), HomalgRing( r ) ) ),
               
               IsOne := r -> IsOne( DecideZero( Eval( r ), HomalgRing( r ) ) ),
               
               Minus :=
                 function( a, b )
                   
                   return DecideZero( Eval( a ) - Eval( b ), HomalgRing( a ) );
                   
                 end,
               
               DivideByUnit :=
                 function( a, u )
                   local R, S, A, U, rel, au;
                   
                   R := HomalgRing( a );
                   
                   S := AmbientRing( R );
                   
                   A := HomalgMatrix( [ Eval( a ) ], 1, 1, S );
                   
                   U := HomalgMatrix( [ Eval( u ) ], 1, 1, S );
                   
                   rel := RingRelations( R );
                   
                   rel := MatrixOfRelations( rel );
                   
                   if IsHomalgRelationsOfRightModule( rel ) then
                       rel := Involution( rel );	## I prefer row convention
                   fi;
                   
                   au := RightDivide( A, U, rel );
                   
                   au := GetEntryOfHomalgMatrix( au, 1, 1 );
                   
                   au := DecideZero( au, HomalgRing( a ) );
                   
                   return au;
                   
                 end,
               
               IsUnit :=
                 function( R, u )
                   local U;
                   
                   U := HomalgMatrix( [ Eval( u ) ], 1, 1, AmbientRing( R ) );
                   
                   U := HomalgResidueClassMatrix( U, R );
                   
                   return not IsBool( Eval( LeftInverse( U ) ) );
                   
                 end,
               
               Sum :=
                 function( a, b )
                   
                   return DecideZero( Eval( a ) + Eval( b ), HomalgRing( a ) );
                   
                 end,
               
               Product :=
                 function( a, b )
                   
                   return DecideZero( Eval( a ) * Eval( b ), HomalgRing( a ) );
                   
                 end,
               
               ShallowCopy :=
                 function( C )
                   local M;
                   
                   M := ShallowCopy( Eval( C ) );
                   
                   if not ( HasIsReducedModuloRingRelations( C ) and IsReducedModuloRingRelations( C ) ) then
                       M := DecideZero( M, HomalgRing( C ) );
                   fi;
                   
                   return M;
                   
                 end,
               
               CopyMatrix :=
                 function( C, R )
                   
                   return R * Eval( C );
                   
                 end,
               
               ZeroMatrix := C -> HomalgZeroMatrix( NrRows( C ), NrColumns( C ), AmbientRing( HomalgRing( C ) ) ),
               
               IdentityMatrix := C -> HomalgIdentityMatrix( NrRows( C ), AmbientRing( HomalgRing( C ) ) ),
               
               AreEqualMatrices :=
                 function( A, B )
                   
                   return IsZero( DecideZero( Eval( A ) - Eval( B ), HomalgRing( A ) ) );
                   
                 end,
               
               Involution :=
                 function( M )
                   local N, R;
                   
                   N := Involution( Eval( M ) );
                   
                   R := HomalgRing( N );
                   
                   if not ( HasIsCommutative( R ) and IsCommutative( R ) and
                            HasIsReducedModuloRingRelations( M ) and IsReducedModuloRingRelations( M ) ) then
                       N := DecideZero( N, HomalgRing( M ) );
                   fi;
                   
                   return N;
                   
                 end,
               
               CertainRows :=
                 function( M, plist )
                   local N;
                   
                   N := CertainRows( Eval( M ), plist );
                   
                   if not ( HasIsReducedModuloRingRelations( M ) and IsReducedModuloRingRelations( M ) ) then
                       N := DecideZero( N, HomalgRing( M ) );
                   fi;
                   
                   return N;
                   
                 end,
               
               CertainColumns :=
                 function( M, plist )
                   local N;
                   
                   N := CertainColumns( Eval( M ), plist );
                   
                   if not ( HasIsReducedModuloRingRelations( M ) and IsReducedModuloRingRelations( M ) ) then
                       N := DecideZero( N, HomalgRing( M ) );
                   fi;
                   
                   return N;
                   
                 end,
               
               UnionOfRows :=
                 function( A, B )
                   local N;
                   
                   N := UnionOfRows( Eval( A ), Eval( B ) );
                   
                   if not ForAll( [ A, B ], HasIsReducedModuloRingRelations and IsReducedModuloRingRelations ) then
                       N := DecideZero( N, HomalgRing( A ) );
                   fi;
                   
                   return N;
                   
                 end,
               
               UnionOfColumns :=
                 function( A, B )
                   local N;
                   
                   N := UnionOfColumns( Eval( A ), Eval( B ) );
                   
                   if not ForAll( [ A, B ], HasIsReducedModuloRingRelations and IsReducedModuloRingRelations ) then
                       N := DecideZero( N, HomalgRing( A ) );
                   fi;
                   
                   return N;
                   
                 end,
               
               DiagMat :=
                 function( e )
                   local N;
                   
                   N := DiagMat( List( e, Eval ) );
                   
                   if not ForAll( e, HasIsReducedModuloRingRelations and IsReducedModuloRingRelations ) then
                       N := DecideZero( N, HomalgRing( e[1] ) );
                   fi;
                   
                   return N;
                   
                 end,
               
               KroneckerMat :=
                 function( A, B )
                   local N;
                   
                   N := KroneckerMat( Eval( A ), Eval( B ) );
                   
                   if not ForAll( [ A, B ], HasIsReducedModuloRingRelations and IsReducedModuloRingRelations ) then
                       N := DecideZero( N, HomalgRing( A ) );
                   fi;
                   
                   return N;
                   
                 end,
               
               MulMat :=
                 function( a, A )
                   
                   return DecideZero( Eval( a ) * Eval( A ), HomalgRing( A ) );
                   
                 end,
               
               AddMat :=
                 function( A, B )
                   
                   return DecideZero( Eval( A ) + Eval( B ), HomalgRing( A ) );
                   
                 end,
               
               SubMat :=
                 function( A, B )
                   
                   return DecideZero( Eval( A ) - Eval( B ), HomalgRing( A ) );
                   
                 end,
               
               Compose :=
                 function( A, B )
                   
                   return DecideZero( Eval( A ) * Eval( B ), HomalgRing( A ) );
                   
                 end,
               
               NrRows := C -> NrRows( Eval( C ) ),
               
               NrColumns := C -> NrColumns( Eval( C ) ),
               
               Determinant := C -> DecideZero( Determinant( Eval( C ) ), HomalgRing( C ) ),
               
               IsZeroMatrix := M -> IsZero( DecideZero( Eval( M ), HomalgRing( M ) ) ),
               
               IsIdentityMatrix := M -> IsIdentityMatrix( DecideZero( Eval( M ), HomalgRing( M ) ) ),
               
               IsDiagonalMatrix := M -> IsDiagonalMatrix( DecideZero( Eval( M ), HomalgRing( M ) ) ),
               
               ZeroRows := C -> ZeroRows( DecideZero( Eval( C ), HomalgRing( C ) ) ),
               
               ZeroColumns := C -> ZeroColumns( DecideZero( Eval( C ), HomalgRing( C ) ) ),
               
               X_CopyRowToIdentityMatrix :=
                 function( M, i, L, j )
                   
                 end,
               
               X_CopyColumnToIdentityMatrix :=
                 function( M, j, L, i )
                   
                 end,
               
               X_SetColumnToZero :=
                 function( M, i, j )
                   
                 end,
               
               X_GetCleanRowsPositions :=
                 function( M, clean_columns )
                   
                 end,
               
        )
 );
