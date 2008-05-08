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
            options := [ "-t" , "--echo=0" , "--no-warn" ],
            BUFSIZE := 1024,
            READY := "!$%&/(",
            CUT_POS_BEGIN := 1,		## these are the most
            CUT_POS_END := 2,		## delicate values!
            eoc_verbose := ";",
            eoc_quiet := ";",
            break_lists := true,	## a Singular specific
            handle_output := true,	## a Singular specific
            check_output := false,	## a Singular specific looks for newlines without commas
            define := "=",
            prompt := "\033[01msingular>\033[0m ",
            output_prompt := "\033[1;30;43m<singular\033[0m ",
            display_color := "\033[0;30;47m",
           )
);

HOMALG_IO_Singular.READY_LENGTH := Length( HOMALG_IO_Singular.READY );

####################################
#
# representations:
#
####################################

# a new subrepresentation of the representation IshomalgExternalObjectWithIOStreamRep:
DeclareRepresentation( "IsHomalgExternalRingObjectInSingularRep",
        IshomalgExternalObjectWithIOStreamRep,
        [  ] );

# a new subrepresentation of the representation IsHomalgExternalRingRep:
DeclareRepresentation( "IsHomalgExternalRingInSingularRep",
        IsHomalgExternalRingRep,
        [  ] );

####################################
#
# families and types:
#
####################################

# a new type:
BindGlobal( "TheTypeHomalgExternalRingObjectInSingular",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingObjectInSingularRep ) );

# a new type:
BindGlobal( "TheTypeHomalgExternalRingInSingular",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingInSingularRep ) );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( RingForHomalgInSingular,
  function( arg )
    local nargs, stream, o, ar, ext_obj;
    
    nargs := Length( arg );
    
    ##check whether the last argument already has a stream pointing to a running
    ##instance of Singular
    if nargs > 1 then
        if IsRecord( arg[nargs] ) and IsBound( arg[nargs].lines ) and IsBound( arg[nargs].pid ) then
            stream := arg[nargs];
        elif IshomalgExternalObjectWithIOStreamRep( arg[nargs] ) or IsHomalgExternalRingRep( arg[nargs] ) then
            stream := homalgStream( arg[nargs] );
        fi;
    fi;

    ##if no such stream is found in the last argument, start and initialize
    ##a new Singular-process
    if not IsBound( stream ) then
        stream := LaunchCAS( HOMALG_IO_Singular );
        ##shut down the "redefining" messages
        homalgSendBlocking( "option(noredefine);LIB \"nctools.lib\";LIB \"matrix.lib\";LIB \"control.lib\";LIB \"ring.lib\"; LIB \"involut.lib\"", "need_command", stream, HOMALG_IO.Pictograms.initialize );
        o := 0;
    else
        o := 1;
    fi;
    
    ##this will lead to the call
    ##ring homalg_variable_something = arg[1];
    ar := [ [ arg[1] ], [ "ring" ], TheTypeHomalgExternalRingObjectInSingular, stream, HOMALG_IO.Pictograms.CreateHomalgRing ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( homalgSendBlocking, ar );
    
    ##prints output in a compatible format
    homalgSendBlocking( "short=0;", "need_command", stream, HOMALG_IO.Pictograms.initialize );
    
    return CreateHomalgRing( ext_obj, TheTypeHomalgExternalRingInSingular );
    
end );

##
InstallGlobalFunction( HomalgFieldOfRationalsInSingular,
  function( arg )
    local ar, R;
    
    ##It seems that Singular does not know the filed of rationals.
    ##Instead we create Q[dummy_variable] and feed only expressions
    ##without "dummy_variable" to Singular. Since homalg in GAP
    ##does not know of the dummy_variable, during the next ring extension
    ##it will vanish and not slow down basis calculations.
    ar := Concatenation( [ "0,dummy_variable,dp" ], [ IsPrincipalIdealRing ], arg );
    
    R := CallFuncList( RingForHomalgInSingular, ar );
    
    SetCharacteristic( R, 0 );
    
    SetIsFieldForHomalg( R, true );
    
    return R;
    
end );

##
InstallMethod( PolynomialRing,
        "for homalg rings in Singular",
        [ IsHomalgExternalRingInSingularRep, IsList ],
        
  function( R, indets )
    local var, c, properties, r, var_of_coeff_ring, ext_obj, S, v, nr_var;
    
    ##compute the new indeterminates for the ring and save them in var
    if IsString( indets ) and indets <> "" then
        var := SplitString( indets, "," ); 
    elif indets <> [ ] and ForAll( indets, i -> IsString( i ) and i <> "" ) then
        var := indets;
    else
        Error( "either a non-empty list of indeterminates or a comma separated string of them must be provided as the second argument\n" );
    fi;
    
    nr_var := Length( indets );
    
    c := Characteristic( R );
    
    properties := [ IsCommutative ];
    
    ##K[x] is a principal ideal ring for a field K
    if Length( var ) = 1 and IsFieldForHomalg( R ) then
        Add( properties, IsPrincipalIdealRing );
    fi;
    
    ##r is set to the ring of coefficients
    ##further a check is done, whether the old indeterminates (if exist) and the new
    ##one are disjoint
    if HasIndeterminatesOfPolynomialRing( R ) then
        r := CoefficientsRing( R );
        var_of_coeff_ring := IndeterminatesOfPolynomialRing( R );
        if not ForAll( var_of_coeff_ring, HasName ) then
            Error( "the indeterminates of coefficients ring must all have a name (use SetName)\n" );
        fi;
        var_of_coeff_ring := List( var_of_coeff_ring, Name );
        if Intersection2( var_of_coeff_ring, var ) <> [ ] then
            Error( "the following indeterminates are already elements of the coefficients ring: ", Intersection2( var_of_coeff_ring, var ), "\n" );
        fi;
    else
      r := R;
    fi;

    ##create the new ring
    ##todo: this creates a block ordering with a new "dp"-block
    ext_obj := homalgSendBlocking( [ "extendring(", nr_var, var, ",dp)" ], [ HOMALG_IO.Pictograms.define ], TheTypeHomalgExternalRingObjectInSingular, properties, R );
    homalgSendBlocking( ["setring ", ext_obj ], "need_command", HOMALG_IO.Pictograms.CreateHomalgRing );
    
    ##prints output in a compatible format
    homalgSendBlocking( "short=0;", "need_command", ext_obj, HOMALG_IO.Pictograms.initialize );
    
    ##since variables in Singular are stored inside a ring it is necessary to
    ##map all variables from the to ring to the new one
    ##todo: kill old ring to reduce memory?
    homalgSendBlocking( ["imapall(", R, ")" ], "need_command", HOMALG_IO.Pictograms.initialize );
    
    S := CreateHomalgRing( ext_obj, TheTypeHomalgExternalRingInSingular );
    
    var := List( Concatenation( var_of_coeff_ring, var ), a -> HomalgExternalRingElement( a, "Singular", S ) );
    
    for v in var do
        SetName( v, homalgPointer( v ) );
    od;
    
    SetCoefficientsRing( S, r );
    SetCharacteristic( S, c );
    SetIsCommutative( S, true );
    SetIndeterminatesOfPolynomialRing( S, var );
    
    return S;
    
end );

##
InstallMethod( SetEntryOfHomalgMatrix,
        "for external matrices in Singular",
        [ IsHomalgExternalMatrixRep, IsInt, IsInt, IsString, IsHomalgExternalRingInSingularRep ],
        
  function( M, r, c, s, R )
    
    homalgSendBlocking( [ M, "[", c, r, "] = ", s ], "need_command", HOMALG_IO.Pictograms.SetEntryOfHomalgMatrix );
    
end );

##
InstallMethod( CreateHomalgMatrix,
        "for homalg matrices",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInSingularRep ],
        
  function( M, r, c, R )
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ M ], [ "matrix" ], [ "[", r, "][", c, "]" ], R, HOMALG_IO.Pictograms.HomalgMatrix );
    homalgSendBlocking( [ ext_obj, " = transpose(", ext_obj, ")" ], "need_command" ); #added by Simon
    
    return HomalgMatrix( ext_obj, r, c, R );
    
