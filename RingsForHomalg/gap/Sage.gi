#############################################################################
##
##  Sage.gi                   RingsForHomalg package          Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for the external computer algebra system Sage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( HOMALG_IO_Sage,
        rec(
            cas := "sage",		## normalized name on which the user should have no control
            name := "Sage",
            executable := [ "sage" ],	## this list is processed from left to right
            options := [ ],
            BUFSIZE := 1024,
            READY := "!$%&/(",
            CUT_POS_BEGIN := 7,		## these are the most
            CUT_POS_END := 10,		## delicate values!
            eoc_verbose := "",
            eoc_quiet := ";",
            remove_enter := true,       ## a Sage specific
	    check_output := true,	## a Sage specific
            only_warning := "WARNING:",	## a Sage specific
            define := "=",
            delete := function( var, stream ) homalgSendBlocking( [ "del ", var ], "need_command", stream, HOMALG_IO.Pictograms.delete ); end,
            multiple_delete := _Sage_multiple_delete,
            prompt := "\033[01msage:\033[0m ",
            output_prompt := "\033[1;34;43m<sage\033[0m ",
            display_color := "\033[0;34;43m",
            InitializeCASMacros := InitializeSageMacros,
           )
);
            
HOMALG_IO_Sage.READY_LENGTH := Length( HOMALG_IO_Sage.READY );

####################################
#
# representations:
#
####################################

# a new subrepresentation of the representation IshomalgExternalRingObjectRep:
DeclareRepresentation( "IsHomalgExternalRingObjectInSageRep",
        IshomalgExternalRingObjectRep,
        [  ] );

# a new subrepresentation of the representation IsHomalgExternalRingRep:
DeclareRepresentation( "IsHomalgExternalRingInSageRep",
        IsHomalgExternalRingRep,
        [  ] );

####################################
#
# families and types:
#
####################################

# a new type:
BindGlobal( "TheTypeHomalgExternalRingObjectInSage",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingObjectInSageRep ) );

# a new type:
BindGlobal( "TheTypeHomalgExternalRingInSage",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingInSageRep ) );

####################################
#
# global functions:
#
####################################

##
InstallGlobalFunction( _Sage_multiple_delete,
  function( var_list, stream )
    local str;
    
    str := [ "del ", var_list ];
    
    homalgSendBlocking( str, "need_command", "break_lists", stream, HOMALG_IO.Pictograms.multiple_delete );
    
end );

##
InstallValue( SageMacros,
        rec(
            
    ZeroRows := "\n\
def ZeroRows(C):\n\
  def check_rows(i):\n\
    return RowChecklist[i]\n\
  RowChecklist=[C.row(x).is_zero() for x in range(C.nrows())]\n\
  return filter(check_rows,range(C.nrows()))\n\n",
    
    ZeroColumns := "\n\
def ZeroColumns(C):\n\
  def check_cols(i):\n\
    return ColChecklist[i]\n\
  ColChecklist=[C.column(x).is_zero() for x in range(C.ncols())]\n\
  return filter(check_cols,range(C.ncols()))\n\n",
    
    FillMatrix := "\n\
def FillMatrix(M,L):\n\
  for x in L:\n\
    M[x[0]-1,x[1]-1] = x[2]\n\n",
    
    )
);

