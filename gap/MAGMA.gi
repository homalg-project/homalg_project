#############################################################################
##
##  MAGMA.gi                  RingsForHomalg package         Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for the external computer algebra system MAGMA.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( HOMALG_IO_MAGMA,
        rec(
            cas := "magma",	## normalized name on which the user should have no control
            name := "MAGMA",
            executable := "magma",
            options := [ ],
            BUFSIZE := 1024,
            READY := "!$%&/(",
	    CUT_BEGIN := 1,	## these is the most
            CUT_END := 2,	## delicate values!
            eoc_verbose := ";",
            eoc_quiet := ";",
            define := ":=",
            prompt := "magma> ",
            output_prompt := "\033[1;31;47m<magma\033[0m ",
            display_color := "\033[0;30;47m",
           )
);

HOMALG_IO_MAGMA.READY_LENGTH := Length( HOMALG_IO_MAGMA.READY );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( RingForHomalgInMAGMA,
  function( arg )
    local stream, ext_obj;
    
    stream := LaunchCAS( HOMALG_IO_MAGMA );
    
    if Length( arg ) > 1 and IsFilter( arg[2] ) then
        ext_obj := HomalgExternalObject( arg[1], "MAGMA", stream, arg[2] );
    else
        ext_obj := HomalgExternalObject( arg[1], "MAGMA", stream, IsHomalgRingInMAGMA );
    fi;
    
    return CreateHomalgRing( ext_obj, IsHomalgExternalObjectWithIOStream );
    
end );

##
InstallMethod( HomalgMatrixInMAGMA,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep, IsHomalgExternalRingRep and IsHomalgExternalObjectWithIOStream ],
        
  function( M, R )
    local ext_obj;
    
    ext_obj := HomalgSendBlocking( [ "Matrix(", R, ",", String( Eval( M ) ), ")" ] );
    
    return HomalgMatrix( ext_obj, R );
    
end );

##
InstallMethod( HomalgMatrixInMAGMA,
        "for homalg matrices",
        [ IsString, IsHomalgExternalRingRep and IsHomalgExternalObjectWithIOStream ],
        
  function( M, R )
    local ext_obj;
    
    ext_obj := HomalgSendBlocking( [ "Matrix(", R, ",", M, ")" ] );
    
    return HomalgMatrix( ext_obj, R );
    
end );

