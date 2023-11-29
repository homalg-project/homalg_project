# SPDX-License-Identifier: GPL-2.0-or-later
# GaussForHomalg: Gauss functionality for the homalg project
#
# Implementations
#

##  Homalg Table for Q in GAP with the Gauss package

####################################
#
# constructor functions and methods:
#
####################################

InstallMethod( CreateHomalgTable,
        "for Q",
        [ IsRationals ],
        
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
                   
                   SetRowRankOfMatrix( H, NumberRows( H ) );
                   
                   SetIsUpperTriangularMatrix( H, true );
                   
                   return H;
                   
               end,
               
               RowRankOfMatrix :=
                 function( M )
                   
                   return Rank( MyEval( M ) );
                   
               end,
               
               RadicalSubobject := MyEval,
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

##  <#GAPDoc Label="HomalgFieldOfRationals">
##  <ManSection>
##    <Func Arg="" Name="HomalgFieldOfRationals" Label="constructor for the field of rationals"/>
##    <Returns>a &homalg; ring</Returns>
##    <Description>
##      The field of rationals <M>&QQ;</M> is returned.
##      The operation <C>SetRingProperties</C> is automatically invoked to set the ring properties.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( HomalgFieldOfRationals,
  function( arg )
    local R;
    
    R := CreateHomalgRing( Rationals );
    
    SetRingFilter( R, IsHomalgRing );
    SetRingElementFilter( R, IsRat );
    
    SetIsRationalsForHomalg( R, true );
    
    SetRingProperties( R, 0 );
    
    return R;
    
end );

##
InstallMethod( HomalgFieldOfRationalsInUnderlyingCAS,
        "for a homalg internal ring",
        [ IsHomalgInternalRingRep ],
        
  HomalgFieldOfRationals );

## create a globally defined field of rationals
HOMALG_MATRICES.QQ := HomalgFieldOfRationals( );
