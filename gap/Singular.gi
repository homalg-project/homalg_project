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
            cas := "singular",			## normalized name on which the user should have no control
            name := "Singular",
            executable := "Singular",
            options := [ "-t", "--echo=0", "--no-warn" ],	## the option "-q" causes IO to believe that Singular has died!
            BUFSIZE := 1024,
            READY := "!$%&/(",
            CUT_POS_BEGIN := 1,			## these are the most
            CUT_POS_END := 2,			## delicate values!
            eoc_verbose := ";",
            eoc_quiet := ";",
            break_lists := true,		## a Singular specific
            handle_output := true,		## a Singular specific
#            original_lines := true,		## a Singular specific
            check_output := true,		## a Singular specific looks for newlines without commas
            setring := _Singular_SetRing,	## a Singular specific
            setinvol := _Singular_SetInvolution,## a Singular specific
            define := "=",
            delete := function( var, stream ) homalgSendBlocking( [ "kill ", var ], "need_command", stream, HOMALG_IO.Pictograms.delete ); end,
            multiple_delete := _Singular_multiple_delete,
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
# global functions:
#
####################################

##
InstallGlobalFunction( _Singular_SetRing,
  function( R )
    local stream;
    
    stream := homalgStream( R );
    
    ## since _Singular_SetRing might be called from homalgSendBlocking,
    ## we first set the new active ring to avoid infinite loops:
    stream.active_ring := R;
    
    homalgSendBlocking( [ "setring ", R ], "need_command", HOMALG_IO.Pictograms.initialize );
    
end );

##
InstallGlobalFunction( _Singular_SetInvolution,
  function( R )
    local RP;
    
    RP := homalgTable( R );
    
    if IsBound( RP!.SetInvolution ) then
        RP!.SetInvolution( R );
    fi;
    
end );

##
InstallGlobalFunction( _Singular_multiple_delete,
  function( var_list, stream )
    local str, var;
    
    str:="";
    
    for var in var_list do
      str := Concatenation( str, "kill ", String ( var ) , ";" );
    od;
    
    homalgSendBlocking( str, "need_command", stream, HOMALG_IO.Pictograms.multiple_delete );
    
end );

