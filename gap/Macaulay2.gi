#############################################################################
##
##  Macaulay2.gi              RingsForHomalg package         Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for the external computer algebra system Macaulay2.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( HOMALG_IO_Macaulay2,
        rec(
            cas := "macaulay2",	## normalized name on which the user should have no control
            name := "Macaulay2",
            executable := "M2",
            options := [ "--no-prompts", "--silent", "--no-readline" ],
            BUFSIZE := 1024,
            READY := "!$%&/(",
	    CUT_BEGIN := 1,	## these is the most
            CUT_END := 16,	## delicate values!
            eoc_verbose := "",
            eoc_quiet := ";",
            define := "=",
            prompt := "M2> ",
            output_prompt := "\033[1;30;43m<M2\033[0m "
           )
);
            
HOMALG_IO_Macaulay2.READY_LENGTH := Length( HOMALG_IO_Macaulay2.READY );