##
InstallGlobalFunction( InitializeSageMacros,
  function( stream )
    local v;
    
    v := stream.variable_name;
    
    return InitializeMacros( SageMacros, stream );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( RingForHomalgInSage,
  function( arg )
    local nargs, ar;
    
    nargs := Length( arg );
    
    ar := [ arg[1] ];
    
    Add( ar, TheTypeHomalgExternalRingObjectInSage );
    
    if nargs > 1 then
        Append( ar, arg{[ 2 .. nargs ]} );
    fi;
    
    ar := [ ar, TheTypeHomalgExternalRingInSage ];
    
    Add( ar, "HOMALG_IO_Sage" );
    
    return CallFuncList( CreateHomalgExternalRing, ar );
    
end );

InstallGlobalFunction( HomalgRingOfIntegersInSage,
  function( arg )
    local nargs, c, R;
    
    nargs := Length( arg );
    
    if nargs > 0 and IsInt( arg[1] ) and arg[1] <> 0 then
        ## characteristic:
        c := AbsInt( arg[1] );
        R := [ "GF(", c, ")" ];
        arg := arg{[ 2 .. nargs ]};
    else
        ## characteristic:
        c := 0;
        R := [ "IntegerModRing(", c, ")" ];
        if nargs > 0 and arg[1] = 0 then
            arg := arg{[ 2 .. nargs ]};
        fi;
    fi;
    
    if not ( IsZero( c ) or IsPrime( c ) ) then
        Error( "the ring Z/", c, "Z (", c, " non-prime) is not yet supported for Sage!\nYou can use the generic residue class ring constructor '/' provided by homalg after defining the ambient ring (over the integers)\nfor help type: ?homalg: constructor for residue class rings\n" );
    fi;
    
    R := Concatenation( [ R, IsPrincipalIdealRing ], arg );
    
    R := CallFuncList( RingForHomalgInSage, R );
    
    SetIsResidueClassRingOfTheIntegers( R, true );
    
    SetRingProperties( R, c );
    
    return R;
    
end );

##
InstallMethod( HomalgRingOfIntegersInUnderlyingCAS,
        "for an integer and homalg ring in Sage",
        [ IsInt, IsHomalgExternalRingInSageRep ],
        
  HomalgRingOfIntegersInSage );

##
InstallGlobalFunction( HomalgFieldOfRationalsInSage,
  function( arg )
    local R;
    
    R := "QQ";
    
    R := Concatenation( [ R ], [ IsPrincipalIdealRing, IsFieldForHomalg ], arg );
    
    R := CallFuncList( RingForHomalgInSage, R );
    
    SetIsRationalsForHomalg( R, true );
    
    SetRingProperties( R, 0 );
    
    return R;
    
end );

##
InstallMethod( HomalgFieldOfRationalsInUnderlyingCAS,
        "for a homalg ring in Sage",
        [ IsHomalgExternalRingInSageRep ],
        
  HomalgFieldOfRationalsInSage );

##
InstallMethod( FieldOfFractions,
        "for homalg rings in Sage",
        [ IsHomalgExternalRingInSageRep and IsIntegersForHomalg ],
        
  function( ZZ )
    
    return HomalgFieldOfRationalsInSage( ZZ );
    
end );

##
InstallMethod( PolynomialRing,
        "for homalg rings",
        [ IsHomalgExternalRingInSageRep, IsList ],
        
  function( R, indets )
    local ar, r, var, nr_var, properties, ext_obj, S, l;
    
    ar := _PrepareInputForPolynomialRing( R, indets );
    
    r := ar[1];
    var := ar[2];	## all indeterminates, relative and base
    nr_var := ar[3];	## the number of relative indeterminates
    properties := ar[4];
    
    ## create the new ring
    ext_obj := homalgSendBlocking( [ "PolynomialRing(", R, ")" ], [ ], [ ".<", var, ">" ], TheTypeHomalgExternalRingObjectInSage, properties, "break_lists", HOMALG_IO.Pictograms.CreateHomalgRing );
    
    S := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInSage );
    
    var := List( var, a -> HomalgExternalRingElement( a, S ) );
    
    Perform( var, Name );
    
    SetIsFreePolynomialRing( S, true );
    
    if HasIndeterminatesOfPolynomialRing( R ) and IndeterminatesOfPolynomialRing( R ) <> [ ] then
        SetBaseRing( S, R );
        l := Length( var );
        SetRelativeIndeterminatesOfPolynomialRing( S, var{[ l - nr_var + 1 .. l ]} );
    fi;
    
    SetRingProperties( S, r, var );
    
    return S;
    
end );

##
InstallMethod( SetMatElm,
        "for homalg external matrices in Sage",
        [ IsHomalgExternalMatrixRep and IsMutable, IsInt, IsInt, IsString, IsHomalgExternalRingInSageRep ],
        
  function( M, r, c, s, R )
    
    homalgSendBlocking( [ M, "[", r-1, c-1, "]=", s ], "need_command", HOMALG_IO.Pictograms.SetMatElm );
    
end );

##
InstallMethod( AddToMatElm,
        "for homalg external matrices in Sage",
        [ IsHomalgExternalMatrixRep and IsMutable, IsInt, IsInt, IsHomalgExternalRingElementRep, IsHomalgExternalRingInSageRep ],
        
  function( M, r, c, a, R )
    
    homalgSendBlocking( [ M, "[", r-1, c-1, "]=", a, "+", M, "[", r-1, c-1, "]" ], "need_command", HOMALG_IO.Pictograms.AddToMatElm );
    
end );

##
InstallMethod( CreateHomalgMatrixFromString,
        "constructor for homalg external matrices in Sage",
        [ IsString, IsHomalgExternalRingInSageRep ],
        
  function( S, R )
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ "matrix(", R, ",", S, ")" ], HOMALG_IO.Pictograms.HomalgMatrix );
    
    return HomalgMatrix( ext_obj, R );
    
end );

