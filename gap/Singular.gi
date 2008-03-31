#############################################################################
##
##  Singular.gi               RingsForHomalg package         Mohamed Barakat
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
            cas := "singular",	## normalized name on which the user should have no control
            name := "Singular",
            executable := "Singular",
            options := [ "-t" , "--echo=0" ],
            BUFSIZE := 1024,
            READY := "!$%&/(",
	    CUT_BEGIN := 1,	## these is the most
            CUT_END := 2,	## delicate values!
            eoc_verbose := ";",
            eoc_quiet := ";",
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
    local stream, init, ext_obj;
    
    stream := LaunchCAS( HOMALG_IO_Singular );
    
    init := HomalgExternalObject( "", "Singular", stream );
    
    HomalgSendBlocking( "LIB \"nctools.lib\"", "need_command", init );
    
    if Length( arg ) > 1 and IsFilter( arg[2] ) then
        ext_obj := HomalgSendBlocking( [ arg[1] ], [ "ring" ], arg[2], init );
    else
        ext_obj := HomalgSendBlocking( [ arg[1] ], [ "ring" ], IsHomalgRingInSingular, init );
    fi;
    
    return CreateHomalgRing( ext_obj, IsHomalgExternalObjectWithIOStream );
    
end );

