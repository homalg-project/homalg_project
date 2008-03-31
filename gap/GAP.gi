#############################################################################
##
##  GAP.gi                    RingsForHomalg package         Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for the external computer algebra system GAP.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( HOMALG_IO_GAP,
        rec(
            cas := "gap",	## normalized name on which the user should have no control
            name := "GAP",
            executable := "gapL",
            options := [ "-b -q" ],
            BUFSIZE := 1024,
            READY := "!$%&/(",
	    CUT_BEGIN := 1,	## these is the most
            CUT_END := 4,	## delicate values!
            eoc_verbose := ";",
            eoc_quiet := ";;",
            define := ":=",
            prompt := "gap> ",
            output_prompt := "\033[1;37;44m<gap\033[0m ",
            display_color := "\033[0;35m",           
           )
);

HOMALG_IO_GAP.READY_LENGTH := Length( HOMALG_IO_GAP.READY );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( RingForHomalgInExternalGAP,
  function( arg )
    local stream, init, table, ext_obj;
    
    stream := LaunchCAS( HOMALG_IO_GAP );
    
    init := HomalgExternalObject( "", "GAP", stream );
    
    HomalgSendBlocking( "LoadPackage(\"homalg\")", "need_command", init );
    
    if Length( arg ) > 1 and IsFilter( arg[2] ) then
        ext_obj := HomalgSendBlocking( [ "CreateHomalgRing(", arg[1], ")" ], arg[2], init );
    else
        ext_obj := HomalgSendBlocking( [ "CreateHomalgRing(", arg[1], ")" ], IsHomalgRingInExternalGAP, init );
    fi;
    
    return CreateHomalgRing( ext_obj, IsHomalgExternalObjectWithIOStream );
    
end );

##
InstallMethod( HomalgMatrixInExternalGAP,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep, IsHomalgExternalRingRep and IsHomalgExternalObjectWithIOStream ],
        
  function( M, R )
    local ext_obj;
    
    ext_obj := HomalgSendBlocking( [ "HomalgMatrix( ", String( Eval( M ) ), ", ", R, " )" ] );
    
    return HomalgMatrix( ext_obj, R );
    
end );

##
InstallMethod( HomalgMatrixInExternalGAP,
        "for homalg matrices",
        [ IsString, IsHomalgExternalRingRep and IsHomalgExternalObjectWithIOStream ],
        
  function( M, R )
    local ext_obj;
    
    ext_obj := HomalgSendBlocking( [ "HomalgMatrix( ", M, ", ", R, " )" ] );
    
    return HomalgMatrix( ext_obj, R );
    
end );

