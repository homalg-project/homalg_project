#############################################################################
##
##  Basic.gi                    homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations of homalg basic procedures.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( BasisOfRowsCoeff,		### defines: BasisOfRowsCoeff (BasisCoeff)
        "for a homalg matrix",
	[ IsMatrixForHomalg ],
        
  function( M )
    local R, RP;
    
    R := HomalgRing( M );
    
    RP := HomalgTable( R );
    
    if IsBound(RP!.BasisOfRowsCoeff) then
        return RP!.BasisOfRowsCoeff( M );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return BasisOfRows( AddRhs( M ) );
    
end );

##
InstallMethod( BasisOfColumnsCoeff,		### defines: BasisOfRowsCoeff (BasisCoeff)
        "for a homalg matrix",
	[ IsMatrixForHomalg ],
        
  function( M )
    local R, RP;
    
    R := HomalgRing( M );
    
    RP := HomalgTable( R );
    
    if IsBound(RP!.BasisOfColumnsCoeff) then
        return RP!.BasisOfColumnsCoeff( M );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return BasisOfColumns( AddBts( M ) );
    
end );

##
InstallMethod( EffectivelyDecideZeroRows,	### defines: EffectivelyDecideZeroRows (ReduceCoeff)
        "for a homalg matrix",
	[ IsMatrixForHomalg, IsMatrixForHomalg ],
        
  function( A, B )
    local R, RP, zz, A_zz;
    
    R := HomalgRing( B );
    
    RP := HomalgTable( R );
  
    if IsBound(RP!.EffectivelyDecideZeroRows) then
        return RP!.EffectivelyDecideZeroRows( A, B );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    zz := MatrixForHomalg( "zero", NrRows( A ), NrRows( B ), R );
    
    A_zz := AddRhs( A, zz );
    
    return DecideZeroRows( A_zz, AddRhs( B ) );
    
end );

##
InstallMethod( EffectivelyDecideZeroColumns,	### defines: EffectivelyDecideZeroColumns (ReduceCoeff)
        "for a homalg matrix",
	[ IsMatrixForHomalg, IsMatrixForHomalg ],
        
  function( A, B )
    local R, RP, zz, A_zz;
    
    R := HomalgRing( B );
    
    RP := HomalgTable( R );
  
    if IsBound(RP!.EffectivelyDecideZeroColumns) then
        return RP!.EffectivelyDecideZeroColumns( A, B );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    zz := MatrixForHomalg( "zero", NrColumns( B ), NrColumns( A ), R );
    
    A_zz := AddBts( A, zz );
    
    return DecideZeroColumns( A_zz, AddBts( B ) );
    
end );

##
InstallMethod( SyzygiesBasisOfRows,		### defines: SyzygiesBasisOfRows (SyzygiesBasis)
        "for homalg matrices",
	[ IsMatrixForHomalg ],
        
  function( M )
    local R, RP, S;
    
    R := HomalgRing( M );
    
    RP := HomalgTable( R );
  
    if IsBound(RP!.SyzygiesBasisOfRows) then
        return RP!.SyzygiesBasisOfRows( M );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    S := SyzygiesGeneratorsOfRows( M, [ ] );
    
    return BasisOfRows( S );
    
end );

##
InstallMethod( SyzygiesBasisOfRows,		### defines: SyzygiesBasisOfRows (SyzygiesBasis)
        "for homalg matrices",
	[ IsMatrixForHomalg, IsMatrixForHomalg ],
        
  function( M1, M2 )
    local R, RP, S;
    
    R := HomalgRing( M1 );
    
    RP := HomalgTable( R );
  
    if IsBound(RP!.SyzygiesBasisOfRows) then
        return RP!.SyzygiesBasisOfRows( M1, M2 );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    S := SyzygiesGeneratorsOfRows( M1, M2 );
    
    return BasisOfRows( S );
    
end );

##
InstallMethod( SyzygiesBasisOfColumns,		### defines: SyzygiesBasisOfColumns (SyzygiesBasis)
        "for homalg matrices",
	[ IsMatrixForHomalg ],
        
  function( M )
    local R, RP, S;
    
    R := HomalgRing( M );
    
    RP := HomalgTable( R );
  
    if IsBound(RP!.SyzygiesBasisOfColumns) then
        return RP!.SyzygiesBasisOfColumns( M );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    S := SyzygiesGeneratorsOfColumns( M, [ ] );
    
    return BasisOfColumns( S );
    
end );

