# SPDX-License-Identifier: GPL-2.0-or-later
# GaussForHomalg: Gauss functionality for the homalg project
#
# Implementations
#

##  Homalg Table for Z / p^n * Z in GAP with the Gauss package

####################################
#
# constructor functions and methods:
#
####################################

##  <#GAPDoc Label="CreateHomalgTable">
##  <ManSection>
##  <Func Arg="R" Name="CreateHomalgTable"/>
##  <Returns>a &homalg; table</Returns>
##  <Description>
##  This returns the &homalg; table of what will become the
##  &homalg; ring <A>R</A> (at this point <A>R</A> is just a &homalg;
##  object with some properties for the method selection of <C>CreateHomalgTable</C>).
##  This method includes the needed functions stored in the global
##  variables <C>CommonHomalgTableForGaussTools</C> and
##  <C>CommonHomalgTableForGaussBasic</C>, and can add some more
##  to the record that will become the &homalg; table.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
InstallMethod( CreateHomalgTable,
        "for Z / p^n * Z",
        [ IsRing and IsFinite ],
        
  function( R )
    local RP, union_of_rows, RP_default, RP_specific, component;
    
    if IsBound( HOMALG_MATRICES.PreferDenseMatrices ) and HOMALG_MATRICES.PreferDenseMatrices = true then
        RP := rec( );
        union_of_rows := Concatenation;
    else
        RP := ShallowCopy( CommonHomalgTableForGaussTools );
        union_of_rows := SparseUnionOfRows;
    fi;
    
    RP_default := ShallowCopy( CommonHomalgTableForGaussBasic );
    
    RP_specific := rec( 
               ## Must be defined if other functions are not defined
               
##  <#GAPDoc Label="ReducedRowEchelonForm">
##  <ManSection>
##  <Func Arg="M, [U]" Name="ReducedRowEchelonForm"/>
##  <Returns>a &homalg; matrix <A>N</A></Returns>
##  <Description>
##  If one argument is given, this returns the triangular basis
##  (reduced row echelon form) of the &homalg; matrix <A>M</A>,
##  again as a &homalg; matrix.
##  In case of two arguments, still only the triangular basis of <A>M</A> is
##  returned, but the transformation matrix is stored in the void
##  &homalg; matrix <A>U</A> as a side effect.
##  The matrices satisfy <M>N = U * M</M>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
               ReducedRowEchelonForm := #compute the reduced row echelon form N of M and, if nargs=2, transformation matrix U
                 function( arg )
                   local M, R, nargs, result, N, H;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   if nargs > 1 and IsHomalgMatrix( arg[2] ) then
                       ## compute N and U:
                       result := EchelonMatTransformation( MyEval( M ) );
                       N := result.vectors;
                       ## assign U:
                       SetMyEval( arg[2], union_of_rows( [ result.coeffs, result.relations ] ) );
                       ResetFilterObj( arg[2], IsVoidMatrix );
                       SetNumberRows( arg[2], NumberRows( M ) );
                       SetNumberColumns( arg[2], NumberRows( M ) );
                       SetIsInvertibleMatrix( arg[2], true );
                   else
                       ## compute N only:
                       N := EchelonMat( MyEval( M ) ).vectors;
                   fi;
                   
                   if N = [ ] then
                       H := HomalgZeroMatrix( 0, NumberColumns( M ), R );
                   else
                       H := HomalgMatrix( N, R ); ## and since this is not i.g. triangular:
                   fi;
                   
                   SetNumberColumns( H, NumberColumns( M ) );
                   
                   if HasIsIntegralDomain( R ) and IsIntegralDomain( R ) then
                       SetRowRankOfMatrix( H, NumberRows( H ) );
                   fi;
                   
                   SetZeroRows( H, [] );
                   
                   SetIsUpperTriangularMatrix( H, true );
                   
                   return H;
                   
               end,
               
               RowRankOfMatrixOverDomain :=
                 function( M )
                   
                   return Rank( MyEval( M ) );
                   
               end,
          );
                 
    for component in NamesOfComponents( RP_default ) do
        RP.(component) := RP_default.(component);
    od;
    
    for component in NamesOfComponents( RP_specific ) do
        RP.(component) := RP_specific.(component);
    od;
                 
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );

