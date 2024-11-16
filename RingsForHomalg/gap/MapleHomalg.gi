# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Implementations
#

##  Implementation stuff for the external computer algebra system Maple.

####################################
#
# global variables:
#
####################################

BindGlobal( "HOMALG_IO_Maple",
        rec(
            cas := "maple", ## normalized name on which the user should have no control
            name := "Maple",
            executable := [ "maple_for_homalg", "maple14", "maple13", "maple12", "maple11", "maple10", "maple9", "maple" ], ## this list is processed from left to right
            options := [ "-q" ],
            BUFSIZE := 1024,
            READY := "!$%&/(",
            CUT_POS_BEGIN := 1, ## these are the most
            CUT_POS_END := 4,   ## delicate values!
            eoc_verbose := ";",
            eoc_quiet := ":",
            error_stdout := "Error, ", ## a Maple specific
            normalized_white_space := NormalizedWhitespace, ## a Maple specific
            trim_display := function( str ) return str{ [ 1 .. Length( str ) - 36 ] }; end, ## a Maple specific
            setring := _MapleHomalg_SetRing, ## a MapleHomalg specific
            define := ":=",
            delete := function( var, stream ) homalgSendBlocking( [ var, " := '", var, "'"  ], "need_command", stream, "delete" ); end,
            multiple_delete := _Maple_multiple_delete,
            garbage_collector := function( stream ) homalgSendBlocking( [ "gc()" ], "need_command", stream, "garbage_collector" ); end,
            prompt := "\033[01mmaple>\033[0m ",
            output_prompt := "\033[1;34;47m<maple\033[0m ",
            display_color := "\033[0;34m",
            #banner :=  function( s ) Print( s.lines{ [ 1 .. Length( s.lines ) - 36 ] } ); end, ## this line is commented since we must start Maple using the -q option, which unfortunately also suppresses the Maple banner
            banner := "\
    |\\^/|     Launching Maple\n\
._|\\|   |/|_. Copyright (c) Maplesoft, a division of Waterloo Maple Inc.\n\
 \\  MAPLE  /  All rights reserved. Maple is a trademark of\n\
 <____ ____>  Waterloo Maple Inc.\n\
      |       ",
            InitializeCASMacros := InitializeMapleMacros,
            UseJacobsonNormalForm := false,
            time := function( stream, t ) return Int( homalgSendBlocking( [ "floor(time() * 1000)" ], "need_output", stream, "time" ) ) - t; end,
           )
);

HOMALG_IO_Maple.READY_LENGTH := Length( HOMALG_IO_Maple.READY );

####################################
#
# families and types:
#
####################################

# five new types:
BindGlobal( "TheTypeHomalgExternalRingObjectInMapleUsingPIR",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingObjectInMapleUsingPIRRep ) );

BindGlobal( "TheTypeHomalgExternalRingObjectInMapleUsingInvolutive",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingObjectInMapleUsingInvolutiveRep ) );

BindGlobal( "TheTypeHomalgExternalRingObjectInMapleUsingJanet",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingObjectInMapleUsingJanetRep ) );

BindGlobal( "TheTypeHomalgExternalRingObjectInMapleUsingJanetOre",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingObjectInMapleUsingJanetOreRep ) );

BindGlobal( "TheTypeHomalgExternalRingObjectInMapleUsingOreModules",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingObjectInMapleUsingOreModulesRep ) );

# a new types:
BindGlobal( "TheTypeHomalgExternalRingInMaple",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingInMapleRep ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( homalgLaTeX,
        "for external objects",
        [ IsHomalgExternalMatrixRep ],
        
  function( o )
    local R;
    
    R := HomalgRing( o );
    
    if IsHomalgExternalRingInMapleRep( R ) then
        
        Print( homalgSendBlocking( [ "latex(", o, ")" ], "need_display", "homalgLaTeX" ) );
        
    else
        
        TryNextMethod( );
        
    fi;

end );

####################################
#
# global functions and variables:
#
####################################

##
InstallGlobalFunction( _MapleHomalg_SetRing,
  function( R )
    local stream;
    
    stream := homalgStream( R );
    
    ## since _MapleHomalg_SetRing might be called from homalgSendBlocking,
    ## we first set the new active ring to avoid infinite loops:
    stream.active_ring := R;
    
    if IsBound( R!.MapleHomalgOptions ) then
        homalgSendBlocking( [ R!.MapleHomalgOptions[1], "(\"set\",", R!.MapleHomalgOptions[2], ")" ], "need_command", "initialize" );
    fi;
    
    if IsBound( HOMALG_IO_Maple.setring_post ) then
        homalgSendBlocking( HOMALG_IO_Maple.setring_post, "need_command", stream, "initialize" );
    fi;
    
end );

##
InstallGlobalFunction( _Maple_multiple_delete,
  function( var_list, stream )
    local str;
    
    str := [ "for _del in ", String( var_list ), " do unassign(convert(_del,symbol)) od" ];
    
    homalgSendBlocking( str, "need_command", stream, "multiple_delete" );
    
end );

##
BindGlobal( "MapleMacros",
        rec(
    
    Eliminate := "\n\
Eliminate := proc(L,indets::list,var::list)\n\
local IB,elim;\n\
IB := `Involutive/InvolutiveBasis`(L,[indets,remove(member,var,indets)]);\n\
elim := remove(has,IB,indets);\n\
if elim = [] then elim := matrix([[]]); fi;\n\
elim;\n\
end:\n\n",
    
    CoefficientsOfPolynomial := "\n\
CoefficientsOfPolynomial := proc(h,x)\n\
if h = 0 then\n\
  [ ]\n\
else\n\
  map(i->coeff(h,x,i),[$0..degree(h,x)]);\n\
fi;\n\
end:\n\n",
    
    CoefficientsOfLaurentPolynomial := "\n\
CoefficientsOfLaurentPolynomial := proc(h,x)\n\
local hdeg,ldeg,degs;\n\
if h = 0 then\n\
  0\n\
else\n\
  hdeg := degree(h,x);\n\
  ldeg := ldegree(h,x);\n\
  degs := map(i->coeff(h,x,i),[$ldeg ..hdeg]);\n\
  op(degs),ldeg;\n\
fi;\n\
end:\n\n",
    
    CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries := "\n\
CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries := proc(mat,var,s,n)\n\
`Involutive/InvolutiveBasis`(mat,var);\n\
CoefficientsOfPolynomial(expand(simplify(`Involutive/PolHilbertSeries`(s)*(1-s)^n)),s);\n\
end:\n\n",
    
    CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries := "\n\
CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries := proc(mat,var,s,denom)\n\
`Involutive/InvolutiveBasis`(mat,var);\n\
CoefficientsOfLaurentPolynomial(expand(simplify(`Involutive/PolWeightedHilbertSeries`(var,s)*denom)),'homalg_variable_for_HP');\n\
end:\n\n",
    
    BestBasis := "\n\
`InvolutiveQS/homalg`[BestBasis] := proc() `homalg/Involutive/BasisQS`(convert(args[1],listlist),args[2..-1]):\n\
end:\n\n",
    
    MyReverse := "\n\
MyReverse := proc(h)\n\
map(i->h[-i],[$1..nops(h)])\n\
end:\n\n",
    
    )
);

##
InstallGlobalFunction( InitializeMapleMacros,
  function( stream )
    
    return InitializeMacros( MapleMacros, stream );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( RingForHomalgInMapleUsingPIR,
  function( arg )
    local nargs, stream, o, display_color, homalg_version, package_version,
          ar, ext_obj, R, RP;
    
    nargs := Length( arg );
    
    if nargs > 1 then
        if IsRecord( arg[nargs] ) and IsBound( arg[nargs].lines ) and IsBound( arg[nargs].pid ) then
            stream := arg[nargs];
        elif IshomalgExternalObjectRep( arg[nargs] ) or IsHomalgExternalRingRep( arg[nargs] ) then
            stream := homalgStream( arg[nargs] );
        fi;
    fi;
    
    if not IsBound( stream ) then
        stream := LaunchCAS( "HOMALG_IO_Maple" );
        if not IsBound( stream.path_to_maple_packages ) then ## each component in HOMALG_IO_Maple is now in the stream
            stream.path_to_maple_packages := Concatenation( PackageInfo( "RingsForHomalg" )[1].InstallationPath, "/maple" );
        fi;
        
        homalgSendBlocking( [ "libname := \"", stream.path_to_maple_packages, "\",libname" ], "need_command", stream, "initialize" );
        o := 0;
    else
        o := 1;
    fi;
    
    InitializeMapleMacros( stream );
    
    homalgSendBlocking( "with(PIR)", "need_command", stream, "initialize" );
    
    if ( not ( IsBound( HOMALG_IO.show_banners ) and HOMALG_IO.show_banners = false )
         and not ( IsBound( HOMALG_IO.show_maple_package_banner ) and HOMALG_IO.show_maple_package_banner = false )
         and not ( IsBound( stream.show_banner ) and stream.show_banner = false ) )
         and not ( IsBound( stream.show_banner_PIR ) and stream.show_banner_PIR = false ) then
        
        if IsBound( stream.color_display ) then
            display_color := stream.color_display;
        else
            display_color := "";
        fi;
        
        homalg_version := homalgSendBlocking("\`homalg/version\`", "need_output", stream, "initialize" ){[ 3 .. 8 ]};
        package_version := homalgSendBlocking("\`PIR/version\`", "need_output", stream, "initialize" ){[ 3 .. 8 ]};
        
        Print( "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n" );
        
        ## leave the below indentation untouched!
        Print( display_color, "\
     PIR - Maple package loaded (version: ", package_version, ")\n\
     Copyright (C) (2004-2006)\n\
     Lehrstuhl B fuer Mathematik, RWTH Aachen, Germany\n\
     (will be used as a ring package via Maple's homalg (ver: ", homalg_version, "))\033[0m\n\
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n" );
        
        stream.show_banner_PIR := false;
        
    fi;
    
    ar := [ [ arg[1], ",", "copy(`PIR/homalg`)" ], TheTypeHomalgExternalRingObjectInMapleUsingPIR, IsCommutative, IsPrincipalIdealRing, stream, "CreateHomalgRing" ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( homalgSendBlocking, ar );
    
    R := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInMaple, IsCommutative, IsPrincipalIdealRing );
    
    homalgSendBlocking( [ "`homalg/homalg_options`(", R, "[-1])" ], "need_command", "initialize" );
    
    _MapleHomalg_SetRing( R );
    
    LetWeakPointerListOnExternalObjectsContainRingCreationNumbers( R );
    
    RP := homalgTable( R );
    
    RP!.Sum :=
      function( a, b )
        
        return homalgSendBlocking( [ a, "+(", b, ")" ], "Sum" );
        
      end;
    
    RP!.Product :=
      function( a, b )
        
        return homalgSendBlocking( [ "(", a, ")*(", b, ")" ], "Product" );
        
      end;
    
    return R;
    
end );

##
InstallGlobalFunction( RingForHomalgInMapleUsingInvolutive,
  function( arg )
    local nargs, stream, o, display_color, homalg_version, package_version,
          var, ar, ext_obj, R, RP;
    
    nargs := Length( arg );
    
    if nargs > 1 then
        if IsRecord( arg[nargs] ) and IsBound( arg[nargs].lines ) and IsBound( arg[nargs].pid ) then
            stream := arg[nargs];
        elif IshomalgExternalObjectRep( arg[nargs] ) or IsHomalgExternalRingRep( arg[nargs] ) then
            stream := homalgStream( arg[nargs] );
        fi;
    fi;
    
    if not IsBound( stream ) then
        stream := LaunchCAS( "HOMALG_IO_Maple" );
        if not IsBound( stream.path_to_maple_packages ) then ## each component in HOMALG_IO_Maple is now in the stream
            stream.path_to_maple_packages := Concatenation( PackageInfo( "RingsForHomalg" )[1].InstallationPath, "/maple" );
        fi;
        homalgSendBlocking( [ "libname := \"", stream.path_to_maple_packages, "\",libname" ], "need_command", stream, "initialize" );
        o := 0;
    else
        o := 1;
    fi;
    
    homalgSendBlocking( "with(Involutive)", "need_command", stream, "initialize" );
    
    if ( not ( IsBound( HOMALG_IO.show_banners ) and HOMALG_IO.show_banners = false )
         and not ( IsBound( HOMALG_IO.show_maple_package_banner ) and HOMALG_IO.show_maple_package_banner = false )
         and not ( IsBound( stream.show_banner ) and stream.show_banner = false ) )
         and not ( IsBound( stream.show_banner_Involutive ) and stream.show_banner_Involutive = false ) then
        
        if IsBound( stream.color_display ) then
            display_color := stream.color_display;
        else
            display_color := "";
        fi;
        
        homalg_version := homalgSendBlocking("\`homalg/version\`", "need_output", stream, "initialize" ){[ 3 .. 8 ]};
        package_version := homalgSendBlocking("\`Involutive/version\`", "need_output", stream, "initialize" );
        
        Print( "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n" );
        
        ## leave the below indentation untouched!
        Print( display_color, "\
     Involutive - Maple package loaded (version: ", package_version, ")\n\
     Copyright (C) (2000-2009) Carlos F. Cid and Daniel Robertz\n\
     Lehrstuhl B fuer Mathematik, RWTH Aachen, Germany\n\
     (will be used as a ring package via Maple's homalg (ver: ", homalg_version, "))\033[0m\n\
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n" );
        
        stream.show_banner_Involutive := false;
        
    fi;
    
    homalgSendBlocking( "with(QuillenSuslin)", "need_command", stream, "initialize" );
    
    if ( not ( IsBound( HOMALG_IO.show_banners ) and HOMALG_IO.show_banners = false )
         and not ( IsBound( HOMALG_IO.show_maple_package_banner ) and HOMALG_IO.show_maple_package_banner = false )
         and not ( IsBound( stream.show_banner ) and stream.show_banner = false ) )
         and not ( IsBound( stream.show_banner_QuillenSuslin ) and stream.show_banner_QuillenSuslin = false ) then
        
        if IsBound( stream.color_display ) then
            display_color := stream.color_display;
        else
            display_color := "";
        fi;
        
        homalg_version := homalgSendBlocking("\`homalg/version\`", "need_output", stream, "initialize" ){[ 3 .. 8 ]};
        package_version := homalgSendBlocking("\`QuillenSuslin/version\`", "need_output", stream, "initialize" );
        
        Print( "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n" );
        
        Print( display_color, "\
     QuillenSuslin - Maple package loaded (version: ", package_version, ")\n\
     Copyright (C) (2003-2008) Anna Fabianska\n\
     Lehrstuhl B fuer Mathematik, RWTH Aachen, Germany\n\
     (will be used as a ring package via Maple's homalg (ver: ", homalg_version, "))\033[0m\n\
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n" );
        
        stream.show_banner_QuillenSuslin := false;
        
    fi;
    
    if IsString( arg[1] ) then
        var := arg[1];
    else
        var := Flat( [ "[", JoinStringsWithSeparator( arg[1] ), "]" ] );
    fi;
    
    ar := [ [ var, ",", "copy(`Involutive/homalg`)" ], TheTypeHomalgExternalRingObjectInMapleUsingInvolutive, IsCommutative, stream, "CreateHomalgRing" ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( homalgSendBlocking, ar );
    
    R := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInMaple, IsCommutative );
    
    ## we need homalg_options(matrix,...) until `homalg/Involutive/BasisQS` is fixed
    homalgSendBlocking( [ "`homalg/homalg_options`(matrix,", R, "[-1])" ], "need_command", "initialize" );
    homalgSendBlocking( [ R, "[-1][BestBasis]:=`InvolutiveQS/homalg`[BestBasis]" ], "need_command", "initialize" );
    
    _MapleHomalg_SetRing( R );
    
    LetWeakPointerListOnExternalObjectsContainRingCreationNumbers( R );
    
    R!.MapleHomalgOptions :=
      [ "`Involutive/InvolutiveOptions`",
        homalgSendBlocking( [ "`Involutive/InvolutiveOptions`(\"get\")" ], R, "initialize" )
                ];
    
    RP := homalgTable( R );
    
    RP!.Sum :=
      function( a, b )
        
        return homalgSendBlocking( [ a, "+(", b, ")" ], "Sum" );
        
      end;
    
    RP!.Product :=
      function( a, b )
        
        return homalgSendBlocking( [ "(", a, ")*(", b, ")" ], "Product" );
        
      end;
    
    return R;
    
end );

##
InstallGlobalFunction( RingForHomalgInMapleUsingJanet,
  function( arg )
    local nargs, stream, o, display_color, homalg_version, package_version,
          var, ar, ext_obj, R, RP_BestBasis, RP;
    
    nargs := Length( arg );
    
    if nargs > 1 then
        if IsRecord( arg[nargs] ) and IsBound( arg[nargs].lines ) and IsBound( arg[nargs].pid ) then
            stream := arg[nargs];
        elif IshomalgExternalObjectRep( arg[nargs] ) or IsHomalgExternalRingRep( arg[nargs] ) then
            stream := homalgStream( arg[nargs] );
        fi;
    fi;
    
    if not IsBound( stream ) then
        stream := LaunchCAS( "HOMALG_IO_Maple" );
        if not IsBound( stream.path_to_maple_packages ) then ## each component in HOMALG_IO_Maple is now in the stream
            stream.path_to_maple_packages := Concatenation( PackageInfo( "RingsForHomalg" )[1].InstallationPath, "/maple" );
        fi;
        homalgSendBlocking( [ "libname := \"", stream.path_to_maple_packages, "\",libname" ], "need_command", stream, "initialize" );
        o := 0;
    else
        o := 1;
    fi;
    
    homalgSendBlocking( "with(Janet)", "need_command", stream, "initialize" );
    
    if ( not ( IsBound( HOMALG_IO.show_banners ) and HOMALG_IO.show_banners = false )
         and not ( IsBound( HOMALG_IO.show_maple_package_banner ) and HOMALG_IO.show_maple_package_banner = false )
         and not ( IsBound( stream.show_banner ) and stream.show_banner = false ) )
         and not ( IsBound( stream.show_banner_Janet ) and stream.show_banner_Janet = false ) then
        
        if IsBound( stream.color_display ) then
            display_color := stream.color_display;
        else
            display_color := "";
        fi;
        
        homalg_version := homalgSendBlocking("\`homalg/version\`", "need_output", stream, "initialize" ){[ 3 .. 8 ]};
        package_version := homalgSendBlocking("\`Janet/version\`", "need_output", stream, "initialize" );
        
        Print( "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n" );
        
        ## leave the below indentation untouched!
        Print( display_color, "\
     Janet - Maple package loaded (version: ", package_version, ")\n\
     Copyright (C) (2000-2009) Carlos F. Cid and Daniel Robertz\n\
     Lehrstuhl B fuer Mathematik, RWTH Aachen, Germany\n\
     (will be used as a ring package via Maple's homalg (ver: ", homalg_version, "))\033[0m\n\
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n" );
        
        stream.show_banner_Janet := false;
        
    fi;
    
    if IsString( arg[1] ) then
        var := arg[1];
    else
        var := Flat( [ "[", JoinStringsWithSeparator( arg[1] ), "]" ] );
    fi;
    
    ar := [ [ var, ",", "copy(`Janet/homalg`)" ], TheTypeHomalgExternalRingObjectInMapleUsingJanet, stream, "CreateHomalgRing" ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( homalgSendBlocking, ar );
    
    R := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInMaple );
    
    homalgSendBlocking( [ "`homalg/homalg_options`(", R, "[-1])" ], "need_command", "initialize" );
    
    _MapleHomalg_SetRing( R );
    
    LetWeakPointerListOnExternalObjectsContainRingCreationNumbers( R );
    
    R!.MapleHomalgOptions :=
      [ "`Janet/JanetOptions`",
        homalgSendBlocking( [ "`Janet/JanetOptions`(\"get\")" ], R, "initialize" )
                ];
    
    if IsBound( HOMALG_IO_Maple.UseJacobsonNormalForm ) and
       HOMALG_IO_Maple.UseJacobsonNormalForm = true and
       homalgSendBlocking( [ "nops(", R, "[1])" ], "need_output" ) = "1" then
        homalgSendBlocking( [ R, "[-1][BestBasis]:=`Janet1/homalg`[BestBasis]" ], "need_command", "initialize" );
        RP := homalgTable( R );
        RP_BestBasis := ShallowCopy( CommonHomalgTableForMapleHomalgBestBasis );
        Perform( NamesOfComponents( RP_BestBasis ),
                function( component ) RP!.(component) := RP_BestBasis.(component); end );
    fi;
    
    SetIsLocalizedWeylRing( R, true );
    
    SetRingProperties( R, var );
    
    return R;
    
end );

##
InstallGlobalFunction( RingForHomalgInMapleUsingJanetOre,
  function( arg )
    local nargs, stream, o, display_color, homalg_version, package_version,
          ar, ext_obj, R, RP;
    
    nargs := Length( arg );
    
    if nargs > 1 then
        if IsRecord( arg[nargs] ) and IsBound( arg[nargs].lines ) and IsBound( arg[nargs].pid ) then
            stream := arg[nargs];
        elif IshomalgExternalObjectRep( arg[nargs] ) or IsHomalgExternalRingRep( arg[nargs] ) then
            stream := homalgStream( arg[nargs] );
        fi;
    fi;
    
    if not IsBound( stream ) then
        stream := LaunchCAS( "HOMALG_IO_Maple" );
        if not IsBound( stream.path_to_maple_packages ) then ## each component in HOMALG_IO_Maple is now in the stream
            stream.path_to_maple_packages := Concatenation( PackageInfo( "RingsForHomalg" )[1].InstallationPath, "/maple" );
        fi;
        homalgSendBlocking( [ "libname := \"", stream.path_to_maple_packages, "\",libname" ], "need_command", stream, "initialize" );
        o := 0;
    else
        o := 1;
    fi;
    
    homalgSendBlocking( "with(JanetOre)", "need_command", stream, "initialize" );
    
    if ( not ( IsBound( HOMALG_IO.show_banners ) and HOMALG_IO.show_banners = false )
         and not ( IsBound( HOMALG_IO.show_maple_package_banner ) and HOMALG_IO.show_maple_package_banner = false )
         and not ( IsBound( stream.show_banner ) and stream.show_banner = false ) )
         and not ( IsBound( stream.show_banner_JanetOre ) and stream.show_banner_JanetOre = false ) then
        
        if IsBound( stream.color_display ) then
            display_color := stream.color_display;
        else
            display_color := "";
        fi;
        
        homalg_version := homalgSendBlocking("\`homalg/version\`", "need_output", stream, "initialize" ){[ 3 .. 8 ]};
        package_version := homalgSendBlocking("\`JanetOre/version\`", "need_output", stream, "initialize" );
        
        Print( "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n" );
        
        ## leave the below indentation untouched!
        Print( display_color, "\
     JanetOre - Maple package loaded (version: ", package_version, ")\n\
     Copyright (C) (2003-2009) Daniel Robertz\n\
     Lehrstuhl B fuer Mathematik, RWTH Aachen, Germany\n\
     (will be used as a ring package via Maple's homalg (ver: ", homalg_version, "))\033[0m\n\
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n" );
        
        stream.show_banner_JanetOre := false;
        
    fi;
    
    ar := [ [ arg[1], ",", "copy(`JanetOre/homalg`)" ], TheTypeHomalgExternalRingObjectInMapleUsingJanetOre, stream, "CreateHomalgRing" ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( homalgSendBlocking, ar );
    
    R := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInMaple );
    
    homalgSendBlocking( [ "`homalg/homalg_options`(", R, "[-1])" ], "need_command", "initialize" );
    
    _MapleHomalg_SetRing( R );
    
    LetWeakPointerListOnExternalObjectsContainRingCreationNumbers( R );
    
    R!.MapleHomalgOptions :=
      [ "`JanetOre/JanetOreOptions`",
        homalgSendBlocking( [ "`JanetOre/JanetOreOptions`(\"get\")" ], R, "initialize" )
                ];
    
    RP := homalgTable( R );
    
    RP!.Sum :=
      function( a, b )
        
        return homalgSendBlocking( [ a, "+(", b, ")" ], "Sum" );
        
      end;
    
    return R;
    
end );

##
InstallGlobalFunction( RingForHomalgInMapleUsingOreModules,
  function( arg )
    local nargs, stream, o, display_color, homalg_version, package_version,
          ar, ext_obj, R, RP;
    
    nargs := Length( arg );
    
    if nargs > 1 then
        if IsRecord( arg[nargs] ) and IsBound( arg[nargs].lines ) and IsBound( arg[nargs].pid ) then
            stream := arg[nargs];
        elif IshomalgExternalObjectRep( arg[nargs] ) or IsHomalgExternalRingRep( arg[nargs] ) then
            stream := homalgStream( arg[nargs] );
        fi;
    fi;
    
    if not IsBound( stream ) then
        stream := LaunchCAS( "HOMALG_IO_Maple" );
        if not IsBound( stream.path_to_maple_packages ) then ## each component in HOMALG_IO_Maple is now in the stream
            stream.path_to_maple_packages := Concatenation( PackageInfo( "RingsForHomalg" )[1].InstallationPath, "/maple" );
        fi;
        homalgSendBlocking( [ "libname := \"", stream.path_to_maple_packages, "\",libname" ], "need_command", stream, "initialize" );
        o := 0;
    else
        o := 1;
    fi;
    
    homalgSendBlocking( "with(OreModules)", "need_command", stream, "initialize" );
    
    if ( not ( IsBound( HOMALG_IO.show_banners ) and HOMALG_IO.show_banners = false )
         and not ( IsBound( HOMALG_IO.show_maple_package_banner ) and HOMALG_IO.show_maple_package_banner = false )
         and not ( IsBound( stream.show_banner ) and stream.show_banner = false ) )
         and not ( IsBound( stream.show_banner_OreModules ) and stream.show_banner_OreModules = false ) then
        
        if IsBound( stream.color_display ) then
            display_color := stream.color_display;
        else
            display_color := "";
        fi;
        
        homalg_version := homalgSendBlocking("\`homalg/version\`", "need_output", stream, "initialize" ){[ 3 .. 8 ]};
        package_version := homalgSendBlocking("\`OreModules/version\`", "need_output", stream, "initialize" );
        
        Print( "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n" );
        
        ## leave the below indentation untouched!
        Print( display_color, "\
     OreModules - Maple package loaded (version: ", package_version, ")\n\
     F. Chyzak, A. Quadrat, D. Robertz\033[0m\n\
     (will be used as a ring package via Maple's homalg (ver: ", homalg_version, "))\033[0m\n\
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n" );
        
        stream.show_banner_OreModules := false;
        
    fi;
    
    ar := [ [ arg[1], ",", "copy(`OreModules/homalg`)" ], TheTypeHomalgExternalRingObjectInMapleUsingOreModules, stream, "CreateHomalgRing" ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( homalgSendBlocking, ar );
    
    R := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInMaple );
    
    homalgSendBlocking( [ "`homalg/homalg_options`(", R, "[-1])" ], "need_command", "initialize" );
    
    _MapleHomalg_SetRing( R );
    
    LetWeakPointerListOnExternalObjectsContainRingCreationNumbers( R );
    
    RP := homalgTable( R );
    
    RP!.Sum :=
      function( a, b )
        
        return homalgSendBlocking( [ a, "+(", b, ")" ], "Sum" );
        
      end;
    
    return R;
    
end );

##
InstallGlobalFunction( HomalgRingOfIntegersInMaple,
  function( arg )
    local nargs, c, d, param, minimal_polynomial, R, name;
    
    nargs := Length( arg );
    
    if nargs > 0 and IsInt( arg[1] ) and arg[1] <> 0 then
        ## characteristic:
        c := AbsInt( arg[1] );
        arg := arg{[ 2 .. nargs ]};
        if nargs > 1 and IsPosInt( arg[1] ) then
            d := arg[1];
            if d > 1 then
                param := Concatenation( "Z", String( c ), "_", String( d ) );
                minimal_polynomial := UnivariatePolynomial( ConwayPol( c, d ), param );
                arg := Concatenation( [ c ], arg{[ 2 .. nargs - 1 ]} );
                R := CallFuncList( RingForHomalgInMapleUsingPIR, arg );
                SetIsFieldForHomalg( R, true );
                SetRingProperties( R, c, d );
                R!.NameOfPrimitiveElement := param;
                name := homalgSendBlocking( [ "convert(", minimal_polynomial, ",symbol)" ], "need_output", R, "homalgSetName" );
                R!.MinimalPolynomialOfPrimitiveElement := name;
                SetName( R, Concatenation( "GF(", String( c ), "^", String( d ), ")" ) );
                return R;
            fi;
            arg := arg{[ 2 .. Length( arg ) ]};
        fi;
        if IsPrime( c ) then
            R := [ c ];
        else
            R := [ [ ], [ c ] ];
        fi;
    else
        ## characteristic:
        c := 0;
        if nargs > 0 and arg[1] = 0 then
            arg := arg{[ 2 .. nargs ]};
        fi;
        R := [ ];
    fi;
    
    R := Concatenation( [ R, IsPrincipalIdealRing ], arg );
    
    R := CallFuncList( RingForHomalgInMapleUsingPIR, R );
    
    SetIsResidueClassRingOfTheIntegers( R, true );
    
    SetRingProperties( R, c );
    
    return R;
    
end );

##
InstallMethod( HomalgRingOfIntegersInUnderlyingCAS,
        "for an integer and homalg ring in Maple",
        [ IsInt, IsHomalgExternalRingInMapleRep ],
        
  HomalgRingOfIntegersInMaple );

##
InstallGlobalFunction( HomalgFieldOfRationalsInMaple,
  function( arg )
    local nargs, param, Q, R;
    
    nargs := Length( arg );
    
    if nargs > 0 and IsString( arg[1] ) then
        
        param := ParseListOfIndeterminates( SplitString( arg[1], "," ) );
        
        arg := arg{[ 2 .. nargs ]};
        
        Q := CallFuncList( HomalgFieldOfRationalsInMaple, arg );
        
        SetRingProperties( Q, 0 );
        
    fi;
    
    R := "[0]";
        
    R := Concatenation( [ R ], arg );
    
    if IsBound( Q ) then
        ## R will be defined in the same instance of Maple as Q
        Add( R, Q );
    fi;
    
    R := CallFuncList( RingForHomalgInMapleUsingPIR, R );
    
    if IsBound( param ) then
        
        R!.AssociatedPolynomialRing := Q * param;
        
        param := List( param, function( a ) local r; r := HomalgExternalRingElement( a, R ); SetName( r, a ); return r; end );
        
        SetRationalParameters( R, param );
        
        SetIsFieldForHomalg( R, true );
        
        SetCoefficientsRing( R, Q );
        
    else
        
        SetIsRationalsForHomalg( R, true );
        
    fi;
    
    SetRingProperties( R, 0 );
    
    return R;
    
end );

##
InstallMethod( HomalgFieldOfRationalsInUnderlyingCAS,
        "for a homalg ring in Maple",
        [ IsHomalgExternalRingInMapleRep ],
        
  HomalgFieldOfRationalsInMaple );

##
InstallMethod( FieldOfFractions,
        "for homalg rings in Maple",
        [ IsHomalgExternalRingInMapleRep and IsIntegersForHomalg ],
        
  function( zz )
    
    return HomalgFieldOfRationalsInMaple( zz );
    
end );

##
InstallMethod( PolynomialRing,
        "for homalg rings in Maple",
        [ IsHomalgExternalRingInMapleRep, IsList ],
        
  function( R, indets )
    local ar, r, var, nr_var, properties, param, c, stream, show_banner, S, l, RP;
    
    ar := _PrepareInputForPolynomialRing( R, indets );
    
    r := ar[1];
    var := ar[2];    ## all indeterminates, relative and base
    nr_var := ar[3]; ## the number of relative indeterminates
    properties := ar[4];
    param := ar[5];
    
    c := Characteristic( R );
    
    if Length( var ) = 1 and HasIsFieldForHomalg( R ) and IsFieldForHomalg( R ) then
        stream := homalgStream( R );
        if IsBound( stream.show_banner ) then
            show_banner := stream.show_banner;
        fi;
        stream.show_banner := false;
        
        S := RingForHomalgInMapleUsingPIR( Flat( [ "[", Flat( var ), ",", String( c ), "]" ] ), R );
        
        if IsBound( show_banner ) then
            stream.show_banner := show_banner;
        else
            Unbind( stream.show_banner );
        fi;
    else
        if HasIndeterminatesOfPolynomialRing( R ) then
            r := CoefficientsRing( R );
        fi;
        
        S := RingForHomalgInMapleUsingInvolutive( var, R );
        
        if c > 0 then
            if IsPrime( c ) then
                homalgSendBlocking( [ "`Involutive/InvolutiveOptions`(\"char\",", c, ")" ], "need_command", R, "initialize" );
            else
                Error( "the coefficient ring Z/", c, "Z (", c, " non-prime) is not directly supported by Involutive yet\nYou can use the generic residue class ring constructor '/' provided by homalg after defining the ambient ring over the integers\nfor help type: ?homalg: constructor for residue class rings\n" );
            fi;
        elif HasIsIntegersForHomalg( r ) and IsIntegersForHomalg( r ) then
            homalgSendBlocking( [ "`Involutive/InvolutiveOptions`(\"rational\",false)" ], "need_command", R, "initialize" );
        fi;
        
        ## we need to save the global options again after setting some of them
        S!.MapleHomalgOptions :=
          [ "`Involutive/InvolutiveOptions`",
            homalgSendBlocking( [ "`Involutive/InvolutiveOptions`(\"get\")" ], R, "initialize" )
                    ];
        
    fi;
    
    var := List( var, a -> HomalgExternalRingElement( a, S ) );
    
    l := Length( var );
    
    Perform( var, Name );
    
    SetIsFreePolynomialRing( S, true );
    
    if HasIndeterminatesOfPolynomialRing( R ) and IndeterminatesOfPolynomialRing( R ) <> [ ] then
        SetBaseRing( S, R );
        SetRelativeIndeterminatesOfPolynomialRing( S, var{[ l - nr_var + 1 .. l ]} );
    fi;
    
    if IsBound( R!.AssociatedPolynomialRing ) then
        S!.AssociatedPolynomialRing := R!.AssociatedPolynomialRing * List( var{[ l - nr_var + 1 .. l ]}, Name );
    fi;
    
    SetRingProperties( S, r, var );
    
    _MapleHomalg_SetRing( S );
    
    RP := homalgTable( S );
    
    RP!.RingName := CommonHomalgTableForRings!.RingName;
    
    return S;
    
end );

##
InstallMethod( RingOfDerivations,
        "for homalg rings in Maple",
        [ IsHomalgExternalRingInMapleRep, IsList ],
        
  function( R, indets )
    local var, nr_var, der, nr_der, properties, stream, ar, r, c, S, RP;
    
    #check whether base ring is polynomial and then extract needed data
    if HasIndeterminatesOfPolynomialRing( R ) and IsCommutative( R ) then
        var := IndeterminatesOfPolynomialRing( R );
        nr_var := Length( var );
    else
        Error( "base ring is not a polynomial ring" );
    fi;
    
    ##compute the new indeterminates (the derivatives) for the ring and save them in der
    if IsString( indets ) and indets <> "" then
        der := SplitString( indets, "," );
    elif indets <> [ ] and ForAll( indets, i -> IsString( i ) and i <> "" ) then
        der := indets;
    else
        Error( "either a non-empty list of indeterminates or a comma separated string of them must be provided as the second argument\n" );
    fi;
    
    nr_der := Length( der );
    
    if not(nr_var=nr_der) then
        Error( "number of indeterminates in base ring does not equal the number of given derivations" );
    fi;
    
    if Intersection2( der , var ) <> [ ] then
        Error( "the following indeterminates are already elements of the base ring: ", Intersection2( der , var ), "\n" );
    fi;
    
    properties := [ ];
    
    stream := homalgStream( R );
    
    ar := JoinStringsWithSeparator( Concatenation( der, List( var, Name ) ) );
    ar := Concatenation( "[ [ ", ar, " ], [ ], [ " );
    ar := Concatenation( ar, JoinStringsWithSeparator( List( [ 1 .. nr_var ], i -> Concatenation( "weyl(", der[i], ",", Name( var[i] ), ")" ) ) ), " ] ]" );
    
    c := Characteristic( R );
    
    r := R;
    
    if HasIndeterminatesOfPolynomialRing( R ) then
        r := CoefficientsRing( R );
    fi;
    
    S := RingForHomalgInMapleUsingJanetOre( ar, stream );
    
    if c > 0 then
        if IsPrime( c ) then
            homalgSendBlocking( [ "`JanetOre/JanetOreOptions`(\"char\",", c, ")" ], "need_command", R, "initialize" );
        else
            Error( "the coefficient ring Z/", c, "Z (", c, " non-prime) is not directly supported by JanetOre yet\nYou can use the generic residue class ring constructor '/' provided by homalg after defining the ambient ring over the integers\nfor help type: ?homalg: constructor for residue class rings\n" );
        fi;
    elif HasIsIntegersForHomalg( r ) and IsIntegersForHomalg( r ) then
        homalgSendBlocking( [ "`JanetOre/JanetOreOptions`(\"rational\",false)" ], "need_command", R, "initialize" );
    fi;
    
    ## we need to save the global options again after setting some of them
    S!.MapleHomalgOptions :=
      [ "`JanetOre/JanetOreOptions`",
        homalgSendBlocking( [ "`JanetOre/JanetOreOptions`(\"get\")" ], R, "initialize" )
                ];
    
    der := List( der , a -> HomalgExternalRingElement( a, S ) );
    
    Perform( der, Name );
    
    SetIsWeylRing( S, true );
    
    SetBaseRing( S, R );
    
    SetRingProperties( S, R, der );
    
    _MapleHomalg_SetRing( S );
    
    RP := homalgTable( S );
    
    RP!.RingName := CommonHomalgTableForRings!.RingName;
    
    return S;
    
end );

##
InstallMethod( ExteriorRing,
        "for homalg rings in Maple",
        [ IsHomalgExternalRingInMapleRep, IsHomalgExternalRingInMapleRep, IsHomalgExternalRingInMapleRep, IsList ],
        
  function( R, Coeff, Base, indets )
    local ar, var, anti, comm, stream, S, RP;
    
    ar := _PrepareInputForExteriorRing( R, Base, indets );
    
    var := ar[3];
    anti := ar[4];
    comm := ar[5];
    
    stream := homalgStream( R );
    
    ar := JoinStringsWithSeparator( Concatenation( comm, anti ) );
    ar := Concatenation( "[ [ ", ar, " ], [ ], [ " );
    ar := Concatenation( ar, Concatenation( "exterior(", JoinStringsWithSeparator( anti ), ")" ), " ] ]" );
    
    S := RingForHomalgInMapleUsingJanetOre( ar, stream );
    
    anti := List( anti , a -> HomalgExternalRingElement( a, S ) );
    
    Perform( anti, Name );
    
    comm := List( comm , a -> HomalgExternalRingElement( a, S ) );
    
    Perform( comm, Name );
    
    SetIsExteriorRing( S, true );
    
    SetBaseRing( S, Base );
    
    SetRingProperties( S, R, anti );
    
    _MapleHomalg_SetRing( S );
    
    RP := homalgTable( S );
    
    RP!.RingName := CommonHomalgTableForRings!.RingName;
    
    return S;
    
end );

##
InstallMethod( RationalShiftAlgebra,
        "for homalg rings in Singular",
        [ IsHomalgExternalRingInMapleRep, IsList ],
        
  function( R, indets )
    local ar, r, var, shift, param, base, stream, display_color, switch, ext_obj,
          alg, b, n, steps, d, Y, RP, Ds, S, B, T;
    
    ar := _PrepareInputForShiftAlgebra( R, indets );
    
    r := ar[1];
    var := ar[2];
    shift := ar[3];
    param := ar[4];
    base := ar[5];
    
    stream := homalgStream( R );
    
    switch := ValueOption( "switch" );
    
    b := Length( base );
    
    n := Length( shift );
    
    steps := ValueOption( "steps" );
    
    if IsRat( steps ) then
        steps := ListWithIdenticalEntries( n, steps );
    elif not ( IsList( steps ) and Length( steps ) = n and ForAll( steps, IsRat ) ) then
        steps := ListWithIdenticalEntries( n, 1 );
    fi;
    
    Ds := shift;
    
    if IsIdenticalObj( switch, true ) then
        
        Error( "not supported in Maple\n" );
        
    else
        
        if HasIsIntegersForHomalg( r ) and IsIntegersForHomalg( r ) then
            
            Error( "not supported in Maple\n" );
            
        else
            
            ext_obj := ListN( Ds, var, {a,c} -> [ a, c ] );

            if Set( steps ) = [ 1 ] then
                ext_obj := List( ext_obj, a -> Concatenation( "`shift`=[", JoinStringsWithSeparator( a ), "], " ) );
            elif Set( steps ) = [ -1 ] then
                ext_obj := List( ext_obj, a -> Concatenation( "`dual_shift`=[", JoinStringsWithSeparator( a ), "], " ) );
            else
                Error( "these steps = ", steps, " are not yet supported\n" );
            fi;
            
            ext_obj := Concatenation( ext_obj );
            ext_obj := Concatenation( ext_obj, "characteristic=", String( Characteristic( R ) ), ", comm=[", JoinStringsWithSeparator( base ), "]" );
            
            if base <> "" then
                
            else
                
            fi;
            
        fi;
        
    fi;
    
    ext_obj := Concatenation( [ "`OreModules/DefineOreAlgebra`(", ext_obj, ")" ] );
    
    ext_obj := homalgSendBlocking( [ ext_obj ], R, "initialize" );
    
    homalgSendBlocking( [ ext_obj, "[4] := [", JoinStringsWithSeparator( Ds ), "]" ], "need_command", "initialize" );
    
    ## as we are not yet done we cannot call CreateHomalgExternalRing
    ## to create a HomalgRing, and only then would homalgSendBlocking call stream.setring,
    ## so till then we have to prevent the garbage collector from stepping in
    stream.DeletePeriod_save := stream.DeletePeriod;
    stream.DeletePeriod := false;
    
    Y := RingForHomalgInMapleUsingOreModules( ext_obj, R );
    
    SetName( Y,
            Concatenation(
                    Concatenation( RingName( r ), "(", JoinStringsWithSeparator( base ), ")(", JoinStringsWithSeparator( var ), ")" ),
                    "<", JoinStringsWithSeparator( shift ), ">" ) );
    
    ## now it is safe to call the garbage collector
    stream.DeletePeriod := stream.DeletePeriod_save;
    Unbind( stream.DeletePeriod_save );
    
    var := List( var , a -> HomalgExternalRingElement( a, Y ) );
    
    Perform( var, Name );
    
    shift := List( shift , a -> HomalgExternalRingElement( a, Y ) );
    
    Perform( shift, Name );
    
    SetIsRationalShiftAlgebra( Y, true );
    
    SetBaseRing( Y, R );
    
    SetRingProperties( Y, R, shift );
    
    RP := homalgTable( Y );
    
    if not ( HasIsFieldForHomalg( r ) and IsFieldForHomalg( r ) ) then
        Unbind( RP!.IsUnit );
        Unbind( RP!.GetColumnIndependentUnitPositions );
        Unbind( RP!.GetRowIndependentUnitPositions );
        Unbind( RP!.GetUnitPosition );
    fi;
    
    if HasIsIntegersForHomalg( r ) and IsIntegersForHomalg( r ) then
        RP!.IsUnit := RP!.IsUnit_Z;
        RP!.GetColumnIndependentUnitPositions := RP!.GetColumnIndependentUnitPositions_Z;
        RP!.GetRowIndependentUnitPositions := RP!.GetRowIndependentUnitPositions_Z;
        RP!.GetUnitPosition := RP!.GetUnitPosition_Z;
        RP!.PrimaryDecomposition := RP!.PrimaryDecomposition_Z;
        RP!.RadicalSubobject := RP!.RadicalSubobject_Z;
        RP!.RadicalDecomposition := RP!.RadicalDecomposition_Z;
        Unbind( RP!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries );
        Unbind( RP!.MaximalDegreePart );
    fi;
    
    shift := List( shift, String );
    
    ## the "commutative" shift algebra
    S := R * shift;
    
    ## does not reduce elements instantaneously
    ## S := HomalgQRingInSingular( AmbientRing( S ), RingRelations( S ) );
    
    Y!.CommutativeShiftAlgebra := S;
    
    ## the Laurent algebra
    B := BaseRing( R );
    
    T := B * shift;
    
    Y!.LaurentAlgebra := T;
    
    #if not IsIdenticalObj( switch, true ) then
    #    P!.SwitchedPseudoShiftAlgebra := PseudoShiftAlgebra( R, indets : switch := true );
    #fi;
    
    return Y;
    
end );

##
InstallMethod( RationalPseudoDoubleShiftAlgebra,
        "for homalg rings in Singular",
        [ IsHomalgExternalRingInMapleRep, IsList ],
        
  function( R, indets )
    local ar, r, var, shift, param, base, stream, display_color, switch, ext_obj,
          alg, b, n, steps, pairs, d, P, RP, Ds, D_s, S, B, T, Y;
    
    ar := _PrepareInputForPseudoDoubleShiftAlgebra( R, indets );
    
    r := ar[1];
    var := ar[2];
    shift := ar[3];
    param := ar[4];
    base := ar[5];
    
    stream := homalgStream( R );
    
    switch := ValueOption( "switch" );
    
    b := Length( base );
    
    n := Length( shift ) / 2;
    
    steps := ValueOption( "steps" );
    
    if IsRat( steps ) then
        steps := ListWithIdenticalEntries( n, steps );
    elif not ( IsList( steps ) and Length( steps ) = n and ForAll( steps, IsRat ) ) then
        steps := ListWithIdenticalEntries( n, 1 );
    fi;
    
    pairs := ValueOption( "pairs" );
    
    if IsIdenticalObj( pairs, true ) then
        Ds := shift{List( [ 1 .. n ], i -> 2 * i - 1 )};
        D_s := shift{List( [ 1 .. n ], i -> 2 * i )};
    else
        Ds := shift{[ 1 .. n ]};
        D_s := shift{[ n + 1 .. 2 * n ]};
    fi;
    
    if IsIdenticalObj( switch, true ) then
        
        Error( "not supported in Maple\n" );
        
    else
        
        if HasIsIntegersForHomalg( r ) and IsIntegersForHomalg( r ) then
            
            Error( "not supported in Maple\n" );
            
        else
            
            if Set( steps ) = [ 1 ] then
                ext_obj := ListN( Ds, D_s, var, {a,b,c} -> [ a, b, c ] );
            elif Set( steps ) = [ -1 ] then
                ext_obj := ListN( Ds, D_s, var, {a,b,c} -> [ b, a, c ] );
            else
                Error( "these steps = ", steps, " are not yet supported\n" );
            fi;
            
            ext_obj := List( ext_obj, a -> Concatenation( "`shift+dual_shift`=[", JoinStringsWithSeparator( a ), "], " ) );
            ext_obj := Concatenation( ext_obj );
            ext_obj := Concatenation( ext_obj, "characteristic=", String( Characteristic( R ) ), ", comm=[", JoinStringsWithSeparator( base ), "]" );
            
            if base <> "" then
                
            else
                
            fi;
            
        fi;
        
    fi;
    
    ext_obj := Concatenation( [ "`OreModules/DefineOreAlgebra`(", ext_obj, ")" ] );
    
    ext_obj := homalgSendBlocking( [ ext_obj ], R, "initialize" );
    
    homalgSendBlocking( [ ext_obj, "[4] := [", JoinStringsWithSeparator( Concatenation( D_s, Ds ) ), "]" ], "need_command", "initialize" );
    
    ## as we are not yet done we cannot call CreateHomalgExternalRing
    ## to create a HomalgRing, and only then would homalgSendBlocking call stream.setring,
    ## so till then we have to prevent the garbage collector from stepping in
    stream.DeletePeriod_save := stream.DeletePeriod;
    stream.DeletePeriod := false;
    
    P := RingForHomalgInMapleUsingOreModules( ext_obj, R );
    
    SetName( P,
            Concatenation(
                    Concatenation( RingName( r ), "(", JoinStringsWithSeparator( base ), ")(", JoinStringsWithSeparator( var ), ")" ),
                    "<", JoinStringsWithSeparator( shift ), ">" ) );
    
    ## now it is safe to call the garbage collector
    stream.DeletePeriod := stream.DeletePeriod_save;
    Unbind( stream.DeletePeriod_save );
    
    var := List( var , a -> HomalgExternalRingElement( a, P ) );
    
    Perform( var, Name );
    
    shift := List( shift , a -> HomalgExternalRingElement( a, P ) );
    
    Perform( shift, Name );
    
    SetIsRationalPseudoDoubleShiftAlgebra( P, true );
    
    SetBaseRing( P, R );
    
    SetRingProperties( P, R, shift );
    
    RP := homalgTable( P );
    
    if not ( HasIsFieldForHomalg( r ) and IsFieldForHomalg( r ) ) then
        Unbind( RP!.IsUnit );
        Unbind( RP!.GetColumnIndependentUnitPositions );
        Unbind( RP!.GetRowIndependentUnitPositions );
        Unbind( RP!.GetUnitPosition );
    fi;
    
    if HasIsIntegersForHomalg( r ) and IsIntegersForHomalg( r ) then
        RP!.IsUnit := RP!.IsUnit_Z;
        RP!.GetColumnIndependentUnitPositions := RP!.GetColumnIndependentUnitPositions_Z;
        RP!.GetRowIndependentUnitPositions := RP!.GetRowIndependentUnitPositions_Z;
        RP!.GetUnitPosition := RP!.GetUnitPosition_Z;
        RP!.PrimaryDecomposition := RP!.PrimaryDecomposition_Z;
        RP!.RadicalSubobject := RP!.RadicalSubobject_Z;
        RP!.RadicalDecomposition := RP!.RadicalDecomposition_Z;
        Unbind( RP!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries );
        Unbind( RP!.MaximalDegreePart );
    fi;
    
    shift := List( shift, String );
    
    ## the "commutative" double-shift algebra
    S := R * shift;
    
    ## does not reduce elements instantaneously
    ## S := HomalgQRingInSingular( AmbientRing( S ), RingRelations( S ) );
    
    P!.CommutativeDoubleShiftAlgebra := S / ListN( Ds, D_s, {d, d_} -> ( d / S ) * ( d_ / S ) - 1 );
    
    ## the Laurent algebra
    B := BaseRing( R );
    
    T := B * shift;
    
    P!.LaurentAlgebra := T / ListN( Ds, D_s, {d, d_} -> ( d / T ) * ( d_ / T ) - 1 );
    
    ## the double-shift algebra
    Y := P / ListN( Ds, D_s, {d, d_} -> ( d / P ) * ( d_ / P ) - 1 );
    
    Y!.CommutativeDoubleShiftAlgebra := P!.CommutativeDoubleShiftAlgebra;
    Y!.LaurentAlgebra := P!.LaurentAlgebra;
    
    SetBaseRing( Y, BaseRing( P ) );
    
    SetParametersOfRationalDoubleShiftAlgebra( Y,
            List( ParametersOfRationalPseudoDoubleShiftAlgebra( P ), d -> d / Y ) );
    
    if HasRelativeParametersOfRationalPseudoDoubleShiftAlgebra( P ) then
        
        SetRelativeParametersOfRationalDoubleShiftAlgebra( Y,
                List( RelativeParametersOfRationalPseudoDoubleShiftAlgebra( P ), d -> d / Y ) );
    fi;
    
    SetIndeterminateShiftsOfRationalDoubleShiftAlgebra( Y,
            List( IndeterminateShiftsOfRationalPseudoDoubleShiftAlgebra( P ), d -> d / Y ) );
    
    P!.RationalDoubleShiftAlgebra := Y;
    
    #if not IsIdenticalObj( switch, true ) then
    #    P!.SwitchedPseudoDoubleShiftAlgebra := PseudoDoubleShiftAlgebra( R, indets : switch := true );
    #fi;
    
    return P;
    
end );

##
InstallMethod( RationalDoubleShiftAlgebra,
        "for homalg rings in Maple",
        [ IsHomalgExternalRingInMapleRep, IsList ],
        
  function( R, indets )
    local P;
    
    P := RationalPseudoDoubleShiftAlgebra( R, indets );
    
    return P!.RationalDoubleShiftAlgebra;
    
end );

##
InstallGlobalFunction( MapleHomalgOptions,
  function( arg )
    local nargs, R, s, ar;
    
    nargs := Length( arg );
    
    R := arg[nargs];
    
    if not IsHomalgExternalRingInMapleRep( R ) then
        Error( "the last argument must be an external ring residing in Maple\n" );
    fi;
    
    s := "";
    
    for ar in arg{[ 1 .. nargs-1 ]} do
        if IsString( ar ) then
            s := Concatenation( s, ar, "," );
        elif IsList( ar ) and Length( ar ) = 2 and ForAll( ar, IsString ) then
            s := Concatenation( s, "\"", ar[1], "\"=", ar[2] , "," );
        else
            Error( "wrong argument: ", ar, "\n" );
        fi;
    od;
    
    Print( homalgSendBlocking( [ "`homalg/homalg_options`(", s, R, "[-1])" ], "need_display", "initialize" ) );
    
end );

##
InstallMethod( AddRationalParameters,
        "for Maple rings",
        [ IsHomalgExternalRingInMapleRep and IsFieldForHomalg, IsList ],
        
  function( R, param )
    local c, par;
    
    if IsString( param ) then
        param := [ param ];
    fi;
    
    param := List( param, String );
    
    c := Characteristic( R );
    
    if HasRationalParameters( R ) then
        par := RationalParameters( R );
        par := List( par, String );
    else
        par := [ ];
    fi;
    
    par := Concatenation( par, param );
    par := JoinStringsWithSeparator( par );
    
    ## TODO: take care of the rest
    if c = 0 then
        return HomalgFieldOfRationalsInMaple( par, R );
    fi;
    
    return HomalgRingOfIntegersInMaple( c, par, R );
    
end );

##
InstallMethod( AddRationalParameters,
        "for Maple rings",
        [ IsHomalgExternalRingInMapleRep and IsFreePolynomialRing, IsList ],
        
  function( R, param )
    local c, par, indets, r;
    
    if IsString( param ) then
        param := [ param ];
    fi;
    
    param := List( param, String );
    
    c := Characteristic( R );
    
    if HasRationalParameters( R ) then
        par := RationalParameters( R );
        par := List( par, String );
    else
        par := [ ];
    fi;
    
    par := Concatenation( par, param );
    par := JoinStringsWithSeparator( par );
    
    indets := Indeterminates( R );
    indets := List( indets, String );
    
    r := CoefficientsRing( R );
    
    if not IsFieldForHomalg( r ) then
        Error( "the coefficients ring is not a field\n" );
    fi;
    
    ## TODO: take care of the rest
    if c = 0 then
        return HomalgFieldOfRationalsInMaple( par, r ) * indets;
    fi;
    
    return HomalgRingOfIntegersInMaple( c, par, r ) * indets;
    
end );

##
InstallMethod( SetMatElm,
        "for homalg external matrices in Maple",
        [ IsHomalgExternalMatrixRep and IsMutable, IsPosInt, IsPosInt, IsString, IsHomalgExternalRingInMapleRep ],
        
  function( M, r, c, s, R )
    
    homalgSendBlocking( [ M, "[", r, c, "]:=", s ], "need_command", "SetMatElm" );
    
end );

##
InstallMethod( AddToMatElm,
        "for homalg external matrices in Maple",
        [ IsHomalgExternalMatrixRep and IsMutable, IsPosInt, IsPosInt, IsHomalgExternalRingElementRep, IsHomalgExternalRingInMapleRep ],
        
  function( M, r, c, a, R )
    
    homalgSendBlocking( [ M, "[", r, c, "]:=", a, "+", M, "[", r, c, "]" ], "need_command", "AddToMatElm" );
    
end );

##
InstallMethod( CreateHomalgMatrixFromString,
        "constructor for homalg external matrices in Maple",
        [ IsString, IsHomalgExternalRingInMapleRep ],
        
  function( S, R )
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ R, "[-1][matrix](", S, ")" ], "HomalgMatrix" );
    
    return HomalgMatrix( ext_obj, R );
    
end );

##
InstallMethod( CreateHomalgMatrixFromString,
        "constructor for homalg external matrices in Maple",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInMapleRep ],
        
  function( S, r, c, R )
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ R, "[-1][matrix](`homalg/ConvertToListList`(", r, c, ",", S, ",", R, "[-1]))" ], "HomalgMatrix" );
    
    return HomalgMatrix( ext_obj, r, c, R );
    
end );

##
InstallMethod( CreateHomalgMatrixFromSparseString,
        "constructor for homalg external matrices in Maple",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInMapleRep ],
        
  function( S, r, c, R )
    local M, s;
    
    M := HomalgInitialMatrix( r, c, R );
    
    s := homalgSendBlocking( S, R, "sparse" );
    
    homalgSendBlocking( [ "for i in ", s, " do ", M, "[i[1],i[2]]:=i[3]: od" ] , "need_command", "HomalgMatrix" );
    
    return M;
    
end );

##
InstallMethod( MatElmAsString,
        "for homalg external matrices in Maple",
        [ IsHomalgExternalMatrixRep, IsPosInt, IsPosInt, IsHomalgExternalRingInMapleRep ],
        
  function( M, r, c, R )
    
    return homalgSendBlocking( [ "convert(", M, "[", r, c, "],symbol)" ], "need_output", "MatElm" );
    
end );

##
InstallMethod( MatElm,
        "for homalg external matrices in Maple",
        [ IsHomalgExternalMatrixRep, IsPosInt, IsPosInt, IsHomalgExternalRingInMapleRep ],
        
  function( M, r, c, R )
    local Mrc;
    
    Mrc := homalgSendBlocking( [ M, "[", r, c, "]" ], "MatElm" );
    
    return HomalgExternalRingElement( Mrc, R );
    
end );

##
InstallMethod( GetListOfHomalgMatrixAsString,
        "for homalg external matrices in Maple",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInMapleRep ],
        
  function( M, R )
    
    return homalgSendBlocking( [ "convert(map(op,convert(", M, ",listlist)),symbol)" ], "need_output", "GetListOfHomalgMatrixAsString" );
    
end );

##
InstallMethod( GetListListOfHomalgMatrixAsString,
        "for homalg external matrices in Maple",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInMapleRep ],
        
  function( M, R )
    
    return homalgSendBlocking( [ "convert(convert(", M, ",listlist),symbol)" ], "need_output", "GetListListOfHomalgMatrixAsString" );
    
end );

##
InstallMethod( GetSparseListOfHomalgMatrixAsString,
        "for homalg external matrices in Maple",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInMapleRep ],
        
  function( M, R )
    
    return homalgSendBlocking( [ "map(i->op(map(j->if ", M, "[i,j]<>", Zero( R ), " then [i,j,convert(", M, "[i,j],symbol)] fi, [$1..", NumberColumns( M ),"])), [$1..", NumberRows( M ),"])" ], "need_output", "GetSparseListOfHomalgMatrixAsString" );
    
