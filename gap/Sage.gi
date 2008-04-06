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
            cas := "sage",		## normalized name on which the user should have no control
            name := "Sage",
            executable := "sage",
            options := [ ],
            BUFSIZE := 1024,
            READY := "!$%&/(",
            CUT_BEGIN := 7,		## these are the most
            CUT_END := 10,		## delicate values!
            eoc_verbose := "",
            eoc_quiet := ";",
            check_output := true,	## a Singular specific
            only_warning := "WARNING:",	## a Sage specific
            define := "=",
            prompt := "sage: ",
            output_prompt := "\033[1;34;43m<sage\033[0m ",
            display_color := "\033[0;34;43m",
           )
);
            
HOMALG_IO_Sage.READY_LENGTH := Length( HOMALG_IO_Sage.READY );

####################################
#
# representations:
#
####################################

# a new subrepresentation of the representation IsHomalgExternalObjectRep:
DeclareRepresentation( "IsHomalgExternalRingObjectInSageRep",
        IsHomalgExternalObjectWithIOStreamRep,
        [  ] );

# a new subrepresentation of the representation IsHomalgExternalRingRep:
DeclareRepresentation( "IsHomalgExternalRingInSageRep",
        IsHomalgExternalRingRep,
        [  ] );

####################################
#
# families and types:
#
####################################

# a new type:
BindGlobal( "HomalgExternalRingObjectInSageType",
        NewType( HomalgRingsFamily,
                IsHomalgExternalRingObjectInSageRep ) );

# a new type:
BindGlobal( "HomalgExternalRingInSageType",
        NewType( HomalgRingsFamily,
                IsHomalgExternalRingInSageRep ) );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( RingForHomalgInSage,
  function( arg )
    local stream, ar, ext_obj;
    
    stream := LaunchCAS( HOMALG_IO_Sage );
    
    ar := [ [ arg[1] ], HomalgExternalRingObjectInSageType, stream ];
    
    if Length( arg ) > 1 then
        ar := Concatenation( ar, arg{[ 2 .. Length( arg ) ]} );
    fi;
    
    ext_obj := CallFuncList( HomalgSendBlocking, ar );
    
    return CreateHomalgRing( ext_obj, HomalgExternalRingInSageType );
    
end );

##
InstallMethod( HomalgMatrixInSage,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep, IsHomalgExternalRingRep ],
        
  function( M, R )
    local ext_obj;
    
    ext_obj := HomalgSendBlocking( [ "matrix(", R, ",", String( Eval( M ) ), ")" ] );
    
    return HomalgMatrix( ext_obj, R );
    
end );

##
InstallMethod( HomalgMatrixInSage,
        "for homalg matrices",
        [ IsString, IsHomalgExternalRingRep ],
        
  function( M, R )
    local ext_obj;
    
    ext_obj := HomalgSendBlocking( [ "matrix(", R, ",", M, ")" ] );
    
    return HomalgMatrix( ext_obj, R );
    
end );

