#############################################################################
##
##  GaussForHomalg.gi          GaussForHomalg package        Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Matrix operations
##
#############################################################################

####################################
#
# constructor functions and methods:
#
####################################

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
