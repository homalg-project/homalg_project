# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Implementations
#

##  Implementation stuff for the external computer algebra system LiE.

####################################
#
# global variables:
#
####################################

BindGlobal( "HOMALG_IO_LiE",
        rec(
            cas := "lie", ## normalized name on which the user should have no control
            name := "LiE",
            executable := [ "lie" ], ## this list is processed from left to right
            options := [ ],
            BUFSIZE := 1024,
            READY := "!%&/)(",
            READY_printed := ~.READY,
            CUT_POS_BEGIN := 1, ## these are the most
            CUT_POS_END := 1,   ## delicate values!
            eoc_verbose := "",
            eoc_quiet := "", ## an LiE specific
            normalized_white_space := NormalizedWhitespace, ## an LiE specific
            ## prints polynomials in a format compatible with other CASs
            define := "=",
            delete := function( var, stream ) homalgSendBlocking( [ var, " = 0" ], "need_command", stream, "delete" ); end,
            multiple_delete := _LiE_multiple_delete,
            prompt := "\033[01mLiE>\033[0m ",
            output_prompt := "\033[1;30;43m<LiE\033[0m ",
            display_color := "\033[0;30;47m",
            banner := """\
LiE version 2.2.2
Authors: Arjeh M. Cohen, Marc van Leeuwen, Bert Lisser.
Free source code distribution
type '?help' for help information
type '?' for a list of help entries.\
""",
            init_string := "",
            InitializeCASMacros := InitializeLiEMacros,
           )
);

HOMALG_IO_LiE.READY_LENGTH := Length( HOMALG_IO_LiE.READY_printed );

####################################
#
# families and types:
#
####################################

# a new type:
BindGlobal( "TheTypeHomalgExternalRingObjectInLiE",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingObjectInLiERep ) );

# a new type:
BindGlobal( "TheTypeHomalgExternalRingInLiE",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingInLiERep ) );

####################################
#
# global functions and variables:
#
####################################

##
InstallGlobalFunction( _LiE_multiple_delete,
  function( var_list, stream )
    local str, var;
    
    str:="";
    
    for var in var_list do
      str := Concatenation( str, String ( var ) , " = 0" );
    od;
    
    homalgSendBlocking( str, "need_command", stream, "multiple_delete" );
    
end );

##
BindGlobal( "LiEMacros",
        rec(

            init := """
""",

    
    )

);

##
InstallGlobalFunction( InitializeLiEMacros,
  function( stream )
    
    return InitializeMacros( LiEMacros, stream );
    
end );

####################################
#
# constructor functions and methods:
#
####################################


####################################
#
# transfer methods:
#
####################################

####################################
#
# View, Print, and Display methods:
#
####################################

