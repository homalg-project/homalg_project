# SPDX-License-Identifier: GPL-2.0-or-later
# MatricesForHomalg: Matrices for the homalg project
#
# Implementations
#

####################################
#
# global variables:
#
####################################

##
InstallValue( CommonHomalgTableForResidueClassRingsTools,

        rec(
               IsZero := r -> IsZero( DecideZero( EvalRingElement( r ), HomalgRing( r ) ) ),
               
               IsOne := r -> IsOne( DecideZero( EvalRingElement( r ), HomalgRing( r ) ) ),
               
               Minus :=
                 function( a, b )
                   
                   return DecideZero( EvalRingElement( a ) - EvalRingElement( b ), HomalgRing( a ) );
                   
                 end,
               
               DivideByUnit :=
                 function( a, u )
                   local R, S, A, U, rel, au;
                   
                   R := HomalgRing( a );
                   
                   S := AmbientRing( R );
                   
                   A := HomalgMatrix( [ EvalRingElement( a ) ], 1, 1, S );
                   
                   U := HomalgMatrix( [ EvalRingElement( u ) ], 1, 1, S );
                   
                   rel := RingRelations( R );
                   
                   rel := MatrixOfRelations( rel );
                   
                   if IsHomalgRingRelationsAsGeneratorsOfRightIdeal( rel ) then
                       rel := Involution( rel ); ## I prefer row convention
                   fi;
                   
                   au := RightDivide( A, U, rel );
                   
                   if au = fail then
                       return fail;
                   fi;
                   
                   au := au[ 1, 1 ];
                   
                   au := DecideZero( au, HomalgRing( a ) );
                   
                   return au;
                   
                 end,
               
               IsUnit :=
                 function( R, u )
                   local U;
                   
                   U := HomalgMatrix( [ EvalRingElement( u ) ], 1, 1, AmbientRing( R ) );
                   
                   U := HomalgResidueClassMatrix( U, R );
                   
                   return not IsBool( LeftInverse( U ) );
                   
                 end,
               
               Sum :=
                 function( a, b )
                   
                   return DecideZero( EvalRingElement( a ) + EvalRingElement( b ), HomalgRing( a ) );
                   
                 end,
               
               Product :=
                 function( a, b )
                   
                   return DecideZero( EvalRingElement( a ) * EvalRingElement( b ), HomalgRing( a ) );
                   
                 end,
               
               ShallowCopy :=
                 function( C )
                   local M;
                   
                   M := ShallowCopy( Eval( C ) );
                   
                   if not ( HasIsReducedModuloRingRelations( C ) and
                            IsReducedModuloRingRelations( C ) ) then
                       
                       ## reduce the matrix N w.r.t. the ring relations
                       M := DecideZero( M, HomalgRing( C ) );
                   fi;
                   
                   return M;
                   
                 end,
               
               CopyMatrix :=
                 function( C, R )
                   
                   return R * Eval( C );
                   
                 end,
               
               ##  <#GAPDoc Label="InitialMatrix:ResidueClassRing">
               ##  <ManSection>
               ##    <Func Arg="" Name="InitialMatrix" Label="ResidueClassRing"/>
               ##    <Returns>a &homalg; matrix over the ambient ring</Returns>
               ##    <Description>
               ##    (&see; <Ref Meth="InitialMatrix" Label="homalgTable entry for initial matrices"/>)
               ##    <Listing Type="Code"><![CDATA[
               InitialMatrix := C -> HomalgInitialMatrix(
                                     NumberRows( C ), NumberColumns( C ), AmbientRing( HomalgRing( C ) ) ),
               ##  ]]></Listing>
               ##    </Description>
               ##  </ManSection>
               ##  <#/GAPDoc>
               
               ##  <#GAPDoc Label="InitialIdentityMatrix:ResidueClassRing">
               ##  <ManSection>
               ##    <Func Arg="" Name="InitialIdentityMatrix" Label="ResidueClassRing"/>
               ##    <Returns>a &homalg; matrix over the ambient ring</Returns>
               ##    <Description>
               ##    (&see; <Ref Meth="InitialIdentityMatrix" Label="homalgTable entry for initial identity matrices"/>)
               ##    <Listing Type="Code"><![CDATA[
               InitialIdentityMatrix := C -> HomalgInitialIdentityMatrix(
                       NumberRows( C ), AmbientRing( HomalgRing( C ) ) ),
               ##  ]]></Listing>
               ##    </Description>
               ##  </ManSection>
               ##  <#/GAPDoc>
               
               ##  <#GAPDoc Label="ZeroMatrix:ResidueClassRing">
               ##  <ManSection>
               ##    <Func Arg="" Name="ZeroMatrix" Label="ResidueClassRing"/>
               ##    <Returns>a &homalg; matrix over the ambient ring</Returns>
               ##    <Description>
               ##    (&see; <Ref Meth="ZeroMatrix" Label="homalgTable entry"/>)
               ##    <Listing Type="Code"><![CDATA[
               ZeroMatrix := C -> HomalgZeroMatrix(
                                     NumberRows( C ), NumberColumns( C ), AmbientRing( HomalgRing( C ) ) ),
               ##  ]]></Listing>
               ##    </Description>
               ##  </ManSection>
               ##  <#/GAPDoc>
               
               ##  <#GAPDoc Label="IdentityMatrix:ResidueClassRing">
               ##  <ManSection>
               ##    <Func Arg="" Name="IdentityMatrix" Label="ResidueClassRing"/>
               ##    <Returns>a &homalg; matrix over the ambient ring</Returns>
               ##    <Description>
               ##    (&see; <Ref Meth="IdentityMatrix" Label="homalgTable entry"/>)
               ##    <Listing Type="Code"><![CDATA[
               IdentityMatrix := C -> HomalgIdentityMatrix(
                       NumberRows( C ), AmbientRing( HomalgRing( C ) ) ),
               ##  ]]></Listing>
               ##    </Description>
               ##  </ManSection>
               ##  <#/GAPDoc>
               
               ##  <#GAPDoc Label="AreEqualMatrices:ResidueClassRing">
               ##  <ManSection>
               ##    <Func Arg="A, B" Name="AreEqualMatrices" Label="ResidueClassRing"/>
               ##    <Returns><C>true</C> or <C>false</C></Returns>
               ##    <Description>
               ##    (&see; <Ref Meth="AreEqualMatrices" Label="homalgTable entry"/>)
               ##    <Listing Type="Code"><![CDATA[
               AreEqualMatrices :=
                 function( A, B )
                   
                   return IsZero( DecideZero( Eval( A ) - Eval( B ), HomalgRing( A ) ) );
                   
                 end,
               ##  ]]></Listing>
               ##    </Description>
               ##  </ManSection>
               ##  <#/GAPDoc>
               
               ##  <#GAPDoc Label="Involution:ResidueClassRing">
               ##  <ManSection>
               ##    <Func Arg="" Name="Involution" Label="ResidueClassRing"/>
               ##    <Returns>a &homalg; matrix over the ambient ring</Returns>
               ##    <Description>
               ##    (&see; <Ref Meth="Involution" Label="homalgTable entry"/>)
               ##    <Listing Type="Code"><![CDATA[
               Involution :=
                 function( M )
                   local N, R;
                   
                   N := Involution( Eval( M ) );
                   
                   R := HomalgRing( N );
                   
                   if not ( HasIsCommutative( R ) and IsCommutative( R ) and
                            HasIsReducedModuloRingRelations( M ) and
                            IsReducedModuloRingRelations( M ) ) then
                       
                       ## reduce the matrix N w.r.t. the ring relations
                       N := DecideZero( N, HomalgRing( M ) );
                   fi;
                   
                   return N;
                   
                 end,
               ##  ]]></Listing>
               ##    </Description>
               ##  </ManSection>
               ##  <#/GAPDoc>
               
               ##  <#GAPDoc Label="TransposedMatrix:ResidueClassRing">
               ##  <ManSection>
               ##    <Func Arg="" Name="TransposedMatrix" Label="ResidueClassRing"/>
               ##    <Returns>a &homalg; matrix over the ambient ring</Returns>
               ##    <Description>
               ##    (&see; <Ref Meth="TransposedMatrix" Label="homalgTable entry"/>)
               ##    <Listing Type="Code"><![CDATA[
               TransposedMatrix :=
                 function( M )
                   local N, R;
                   
                   N := TransposedMatrix( Eval( M ) );
                   
                   R := HomalgRing( N );
                   
                   if not ( HasIsCommutative( R ) and IsCommutative( R ) and
                            HasIsReducedModuloRingRelations( M ) and
                            IsReducedModuloRingRelations( M ) ) then
                       
                       ## reduce the matrix N w.r.t. the ring relations
                       N := DecideZero( N, HomalgRing( M ) );
                   fi;
                   
                   return N;
                   
                 end,
               ##  ]]></Listing>
               ##    </Description>
               ##  </ManSection>
               ##  <#/GAPDoc>
               
               ##  <#GAPDoc Label="CertainRows:ResidueClassRing">
               ##  <ManSection>
               ##    <Func Arg="" Name="CertainRows" Label="ResidueClassRing"/>
               ##    <Returns>a &homalg; matrix over the ambient ring</Returns>
               ##    <Description>
               ##    (&see; <Ref Meth="CertainRows" Label="homalgTable entry"/>)
               ##    <Listing Type="Code"><![CDATA[
               CertainRows :=
                 function( M, plist )
                   local N;
                   
                   N := CertainRows( Eval( M ), plist );
                   
                   if not ( HasIsReducedModuloRingRelations( M ) and
                            IsReducedModuloRingRelations( M ) ) then
                       
                       ## reduce the matrix N w.r.t. the ring relations
                       N := DecideZero( N, HomalgRing( M ) );
                   fi;
                   
                   return N;
                   
                 end,
               ##  ]]></Listing>
               ##    </Description>
               ##  </ManSection>
               ##  <#/GAPDoc>
               
               ##  <#GAPDoc Label="CertainColumns:ResidueClassRing">
               ##  <ManSection>
               ##    <Func Arg="" Name="CertainColumns" Label="ResidueClassRing"/>
               ##    <Returns>a &homalg; matrix over the ambient ring</Returns>
               ##    <Description>
               ##    (&see; <Ref Meth="CertainColumns" Label="homalgTable entry"/>)
               ##    <Listing Type="Code"><![CDATA[
               CertainColumns :=
                 function( M, plist )
                   local N;
                   
                   N := CertainColumns( Eval( M ), plist );
                   
                   if not ( HasIsReducedModuloRingRelations( M ) and
                            IsReducedModuloRingRelations( M ) ) then
                       
                       ## reduce the matrix N w.r.t. the ring relations
                       N := DecideZero( N, HomalgRing( M ) );
                   fi;
                   
                   return N;
                   
                 end,
               ##  ]]></Listing>
               ##    </Description>
               ##  </ManSection>
               ##  <#/GAPDoc>
               
               ##  <#GAPDoc Label="UnionOfRows:ResidueClassRing">
               ##  <ManSection>
               ##    <Func Arg="" Name="UnionOfRows" Label="ResidueClassRing"/>
               ##    <Returns>a &homalg; matrix over the ambient ring</Returns>
               ##    <Description>
               ##    (&see; <Ref Meth="UnionOfRows" Label="homalgTable entry"/>)
               ##    <Listing Type="Code"><![CDATA[
               UnionOfRows :=
                 function( L )
                   local N;
                   
                   N := UnionOfRows( List( L, Eval ) );
                   
                   if not ForAll( L, HasIsReducedModuloRingRelations and
                              IsReducedModuloRingRelations ) then
                       
                       ## reduce the matrix N w.r.t. the ring relations
                       N := DecideZero( N, HomalgRing( L[1] ) );
                   fi;
                   
                   return N;
                   
                 end,
               ##  ]]></Listing>
               ##    </Description>
               ##  </ManSection>
               ##  <#/GAPDoc>
               
               ##  <#GAPDoc Label="UnionOfColumns:ResidueClassRing">
               ##  <ManSection>
               ##    <Func Arg="" Name="UnionOfColumns" Label="ResidueClassRing"/>
               ##    <Returns>a &homalg; matrix over the ambient ring</Returns>
               ##    <Description>
               ##    (&see; <Ref Meth="UnionOfColumns" Label="homalgTable entry"/>)
               ##    <Listing Type="Code"><![CDATA[
               UnionOfColumns :=
                 function( L )
                   local N;
                   
                   N := UnionOfColumns( List( L, Eval ) );
                   
                   if not ForAll( L, HasIsReducedModuloRingRelations and
                              IsReducedModuloRingRelations ) then
                       
                       ## reduce the matrix N w.r.t. the ring relations
                       N := DecideZero( N, HomalgRing( L[1] ) );
                   fi;
                   
                   return N;
                   
                 end,
               ##  ]]></Listing>
               ##    </Description>
               ##  </ManSection>
               ##  <#/GAPDoc>
               
               ##  <#GAPDoc Label="DiagMat:ResidueClassRing">
               ##  <ManSection>
               ##    <Func Arg="" Name="DiagMat" Label="ResidueClassRing"/>
               ##    <Returns>a &homalg; matrix over the ambient ring</Returns>
               ##    <Description>
               ##    (&see; <Ref Meth="DiagMat" Label="homalgTable entry"/>)
               ##    <Listing Type="Code"><![CDATA[
               DiagMat :=
                 function( e )
                   local N;
                   
                   N := DiagMat( List( e, Eval ) );
                   
                   if not ForAll( e, HasIsReducedModuloRingRelations and
                              IsReducedModuloRingRelations ) then
                       
                       ## reduce the matrix N w.r.t. the ring relations
                       N := DecideZero( N, HomalgRing( e[1] ) );
                   fi;
                   
                   return N;
                   
                 end,
               ##  ]]></Listing>
               ##    </Description>
               ##  </ManSection>
               ##  <#/GAPDoc>
               
               ##  <#GAPDoc Label="KroneckerMat:ResidueClassRing">
               ##  <ManSection>
               ##    <Func Arg="" Name="KroneckerMat" Label="ResidueClassRing"/>
               ##    <Returns>a &homalg; matrix over the ambient ring</Returns>
               ##    <Description>
               ##    (&see; <Ref Meth="KroneckerMat" Label="homalgTable entry"/>)
               ##    <Listing Type="Code"><![CDATA[
               KroneckerMat :=
                 function( A, B )
                   local N;
                   
                   N := KroneckerMat( Eval( A ), Eval( B ) );
                   
                   if not ForAll( [ A, B ], HasIsReducedModuloRingRelations and
                              IsReducedModuloRingRelations ) then
                       
                       ## reduce the matrix N w.r.t. the ring relations
                       N := DecideZero( N, HomalgRing( A ) );
                   fi;
                   
                   return N;
                   
                 end,
               ##  ]]></Listing>
               ##    </Description>
               ##  </ManSection>
               ##  <#/GAPDoc>
               
               ##  <#GAPDoc Label="DualKroneckerMat:ResidueClassRing">
               ##  <ManSection>
               ##    <Func Arg="" Name="DualKroneckerMat" Label="ResidueClassRing"/>
               ##    <Returns>a &homalg; matrix over the ambient ring</Returns>
               ##    <Description>
               ##    (&see; <Ref Meth="DualKroneckerMat" Label="homalgTable entry"/>)
               ##    <Listing Type="Code"><![CDATA[
               DualKroneckerMat :=
                 function( A, B )
                   local N;
                   
                   N := DualKroneckerMat( Eval( A ), Eval( B ) );
                   
                   if not ForAll( [ A, B ], HasIsReducedModuloRingRelations and
                              IsReducedModuloRingRelations ) then
                       
                       ## reduce the matrix N w.r.t. the ring relations
                       N := DecideZero( N, HomalgRing( A ) );
                   fi;
                   
                   return N;
                   
                 end,
               ##  ]]></Listing>
               ##    </Description>
               ##  </ManSection>
               ##  <#/GAPDoc>
               
               ##  <#GAPDoc Label="MulMat:ResidueClassRing">
               ##  <ManSection>
               ##    <Func Arg="" Name="MulMat" Label="ResidueClassRing"/>
               ##    <Returns>a &homalg; matrix over the ambient ring</Returns>
               ##    <Description>
               ##    (&see; <Ref Meth="MulMat" Label="homalgTable entry"/>)
               ##    <Listing Type="Code"><![CDATA[
               MulMat :=
                 function( a, A )
                   
                   return DecideZero( EvalRingElement( a ) * Eval( A ), HomalgRing( A ) );
                   
                 end,
               MulMatRight :=
                 function( A, a )
                   
                   return DecideZero( Eval( A ) * EvalRingElement( a ), HomalgRing( A ) );
                   
                 end,
               ##  ]]></Listing>
               ##    </Description>
               ##  </ManSection>
               ##  <#/GAPDoc>
               
               ##  <#GAPDoc Label="AddMat:ResidueClassRing">
               ##  <ManSection>
               ##    <Func Arg="" Name="AddMat" Label="ResidueClassRing"/>
               ##    <Returns>a &homalg; matrix over the ambient ring</Returns>
               ##    <Description>
               ##    (&see; <Ref Meth="AddMat" Label="homalgTable entry"/>)
               ##    <Listing Type="Code"><![CDATA[
               AddMat :=
                 function( A, B )
                   
                   return DecideZero( Eval( A ) + Eval( B ), HomalgRing( A ) );
                   
                 end,
               ##  ]]></Listing>
               ##    </Description>
               ##  </ManSection>
               ##  <#/GAPDoc>
               
               ##  <#GAPDoc Label="SubMat:ResidueClassRing">
               ##  <ManSection>
               ##    <Func Arg="" Name="SubMat" Label="ResidueClassRing"/>
               ##    <Returns>a &homalg; matrix over the ambient ring</Returns>
               ##    <Description>
               ##    (&see; <Ref Meth="SubMat" Label="homalgTable entry"/>)
               ##    <Listing Type="Code"><![CDATA[
               SubMat :=
                 function( A, B )
                   
                   return DecideZero( Eval( A ) - Eval( B ), HomalgRing( A ) );
                   
                 end,
               ##  ]]></Listing>
               ##    </Description>
               ##  </ManSection>
               ##  <#/GAPDoc>
               
               ##  <#GAPDoc Label="Compose:ResidueClassRing">
               ##  <ManSection>
               ##    <Func Arg="" Name="Compose" Label="ResidueClassRing"/>
               ##    <Returns>a &homalg; matrix over the ambient ring</Returns>
               ##    <Description>
               ##    (&see; <Ref Meth="Compose" Label="homalgTable entry"/>)
               ##    <Listing Type="Code"><![CDATA[
               Compose :=
                 function( A, B )
                   
                   return DecideZero( Eval( A ) * Eval( B ), HomalgRing( A ) );
                   
                 end,
               ##  ]]></Listing>
               ##    </Description>
               ##  </ManSection>
               ##  <#/GAPDoc>
               
               ##  <#GAPDoc Label="NumberRows:ResidueClassRing">
               ##  <ManSection>
               ##    <Func Arg="C" Name="NumberRows" Label="ResidueClassRing"/>
               ##    <Returns>a nonnegative integer</Returns>
               ##    <Description>
               ##    (&see; <Ref Meth="NumberRows" Label="homalgTable entry"/>)
               ##    <Listing Type="Code"><![CDATA[
               NumberRows := C -> NumberRows( Eval( C ) ),
               ##  ]]></Listing>
               ##    </Description>
               ##  </ManSection>
               ##  <#/GAPDoc>
               
               ##  <#GAPDoc Label="NumberColumns:ResidueClassRing">
               ##  <ManSection>
               ##    <Func Arg="C" Name="NumberColumns" Label="ResidueClassRing"/>
               ##    <Returns>a nonnegative integer</Returns>
               ##    <Description>
               ##    (&see; <Ref Meth="NumberColumns" Label="homalgTable entry"/>)
               ##    <Listing Type="Code"><![CDATA[
               NumberColumns := C -> NumberColumns( Eval( C ) ),
               ##  ]]></Listing>
               ##    </Description>
               ##  </ManSection>
               ##  <#/GAPDoc>
               
               ##  <#GAPDoc Label="Determinant:ResidueClassRing">
               ##  <ManSection>
               ##    <Func Arg="C" Name="Determinant" Label="ResidueClassRing"/>
               ##    <Returns>an element of ambient &homalg; ring</Returns>
               ##    <Description>
               ##    (&see; <Ref Meth="Determinant" Label="homalgTable entry"/>)
               ##    <Listing Type="Code"><![CDATA[
               Determinant := C -> DecideZero( Determinant( Eval( C ) ), HomalgRing( C ) ),
               ##  ]]></Listing>
               ##    </Description>
               ##  </ManSection>
               ##  <#/GAPDoc>
               
               ##  <#GAPDoc Label="IsZeroMatrix:ResidueClassRing">
               ##  <ManSection>
               ##    <Func Arg="M" Name="IsZeroMatrix" Label="ResidueClassRing"/>
               ##    <Returns><C>true</C> or <C>false</C></Returns>
               ##    <Description>
               ##    (&see; <Ref Meth="IsZeroMatrix" Label="homalgTable entry"/>)
               ##    <Listing Type="Code"><![CDATA[
               IsZeroMatrix := M -> IsZero( DecideZero( Eval( M ), HomalgRing( M ) ) ),
               ##  ]]></Listing>
               ##    </Description>
               ##  </ManSection>
               ##  <#/GAPDoc>
               
               ##  <#GAPDoc Label="IsIdentityMatrix:ResidueClassRing">
               ##  <ManSection>
               ##    <Func Arg="M" Name="IsOne" Label="ResidueClassRing"/>
               ##    <Returns><C>true</C> or <C>false</C></Returns>
               ##    <Description>
               ##    (&see; <Ref Meth="IsIdentityMatrix" Label="homalgTable entry"/>)
               ##    <Listing Type="Code"><![CDATA[
               IsIdentityMatrix := M ->
                         IsOne( DecideZero( Eval( M ), HomalgRing( M ) ) ),
               ##  ]]></Listing>
               ##    </Description>
               ##  </ManSection>
               ##  <#/GAPDoc>
               
               ##  <#GAPDoc Label="IsDiagonalMatrix:ResidueClassRing">
               ##  <ManSection>
               ##    <Func Arg="M" Name="IsDiagonalMatrix" Label="ResidueClassRing"/>
               ##    <Returns><C>true</C> or <C>false</C></Returns>
               ##    <Description>
               ##    (&see; <Ref Meth="IsDiagonalMatrix" Label="homalgTable entry"/>)
               ##    <Listing Type="Code"><![CDATA[
               IsDiagonalMatrix := M ->
                         IsDiagonalMatrix( DecideZero( Eval( M ), HomalgRing( M ) ) ),
               ##  ]]></Listing>
               ##    </Description>
               ##  </ManSection>
               ##  <#/GAPDoc>
               
               ##  <#GAPDoc Label="ZeroRows:ResidueClassRing">
               ##  <ManSection>
               ##    <Func Arg="C" Name="ZeroRows" Label="ResidueClassRing"/>
               ##    <Returns>a &homalg; matrix over the ambient ring</Returns>
               ##    <Description>
               ##    (&see; <Ref Meth="ZeroRows" Label="homalgTable entry"/>)
               ##    <Listing Type="Code"><![CDATA[
               ZeroRows := C -> ZeroRows( DecideZero( Eval( C ), HomalgRing( C ) ) ),
               ##  ]]></Listing>
               ##    </Description>
               ##  </ManSection>
               ##  <#/GAPDoc>
               
               ##  <#GAPDoc Label="ZeroColumns:ResidueClassRing">
               ##  <ManSection>
               ##    <Func Arg="C" Name="ZeroColumns" Label="ResidueClassRing"/>
               ##    <Returns>a &homalg; matrix over the ambient ring</Returns>
               ##    <Description>
               ##    (&see; <Ref Meth="ZeroColumns" Label="homalgTable entry"/>)
               ##    <Listing Type="Code"><![CDATA[
               ZeroColumns := C -> ZeroColumns( DecideZero( Eval( C ), HomalgRing( C ) ) ),
               ##  ]]></Listing>
               ##    </Description>
               ##  </ManSection>
               ##  <#/GAPDoc>
               
               Diff :=
                 function( D, N )
                     return HomalgRing( D ) * Diff( Eval( D ), Eval( N ) );
                 end,
               
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
               
               Pullback := 
                 function( phi, M )
                   
                   if not IsBound( phi!.RingMapToFree ) then
                       phi!.RingMapToFree := RingMap( ImagesOfRingMap( phi ), Source( phi ), AmbientRing( Range( phi ) ) );
                   fi;
                   
                   return Pullback( phi!.RingMapToFree, M );
                   
                 end,
               
               DegreeOfRingElement :=
                 function( r, R )
                   
                   return Degree( EvalRingElement( DecideZero( r ) ) );
                   
                 end,
        )
 );

