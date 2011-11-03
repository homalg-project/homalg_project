#############################################################################
##
##  Singular.gi               RingsForHomalg package         Mohamed Barakat
##                                                    Markus Lange-Hegermann
##                                                          Oleksandr Motsak
##                                                           Hans Schönemann
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

InstallValue( HOMALG_IO_polymake,
        rec(
            cas := "polymake",			## normalized name on which the user should have no control
            name := "polymake",
            executable := [ "polymake" ],	## this list is processed from left to right
            #options := [ "-t", "--echo=0", "--no-warn" ],	## the option "-q" causes IO to believe that Singular has died!
	    options :=[],
            BUFSIZE := 1024,
            READY := "!$%&/(",
            CUT_POS_BEGIN := 1,			## these are the most
            CUT_POS_END := 12,			## delicate values!
            eoc_verbose := ";",
            eoc_quiet := ";",
            #nolistlist := true,			## a Singular specific
            #break_lists := true,		## a Singular specific
            #handle_output := true,		## a Singular specific
#            original_lines := true,		## a Singular specific
            #check_output := true,		## a Singular specific looks for newlines without commas
            #setring := _Singular_SetRing,	## a Singular specific
            ## prints polynomials in a format compatible with other CASs
            #setring_post := [ "short=0;", "option(redTail);" ],	## a Singular specific
            #setinvol := _Singular_SetInvolution,## a Singular specific
            define := "=",
            #delete := function( var, stream ) homalgSendBlocking( [ "kill ", var ], "need_command", stream, HOMALG_IO.Pictograms.delete ); end,
            #multiple_delete := _Singular_multiple_delete,
            #prompt := "\033[01msingular>\033[0m ",
            #output_prompt := "\033[1;30;43m<singular\033[0m ",
            #display_color := "\033[0;30;47m",
            #init_string := "option(noredefine);option(redSB);LIB \"matrix.lib\";LIB \"involut.lib\";LIB \"nctools.lib\";LIB \"poly.lib\";LIB \"finvar.lib\"",
            #InitializeMacros := InitializeSingularMacros,
           )
);

HOMALG_IO_polymake.READY_LENGTH := Length( HOMALG_IO_polymake.READY );


