#############################################################################
##
##  Singular.gi               RingsForHomalg package         Mohamed Barakat
##                                                    Markus Lange-Hegermann
##                                                    
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for the external computer algebra system Singular.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( HOMALG_IO_Singular,
        rec(
            cas := "singular",		## normalized name on which the user should have no control
            name := "Singular",
            executable := "Singular",
            options := [ "-t" , "--echo=0" ],
            BUFSIZE := 1024,
            READY := "!$%&/(",
            CUT_BEGIN := 1,		## these are the most
            CUT_END := 2,		## delicate values!
            eoc_verbose := ";",
            eoc_quiet := ";",
            break_lists := true,	## a Singular specific
            handle_output := true,	## a Singular specific
            check_output := true,	## a Singular specific
            define := "=",
            prompt := "singular> ",
            output_prompt := "\033[1;30;43m<singular\033[0m ",
            display_color := "\033[0;30;47m",
           )
);

HOMALG_IO_Singular.READY_LENGTH := Length( HOMALG_IO_Singular.READY );

####################################
#
# representations:
#
####################################

# a new subrepresentation of the representation IsHomalgExternalObjectRep:
DeclareRepresentation( "IsHomalgExternalRingObjectInSingularRep",
        IsHomalgExternalObjectWithIOStreamRep,
        [  ] );

# a new subrepresentation of the representation IsHomalgExternalRingRep:
DeclareRepresentation( "IsHomalgExternalRingInSingularRep",
        IsHomalgExternalRingRep,
        [  ] );

####################################
#
# families and types:
#
####################################

# a new type:
BindGlobal( "HomalgExternalRingObjectInSingularType",
        NewType( HomalgRingsFamily,
                IsHomalgExternalRingObjectInSingularRep ) );

# a new type:
BindGlobal( "HomalgExternalRingInSingularType",
        NewType( HomalgRingsFamily,
                IsHomalgExternalRingInSingularRep ) );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( RingForHomalgInSingular,
  function( arg )
    local nargs, stream, o, ar, ext_obj;
    
    nargs := Length( arg );
    
    if nargs > 1 then
        if IsRecord( arg[nargs] ) and IsBound( arg[nargs].lines ) and IsBound( arg[nargs].pid ) then
            stream := arg[nargs];
        elif IsHomalgExternalObjectWithIOStreamRep( arg[nargs] ) or IsHomalgExternalRingRep( arg[nargs] ) then
            stream := HomalgStream( arg[nargs] );
        fi;
    fi;
    
    if not IsBound( stream ) then
        stream := LaunchCAS( HOMALG_IO_Singular );
        HomalgSendBlocking( "LIB \"nctools.lib\"", "need_command", stream );
        HomalgSendBlocking( "LIB \"matrix.lib\"", "need_command", stream );
        HomalgSendBlocking( "LIB \"control.lib\"", "need_command", stream );
        o := 0;
    else
        o := 1;
    fi;
    
    ar := [ [ arg[1] ], [ "ring" ], HomalgExternalRingObjectInSingularType, stream ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( HomalgSendBlocking, ar );
    
    return CreateHomalgRing( ext_obj, HomalgExternalRingInSingularType );
    
end );

##
InstallMethod( HomalgMatrixInSingular,
        "for homalg matrices",
        [ IsInt, IsInt, IsString, IsHomalgExternalRingInSingularRep ],
        
  function( r, c, M, R )
    local ext_obj;
    
    ext_obj := HomalgSendBlocking( [ M ], [ "matrix" ], [ "[", r, "][", c, "]" ], R);
    
    return HomalgMatrix( ext_obj, R );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( Display,
        "for homalg matrices",
        [ IsHomalgExternalMatrixRep ], 1,
        
  function( o )
    local cas, stream, display_color;
    
    stream := HomalgStream( o );
    
    cas := stream.cas;
    
    if cas = "singular" then
        
        if IsBound( stream.color_display ) then
            display_color := stream.color_display;
        else
            display_color := "";
        fi;
        
        Print( display_color, HomalgSendBlocking( [ "print(", o, ")" ], "need_display" ) );
        
    else
        
        TryNextMethod( );
        
    fi;
    
end);
