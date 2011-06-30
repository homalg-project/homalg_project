#############################################################################
##
##  ResidueClassRing.gi         MatricesForHomalg package    Mohamed Barakat
##
##  Copyright 2007-2009 Mohamed Barakat, Universität des Saarlandes
##
##  Implementation stuff for homalg residue class rings.
##
#############################################################################

####################################
#
# representations:
#
####################################

##  <#GAPDoc Label="IsHomalgResidueClassRingRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="R" Name="IsHomalgResidueClassRingRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The representation of &homalg; residue class rings. <P/>
##      (It is a subrepresentation of the &GAP; representation <Br/>
##      <C>IsHomalgRingOrFinitelyPresentedModuleRep</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsHomalgResidueClassRingRep",
        IsHomalgRing and IsHomalgRingOrFinitelyPresentedModuleRep,
        [ "ring" ] );

##  <#GAPDoc Label="IsHomalgResidueClassRingElementRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="r" Name="IsHomalgResidueClassRingElementRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The representation of elements of &homalg; residue class rings. <P/>
##      (It is a representation of the &GAP; category <C>IsHomalgRingElement</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsHomalgResidueClassRingElementRep",
        IsHomalgRingElement,
        [ "pointer" ] );

##  <#GAPDoc Label="IsHomalgResidueClassMatrixRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="A" Name="IsHomalgResidueClassMatrixRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The representation of &homalg; matrices with entries in a &homalg; residue class ring. <P/>
##      (It is a representation of the &GAP; category <C>IsHomalgMatrix</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsHomalgResidueClassMatrixRep",
        IsHomalgMatrix,
        [ ] );

## three new types:
BindGlobal( "TheTypeHomalgResidueClassRing",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgResidueClassRingRep ) );

BindGlobal( "TheTypeHomalgResidueClassRingElement",
        NewType( TheFamilyOfHomalgRingElements,
                IsHomalgResidueClassRingElementRep ) );

BindGlobal( "TheTypeHomalgResidueClassMatrix",
        NewType( TheFamilyOfHomalgMatrices,
                IsHomalgResidueClassMatrixRep ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( Indeterminates,
        "for homalg rings",
        [ IsHomalgRing and IsHomalgResidueClassRingRep ],
        
  function( R )
    
    return List( Indeterminates( AmbientRing( R ) ), r -> r / R );
    
end );

##
InstallMethod( RelativeIndeterminatesOfPolynomialRing,
        "for homalg rings",
        [ IsHomalgRing and IsHomalgResidueClassRingRep ],
        
  function( R )
    
    return List( RelativeIndeterminatesOfPolynomialRing( AmbientRing( R ) ), r -> r / R );
    
end );

##
InstallMethod( String,
        "for homalg residue class ring elements",
        [ IsHomalgResidueClassRingElementRep ],

  function( o )
    
    return String( EvalRingElement( o ) );
    
end );

##
InstallMethod( Name,
        "for homalg residue class ring elements",
        [ IsHomalgResidueClassRingElementRep ],

  function( o )
    local name;
    
    if IsHomalgRingElement( EvalRingElement( o ) ) then
        name := Name;
    else
        name := String;
    fi;
    
    return Flat( [ "|[ ", name( EvalRingElement( o ) ), " ]|" ] );
    
end );

##
InstallMethod( BlindlyCopyMatrixPropertiesToResidueClassMatrix,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgResidueClassMatrixRep ],
        
  function( S, T )
    local c;
    
    for c in [ NrRows, NrColumns ] do
        if Tester( c )( S ) then
            Setter( c )( T, c( S ) );
        fi;
    od;
    
    for c in [ IsZero, IsOne, IsDiagonalMatrix ] do
        if Tester( c )( S ) and c( S ) then
            Setter( c )( T, c( S ) );
        fi;
    od;
    
end );

##
InstallMethod( SetEntryOfHomalgMatrix,
        "for homalg residue class matrices",
        [ IsHomalgResidueClassMatrixRep and IsMutable, IsInt, IsInt, IsString, IsHomalgResidueClassRingRep ],
        
  function( M, r, c, s, R )
    
    SetEntryOfHomalgMatrix( Eval( M ), r, c, s, AmbientRing( R ) );
    
end );

##
InstallMethod( SetEntryOfHomalgMatrix,
        "for homalg residue class matrices",
        [ IsHomalgResidueClassMatrixRep and IsMutable, IsInt, IsInt, IsHomalgResidueClassRingElementRep, IsHomalgResidueClassRingRep ],
        
  function( M, r, c, a, R )
    
    SetEntryOfHomalgMatrix( Eval( M ), r, c, EvalRingElement( a ), AmbientRing( R ) );
    
end );

##
InstallMethod( GetEntryOfHomalgMatrixAsString,
        "for homalg residue class matrices",
        [ IsHomalgResidueClassMatrixRep, IsInt, IsInt, IsHomalgResidueClassRingRep ],
        
  function( M, r, c, R )
    
    return GetEntryOfHomalgMatrixAsString( Eval( M ), r, c, AmbientRing( R ) );
    
end );

##
InstallMethod( GetEntryOfHomalgMatrix,
        "for homalg residue class matrices",
        [ IsHomalgResidueClassMatrixRep, IsInt, IsInt, IsHomalgResidueClassRingRep ],
        
  function( M, r, c, R )
    
    return HomalgResidueClassRingElement( GetEntryOfHomalgMatrix( Eval( M ), r, c, AmbientRing( R ) ), R );
    
end );

##
InstallMethod( GetListOfHomalgMatrixAsString,
        "for homalg residue class matrices",
        [ IsHomalgResidueClassMatrixRep, IsHomalgResidueClassRingRep ],
        
  function( M, R )
    
    return GetListOfHomalgMatrixAsString( Eval( M ), AmbientRing( R ) );
    
end );

##
InstallMethod( GetListListOfHomalgMatrixAsString,
        "for homalg residue class matrices",
        [ IsHomalgResidueClassMatrixRep, IsHomalgResidueClassRingRep ],
        
  function( M, R )
    
    return GetListListOfHomalgMatrixAsString( Eval( M ), AmbientRing( R ) );
    
end );

##
InstallMethod( GetSparseListOfHomalgMatrixAsString,
        "for homalg residue class matrices",
        [ IsHomalgResidueClassMatrixRep, IsHomalgResidueClassRingRep ],
        
  function( M, R )
    
    return GetSparseListOfHomalgMatrixAsString( Eval( M ), AmbientRing( R ) );
    
end );

##
InstallMethod( UnionOfRows,
        "for homalg residue class matrices",
        [ IsHomalgResidueClassMatrixRep, IsHomalgRingRelations ],
        
  function( M, ring_rel )
    local R, rel;
    
    if NrColumns( M ) = 0 then
        return Eval( M );
    fi;
    
    R := HomalgRing( M );
    
    rel := MatrixOfRelations( ring_rel );
    
    if not IsIdenticalObj( AmbientRing( R ), HomalgRing( rel ) ) then
        TryNextMethod( );
    fi;
    
    if IsHomalgRingRelationsAsGeneratorsOfRightIdeal( ring_rel ) then
        rel := Involution( rel );
    fi;
    
    rel := DiagMat( ListWithIdenticalEntries( NrColumns( M ), rel ) );
    
    return UnionOfRows( Eval( M ), rel );
    
end );

##
InstallMethod( UnionOfRows,
        "for homalg residue class matrices",
        [ IsHomalgResidueClassMatrixRep ],
        
  function( M )
    
    return UnionOfRows( M, RingRelations( HomalgRing( M ) ) );
    
end );

##
InstallMethod( UnionOfColumns,
        "for homalg residue class matrices",
        [ IsHomalgResidueClassMatrixRep, IsHomalgRingRelations ],
        
  function( M, ring_rel )
    local R, rel;
    
    if NrRows( M ) = 0 then
        return Eval( M );
    fi;
    
    R := HomalgRing( M );
    
    rel := MatrixOfRelations( ring_rel );
    
    if not IsIdenticalObj( AmbientRing( R ), HomalgRing( rel ) ) then
        TryNextMethod( );
    fi;
    
    if IsHomalgRingRelationsAsGeneratorsOfLeftIdeal( ring_rel ) then
        rel := Involution( rel );
    fi;
    
    rel := DiagMat( ListWithIdenticalEntries( NrRows( M ), rel ) );
    
    return UnionOfColumns( Eval( M ), rel );
    
end );

##
InstallMethod( UnionOfColumns,
        "for homalg residue class matrices",
        [ IsHomalgResidueClassMatrixRep ],
        
  function( M )
    
    return UnionOfColumns( M, RingRelations( HomalgRing( M ) ) );
    
end );

##
InstallMethod( DecideZero,
        "for homalg ring elements",
        [ IsRingElement, IsHomalgResidueClassRingRep ],
        
  function( r, R )
    
    return DecideZero( r, RingRelations( R ) );
    
end );

##
InstallMethod( DecideZero,
        "for homalg residue class ring elements",
        [ IsHomalgResidueClassRingElementRep ],
        
  function( r )
    local R, red;
    
    if HasIsReducedModuloRingRelations( r ) and IsReducedModuloRingRelations( r ) then
        return r;
    fi;
    
    R := HomalgRing( r );
    
    red := DecideZero( EvalRingElement( r ), R );
    
    red := HomalgResidueClassRingElement( red, R );
    
    SetIsReducedModuloRingRelations( red, true );
    IsZero( red );
    
    return red;
    
end );

##
InstallMethod( DecideZero,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgResidueClassRingRep ],
        
  function( M, R )
    
    return DecideZero( M, MatrixOfRelations( RingRelations( R ) ) );
    
end );

##
InstallMethod( DecideZero,
        "for homalg residue class matrices",
        [ IsHomalgResidueClassMatrixRep ],
        
  function( M )
    local R, red;
    
    if HasIsReducedModuloRingRelations( M ) and IsReducedModuloRingRelations( M ) then
        return M;
    fi;
    
    R := HomalgRing( M );
    
    if IsEmptyMatrix( M ) then
        
        SetIsReducedModuloRingRelations( M, true );
        IsZero( M );
        
        return M;
    fi;
    
    red := DecideZero( Eval( M ), R );
    
    red := HomalgResidueClassMatrix( red, R );
    
    SetIsReducedModuloRingRelations( red, true );
    IsZero( red );
    
    return red;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( CreateHomalgTableForResidueClassRings,
        "for homalg rings",
        [ IsHomalgRing ],
        
  function( ambientR )
    local RP, RP_General, RP_Basic, RP_specific, component;
    
    RP := ShallowCopy( CommonHomalgTableForResidueClassRingsTools );
    
    RP_General := ShallowCopy( CommonHomalgTableForResidueClassRings );
    
    RP_Basic := ShallowCopy( CommonHomalgTableForResidueClassRingsBasic );
    
    RP_specific := rec(
                       Zero := Zero( ambientR ),
                       
                       One := One( ambientR ),
                       
                       MinusOne := MinusOne( ambientR ),
                       );
    
    for component in NamesOfComponents( RP_General ) do
        RP.(component) := RP_General.(component);
    od;
    
    for component in NamesOfComponents( RP_Basic ) do
        RP.(component) := RP_Basic.(component);
    od;
    
    for component in NamesOfComponents( RP_specific ) do
        RP.(component) := RP_specific.(component);
    od;
    
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );

##  <#GAPDoc Label="ResidueClassRingConstructor">
##  <ManSection>
##    <Oper Arg="R, ring_rel" Name="\/" Label="constructor for residue class rings"/>
##    <Returns>a &homalg; ring</Returns>
##    <Description>
##      This is the &homalg; constructor for residue class rings <A>R</A> <M>/ I</M>, where
##      <A>R</A> is a &homalg; ring and <M>I=</M><A>ring_rel</A> is the ideal of relations
##      generated by <A>ring_rel</A>. <A>ring_rel</A> might be:
##      <List>
##        <Item>a set of ring relations of a left resp. right ideal</Item>
##        <Item>a list of ring elements of <A>R</A></Item>
##        <Item>a ring element of <A>R</A></Item>
##      </List>
##      For noncommutative rings: In the first case the set of ring relations
##      should generate the ideal of relations <M>I</M> as left resp. right ideal,
##      and their involutions should generate <M>I</M> as right resp. left ideal.
##      If <A>ring_rel</A> is not a set of relations, a <E>left</E> set of relations is constructed. <P/>
##      The operation <C>SetRingProperties</C> is automatically invoked to set the ring properties.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );
##  <An internal ring>
##  gap> Display( ZZ );
##  Z
##  gap> Z256 := ZZ / 2^8;
##  <A residue class ring>
##  gap> Display( Z256 );
##  Z/( 256 )
##  gap> Z2 := Z256 / 6;
##  <A residue class ring>
##  gap> Display( Z2 );
##  Z/( 2 )
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( \/,	## this operation is declared in the file HomalgRelations.gd
        "constructor for homalg rings",
        [ IsHomalgRing, IsHomalgRingRelations ],
        
  function( R, ring_rel )
    local A, RP, S, mat, rel, left, rel_old, mat_old, left_old, c;
    
    if IsHomalgResidueClassRingRep( R ) then
        A := AmbientRing( R );
    else
        A := R;
    fi;
    
    RP := CreateHomalgTableForResidueClassRings( A );
    
    ## create the residue class ring
    S := CreateHomalgRing( R, [ TheTypeHomalgResidueClassRing, TheTypeHomalgResidueClassMatrix ], HomalgResidueClassRingElement, RP );
    
    ## the constructor of matrices over residue class rings
    SetConstructorForHomalgMatrices( S,
            function( arg )
              local mat, l, ar, M, R;
              
              l := Length( arg );
              
              mat := arg[1];
              
              if IsList( mat ) and ForAll( mat, IsHomalgResidueClassRingElementRep ) then
                  mat := List( mat, EvalRingElement );
              fi;
              
              ar := List( arg{[ 2 .. l ]},
                          function( i )
                            if IsHomalgResidueClassRingRep( i ) then
                                return AmbientRing( i );
                            else
                                return i;
                            fi;
                          end );
              
              M := CallFuncList( HomalgMatrix, Concatenation( [ mat ], ar ) );
              
              R := arg[l];
              
              return HomalgResidueClassMatrix( M, R );
              
            end );
    
    ## for the view methods:
    ## <A residue class ring>
    ## <A matrix over a residue class ring>
    S!.description := " residue class";
    
    ## it is safe to evaluate empty residue class matrices
    S!.SafeToEvaluateEmptyMatrices := true;
    
    mat := MatrixOfRelations( ring_rel );
    
    left := IsHomalgRingRelationsAsGeneratorsOfLeftIdeal( ring_rel );
    
    ## merge the new ring relations with the relations of the ambient ring
    if IsHomalgResidueClassRingRep( R ) then
        
        ## the ambient ring is the ambient ring of the ambient ring :)
        SetAmbientRing( S, A );
        
        ## the new ring relations
        mat := mat * AmbientRing( S );	## be sure to have all relations over the true ambient ring
        if left then
            rel := HomalgRingRelationsAsGeneratorsOfLeftIdeal( mat );
        else
            rel := HomalgRingRelationsAsGeneratorsOfRightIdeal( mat );
        fi;
        
        ## the relations of the ambient ring
        rel_old := RingRelations( R );
        mat_old := MatrixOfRelations( rel_old );
        left_old := IsHomalgRingRelationsAsGeneratorsOfLeftIdeal( rel_old );
        if left_old <> left then
            Error( "the relations of the ambient ring and the given relations must both be either left or right relations\n" );
        fi;
        if left_old then
            rel_old := HomalgRingRelationsAsGeneratorsOfLeftIdeal( mat_old );
        else
            rel_old := HomalgRingRelationsAsGeneratorsOfRightIdeal( mat_old );
        fi;
        
        ## merge old an new ring relations
        rel := BasisOfModule( UnionOfRelations( rel_old, rel ) );
    else
        
        SetAmbientRing( S, A );
        
        if left then
            rel := HomalgRingRelationsAsGeneratorsOfLeftIdeal( mat );
        else
            rel := HomalgRingRelationsAsGeneratorsOfRightIdeal( mat );
        fi;
    fi;
    
    SetRingRelations( S, BasisOfModule( rel ) );
    
    ## residue class rings of the integers
    if HasIsResidueClassRingOfTheIntegers( R ) and
       IsResidueClassRingOfTheIntegers( R ) then
        SetIsResidueClassRingOfTheIntegers( S, true );
        c := RingRelations( S );
        c := MatrixOfRelations( c );
        c := EntriesOfHomalgMatrix( c );
        if Length( c ) = 1 then
            c := c[1];
            if IsHomalgRingElement( c ) and Int( Name( c ) ) <> fail then
                c := Int( Name( c ) );
            fi;
        fi;
        if IsInt( c ) then
            SetRingProperties( S, c );
        fi;
    fi;
    
    return S;
    
end );

##
InstallMethod( PolynomialRing,
        "for homalg rings",
        [ IsHomalgRing and IsHomalgResidueClassRingRep, IsList ],
        
  function( R, indets )
    local S;
    
    S := PolynomialRing( AmbientRing( R ), indets );
    
    return S / ( S * RingRelations( R ) );
    
end );

##
InstallMethod( \/,
        "constructor for a homalg rings",
        [ IsHomalgRing, IsHomalgMatrix ],
        
  function( R, ring_rel )
    
    if NrRows( ring_rel ) = 0 or NrColumns( ring_rel ) = 0  then
        return R;
    elif NrColumns( ring_rel ) = 1 then
        return R / HomalgRingRelationsAsGeneratorsOfLeftIdeal( ring_rel );
    elif NrRows( ring_rel ) = 1 then
        return R / HomalgRingRelationsAsGeneratorsOfRightIdeal( ring_rel );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \/,
        "constructor for homalg rings",
        [ IsHomalgRing, IsList ],
        
  function( R, ring_rel )
    
    if ForAll( ring_rel, IsString ) then
        return R / List( ring_rel, s -> HomalgRingElement( s, R ) );
    elif not ForAll( ring_rel, IsRingElement ) then
        TryNextMethod( );
    fi;
    
    return R / HomalgMatrix( ring_rel, Length( ring_rel ), 1, R );
    
end );

##
InstallMethod( \/,
        "constructor for homalg rings",
        [ IsHomalgRing, IsRingElement ],
        
  function( R, ring_rel )
    
    return R / [ ring_rel ];
    
end );

##
InstallMethod( \/,
        "constructor for homalg rings",
        [ IsHomalgRing, IsString ],
        
  function( R, ring_rel )
    
    return R / HomalgRingElement( ring_rel, R );
    
end );

##
InstallGlobalFunction( HomalgResidueClassRingElement,
  function( arg )
    local nargs, a, ring, ar, properties, r;
    
    nargs := Length( arg );
    
    if nargs = 0 then
        Error( "empty input\n" );
    fi;
    
    a := arg[1];
    
    if IsHomalgResidueClassRingElementRep( a ) then
        
        ## otherwise simply return it
        return a;
        
    elif nargs = 2 then
        
        ## extract the properties of the global ring element
        if IsHomalgRing( arg[2] ) then
            ring := arg[2];
            ar := [ a, ring ];
            properties := KnownTruePropertiesOfObject( a );	## FIXME: a huge potential for problems
            Add( ar, List( properties, ValueGlobal ) );  ## at least an empty list is inserted; avoids infinite loops
            return CallFuncList( HomalgResidueClassRingElement, ar );
        fi;
        
    fi;
    
    properties := [ ];
    
    for ar in arg{[ 2 .. nargs ]} do
        if not IsBound( ring ) and IsHomalgRing( ar ) then
            ring := ar;
        elif IsList( ar ) and ForAll( ar, IsFilter ) then
            Append( properties, ar );
        else
            Error( "this argument (now assigned to ar) should be in { IsHomalgRing, IsRingElement, IsList( IsFilter ) }\n" );
        fi;
    od;
    
    if IsBound( ring ) then
        
        r := rec( ring := ring );
        
        if not IsRingElement( a ) then
            a := HomalgRingElement( a, AmbientRing( ring ) );
        fi;
        
        ## Objectify:
        ObjectifyWithAttributes(
                r, TheTypeHomalgResidueClassRingElement,
                EvalRingElement, a );
    else
        r := a;
    fi;
    
    if properties <> [ ] then
        for ar in properties do
            Setter( ar )( r, true );
        od;
    fi;
    
    return r;
    
end );

##
InstallGlobalFunction( HomalgResidueClassMatrix,
  function( M, R )
    local matrix;
    
    #if not IsIdenticalObj( HomalgRing( M ), AmbientRing( R ) ) then
    #    Error( "the ring the matrix and the ambient ring of the specified residue class ring are not identical\n" );
    #fi;
    
    matrix := rec( ring := R );
    
    ObjectifyWithAttributes(
            matrix, TheTypeHomalgResidueClassMatrix,
            Eval, M );
    
    BlindlyCopyMatrixPropertiesToResidueClassMatrix( M, matrix );
    
    return matrix;
    
end );

##
InstallMethod( \*,
        "for homalg matrices",
        [ IsHomalgResidueClassRingRep, IsHomalgMatrix ],
        
  function( R, m )
    
    return HomalgResidueClassMatrix( AmbientRing( R ) * m, R );
    
end );

##
InstallMethod( \*,
        "for homalg residue class matrices",
        [ IsHomalgRing, IsHomalgResidueClassMatrixRep ],
        
  function( R, m )
    
    return R * Eval( m );
    
end );

##
InstallMethod( CreateHomalgMatrixFromString,
        "for homalg matrices",
        [ IsString, IsHomalgResidueClassRingRep ],
        
  function( S, R )
    
    return HomalgResidueClassMatrix( CreateHomalgMatrixFromString( S, AmbientRing( R ) ), R );
    
end );

##
InstallMethod( CreateHomalgMatrixFromString,
        "for homalg matrices",
        [ IsString, IsInt, IsInt, IsHomalgResidueClassRingRep ],
        
  function( S, r, c, R )
    
    return HomalgResidueClassMatrix( CreateHomalgMatrixFromString( S, r, c, AmbientRing( R ) ), R );
    
end );

##
InstallMethod( CreateHomalgMatrixFromSparseString,
        "for homalg matrices",
        [ IsString, IsInt, IsInt, IsHomalgResidueClassRingRep ],
        
  function( S, r, c, R )
    
    return HomalgResidueClassMatrix( CreateHomalgMatrixFromSparseString( S, r, c, AmbientRing( R ) ), R );
    
end );

##
InstallMethod( SaveHomalgMatrixToFile,
        "for external matrices in GAP",
        [ IsString, IsHomalgResidueClassMatrixRep, IsHomalgResidueClassRingRep ],
        
  function( filename, M, R )
    
    return SaveHomalgMatrixToFile( filename, Eval( M ), AmbientRing( R ) );
    
end );

##
InstallMethod( LoadHomalgMatrixFromFile,
        "for external rings in GAP",
        [ IsString, IsHomalgResidueClassRingRep ],
        
  function( filename, R )
    local M;
    
    M := LoadHomalgMatrixFromFile( filename, AmbientRing( R ) );
    
    return HomalgResidueClassMatrix( M, R );
    
end );

##
InstallMethod( PostMakeImmutable,
        "for homalg residue class matrices",
        [ IsHomalgResidueClassMatrixRep and HasEval ],
        
  function( A )
    
    MakeImmutable( Eval( A ) );
    
end );

##
InstallMethod( SetIsMutableMatrix,
        "for homalg residue class matrices",
        [ IsHomalgResidueClassMatrixRep, IsBool ],
        
  function( A, b )
    
    if b = true then
        SetFilterObj( A, IsMutable );
    else
        ResetFilterObj( A, IsMutable );
    fi;
    
    SetIsMutableMatrix( Eval( A ), b );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( Display,
        "for homalg residue class ring elements",
        [ IsHomalgResidueClassRingElementRep ],
        
  function( r )
    
    Print( Name( r ), "\n" );
    
end );

##
InstallMethod( Display,
        "for homalg matrices over a homalg residue class ring",
        [ IsHomalgResidueClassMatrixRep ],
        
  function( A )
    local rel;
    
    Display( Eval( A ) );
    Print( "\nmodulo " );
    
    rel := EntriesOfHomalgMatrix( MatrixOfRelations( RingRelations( HomalgRing( A ) ) ) );
    
    if ForAll( rel, IsHomalgRingElement ) then
        rel := JoinStringsWithSeparator( List( rel, Name ), ", " );
        Print( "[ ", rel, " ]\n" );
    else
        Print( rel, "\n" );	## we assume that rel is a list of GAP4 ring elements that can be properly displayed
    fi;
    
end );
