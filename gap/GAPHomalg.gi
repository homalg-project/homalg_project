#############################################################################
##
##  GAPHomalg.gi              RingsForHomalg package         Mohamed Barakat
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
            cas := "gap",		## normalized name on which the user should have no control
            name := "GAP",
            executable := "gapL",
            options := [ "-b -q" ],
            BUFSIZE := 1024,
            READY := "!$%&/(",
            CUT_BEGIN := 1,		## these are the most
            CUT_END := 4,		## delicate values!
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
# representations:
#
####################################

# a new subrepresentation of the representation IshomalgExternalObjectWithIOStreamRep:
DeclareRepresentation( "IsHomalgExternalRingObjectInGAPRep",
        IshomalgExternalObjectWithIOStreamRep,
        [  ] );

# a new subrepresentation of the representation IsHomalgExternalRingRep:
DeclareRepresentation( "IsHomalgExternalRingInGAPRep",
        IsHomalgExternalRingRep,
        [  ] );

####################################
#
# families and types:
#
####################################

# a new type:
BindGlobal( "TheTypeHomalgExternalRingObjectInGAP",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingObjectInGAPRep ) );

# a new type:
BindGlobal( "TheTypeHomalgExternalRingInGAP",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingInGAPRep ) );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( RingForHomalgInExternalGAP,
  function( arg )
    local nargs, stream, o, ar, ext_obj;
    
    nargs := Length( arg );
    
    if nargs > 1 then
        if IsRecord( arg[nargs] ) and IsBound( arg[nargs].lines ) and IsBound( arg[nargs].pid ) then
            stream := arg[nargs];
        elif IshomalgExternalObjectWithIOStreamRep( arg[nargs] ) or IsHomalgExternalRingRep( arg[nargs] ) then
            stream := homalgStream( arg[nargs] );
        fi;
    fi;
    
    if not IsBound( stream ) then
        stream := LaunchCAS( HOMALG_IO_GAP );
        o := 0;
    else
        o := 1;
    fi;
    
    homalgSendBlocking( "LoadPackage(\"homalg\")", "need_command", stream );
    
    ar := [ [ "CreateHomalgRing( ", arg[1], " )" ], TheTypeHomalgExternalRingObjectInGAP, stream ];
    
    if Length( arg ) > 1 then
        ar := Concatenation( ar, arg{[ 2 .. Length( arg ) ]} );
    fi;
    
    ext_obj := CallFuncList( homalgSendBlocking, ar );
    
    return CreateHomalgRing( ext_obj, TheTypeHomalgExternalRingInGAP );
    
end );

##
InstallMethod( CreateHomalgMatrixInExternalCAS,
        "for homalg matrices",
        [ IsString, IsHomalgExternalRingInGAPRep ],
        
  function( S, R )
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ "HomalgMatrix( ", S, ", ", R, " )" ] );
    
    return HomalgMatrix( ext_obj, R );
    
end );

##
InstallMethod( CreateHomalgMatrixInExternalCAS,
        "for a list of an (external) matrix",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInGAPRep ],
  function( S, r, c, R )
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ "HomalgMatrix( ListToListList( ", S, ", ", r, c , " ), ", R, " )" ] );
    
    return HomalgMatrix( ext_obj, R );
    
end );

##
InstallMethod( GetListOfHomalgExternalMatrixAsString,
        "for maple matrices",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInGAPRep ],
        
  function( M, R )
    
    return homalgSendBlocking( [ "Concatenation( Eval( ", M, " ) )" ], "need_output" );
    
end );

##
InstallMethod( GetListListOfHomalgExternalMatrixAsString,
        "for maple matrices",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInGAPRep ],
        
  function( M, R )
    
    return homalgSendBlocking( [ "Eval( ", M, " )" ], "need_output" );
    
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
    local stream, display_color;
    
    stream := homalgStream( o );
    
    if IsHomalgExternalRingInGAPRep( HomalgRing( o ) ) then
        
        if IsBound( stream.color_display ) then
            display_color := stream.color_display;
        else
            display_color := "";
        fi;
        
        Print( display_color, homalgSendBlocking( [ "Display(", o, ")" ], "need_display" ) );
        
    else
        
        TryNextMethod( );
        
    fi;
    
end);