##
InstallMethod( SyzygiesBasisOfColumns,		### defines: SyzygiesBasisOfColumns (SyzygiesBasis)
        "for homalg matrices",
	[ IsMatrixForHomalg, IsMatrixForHomalg ],
        
  function( M1, M2 )
    local R, RP, S;
    
    R := HomalgRing( M1 );
    
    RP := HomalgTable( R );
  
    if IsBound(RP!.SyzygiesBasisOfColumns) then
        return RP!.SyzygiesBasisOfColumns( M1, M2 );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    S := SyzygiesGeneratorsOfColumns( M1, M2 );
    
    return BasisOfColumns( S );
    
end );

##
InstallMethod( RightDivide,			### defines: RightDivide (RightDivideF)
        "for homalg matrices",
	[ IsMatrixForHomalg, IsMatrixForHomalg ],
        
  function( B, A )
    local R, RP, IA, CA, NF, CB;
    
    R := HomalgRing( B );
    
    RP := HomalgTable( R );
  
    if IsBound(RP!.RightDivide) then
        return RP!.RightDivide( B, A );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    ## CA * A = IA
    IA := BasisOfRowsCoeff( A );
    
    CA := RightHandSide( IA );
    
    ## NF = B + CB * IA
    NF := EffectivelyDecideZeroRows( B, IA );
    
    CB := RightHandSide( NF );
    
    ## NF <> 0
    if not IsZeroMatrix( NF ) then
        Error( "The second argument is not a right factor of the first, i.e. the second argument is not a generating set!\n" );
    fi;
    
    ## CD = -CB * CA => CD * A = B
    return -CB * CA;
    
end );

##
InstallMethod( Leftinverse,			### defines: Leftinverse (LeftinverseF)
        "for homalg matrices",
	[ IsMatrixForHomalg ],
        
  function( L )
    local R, RP, Id;
    
    R := HomalgRing( L );
    
    RP := HomalgTable( R );
  
    if IsBound(RP!.Leftinverse) then
        return RP!.Leftinverse( L );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    Id := MatrixForHomalg( "identity", NrColumns( L ), R );
    
    return RightDivide( Id, L );
    
end );

