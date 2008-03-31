#############################################################################
##
##  Sage.gi                   RingsForHomalg package         Mohamed Barakat
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
            cas := "sage",	## normalized name on which the user should have no control
            name := "Sage",
            executable := "sage",
            options := [ ],
            BUFSIZE := 1024,
            READY := "!$%&/(",
	    CUT_BEGIN := 7,	## these is the most
            CUT_END := 10,	## delicate values!
            eoc_verbose := "",
            eoc_quiet := ";",
            define := "=",
            prompt := "sage: ",
            output_prompt := "\033[1;34;43m<sage\033[0m ",
            display_color := "\033[0;34;43m",
           )
);
            
HOMALG_IO_Sage.READY_LENGTH := Length( HOMALG_IO_Sage.READY );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( RingForHomalgInSage,
  function( arg )
    local stream, ext_obj;
    
    stream := LaunchCAS( HOMALG_IO_Sage );
    
    if Length( arg ) > 1 and IsFilter( arg[2] ) then
        ext_obj := HomalgExternalObject( arg[1], "Sage", stream, arg[2] );
    else
        ext_obj := HomalgExternalObject( arg[1], "Sage", stream, IsHomalgRingInSage );
    fi;
    
    return CreateHomalgRing( ext_obj, IsHomalgExternalObjectWithIOStream );
    
end );

##
InstallMethod( HomalgMatrixInSage,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep, IsHomalgExternalRingRep and IsHomalgExternalObjectWithIOStream ],
        
  function( M, R )
    local ext_obj;
    
    ext_obj := HomalgSendBlocking( [ "matrix(", R, ",", String( Eval( M ) ), ")" ] );
    
    return HomalgMatrix( ext_obj, R );
    
end );

##
InstallMethod( HomalgMatrixInSage,
        "for homalg matrices",
        [ IsString, IsHomalgExternalRingRep and IsHomalgExternalObjectWithIOStream ],
        
  function( M, R )
    local ext_obj;
    
    ext_obj := HomalgSendBlocking( [ "matrix(", R, ",", M, ")" ] );
    
    return HomalgMatrix( ext_obj, R );
    
end );

