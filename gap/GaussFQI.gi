#############################################################################
##
##  GaussFields.gi              GaussForHomalg package        Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Homalg Table for Z / p^n * Z in GAP with the Gauss package
##
#############################################################################

####################################
#
# constructor functions and methods:
#
####################################

InstallMethod( CreateHomalgTable,
        "for Z / p^n * Z",
        [ IsRing and IsFinite ],
        
  function( R )
    local RP, RP_default, RP_specific, component;
    
    if IsBound( HOMALG.PreferDenseMatrices ) and HOMALG.PreferDenseMatrices = true then
        RP := rec( );
    else
        RP := ShallowCopy( CommonHomalgTableForGaussTools );
    fi;
    
    RP_default := ShallowCopy( CommonHomalgTableForGaussBasic );
    
    RP_specific := rec( 
               ## Must be defined if other functions are not defined
                   
               TriangularBasisOfRows := #compute the reduced row echelon form N of M and, if nargs=2, transformation matrix U
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
                       SetMyEval( arg[2], UnionOfRows( result.coeffs, result.relations ) );
                       ResetFilterObj( arg[2], IsVoidMatrix );
                       SetNrRows( arg[2], NrRows( M ) );
                       SetNrColumns( arg[2], NrRows( M ) );
                       SetIsInvertibleMatrix( arg[2], true );
                   else
                       ## compute N only:
                       N := EchelonMat( MyEval( M ) ).vectors;
                   fi;
                   
                   if N = [ ] then
                       H := HomalgZeroMatrix( 0, NrColumns( M ), R );
                   else
                       H := HomalgMatrix( N, R ); ## and since this is not i.g. triangular:
                   fi;
                   
                   SetNrColumns( H, NrColumns( M ) );
                   SetRowRankOfMatrix( H, NrRows( H ) );
                   SetRowRankOfMatrix( M, NrRows( H ) );
		   
                   if HasIsDiagonalMatrix( M ) and IsDiagonalMatrix( M ) then
                       SetIsDiagonalMatrix( H, true );   
                   else
                       SetIsUpperTriangularMatrix( H, true );
                   fi;
                   
                   return H;
                   
                 end
                 
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

##
InstallMethod( GetEntryOfHomalgMatrix,
        [ IsHomalgInternalMatrixRep, IsInt, IsInt, IsHomalgInternalRingRep ],
  function( M, i, j, R )
    local m;
    m := Eval( M );
    if IsSparseMatrix( m ) then
        return GetEntry( m, i, j ); #calls GetEntry for sparse matrices
    fi;
    TryNextMethod();
  end
);
  
##
InstallMethod( SetEntryOfHomalgMatrix,
        [ IsHomalgInternalMatrixRep and IsMutableMatrix, IsInt, IsInt, IsRingElement, IsHomalgInternalRingRep ],
  function( M, i, j, e, R )
    local m;
    m := Eval( M );
    if IsSparseMatrix( m ) then
        SetEntry( m, i, j, e ); #calls SetEntry for sparse matrices
    else
        TryNextMethod();
    fi;
  end
);
  
##
InstallMethod( AddToEntryOfHomalgMatrix,
        [ IsHomalgInternalMatrixRep and IsMutableMatrix, IsInt, IsInt, IsRingElement, IsHomalgInternalRingRep ],
  function( M, i, j, e, R )
    local m;
    m := Eval( M );
    if IsSparseMatrix( m ) then
        AddToEntry( m, i, j, e ); #calls AddToEntry for sparse matrices
    else
        TryNextMethod();
    fi;
  end
);