end );

####################################
#
# transfer methods:
#
####################################

##
InstallMethod( SaveHomalgMatrixToFile,
        "for homalg external matrices in Maple",
        [ IsString, IsHomalgMatrix, IsHomalgExternalRingInMapleRep ],
        
  function( filename, M, R )
    local mode, command;
    
    if not IsBound( M!.SaveAs ) then
        mode := "ListList";
    else
        mode := M!.SaveAs; #not yet supported
    fi;
    
    if mode = "ListList" then
        command := [ "_fs := fopen(\"", filename, "\",WRITE): ",
                     "fprintf( _fs, %s, convert(convert(", M, ",listlist),string)): ",
                     "fflush( _fs ): ",
                     "fclose( _fs )" ];
        
        homalgSendBlocking( command, "need_command", "SaveHomalgMatrixToFile" );
        
    fi;
    
    return true;
    
end );

##
InstallMethod( LoadHomalgMatrixFromFile,
        "for external rings in Maple",
        [ IsString, IsHomalgExternalRingInMapleRep ],
        
  function( filename, R )
    local mode, command, M;
    
    if not IsBound( R!.LoadAs ) then
        mode := "ListList";
    else
        mode := R!.LoadAs; #not yet supported
    fi;
    
    M := HomalgVoidMatrix( R );
    
    if mode = "ListList" then
        
        command := [ "_fs := fopen(\"", filename, "\",READ): ",
                     "_str := readbytes( _fs, infinity, TEXT ): ",
                     "fclose( _fs ): ",
                     M, ":=", R, "[-1][matrix](parse( _str ))" ];
        
        homalgSendBlocking( command, "need_command", "LoadHomalgMatrixFromFile" );
        
    fi;
    
    return M;
    
end );

##
InstallMethod( homalgSetName,
        "for homalg ring elements",
        [ IsHomalgExternalRingElementRep, IsString, IsHomalgExternalRingInMapleRep ],
        
  function( r, name, R )
    
    SetName( r, homalgSendBlocking( [ "convert( ", r, ", symbol )" ], "need_output", "homalgSetName" ) );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( Display,
        "for homalg external matrices in Maple",
        [ IsHomalgExternalMatrixRep ], 1,
        
  function( o )
    
    if IsHomalgExternalRingInMapleRep( HomalgRing( o ) ) then
        
        Print(  homalgSendBlocking( [ "eval(", HomalgRing( o ), "[-1][matrix](", o, "))" ], "need_display", "Display" ) );
        
    else
        
        TryNextMethod( );
        
    fi;
    
end );

##
InstallMethod( DisplayRing,
        "for homalg rings in Maple",
        [ IsHomalgExternalRingInMapleRep ], 1,
        
  function( o )
    
    homalgDisplay( [ o, "[1]" ] );
    
end );