##
InstallGlobalFunction( InitializeSingularTools,
  function( stream )
    local IsMemberOfList, Difference,
          GetColumnIndependentUnitPositions, GetRowIndependentUnitPositions,
          IsZeroMatrix, IsIdentityMatrix, IsDiagonalMatrix,
          ZeroRows, ZeroColumns, GetUnitPosition, GetCleanRowsPositions,
          BasisOfRowModule, BasisOfColumnModule,
          BasisOfRowsCoeff, BasisOfColumnsCoeff,
          DecideZeroRows, DecideZeroColumns,
          DecideZeroRowsEffectively, DecideZeroColumnsEffectively,
          SyzygiesGeneratorsOfRows, SyzygiesGeneratorsOfRows2,
          SyzygiesGeneratorsOfColumns, SyzygiesGeneratorsOfColumns2;
    
    IsMemberOfList := "\n\
proc IsMemberOfList (int i, list l)\n\
{\n\
  int k = size(l);\n\
  \n\
  for (int p=1; p<=k; p=p+1)\n\
  {\n\
    if (l[p]==i)\n\
    {\n\
      return(1); // this is not a mistake\n\
    }\n\
  }\n\
  return(0);\n\
}\n\n";
    
    Difference := "\n\
proc Difference (list a, list b)\n\
{\n\
  list c;\n\
  int s=size(a);\n\
  \n\
  for (int p=1; p<=s; p=p+1)\n\
  {\n\
    if (IsMemberOfList(a[p],b)==0)\n\
    {\n\
      c[size(c)+1] = a[p];\n\
    }\n\
  }\n\
  return(c);\n\
}\n\n";
    
    IsZeroMatrix := "\n\
proc IsZeroMatrix (matrix m)\n\
{\n\
  matrix z[nrows(m)][ncols(m)];\n\
  return(m==z);\n\
}\n\n";
    
    IsIdentityMatrix := "\n\
proc IsIdentityMatrix (matrix m)\n\
{\n\
  return(m==unitmat(nrows(m)));\n\
}\n\n";
    
    IsDiagonalMatrix := "\n\
proc IsDiagonalMatrix (matrix m)\n\
{\n\
  int min=nrows(m);\n\
  if (min>ncols(m))\n\
  {\n\
    min=ncols(m);\n\
  }\n\
  matrix z[nrows(m)][ncols(m)];\n\
  matrix c = m;\n\
  for (int i=1; i<=min; i=i+1)\n\
  {\n\
    c[i,i]=0;\n\
  }\n\
  return(c==z);\n\
}\n\n";
    
    ZeroRows := "\n\
proc ZeroRows (matrix m)\n\
{\n\
  list l;\n\
  for (int i=1;i<=ncols(m);i=i+1)\n\
  {\n\
    if (m[i]==0)\n\
    {\n\
      l[size(l)+1]=i;\n\
    }\n\
  }\n\
  if (size(l)==0)\n\
  {\n\
    return(\"[]\"));\n\
  }\n\
  return(string(l));\n\
}\n\n";
    
    ZeroColumns := "\n\
proc ZeroColumns (matrix n)\n\
{\n\
  matrix m=transpose(n);\n\
  list l;\n\
  for (int i=1;i<=ncols(m);i=i+1)\n\
  {\n\
    if (m[i]==0)\n\
    {\n\
      l[size(l)+1]=i;\n\
    }\n\
  }\n\
  if (size(l)==0)\n\
  {\n\
    return(\"[]\"));\n\
  }\n\
  return(string(l));\n\
}\n\n";
    
    GetColumnIndependentUnitPositions := "\n\
proc GetColumnIndependentUnitPositions (matrix M, list pos_list)\n\
{\n\
  int m = nrows(M);\n\
  int n = ncols(M);\n\
  \n\
  list rest;\n\
  for (int o=1; o<=m; o=o+1)\n\
  {\n\
    rest[size(rest)+1] = o;\n\
  }\n\
  int r = m;\n\
  list e;\n\
  list rest2;\n\
  list pos;\n\
  int i; int k; int a;\n\
  \n\
  for (int j=1; j<=n; j=j+1)\n\
  {\n\
    for (i=1; i<=r; i=i+1)\n\
    {\n\
      k = rest[r-i+1];\n\
      if (deg(M[k,j]) == 0) //IsUnit\n\
      {\n\
        rest2 = e;\n\
        pos[size(pos)+1] = list(j,k);\n\
        for (a=1; a<=r; a=a+1)\n\
        {\n\
          if (M[rest[a],j] == 0)\n\
          {\n\
            rest2[size(rest2)+1] = rest[a];\n\
          }\n\
        }\n\
        rest = rest2;\n\
        r = size(rest);\n\
        break;\n\
      }\n\
    }\n\
  }\n\
  return(string(pos));\n\
}\n\n";
    
    GetRowIndependentUnitPositions := "\n\
proc GetRowIndependentUnitPositions (matrix M, list pos_list)\n\
{\n\
  int m = nrows(M);\n\
  int n = ncols(M);\n\
  \n\
  list rest;\n\
  for (int o=1; o<=n; o=o+1)\n\
  {\n\
    rest[size(rest)+1] = o;\n\
  }\n\
  int r = n;\n\
  list e;\n\
  list rest2;\n\
  list pos;\n\
  int j; int k; int a;\n\
  \n\
  for (int i=1; i<=m; i=i+1)\n\
  {\n\
    for (j=1; j<=r; j=j+1)\n\
    {\n\
      k = rest[r-j+1];\n\
      if (deg(M[i,k]) == 0) //IsUnit\n\
      {\n\
        rest2 = e;\n\
        pos[size(pos)+1] = list(i,k);\n\
        for (a=1; a<=r; a=a+1)\n\
        {\n\
          if (M[i,rest[a]] == 0)\n\
          {\n\
            rest2[size(rest2)+1] = rest[a];\n\
          }\n\
        }\n\
        rest = rest2;\n\
        r = size(rest);\n\
        break;\n\
      }\n\
    }\n\
  }\n\
  return(string(pos));\n\
}\n\n";
    
    GetUnitPosition := "\n\
proc GetUnitPosition (matrix M, list pos_list)\n\
{\n\
  int m = nrows(M);\n\
  int n = ncols(M);\n\
  list rest;\n\
  for (int o=1; o<=m; o=o+1)\n\
  {\n\
    rest[size(rest)+1] = o;\n\
  }\n\
  rest=Difference(rest,pos_list);\n\
  for (int j=1; j<=n; j=j+1)\n\
  {\n\
    for (int i=1; i<=size(rest); i=i+1)\n\
    {\n\
      if (deg(M[rest[i],j]) == 0)\n\
      {\n\
        return(string(j,\",\",rest[i])); // this is not a mistake\n\
      }\n\
    }\n\
  }\n\
  return(\"fail\");\n\
}\n\n";
    
    GetCleanRowsPositions := "\n\
proc GetCleanRowsPositions (matrix m, list l)\n\
{\n\
  list rows = list();\n\
  for (int i=1;i<=size(l);i=i+1)\n\
  {\n\
    for (int j=1;j<=ncols(m);j=j+1)\n\
    {\n\
      if (m[l[i],j]==1)\n\
      {\n\
        rows[size(rows)+1] = j;\n\
        break;\n\
      }\n\
    }\n\
  }\n\
  if (size(rows)==0)\n\
  {\n\
    return(\"[]\"));\n\
  }\n\
  return(string(rows));\n\
}\n\n";
    
    BasisOfRowModule := "\n\
proc BasisOfRowModule (matrix M)\n\
{\n\
  return(std(M));\n\
}\n\n";
    
    BasisOfColumnModule := "\n\
proc BasisOfColumnModule (matrix M)\n\
{\n\
  return(Involution(std(Involution(M))));\n\
}\n\n";
    
    BasisOfRowsCoeff := "\n\
proc BasisOfRowsCoeff (matrix M)\n\
{\n\
  matrix B = std(M);\n\
  matrix T = lift(M,B); //never use stdlift, also because it might differ from std!!!\n\
  list l = B,T;\n\
  return(l)\n\
}\n\n";
    
#    ## according to the documentation B=M*T in the commutative case, but it somehow does not work :(
#    ## and for plural to work one would need to define B=transpose(transpose(T)*transpose(M)), which is expensive!!
#    BasisOfRowsCoeff := "\n\
#proc BasisOfRowsCoeff (matrix M)\n\
#{\n\
#  matrix T;\n\
#  matrix B = matrix(liftstd(M,T));\n\
#  list l = transpose(transpose(T)*transpose(M)),T;\n\
#  return(l)\n\
#}\n\n";
    
    BasisOfColumnsCoeff := "\n\
proc BasisOfColumnsCoeff (matrix M)\n\
{\n\
  list l = BasisOfRowsCoeff(Involution(M));\n\
  matrix B = l[1];\n\
  matrix T = l[2];\n\
  l = Involution(B),Involution(T);\n\
  return(l);\n\
}\n\n";
    
    DecideZeroRows := "\n\
proc DecideZeroRows (matrix A, matrix B)\n\
{\n\
  return(reduce(A,B));\n\
}\n\n";
    
    DecideZeroColumns := "\n\
proc DecideZeroColumns (matrix A, matrix B)\n\
{\n\
  return(Involution(reduce(Involution(A),Involution(B))));\n\
}\n\n";
    
#todo: read part of the unit matrix in singular help!
#      it is ignored right now.
# division(A^t,B^t) returns (TT^t, M^t, U^t) with
#                A^t*U^t = B^t*TT^t + M^t
# <=> (ignore U) M^t = A^t - B^t*TT^tr
# <=>            M   = A   + (-TT) * B
# <=> (T:=-TT)   M   = A   + T * B
#M^t=A^t-T^t*B^t
    
    DecideZeroRowsEffectively := "\n\
proc DecideZeroRowsEffectively (matrix A, matrix B)\n\
{\n\
  matrix M = reduce(A,B);\n\
  matrix T = lift(B,M-A);\n\
  list l = M,T;\n\
  return(l);\n\
}\n\n";
    
    DecideZeroColumnsEffectively := "\n\
proc DecideZeroColumnsEffectively (matrix A, matrix B)\n\
{\n\
  list l = DecideZeroRowsEffectively(Involution(A),Involution(B));\n\
  matrix B = l[1];\n\
  matrix T = l[2];\n\
  l = Involution(B),Involution(T);\n\
  return(l);\n\
}\n\n";
    
    SyzygiesGeneratorsOfRows := "\n\
proc SyzygiesGeneratorsOfRows (matrix M)\n\
{\n\
  return(syz(M));\n\
}\n\n";
    
    SyzygiesGeneratorsOfRows2 := "\n\
proc SyzygiesGeneratorsOfRows2 (matrix M1, matrix M2)\n\
{\n\
  int r = nrows(M1);\n\
  int c1 = ncols(M1);\n\
  int c2 = ncols(M2);\n\
  matrix M[r][c1+c2] = concat(M1,M2);\n\
  matrix s=syz(M);\n\
  return(submat(s,1..c1,1..ncols(s)));\n\
}\n\n";
    
    SyzygiesGeneratorsOfColumns := "\n\
proc SyzygiesGeneratorsOfColumns (matrix M)\n\
{\n\
  return(Involution(syz(Involution(M))));\n\
}\n\n";
    
    SyzygiesGeneratorsOfColumns2 := "\n\
proc SyzygiesGeneratorsOfColumns2 (matrix M1, matrix M2)\n\
{\n\
  return(Involution(SyzygiesGeneratorsOfRows2(Involution(M1),Involution(M2))));\n\
}\n\n";
    
    homalgSendBlocking( "int i; int j; int k; list l;\n\n", "need_command", stream, HOMALG_IO.Pictograms.initialize );
    homalgSendBlocking( IsMemberOfList, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( Difference, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( IsZeroMatrix, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( IsIdentityMatrix, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( IsDiagonalMatrix, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( ZeroRows, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( ZeroColumns, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( GetColumnIndependentUnitPositions, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( GetRowIndependentUnitPositions, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( GetUnitPosition, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( GetCleanRowsPositions, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( BasisOfRowModule, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( BasisOfColumnModule, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( BasisOfRowsCoeff, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( BasisOfColumnsCoeff, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( DecideZeroRows, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( DecideZeroColumns, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( DecideZeroRowsEffectively, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( DecideZeroColumnsEffectively, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( SyzygiesGeneratorsOfRows, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( SyzygiesGeneratorsOfRows2, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( SyzygiesGeneratorsOfColumns, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( SyzygiesGeneratorsOfColumns2, "need_command", stream, HOMALG_IO.Pictograms.define );
    
    
  end
);

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( RingForHomalgInSingular,
  function( arg )
    local nargs, stream, o, ar, ext_obj, R, RP;
    
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
        homalgSendBlocking( "option(noredefine);option(redSB);LIB \"matrix.lib\";LIB \"control.lib\";LIB \"ring.lib\";LIB \"involut.lib\"", "need_command", stream, HOMALG_IO.Pictograms.initialize );
        o := 0;
    else
        o := 1;
    fi;
    
    InitializeSingularTools( stream );
    
    ##this will lead to the call
    ##ring homalg_variable_something = arg[1];
    ar := [ [ arg[1] ], [ "ring" ], TheTypeHomalgExternalRingObjectInSingular, stream, HOMALG_IO.Pictograms.CreateHomalgRing ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( homalgSendBlocking, ar );
    
    R := CreateHomalgRing( ext_obj, TheTypeHomalgExternalRingInSingular );
    
    _Singular_SetRing( R );
    
    ##prints output in a compatible format
    homalgSendBlocking( "option(redTail);short=0;", "need_command", stream, HOMALG_IO.Pictograms.initialize );
    
    RP := homalgTable( R );
    
    RP!.SetInvolution :=
      function( R )
        homalgSendBlocking( "\nproc Involution (matrix m)\n{\n  return(transpose(m));\n}\n\n", "need_command", R, HOMALG_IO.Pictograms.define );
    end;
    
    RP!.SetInvolution( R );
    
    return R;
    
end );

##
InstallGlobalFunction( HomalgFieldOfRationalsInSingular,
  function( arg )
    local ar, R;
    
    ##It seems that Singular does not know the fields.
    ##Instead we create Q[dummy_variable] and feed only expressions
    ##without "dummy_variable" to Singular. Since homalg in GAP
    ##does not know of the dummy_variable, during the next ring extension
    ##it will vanish and not slow down basis calculations.
    ar := Concatenation( [ "0,dummy_variable,dp" ], [ IsPrincipalIdealRing ], arg );
    
    R := CallFuncList( RingForHomalgInSingular, ar );
    
    SetIsFieldForHomalg( R, true );
    
    SetRingProperties( R, 0 );
    
    return R;
    
end );

##
InstallGlobalFunction( HomalgRingOfIntegersInSingular,
  function( p )
    local ar, R;
    
    if not IsPrime( p ) then
      Error("given number ist not prime\n");
    fi;
    
    ##It seems that Singular does not know fields.
    ##Instead we create GF(p)[dummy_variable] and feed only expressions
    ##without "dummy_variable" to Singular. Since homalg in GAP
    ##does not know of the dummy_variable, during the next ring extension
    ##it will vanish and not slow down basis calculations.
    ar := Concatenation( [ Concatenation( String(p), ",dummy_variable,dp") ], [ IsPrincipalIdealRing ] );
    
    R := CallFuncList( RingForHomalgInSingular, ar );
    
    SetIsFieldForHomalg( R, true );
    
    SetRingProperties( R, p );
    
    return R;
    
end );

##
InstallMethod( PolynomialRing,
        "for homalg rings in Singular",
        [ IsHomalgExternalRingInSingularRep, IsList ],
        
  function( R, indets )
    local var, c, properties, r, var_of_coeff_ring, ext_obj, S, v, nr_var, RP;
    
    ##compute the new indeterminates for the ring and save them in var
    if IsString( indets ) and indets <> "" then
        var := SplitString( indets, "," ); 
    elif indets <> [ ] and ForAll( indets, i -> IsString( i ) and i <> "" ) then
        var := indets;
    else
        Error( "either a non-empty list of indeterminates or a comma separated string of them must be provided as the second argument\n" );
    fi;
    
    nr_var := Length( var );
    
    c := Characteristic( R );
    
    properties := [ IsCommutative ];
    
    ##K[x] is a principal ideal ring for a field K
    if Length( var ) = 1 and HasIsFieldForHomalg( R ) and IsFieldForHomalg( R ) then
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
      var_of_coeff_ring := [];
    fi;

    ##create the new ring
    if var_of_coeff_ring = [] then
      ext_obj := homalgSendBlocking( [ c, ",(", var, "),dp" ] , [ "ring" ], TheTypeHomalgExternalRingObjectInSingular, properties, R, HOMALG_IO.Pictograms.CreateHomalgRing );
    else
      ext_obj := homalgSendBlocking( [ c, ",(", var_of_coeff_ring, var, "),dp" ] , [ "ring" ], TheTypeHomalgExternalRingObjectInSingular, properties, R, HOMALG_IO.Pictograms.CreateHomalgRing );
    fi;
    
    S := CreateHomalgRing( ext_obj, TheTypeHomalgExternalRingInSingular );
    
    var := List( Concatenation( var_of_coeff_ring, var ), a -> HomalgExternalRingElement( a, S ) );
    
    for v in var do
        SetName( v, homalgPointer( v ) );
    od;
    
    _Singular_SetRing( S );
    
    ##since variables in Singular are stored inside a ring it is necessary to
    ##map all variables from the to ring to the new one
    ##todo: kill old ring to reduce memory?
    homalgSendBlocking( ["imapall(", homalgPointer( R ), ")" ], "need_command", ext_obj, HOMALG_IO.Pictograms.initialize );
    
    homalgSendBlocking( "option(redTail);short=0;", "need_command", ext_obj, HOMALG_IO.Pictograms.initialize );
    
    SetIsFreePolynomialRing( S, true );
    
    SetRingProperties( S, r, var );
    
    RP := homalgTable( S );
    
    RP!.SetInvolution :=
      function( R )
        homalgSendBlocking( "\nproc Involution (matrix m)\n{\n  return(transpose(m));\n}\n\n", "need_command", R, HOMALG_IO.Pictograms.define );
    end;
    
    ## reseting the "Involution" must be after "imapall":
    RP!.SetInvolution( S );
    
    return S;
    
end );

##
InstallMethod( RingOfDerivations,
        "for homalg rings in Singular",
        [ IsHomalgExternalRingInSingularRep, IsList ],
        
  function( R, indets )
    local var, nr_var, der, nr_der, properties, stream, display_color,
          PR, ext_obj, S, v, RP;

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
    
    if not ForAll( var, HasName ) then
      Error( "the indeterminates of base ring must all have a name (use SetName)\n" );
    fi;
    
    properties := [ ];
    
    stream := homalgStream( R );
    
    homalgSendBlocking( [ "LIB \"nctools.lib\";" ], "need_command", stream, HOMALG_IO.Pictograms.initialize );
    
    if IsBound( stream.color_display ) then
        display_color := stream.color_display;
    else
        display_color := "";
    fi;
    
    Print( "----------------------------------------------------------------\n" );
    
    ## leave the below indentation untouched!
    Print( display_color, "\
                     SINGULAR::PLURAL\n\
The SINGULAR Subsystem for Non-commutative Polynomial Computations\n\
     by: G.-M. Greuel, V. Levandovskyy, H. Schoenemann\n\
FB Mathematik der Universitaet, D-67653 Kaiserslautern\033[0m\n\
----------------------------------------------------------------\n\n" );
    
    ##create the new ring in 2 steps: expand polynomial ring with derivatives and then
    ##add the Weyl-structure
    ##todo: this creates a block ordering with a new "dp"-block
    PR := homalgSendBlocking( [ Characteristic( R ), ",(", var, der, "),dp" ] , [ "ring" ], R, HOMALG_IO.Pictograms.initialize );
    ext_obj := homalgSendBlocking( [ "Weyl();" ] , [ "def" ] , TheTypeHomalgExternalRingObjectInSingular, properties, PR, HOMALG_IO.Pictograms.CreateHomalgRing );
    
    S := CreateHomalgRing( ext_obj, TheTypeHomalgExternalRingInSingular );
    
    der := List( der , a -> HomalgExternalRingElement( a, S ) );
    
    for v in der do
        SetName( v, homalgPointer( v ) );
    od;
    
    _Singular_SetRing( S );
    
    ##since variables in Singular are stored inside a ring it is necessary to
    ##map all variables from the to ring to the new one
    ##todo: kill old ring to reduce memory?
    homalgSendBlocking( ["imapall(", homalgPointer( R ), ")" ], "need_command", stream, HOMALG_IO.Pictograms.initialize );
    
    homalgSendBlocking( "option(redTail);short=0;", "need_command", stream, HOMALG_IO.Pictograms.initialize );
    
    SetIsWeylRing( S, true );
    
    SetRingProperties( S, R, der );
    
    RP := homalgTable( S );
    
    RP!.SetInvolution :=
      function( R )
        homalgSendBlocking( Concatenation(
                [ "\nproc Involution (matrix M)\n{\n" ],
                [ "  map F = ", R, ", " ],
                IndeterminateCoordinatesOfRingOfDerivations( R ),
                Concatenation( List( IndeterminateDerivationsOfRingOfDerivations( R ), a -> [ ", -" , a ] ) ),
                [ ";\n  return( transpose( involution( M, F ) ) );\n}\n\n" ]
                ), "need_command", HOMALG_IO.Pictograms.define );
    end;
    
    ## reseting the "Involution" must be after "imapall":
    RP!.SetInvolution( S );
    
    RP!.Compose :=
      function( A, B )
        
        return homalgSendBlocking( [ "transpose( transpose(", A, ") * transpose(", B, ") )" ], [ "matrix" ], HOMALG_IO.Pictograms.Compose ); # FIXME : this has to be extensively documented to be understandable!
        
    end;
    
    return S;
    
end );

##
InstallMethod( SetEntryOfHomalgMatrix,
        "for external matrices in Singular",
        [ IsHomalgExternalMatrixRep and IsMutableMatrix, IsInt, IsInt, IsString, IsHomalgExternalRingInSingularRep ],
        
  function( M, r, c, s, R )
    
    homalgSendBlocking( [ M, "[", c, r, "]=", s ], "need_command", HOMALG_IO.Pictograms.SetEntryOfHomalgMatrix );
    
end );

##
InstallMethod( AddToEntryOfHomalgMatrix,
        "for external matrices in Singular",
        [ IsHomalgExternalMatrixRep and IsMutableMatrix, IsInt, IsInt, IsHomalgExternalRingElementRep, IsHomalgExternalRingInSingularRep ],
        
  function( M, r, c, a, R )
    
    homalgSendBlocking( [ M, "[", c, r, "]=", a, "+", M, "[", c, r, "]" ], "need_command", HOMALG_IO.Pictograms.AddToEntryOfHomalgMatrix );
    
end );

##
InstallMethod( CreateHomalgMatrix,
        "for homalg matrices",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInSingularRep ],
        
  function( M, r, c, R )
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ M ], [ "matrix" ], [ "[", r, "][", c, "]" ], R, HOMALG_IO.Pictograms.HomalgMatrix );
    
    if not ( r = 1 and c = 1 ) then
        homalgSendBlocking( [ ext_obj, " = transpose(", ext_obj, ")" ], "need_command", HOMALG_IO.Pictograms.TransposedMatrix ); #added by Simon
    fi;
    
    return HomalgMatrix( ext_obj, r, c, R );
    
end );

##
InstallMethod( GetEntryOfHomalgMatrixAsString,
        "for external matrices in Singular",
        [ IsHomalgExternalMatrixRep, IsInt, IsInt, IsHomalgExternalRingInSingularRep ],
        
  function( M, r, c, R )
    
    return homalgSendBlocking( [ M, "[", c, r, "]" ], "need_output", HOMALG_IO.Pictograms.GetEntryOfHomalgMatrix );
    
end );

##
InstallMethod( GetEntryOfHomalgMatrix,
        "for external matrices in Singular",
        [ IsHomalgExternalMatrixRep, IsInt, IsInt, IsHomalgExternalRingInSingularRep ],
        
  function( M, i, j, R )
    
    return homalgSendBlocking( [ M, "[", j, i, "]" ], [ "def" ], "return_ring_element", HOMALG_IO.Pictograms.GetEntryOfHomalgMatrix );
    
end );

####################################
#
# transfer methods:
#
####################################

##
InstallMethod( GetListOfHomalgMatrixAsString,
        "for external matrices in Singular",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInSingularRep ],
        
  function( M, R )
    
    return homalgSendBlocking( [ "\"[\"+string(transpose(", M, "))+\"]\"" ], "need_output", HOMALG_IO.Pictograms.GetListOfHomalgMatrixAsString );
    #remark: matrices are saved transposed in singular
    
end );

##
InstallMethod( GetListListOfHomalgMatrixAsString,
        "for external matrices in Singular",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInSingularRep ],
        
  function( M, R )
    local command;
    
      command := [
          "matrix m[", NrColumns( M ),"][1];",
          "string s = \"[\";",
          "for(int i=1;i<=", NrRows( M ), ";i=i+1){",
            "m = ", M, "[1..", NrColumns( M ), ",i];",#remark: matrices are saved transposed in singular
            "if(i!=1){s=s+\",\";};",
            "s=s+\"[\"+string(m)+\"]\";",
          "};",
          "s=s+\"]\";"
        ];
        
        homalgSendBlocking( command, "need_command", HOMALG_IO.Pictograms.GetListListOfHomalgMatrixAsString );
    
        return homalgSendBlocking( [ "s" ], "need_output", R, HOMALG_IO.Pictograms.GetListListOfHomalgMatrixAsString );
    
end );

##
#InstallMethod( GetSparseListOfHomalgMatrixAsString,
#        "for external matrices in Singular",
#        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInSingularRep ],
#        
#  function( M , R )
#    local command,s;
#
#    command := [
#          "list l;poly p;list l2;",
#          "for(int i=1;i<=", NrRows( M ), ";i=i+1){",
#            "for(int j=1;j<=", NrColumns( M ), ";j=j+1){",
#              "p=", M, "[j,i];", #remark: matrices are saved transposed in singular
#              "if(p!=0){l2=[i,j,p];l=insert(l,l2)};",
#            "};",
#          "};"
#        ];
#    
#    homalgSendBlocking( command, "need_command", HOMALG_IO.Pictograms.GetSparseListOfHomalgMatrixAsString);
#    
#    s := homalgSendBlocking( "l", "need_output", R, HOMALG_IO.Pictograms.GetSparseListOfHomalgMatrixAsString);
#    
#    if s <> "emptylist" then
#      return s;
#    else
#      return "[]"
#    fi;
#    
#end );

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
          #remark: matrices are saved transposed in singular
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
    local mode, fs, str, command, M;
    
    if not IsBound( R!.LoadAs ) then
        mode := "ListList";
    else
        mode := R!.LoadAs; #not yet supported
    fi;
    
    #read the file with GAP and parse it for better Singular reading:
    fs := IO_File( filename, "r" );
    if fs = fail then
        Error( "unable to open the file ", filename, " for reading\n" );
    fi;
    str := IO_ReadUntilEOF( fs );
    if str = fail then
        Error( "unable to read lines from the file ", filename, "\n" );
    fi;
    if IO_Close( fs ) = fail then
        Error( "unable to close the file ", filename, "\n" );
    fi;
    
    str := Filtered( str, c -> not c in " []" );
    
    fs := IO_File( filename, "w" );
    if fs = fail then
        Error( "unable to open the file ", filename, " for writing\n" );
    fi;
    if IO_WriteFlush( fs, str ) = fail then
        Error( "unable to write in the file ", filename, "\n" );
    fi;
    if IO_Close( fs ) = fail then
        Error( "unable to close the file ", filename, "\n" );
    fi;
    
    
    M := HomalgVoidMatrix( R );
    
    if mode = "ListList" then
        
        command := [ "string s=read(\"r: ", filename, "\");",
                     "execute( \"matrix ", M, "[", r, "][", c, "] = \" + s + \";\" );",
                     M, " = transpose(", M, ")" ];#remark: matrices are saved transposed in singular
        
        homalgSendBlocking( command, "need_command", HOMALG_IO.Pictograms.LoadDataOfHomalgMatrixFromFile );
        
    fi;
    
    return M;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
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

##
InstallMethod( DisplayRing,
        "for homalg rings in Singular",
        [ IsHomalgExternalRingInSingularRep ], 1,
        
  function( o )
    
    homalgDisplay( [ "print(", o, ")" ] );
    
end );