end );

##
InstallMethod( GetEntryOfHomalgMatrixAsString,
        "for external matrices in Singular",
        [ IsHomalgExternalMatrixRep, IsInt, IsInt, IsHomalgExternalRingInSingularRep ],
        
  function( M, r, c, R )
    
    return homalgSendBlocking( [ M, "[", r, c, "]" ], "need_output", HOMALG_IO.Pictograms.GetEntryOfHomalgMatrix );
    
end );

##
InstallMethod( GetEntryOfHomalgMatrix,
        "for external matrices in Singular",
        [ IsHomalgExternalMatrixRep, IsInt, IsInt, IsHomalgExternalRingInSingularRep ],
        
  function( M, i, j, R )
    local Mij;
    
    Mij := homalgSendBlocking( [ M, "[", j, i, "]" ], [ "def" ], HOMALG_IO.Pictograms.GetEntryOfHomalgMatrix );
    
    return HomalgExternalRingElement( homalgPointer( Mij ), "Singular", R );
    
end );

####################################
#
# File related methods:
#
####################################

##
InstallMethod( SaveDataOfHomalgMatrixToFile,
        "for external matrices in Singular",
        [ IsString, IsHomalgMatrix, IsHomalgExternalRingInSingularRep ],
        
  function( filename, M, R )
    local mode, command;
    
    if not IsBound( M!.SaveAs ) then
        mode := "ListList";
    else
        mode := M!.SaveAs; #not yet supported
    fi;
    
    if mode = "ListList" then

        command := [ 
          "matrix m[", NrColumns( M ),"][1];",
          "string s = \"[\";",
          "for(int i=1;i<=", NrRows( M ), ";i=i+1)",
          "{m = ", M, "[1..", NrColumns( M ), ",i]; if(i!=1){s=s+\",\";};s=s+\"[\"+string(m)+\"]\";};",
          "s=s+\"]\";",
          "write(\"w: ", filename,"\",s);"
        ];

        homalgSendBlocking( command, "need_command", HOMALG_IO.Pictograms.SaveDataOfHomalgMatrixToFile );

    fi;
    
    return true;
    
end );


##
InstallMethod( LoadDataOfHomalgMatrixFromFile,
        "for external rings in Singular",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInSingularRep ],
        
  function( filename, r, c, R )
    local mode, command, M;
    
    if not IsBound( R!.LoadAs ) then
        mode := "ListList";
    else
        mode := R!.LoadAs; #not yet supported
    fi;
    
    M := HomalgVoidMatrix( R );
    
    if mode = "ListList" then
        
        command := [ "string s=read(\"r: ", filename, "\");",
                     "string w=\"\";for(int i=1;i<=size(s);i=i+1){if(s[i]<>\"[\" && s[i]<>\"]\"){w=w+s[i];};};",
                     "execute( \"matrix ", M, "[", r, "][", c, "] = \" + w + \";\" );",
                     M, " = transpose(", M, ")" ];
        
        homalgSendBlocking( command, "need_command", HOMALG_IO.Pictograms.LoadDataOfHomalgMatrixFromFile );
        
    fi;
    
    return M;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( Display,
        "for homalg matrices in Singular",
        [ IsHomalgExternalMatrixRep ], 1,
        
  function( o )
    
    if IsHomalgExternalRingInSingularRep( HomalgRing( o ) ) then
        
        Print( homalgSendBlocking( [ "print(transpose(", o, "))" ], "need_display", HOMALG_IO.Pictograms.Display ) );
        
    else
        
        TryNextMethod( );
        
    fi;
    
end );

InstallMethod( Display,
        "for homalg rings in Singular",
        [ IsHomalgExternalRingInSingularRep ], 1,
        
  function( o )
    
    Print( homalgSendBlocking( [ "print(", o, ")" ], "need_display", HOMALG_IO.Pictograms.Display ) );
    
end );