##
InstallMethod( CreateHomalgMatrixFromString,
        "constructor for homalg external matrices in Sage",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInSageRep ],
 function( S, r, c, R )
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ "matrix(", R, r, c, ",", S, ")" ], HOMALG_IO.Pictograms.HomalgMatrix );
    
    return HomalgMatrix( ext_obj, r, c, R );
    
end );

##
InstallMethod( CreateHomalgMatrixFromSparseString,
        "constructor for homalg external matrices in Sage",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInSageRep ],

  function( S, r, c, R )
    local M, s;
    
    M := HomalgInitialMatrix( r, c, R );
    
    s := homalgSendBlocking( S, R, HOMALG_IO.Pictograms.sparse );
    
    homalgSendBlocking( [ "FillMatrix(", M, ",",  s, ")" ], "need_command", HOMALG_IO.Pictograms.HomalgMatrix );
    
    return M;
    
end );

##
InstallMethod( MatElmAsString,
        "for homalg external matrices in Sage",
        [ IsHomalgExternalMatrixRep, IsInt, IsInt, IsHomalgExternalRingInSageRep ],

  function( M, r, c, R )
    
    return homalgSendBlocking( [ M, "[", r-1, c-1, "]" ], "need_output", HOMALG_IO.Pictograms.MatElm );
    
end );

##
InstallMethod( MatElm,
        "for homalg external matrices in Sage",
        [ IsHomalgExternalMatrixRep, IsInt, IsInt, IsHomalgExternalRingInSageRep ],
        
  function( M, r, c, R )
    local Mrc;
    
    Mrc := homalgSendBlocking( [ M, "[", r-1, c-1, "]" ], HOMALG_IO.Pictograms.MatElm );
    
    return HomalgExternalRingElement( Mrc, R );
    
end );

##
InstallMethod( GetListOfHomalgMatrixAsString,
        "for homalg external matrices in Sage",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInSageRep ],
        
  function( M, R )
    
    return homalgSendBlocking( [ M, ".list()" ], "need_output", HOMALG_IO.Pictograms.GetListOfHomalgMatrixAsString );
    
end );

##
InstallMethod( GetListListOfHomalgMatrixAsString,
        "for homalg external matrices in Sage",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInSageRep ],
        
  function( M, R )
    
    return homalgSendBlocking( [ "[", M, "[x].list() for x in range(", NrRows( M ), ")]" ], "need_output", HOMALG_IO.Pictograms.GetListListOfHomalgMatrixAsString );
    
end );

##
InstallMethod( GetSparseListOfHomalgMatrixAsString,
        "for homalg external matrices in Sage",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInSageRep ],
        
  function( M , R )
    
    return homalgSendBlocking( [ "[ [r+1,c+1,", M, "[r,c]] for r in range(", NrRows(M), ") for c in range(", NrColumns(M), ") if not ", M, "[r,c]==", Zero( R ), " ]" ], "need_output", HOMALG_IO.Pictograms.GetSparseListOfHomalgMatrixAsString );
    
end );

##
InstallMethod( SaveHomalgMatrixToFile,
        "for homalg external matrices in Sage",
        [ IsString, IsHomalgMatrix, IsHomalgExternalRingInSageRep ],
        
  function( filename, M, R )
    local mode, command;
    
    if not IsBound( M!.SaveAs ) then
        mode := "ListList";
    else
        mode := M!.SaveAs; #not yet supported
    fi;
    
    if mode = "ListList" then
        command := [ "_fs = open('", filename, "','w'); ",
                     "_fs.write(str( [", M, "[x].list() for x in range(", NrRows( M ), ")] )); ",
                     "_fs.close()" ];
                
        homalgSendBlocking( command, "need_command", HOMALG_IO.Pictograms.SaveHomalgMatrixToFile );
                
    fi;
    
    return true;
    
end );

##
InstallMethod( LoadHomalgMatrixFromFile,
        "for external rings in Sage",
        [ IsString, IsHomalgExternalRingInSageRep ],
        
  function( filename, R )
    local mode, command, M;
    
    if not IsBound( R!.LoadAs ) then
        mode := "ListList";
    else
        mode := R!.LoadAs; #not yet supported
    fi;
    
    M := HomalgVoidMatrix( R );
    
    if mode = "ListList" then
        
        command := [ "_fs = open('", filename, "','r'); ",
                     "_str = _fs.read(); ",
                     "_fs.close(); ",
                     M, "= matrix(", R, ",eval(_str))" ];
        
        homalgSendBlocking( command, "need_command", HOMALG_IO.Pictograms.LoadHomalgMatrixFromFile );
        
    fi;
    
    return M;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( DisplayRing,
        "for homalg rings in Sage",
        [ IsHomalgExternalRingInSageRep ], 1,
        
  function( o )
    
    homalgDisplay( o );
    
end );

