#############################################################################
##
##  MatrixForHomalg.gi          homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for homalg matrices.
##
#############################################################################

####################################
#
# representations:
#
####################################

# two new representations for the category IsMatrixForHomalg:
DeclareRepresentation( "IsHomalgInternalMatrixRep",
        IsMatrixForHomalg,
        [ ] );

DeclareRepresentation( "IsHomalgExternalMatrixRep",
        IsMatrixForHomalg,
        [ ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "HomalgMatricesFamily",
        NewFamily( "HomalgMatricesFamily" ));

# two new types:
BindGlobal( "HomalgInternalMatrixType",
        NewType( HomalgMatricesFamily ,
                IsHomalgInternalMatrixRep ));

BindGlobal( "HomalgExternalMatrixType",
        NewType( HomalgMatricesFamily ,
                IsHomalgExternalMatrixRep ));

####################################
#
# logical implications methods:
#
####################################



####################################
#
# constructor functions and methods:
#
####################################

InstallGlobalFunction( MatrixForHomalg,
  function( arg )
    local nar, R, matrix, M;
    
    nar := Length( arg );
    
    R := arg[nar];
    
    if not IsRingForHomalg( R ) then
        Error("the last argument must be an IsRingForHomalg");
    fi;
    
    matrix := rec( ring := R );
    
    ## the identity matrix:
    if IsString(arg[1]) and arg[1] <> [] and LowercaseString(arg[1]{[1..2]}) = "id" then
        
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, HomalgInternalMatrixType,
                IsIdentityMatrix, true,
                IsFullRowRankMatrix, true,
                IsFullColumnRankMatrix, true );
        
        if Length(arg) > 2 and IsPosInt(arg[2]) then
            SetNrRows( matrix, arg[2] );
            SetNrColumns( matrix, arg[2] );
            SetRankOfMatrix( matrix, arg[2] );
        fi;
        
        return matrix;
        
    fi;
    
    ## the zero matrix:
    if IsString(arg[1]) and arg[1] <> [] and LowercaseString(arg[1]{[1..4]}) = "zero" then
        
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, HomalgInternalMatrixType,
                IsZeroMatrix, true );
        
        if Length(arg) > 2 and IsPosInt(arg[2]) then
            SetNrRows( matrix, arg[2] );
            SetNrColumns( matrix, arg[3] );
            SetRankOfMatrix( matrix, 0 );
        fi;
        
        return matrix;
        
    fi;
        
    if IsList(arg[1]) and Length(arg[1]) <> 0 and not IsList(arg[1][1]) then
        M := List( arg[1], a->[a] ); ## NormalizeInput
    else
        M := arg[1];
    fi;
    
    if IsList(arg[1]) then ## HomalgInternalMatrixType
        
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, HomalgInternalMatrixType,
                Eval, M );
        
        if Length(arg[1]) = 0 then
            SetNrRows( matrix, 0 );
            SetNrColumns( matrix, 0 );
            SetIsZeroMatrix( matrix, true );
        elif arg[1][1] = [] then
            SetNrRows( matrix, Length(arg[1]) );
            SetNrColumns( matrix, 0 );
            SetIsZeroMatrix( matrix, true );
        elif not IsList(arg[1][1]) then
            SetNrRows( matrix, Length(arg[1]) );
            SetNrColumns( matrix, 1 );
        elif IsMatrix(arg[1]) then
            SetNrRows( matrix, Length(arg[1]) );
            SetNrColumns( matrix, Length(arg[1][1]) );
        fi;
    else ## HomalgExternalMatrixType
        
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, HomalgExternalMatrixType,
                Eval, M );
        
    fi;
    
    return matrix;
    
end );
  
####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( ViewObj,
        "for homalg matrices",
        [ IsMatrixForHomalg and IsZeroMatrix ],
        
  function( o )
    
    Print( "<A homalg " );
    
    if IsHomalgInternalMatrixRep( o ) then
        Print( "internal " );
    else
        Print( "external " );
    fi;
    
    if HasNrRows( o ) then
        Print( NrRows( o ), " " );
    fi;
    
    if HasNrColumns( o ) then
        Print( "by ", NrColumns( o ), " " );
    fi;
    
    Print( "zero matrix>" );
    
end );

InstallMethod( ViewObj,
        "for homalg matrices",
        [ IsMatrixForHomalg and IsIdentityMatrix ],
        
  function( o )
    
    Print( "<A homalg " );
    
    if IsHomalgInternalMatrixRep( o ) then
        Print( "internal " );
    else
        Print( "external " );
    fi;
    
    if HasNrRows( o ) then
        Print( NrRows( o ), " " );
    fi;
    
    if HasNrColumns( o ) then
        Print( "by ", NrColumns( o ), " " );
    fi;
    
    Print( "identity matrix>" );
    
end );

InstallMethod( ViewObj,
        "for homalg matrices",
        [ IsMatrixForHomalg ],
        
  function( o )
    
    Print( "<A homalg " );
    
    if IsHomalgInternalMatrixRep( o ) then
        Print( "internal " );
    else
        Print( "external " );
    fi;
    
    if HasNrRows( o ) then
        Print( NrRows( o ), " " );
    fi;
    
    if HasNrColumns( o ) then
        Print( "by ", NrColumns( o ), " " );
    fi;
    
    Print( "matrix>" );
    
end );

InstallMethod( Display,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep ],
        
  function( o )
    
    Print( Eval( o ), "\n" );
    
end);
