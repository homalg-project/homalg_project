#############################################################################
##
##  HomalgGenerators.gi         Modules package              Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for a set of generators.
##
#############################################################################

##  <#GAPDoc Label="Generators:intro">
##  To present a left/right module it suffices to take a matrix <A>rel</A> and interpret its rows/columns
##  as relations among <M>n</M> <E>abstract</E> generators, where <M>n</M> is the number of columns/rows
##  of <A>rel</A>. Only that these abstract generators are useless when it comes to specific modules like
##  modules of homomorphisms, where one expects the generators to be maps between modules. For this
##  reason a presentation of a module in &homalg; is not merely a matrix of relations, but together with
##  a set of generators.
##  <P/>
##  In &homalg; a set of generators of a left/right module is given by a matrix <A>gen</A> with rows/columns
##  being interpreted as the generators.
##  <P/>
##  The data structure of a module in &homalg; is designed to contain not only one but several sets of generators
##  (together with their sets of relations (&see; Chapter <Ref Chap="Relations"/>)).
##  The different sets of generators are linked with so-called transition matrices (&see; Chapter <Ref Chap="Modules"/>).
##  <#/GAPDoc>

####################################
#
# representations:
#
####################################

##  <#GAPDoc Label="IsGeneratorsOfModuleRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="rel" Name="IsGeneratorsOfModuleRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of a finite set of generators of a &homalg; module. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgGenerators"/>)
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsGeneratorsOfModuleRep",
        IsHomalgGenerators,
        [ "generators" ] );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsGeneratorsOfFinitelyGeneratedModuleRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="rel" Name="IsGeneratorsOfFinitelyGeneratedModuleRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of a finite set of generators of a finitely generated &homalg; module. <P/>
##      (It is a representation of the &GAP; representation <Ref Filt="IsGeneratorsOfModuleRep"/>)
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsGeneratorsOfFinitelyGeneratedModuleRep",
        IsGeneratorsOfModuleRep,
        [ "generators", "relations_of_hullmodule" ] );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgGenerators",
        NewFamily( "TheFamilyOfHomalgGenerators" ) );

# four new types:
BindGlobal( "TheTypeHomalgGeneratorsOfLeftModule",
        NewType(  TheFamilyOfHomalgGenerators,
                IsGeneratorsOfModuleRep and IsHomalgGeneratorsOfLeftModule ) );

BindGlobal( "TheTypeHomalgGeneratorsOfRightModule",
        NewType(  TheFamilyOfHomalgGenerators,
                IsGeneratorsOfModuleRep and IsHomalgGeneratorsOfRightModule ) );

BindGlobal( "TheTypeHomalgGeneratorsOfFinitelyGeneratedLeftModule",
        NewType(  TheFamilyOfHomalgGenerators,
                IsGeneratorsOfFinitelyGeneratedModuleRep and IsHomalgGeneratorsOfLeftModule ) );