##
InstallMethod( PrimaryDecompositionOp,
        "for a homalg matrix over a residue class ring",
        [ IsHomalgResidueClassMatrixRep ],
        
  function( M )
    local R, triv, rel, m;
    
    R := HomalgRing( M );
    
    if IsZero( M ) then
        if NumberColumns( M ) = 0 then
            triv := HomalgIdentityMatrix( 1, R );
        else
            triv := HomalgZeroMatrix( 0, 1, R );
        fi;
        M!.PrimaryDecomposition := [ [ triv, triv ] ];
        return M!.PrimaryDecomposition;
    fi;
    
    rel := RingRelations( R );
    rel := MatrixOfRelations( rel );
    rel := ListWithIdenticalEntries( NumberColumns( M ), rel );
    rel := DiagMat( rel );
    
    m := UnionOfRows( Eval( M ), rel );
    
    M!.PrimaryDecomposition := List( PrimaryDecompositionOp( m ), a -> List( a, b -> R * b ) );
    
    return M!.PrimaryDecomposition;
    
end );

##
InstallMethod( RadicalDecompositionOp,
        "for a homalg matrix over a residue class ring",
        [ IsHomalgResidueClassMatrixRep ],
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    return List( RadicalDecompositionOp( Eval( M ) ), a -> R * a );
    
end );