##
InstallGlobalFunction( BetterEquivalentMatrix,	### defines: BetterEquivalentMatrix (BetterGenerators) (incomplete)
  function( arg )
    local M, R, RP, nargs, U, V, UI, VI, compute_U, compute_V, compute_UI, compute_VI,
        nar_U, nar_V, nar_UI, nar_VI, m, n, finished, barg, A, CM;
    
    if not IsMatrixForHomalg( arg[1] ) then
        Error( "expecting a homalg matrix as a first argument, but received ", arg[1], "\n" );
    fi;
    
    M := arg[1];
    
    R := HomalgRing( M );
    
    RP := HomalgTable( R );
  
    if IsBound(RP!.BetterEquivalentMatrix) then
        return RP!.BetterEquivalentMatrix( arg );
    fi;
    
    nargs := Length( arg );
    
    if nargs = 1 then
        ## BetterEquivalentMatrix(M)
        compute_U := false;
        compute_V := false;
        compute_UI := false;
        compute_VI := false;
    elif nargs = 2 and IsMatrixForHomalg( arg[2] ) then
        ## BetterEquivalentMatrix(M,V)
        compute_U := false;
        compute_V := true;
        compute_UI := false;
        compute_VI := false;
        nar_V := 2;
    elif nargs > 2 and IsMatrixForHomalg( arg[2] ) and IsString( arg[3] ) then
        ## BetterEquivalentMatrix(M,VI,"")
        compute_U := false;
        compute_V := false;
        compute_UI := false;
        compute_VI := true;
        nar_VI := 2;
    elif nargs > 4 and IsMatrixForHomalg( arg[2] ) and IsMatrixForHomalg( arg[3] )
      and IsString( arg[4] ) and IsString( arg[5] ) then
        ## BetterEquivalentMatrix(M,V,VI,"","")
        compute_U := false;
        compute_V := true;
        compute_UI := false;
        compute_VI := true;
        nar_V := 2;
        nar_VI := 3;
    elif nargs > 5 and IsMatrixForHomalg( arg[2] ) and IsMatrixForHomalg( arg[3] )
      and IsString( arg[4] ) and IsString( arg[5] ) and IsString( arg[6] ) then
        ## BetterEquivalentMatrix(M,U,UI,"","","")
        compute_U := true;
        compute_V := false;
        compute_UI := true;
        compute_VI := false;
        nar_U := 2;
        nar_UI := 3;
    elif nargs > 3 and IsMatrixForHomalg( arg[2] ) and IsMatrixForHomalg( arg[3] )
      and IsString( arg[5] ) then
        ## BetterEquivalentMatrix(M,UI,VI,"")
        compute_U := false;
        compute_V := false;
        compute_UI := true;
        compute_VI := true;
        nar_UI := 2;
        nar_VI := 3;
    elif nargs > 4 and IsMatrixForHomalg( arg[2] ) and IsMatrixForHomalg( arg[3] )
      and IsMatrixForHomalg( arg[4] ) and IsMatrixForHomalg( arg[5] ) then
        ## BetterEquivalentMatrix(M,U,V,UI,VI)
        compute_U := true;
        compute_V := true;
        compute_UI := true;
        compute_VI := true;
        nar_U := 2;
        nar_V := 3;
        nar_UI := 4;
        nar_VI := 5;
    elif IsMatrixForHomalg( arg[2] ) and IsMatrixForHomalg( arg[3] ) then
        ## BetterEquivalentMatrix(M,U,V)
        compute_U := true;
        compute_V := true;
        compute_UI := false;
        compute_VI := false;
        nar_U := 2;
        nar_V := 3;
    else
        Error( "Wrong input!\n" );
    fi;
    
    m := NrColumns( M );
    n := NrRows( M );
    
    finished := false;
    
    if (compute_U or compute_UI or compute_V or compute_VI) then ## this is not a mistake
        if IsHomalgInternalMatrixRep( M ) then
            U := MatrixForHomalg( "internal", R );
        else
            U := MatrixForHomalg( "external", R );
        fi;
    fi;
        
    if (compute_V or compute_VI) then
        if IsHomalgInternalMatrixRep( M ) then
            V := MatrixForHomalg( "internal", R );
        else
            V := MatrixForHomalg( "external", R );
        fi;
    fi;
    
    #=====# begin of the core procedure #=====#
    
    if HasIsZeroMatrix( M ) and IsZeroMatrix( M ) then
        
        if compute_U then
            SetPreEval( U, MatrixForHomalg( "identity", NrRows( M ), R ) );
        fi;
        
        if compute_V then
            SetPreEval( V, MatrixForHomalg( "identity", NrColumns( M ), R ) );
        fi;
        
        if compute_UI then
            UI := MatrixForHomalg( "identity", NrRows( M ), R );
        fi;
        
        if compute_VI then
            VI := MatrixForHomalg( "identity", NrColumns( M ), R );
        fi;
        
        
        finished := true;
        
    fi;
    
    if not finished and IsBound( RP!.BestBasis ) then
        
        if not (compute_U or compute_UI or compute_V or compute_VI) then
            barg := [ M ];
        elif (compute_U or compute_UI) and not (compute_V or compute_VI) then
            barg := [ M, U ];
        else
            barg := [ M, U, V ];
        fi;
        
        M := CallFuncList( RP!.BestBasis, barg );
        
        ## FIXME:
        #if (compute_V or compute_VI) then
        #    if IsList( V ) and V <> [] and IsString( V[1] ) then
        #        if LowercaseString( V[1]{[1..3]} ) = "inv" then
        #            VI := V[2];
        #            if compute_V then
        #                V := Leftinverse( VI, arg[1], "NO_CHECK");
        #            fi;
        #        else
        #            Error( "Cannot interpret the first string in V ", V[1], "\n" );
        #        fi;
        #    fi;
        #fi;
        
        if compute_UI then
            if IsString( U ) then
                UI := U;
            else
                UI := Leftinverse( U );
            fi;
        fi;
        if compute_VI and not IsBound( VI ) then
            VI := Leftinverse( V );
        fi;
    
        A := BasisOfRowsCoeff( M );
        
        CM := RightHandSide( A );
        
        if compute_U and not IsString( U ) then
            U := CM * U;
        fi;
        
        if compute_UI and not IsString( UI ) then
            RightDivide( M, A );
            UI := UI * last;
        fi;
        
        M := A;
	
    fi;
    
    if compute_U then
        SetPreEval( arg[nar_U], U );
    fi;
    
    if compute_V then
        SetPreEval( arg[nar_V], V );
    fi;
    
    if compute_UI then
        SetPreEval( arg[nar_UI], UI );
    fi;
    
    if compute_VI then
        SetPreEval( arg[nar_VI], VI );
    fi;
    
    return M;
    
end );