BindGlobal( "TheTypeHomalgGeneratorsOfFinitelyGeneratedRightModule",
        NewType(  TheFamilyOfHomalgGenerators,
                IsGeneratorsOfFinitelyGeneratedModuleRep and IsHomalgGeneratorsOfRightModule ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( MatrixOfGenerators,
        "for sets of generators of homalg modules",
        [ IsHomalgGenerators ],
        
  function( gen )
    
    return gen!.generators;
    
end );

##
InstallMethod( HomalgRing,
        "for sets of generators of homalg modules",
        [ IsHomalgGenerators ],
        
  function( gen )
    
    return HomalgRing( MatrixOfGenerators( gen ) );
    
end );

##
InstallMethod( GetGenerators,
        "for a set of homalg generators and a positive integer",
        [ IsGeneratorsOfFinitelyGeneratedModuleRep, IsPosInt ],
        
  function( gen, g )
    local AdjustedGenerators, mat, G, proc;
    
    if not IsBound( gen!.AdjustedGenerators ) then
        gen!.AdjustedGenerators := [ ];
    fi;
    
    AdjustedGenerators := gen!.AdjustedGenerators;
    
    if IsBound( AdjustedGenerators[g] ) then
        return AdjustedGenerators[g];
    fi;
    
    mat := MatrixOfGenerators( gen );
    
    if IsHomalgGeneratorsOfLeftModule( gen ) then
        G := CertainRows( mat, [ g ] );
    else
        G := CertainColumns( mat, [ g ] );
    fi;
    
    if HasProcedureToReadjustGenerators( gen ) then
        proc := ProcedureToReadjustGenerators( gen );
        G := CallFuncList( proc[1], Concatenation( [ G ], proc{[ 2 .. Length( proc ) ]} ) );
    fi;
    
    AdjustedGenerators[g] := G;
    
    return G;
    
end );

##
InstallMethod( GetGenerators,
        "for a set of homalg generators and a list of positive integer",
        [ IsGeneratorsOfFinitelyGeneratedModuleRep, IsList ],
        
  function( gen, g )
    
    return List( g, i -> GetGenerators( gen, i ) );
    
end );

##
InstallMethod( GetGenerators,
        "for homalg generators",
        [ IsGeneratorsOfFinitelyGeneratedModuleRep ],
        
  function( gen )
    
    return GetGenerators( gen, [ 1 .. NrGenerators( gen ) ] );
    
end );

##
InstallMethod( RelationsOfHullModule,
        "for sets of generators of homalg modules",
        [ IsHomalgGenerators ],
        
  function( gen )
    
    return gen!.relations_of_hullmodule;
    
end );

##
InstallMethod( HasNrRelations,
        "for sets of generators of homalg modules",
        [ IsHomalgGenerators ],
        
  function( gen )
    
    return HasNrRelations( RelationsOfHullModule( gen ) );
    
end );

##
InstallMethod( NrRelations,
        "for sets of generators of homalg modules",
        [ IsHomalgGenerators ],
        
  function( gen )
    
    return NrRelations( RelationsOfHullModule( gen ) );
    
end );

##
InstallMethod( MatrixOfRelations,
        "for sets of generators of homalg modules",
        [ IsHomalgGenerators ],
        
  function( gen )
    
    return EvaluatedMatrixOfRelations( RelationsOfHullModule( gen ) );
    
end );

##
InstallMethod( HasNrGenerators,
        "for sets of generators of homalg modules",
        [ IsHomalgGeneratorsOfRightModule ],
        
  function( gen )
    
    return HasNrColumns( MatrixOfGenerators( gen ) );
    
end );

##
InstallMethod( HasNrGenerators,
        "for sets of generators of homalg modules",
        [ IsHomalgGeneratorsOfLeftModule ],
        
  function( gen )
    
    return HasNrRows( MatrixOfGenerators( gen ) );
    
end );

##
InstallMethod( NrGenerators,			### defines: NrGenerators (NumberOfGenerators)
        "for sets of generators of homalg modules",
        [ IsHomalgGeneratorsOfRightModule ],
        
  function( gen )
    
    return NrColumns( MatrixOfGenerators( gen ) );
    
end );

##
InstallMethod( NrGenerators,			### defines: NrGenerators (NumberOfGenerators)
        "for sets of generators of homalg modules",
        [ IsHomalgGeneratorsOfLeftModule ],
        
  function( gen )
    
    return NrRows( MatrixOfGenerators( gen ) );
    
end );

##
InstallMethod( CertainGenerators,
        "for sets of generators of homalg modules",
        [ IsHomalgGeneratorsOfRightModule, IsList ],
        
  function( gen, list )
    
    return CertainColumns( MatrixOfGenerators( gen ), list );
    
end );

##
InstallMethod( CertainGenerators,
        "for sets of generators of homalg modules",
        [ IsHomalgGeneratorsOfLeftModule, IsList ],
        
  function( gen, list )
    
    return CertainRows( MatrixOfGenerators( gen ), list );
    
end );

##
InstallMethod( CertainGenerator,
        "for sets of generators of homalg modules",
        [ IsHomalgGenerators, IsPosInt ],
        
  function( gen, pos )
    
    return CertainGenerators( gen, [ pos ] );
    
end );

##
InstallMethod( NewHomalgGenerators,
        "for sets of generators of homalg modules",
        [ IsHomalgMatrix, IsHomalgGenerators ],
        
  function( mat, gen )
    local relations_of_hullmodule, gen_new;
    
    relations_of_hullmodule := RelationsOfHullModule( gen );
    
    if IsHomalgGeneratorsOfLeftModule( gen ) then
        gen_new := HomalgGeneratorsForLeftModule( mat, relations_of_hullmodule );
    else
        gen_new := HomalgGeneratorsForRightModule( mat, relations_of_hullmodule );
    fi;
    
    if HasProcedureToReadjustGenerators( gen ) then
        SetProcedureToReadjustGenerators( gen_new, ProcedureToReadjustGenerators( gen ) );
    fi;
    
    if HasProcedureToNormalizeGenerators( gen ) then
        SetProcedureToNormalizeGenerators( gen_new, ProcedureToNormalizeGenerators( gen ) );
    fi;
    
    if IsBound( gen!.ring ) then
        gen_new!.ring := gen!.ring;
    fi;
    
    if IsBound( gen!.ConvertTransitionMatrix ) then
        gen_new!.ConvertTransitionMatrix := gen!.ConvertTransitionMatrix;
    fi;
    
    return gen_new;
    
end );

##
InstallMethod( UnionOfRelations,
        "for sets of generators of homalg modules",
        [ IsHomalgGenerators, IsHomalgRelations ],
        
  function( gen, rel )
    local gen_new, hull;
    
    gen_new := MatrixOfGenerators( gen );
    
    hull := RelationsOfHullModule( gen );
    
    hull := UnionOfRelations( hull, rel );
    
    if IsHomalgGeneratorsOfLeftModule( gen ) and IsHomalgRelationsOfLeftModule( rel ) then
        gen_new := HomalgGeneratorsForLeftModule( gen_new, hull );
    elif IsHomalgGeneratorsOfRightModule( gen ) and IsHomalgRelationsOfRightModule( rel ) then
        gen_new := HomalgGeneratorsForRightModule( gen_new, hull );
    else
        Error( "the set of generators and the set of relations must either be both left or both right\n" );
    fi;
    
    if HasProcedureToReadjustGenerators( gen ) then
        SetProcedureToReadjustGenerators( gen_new, ProcedureToReadjustGenerators( gen ) );
    fi;
    
    if HasProcedureToNormalizeGenerators( gen ) then
        SetProcedureToNormalizeGenerators( gen_new, ProcedureToNormalizeGenerators( gen ) );
    fi;
    
    if IsBound( gen!.ring ) then
        gen_new!.ring := gen!.ring;
    fi;
    
    if IsBound( gen!.ConvertTransitionMatrix ) then
        gen_new!.ConvertTransitionMatrix := gen!.ConvertTransitionMatrix;
    fi;
    
    return gen_new;
    
end );

##
InstallMethod( DecideZero,
        "for sets of generators of homalg modules",
        [ IsHomalgGenerators ],
        
  function( gen )
    local gen_old, gen_new;
    
    if not IsBound( gen!.DecideZero ) then	## IsReduced is not set, otherwise the method below would apply
        gen_old := MatrixOfGenerators( gen );
        gen_new := DecideZero( gen_old, RelationsOfHullModule( gen ) );
        if gen_new = gen_old then
            gen!.DecideZero := gen_old;
            SetIsReduced( gen, true );
            return gen;
        fi;
        gen!.DecideZero := gen_new;
        SetIsReduced( gen, false );
    fi;
    
    gen_new := NewHomalgGenerators( gen!.DecideZero, gen );
    
    SetIsReduced( gen_new, true );
    
    return gen_new;
    
end );

##
InstallMethod( DecideZero,
        "for sets of generators of homalg modules",
        [ IsHomalgGenerators and IsReduced ],
        
  function( gen )
    
    return gen;
    
end );

##
InstallMethod( DecideZero,
        "for sets of generators of homalg modules",
        [ IsHomalgGenerators, IsHomalgRelations ],
        
  function( gen, rel )
    
    if not IsBound( gen!.DecideZero ) then
        gen!.DecideZero := DecideZero( MatrixOfGenerators( gen ), rel );
        SetIsReduced( gen, false );
    fi;
    
    return gen!.DecideZero;
    
end );

##
InstallMethod( GetRidOfZeroGenerators,	### defines: GetRidOfZeroGenerators (BetterBasis)
        "for sets of generators of homalg modules",
        [ IsHomalgGenerators ],
        
  function( _gen )
    local R, RP, gen, nonzero;
    
    R := HomalgRing( _gen );
    
    RP := homalgTable( R );
    
    #=====# begin of the core procedure #=====#
    
    gen := DecideZero( _gen );
    
    if IsHomalgGeneratorsOfLeftModule( gen ) then
        
        if IsBound(RP!.SimplifyBasisOfRows) then
            gen := RP!.SimplifyBasisOfRows( gen );
        else
            gen := MatrixOfGenerators( gen );
        fi;
        
        nonzero := NonZeroRows( gen );
        
        gen := CertainRows( gen, nonzero );
        
    else
        
        if IsBound(RP!.SimplifyBasisOfColumns) then
            gen := RP!.SimplifyBasisOfColumns( gen );
        else
            gen := MatrixOfGenerators( gen );
        fi;
        
        nonzero := NonZeroColumns( gen );
        
        gen := CertainColumns( gen, nonzero );
        
    fi;
    
    gen := NewHomalgGenerators( gen, _gen );
    
    return gen;
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for sets of relations of homalg modules",
        [ IsHomalgGeneratorsOfRightModule, IsHomalgRelationsOfRightModule ],
        
  function( gen, rel )
    
    return HomalgRelationsForRightModule( SyzygiesGeneratorsOfColumns, [ MatrixOfGenerators( gen ), MatrixOfRelations( rel ) ] );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for sets of relations of homalg modules",
        [ IsHomalgGeneratorsOfLeftModule, IsHomalgRelationsOfLeftModule ],
        
  function( gen, rel )
    
    return HomalgRelationsForLeftModule( SyzygiesGeneratorsOfRows, [ MatrixOfGenerators( gen ), MatrixOfRelations( rel ) ] );
    
end );

##
InstallMethod( ReducedSyzygiesGenerators,
        "for sets of relations of homalg modules",
        [ IsHomalgGeneratorsOfRightModule, IsHomalgRelationsOfRightModule ],
        
  function( gen, rel )
    
    return ReducedSyzygiesGenerators( MatrixOfGenerators( gen ), rel );
    
end );

##
InstallMethod( ReducedSyzygiesGenerators,
        "for sets of relations of homalg modules",
        [ IsHomalgGeneratorsOfLeftModule, IsHomalgRelationsOfLeftModule ],
        
  function( gen, rel )
    
    return ReducedSyzygiesGenerators( MatrixOfGenerators( gen ), rel );
    
end );

##
InstallMethod( \*,
        "for sets of generators of homalg modules",
        [ IsHomalgMatrix, IsHomalgGenerators ],
        
  function( TI, gen )
    local generators, R;
    
    generators := MatrixOfGenerators( gen );
    
    R := HomalgRing( generators );
    
    if not IsIdenticalObj( R, HomalgRing( TI ) ) then
        if IsBound( gen!.ConvertTransitionMatrix ) then
            TI := gen!.ConvertTransitionMatrix( TI );
        elif IsBound( gen!.ring ) and IsIdenticalObj( gen!.ring, HomalgRing( TI ) ) then
            TI := TI * R;
        fi;
    fi;
    
    if IsHomalgMatrix( TI ) then
        if IsHomalgGeneratorsOfLeftModule( gen ) then
            generators := NewHomalgGenerators( TI * generators, gen ); ## the hull relations remain unchanged :)
        else
            generators := NewHomalgGenerators( generators * TI, gen ); ## the hull relations remain unchanged :)
        fi;
    elif IsFunction( TI ) then
        generators := NewHomalgGenerators( TI( generators ), gen ); ## the hull relations remain unchanged :)
    else
        Error( "unknown type of transition operation\n" );
    fi;
    
    return generators;
    
end );

##
InstallMethod( \*,
        "for sets of generators of homalg modules",
        [ IsHomalgGenerators, IsHomalgGenerators ],
        
  function( gen1, gen2 )
    local gen;
    
    if not ( IsHomalgGeneratorsOfLeftModule( gen1 ) and IsHomalgGeneratorsOfLeftModule( gen2 ) )
       and not ( IsHomalgGeneratorsOfRightModule( gen1 ) and IsHomalgGeneratorsOfRightModule( gen2 ) ) then
        Error( "the two sets of generators must either be both left or both right\n" );
    fi;
    
    gen := MatrixOfGenerators( gen1 ) * gen2;
    
    return gen;
    
end );

##
InstallMethod( \*,
        "for sets of generators of homalg modules",
        [ IsHomalgRelations, IsHomalgGenerators ],
        
  function( rel, gen )
    local rel_mat, gen_mat, R;
    
    rel_mat := MatrixOfRelations( rel );
    
    gen_mat := MatrixOfGenerators( gen );
    
    R := HomalgRing( gen_mat );
    
    if not IsIdenticalObj( R, HomalgRing( rel_mat ) ) then
        if IsBound( gen!.ring ) and IsIdenticalObj( gen!.ring, HomalgRing( rel_mat ) ) then
            rel_mat := rel_mat * R;
        fi;
    fi;
    
    if IsBound( gen!.ConvertTransitionMatrix ) then
        rel_mat := gen!.ConvertTransitionMatrix( rel_mat );
    fi;
    
    if IsHomalgMatrix( rel_mat ) then
        if IsHomalgRelationsOfLeftModule( rel ) then
            if IsHomalgGeneratorsOfRightModule( gen ) then
                Error( "the set of generators and the set of relations must either be both left or both right\n" );
            fi;
            return HomalgRelationsForLeftModule( rel_mat * gen_mat );
        else
            if IsHomalgGeneratorsOfLeftModule( gen ) then
                Error( "the set of generators and the set of relations must either be both left or both right\n" );
            fi;
            return HomalgRelationsForRightModule( gen_mat * rel_mat );
        fi;
    elif IsFunction( rel_mat ) then
        if IsHomalgRelationsOfLeftModule( rel ) then
            return HomalgRelationsForLeftModule( rel_mat( gen_mat ) );
        else
            return HomalgRelationsForRightModule( rel_mat( gen_mat ) );
        fi;
    else
        Error( "unknown type of transition operation\n" );
    fi;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( HomalgGeneratorsForLeftModule,
  function( arg )
    local nargs, ar, R, generators, relations_of_hullmodule, gen;
    
    nargs := Length( arg );
    
    for ar in arg{ [ 2 .. nargs ] } do
        if IsHomalgRing( ar ) then
            R := ar;
            break;
        fi;
    od;
    
    if IsHomalgMatrix( arg[1] ) then
        ResetFilterObj( arg[1], IsMutable );
        generators := arg[1];
    elif IsBound( R ) then
        generators := HomalgMatrix( arg[1], R );
    else
        Error( "if the first argument isn't of type IsHomalgMatrix, then the last argument must be of type IsHomalgRing\n" );
    fi;
    
    if not IsBound( R ) then
        R := HomalgRing( generators );
    fi;
    
    for ar in arg{ [ 2 .. nargs ] } do
        if IsHomalgRelations( ar ) then
            if not IsHomalgRelationsOfLeftModule( ar ) then
                Error( "the set of relations of the hull module of the generators is not a set of relations of a left module\n" );
            fi;
            relations_of_hullmodule := ar;
            break;
        elif IsHomalgMatrix( ar ) then
            relations_of_hullmodule := HomalgRelationsForLeftModule( ar );
            break;
        elif IsList( ar ) and not IsStringRep( ar ) and IsBound( R ) then
            relations_of_hullmodule := HomalgRelationsForLeftModule( ar, R );
            break;
        elif nargs > 2 then
            if IsBound( R ) then
                relations_of_hullmodule := HomalgRelationsForLeftModule( ar, R );
                break;
            else
                Error( "if more than two arguments are provided and the second argument is neither of type IsHomalgRelations nor of type IsHomalgMatrix, then the last argument must be of type IsHomalgRing\n" );
            fi;
        fi;
    od;
    
    if not IsBound( relations_of_hullmodule ) then
        relations_of_hullmodule :=
          HomalgRelationsForLeftModule( HomalgZeroMatrix( 0, NrColumns( generators ), R ) );
    fi;
    
    gen := rec( generators := generators,
                relations_of_hullmodule := relations_of_hullmodule );
    
    ## Objectify:
    Objectify( TheTypeHomalgGeneratorsOfFinitelyGeneratedLeftModule, gen );
    
    return gen;
    
end );

##
InstallGlobalFunction( HomalgGeneratorsForRightModule,
  function( arg )
    local nargs, ar, R, generators, relations_of_hullmodule, gen;
    
    nargs := Length( arg );
    
    for ar in arg{ [ 2 .. nargs ] } do
        if IsHomalgRing( ar ) then
            R := ar;
            break;
        fi;
    od;
    
    if IsHomalgMatrix( arg[1] ) then
        ResetFilterObj( arg[1], IsMutable );
        generators := arg[1];
    elif IsBound( R ) then
        generators := HomalgMatrix( arg[1], R );
    else
        Error( "if the first argument isn't of type IsHomalgMatrix, then the last argument must be of type IsHomalgRing\n" );
    fi;
    
    if not IsBound( R ) then
        R := HomalgRing( generators );
    fi;
    
    for ar in arg{ [ 2 .. nargs ] } do
        if IsHomalgRelations( ar ) then
            if not IsHomalgRelationsOfRightModule( ar ) then
                Error( "the set of relations of the hull module of the generators is not a set of relations of a right module\n" );
            fi;
            relations_of_hullmodule := ar;
            break;
        elif IsHomalgMatrix( ar ) then
            relations_of_hullmodule := HomalgRelationsForRightModule( ar );
            break;
        elif IsList( ar ) and not IsStringRep( ar ) and IsBound( R ) then
            relations_of_hullmodule := HomalgRelationsForRightModule( ar, R );
            break;
        elif nargs > 2 then
            if IsBound( R ) then
                relations_of_hullmodule := HomalgRelationsForRightModule( ar, R );
                break;
            else
                Error( "if more than two arguments are provided and the second argument is neither of type IsHomalgRelations nor of type IsHomalgMatrix, then the last argument must be of type IsHomalgRing\n" );
            fi;
        fi;
    od;
    
    if not IsBound( relations_of_hullmodule ) then
        relations_of_hullmodule :=
          HomalgRelationsForRightModule( HomalgZeroMatrix( NrRows( generators ), 0, R ) );
    fi;
    
    gen := rec( generators := generators,
                relations_of_hullmodule := relations_of_hullmodule );
    
    ## Objectify:
    Objectify( TheTypeHomalgGeneratorsOfFinitelyGeneratedRightModule, gen );
    
    return gen;
    
end );

##
InstallMethod( RingMap,
        "for homalg rings",
        [ IsHomalgGenerators, IsHomalgRing, IsHomalgRing ],
        
  function( images, S, T )
    local R, psi;
    
    if IsIdenticalObj( HomalgRing( images ), T ) then
        psi := RingMap( MatrixOfGenerators( images ), S, T );
    else
        psi := RingMap( T * MatrixOfGenerators( images ), S, T );
    fi;
    
    if IsHomalgGeneratorsOfLeftModule( images ) then
        psi!.left := true;
    else
        psi!.left := false;
    fi;
    
    return psi;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( ViewObj,
        "for homalg generators",
        [ IsHomalgGenerators ],
        
  function( o )
    local g;
    
    g := NrGenerators( o );
    
    if g = 0 then
        Print( "<An empty set of generators " );
    elif g = 1 then
        Print( "<A set consisting of a single generator " );
    else
        Print( "<A set of ", g, " generators " );
    fi;
    
    Print( "of a homalg " );
    
    if IsHomalgGeneratorsOfLeftModule( o ) then
        Print( "left " );
    else
        Print( "right " );
    fi;
    
    Print( "module>" );
    
end );

InstallMethod( Display,
        "for homalg generators",
        [ IsHomalgGenerators ],
        
  function( o )
    local g;
    
    g := NrGenerators( o );
    
    if g = 0 then
        Print( "an empty set of generators\n" );
    else
        Display( MatrixOfGenerators( o ) );
        
        Print( "\na set " );
        
        if g = 1 then
            Print( "consisting of a single generator given by (the" );
        else
            Print( "of ", g, " generators given by the" );
        fi;
        
        if IsHomalgGeneratorsOfLeftModule( o ) then
            Print( " row" );
        else
            Print( " column" );
        fi;
        
        if g = 1 then
            Print( " of)" );
        else
            Print( "s of" );
        fi;
        
        Print( " the above matrix\n" );
    fi;
    
end );

InstallMethod( Display,
        "for homalg generators",
        [ IsHomalgGenerators and HasProcedureToReadjustGenerators ],
        
  function( o )
    local g, mat, proc, l, i;
    
    g := NrGenerators( o );
    
    if g = 0 then
        Print( "an empty set of generators\n" );
    else
        mat := MatrixOfGenerators( o );
        
        proc := ProcedureToReadjustGenerators( o );
        l := Length( proc );
    
        if IsHomalgGeneratorsOfLeftModule( o ) then
            for i in [ 1 .. NrGenerators( o ) ] do
                Display( CallFuncList( proc[1], Concatenation( [ CertainRows( mat, [ i ] ) ], proc{[ 2 .. l ]} ) ) ); Print( "\n" );
            od;
        else
            for i in [ 1 .. NrGenerators( o ) ] do
                Display( CallFuncList( proc[1], Concatenation( [ CertainColumns( mat, [ i ] ) ], proc{[ 2 .. l ]} ) ) ); Print( "\n" );
            od;
        fi;
        
        Print( "a set " );
        
        if g = 1 then
            Print( "consisting of a single generator" );
        else
            Print( "of ", g, " generators" );
        fi;
        
        Print( " given by the the above " );
        
        if g = 1 then
            Print( "matrix\n" );
        else
            Print( "matrices\n" );
        fi;
    fi;
    
end );
