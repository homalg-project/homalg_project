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
            CUT_BEGIN := 1,		## these is the most
            CUT_END := 2,		## delicate values!
            eoc_verbose := ";",
            eoc_quiet := ";",
            break_lists := true,	## a Singular specific
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
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( RingForHomalgInSingular,
  function( arg )
    local stream, ext_obj;
    
    stream := LaunchCAS( HOMALG_IO_Singular );
    
    HomalgSendBlocking( "LIB \"nctools.lib\"", "need_command", stream );
    HomalgSendBlocking( "LIB \"matrix.lib\"", "need_command", stream );
    HomalgSendBlocking( "LIB \"control.lib\"", "need_command", stream );
    
    if Length( arg ) > 1 and IsFilter( arg[2] ) then
        ext_obj := HomalgSendBlocking( [ arg[1] ], [ "ring" ], arg[2], stream );
    else
        ext_obj := HomalgSendBlocking( [ arg[1] ], [ "ring" ], IsHomalgRingInSingular, stream );
    fi;
    
    return CreateHomalgRing( ext_obj, IsHomalgExternalObjectWithIOStream );
    
end );

##
InstallMethod( HomalgMatrixInSingular,
        "for homalg matrices",
        [ IsInt, IsInt, IsString, IsHomalgExternalRingRep and IsHomalgExternalObjectWithIOStream ],
        
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
