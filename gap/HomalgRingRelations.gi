#############################################################################
##
##  HomalgRingRelations.gi      MatricesForHomalg package    Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, RWTH-Aachen University
##
##  Implementation stuff for a set of relations.
##
#############################################################################

####################################
#
# representations:
#
####################################

##  <#GAPDoc Label="IsRingRelationsRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="rel" Name="IsRingRelationsRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of a finite set of relations of a finitely presented &homalg; module. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgRingRelations"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsRingRelationsRep",
        IsHomalgRingRelations,
        [ ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgRingRelations",
        NewFamily( "TheFamilyOfHomalgRingRelations" ) );

# two new types:
BindGlobal( "TheTypeHomalgRingRelationsAsGeneratorsOfLeftIdeal",
        NewType(  TheFamilyOfHomalgRingRelations,
                IsRingRelationsRep and IsHomalgRingRelationsAsGeneratorsOfLeftIdeal ) );

BindGlobal( "TheTypeHomalgRingRelationsAsGeneratorsOfRightIdeal",
        NewType(  TheFamilyOfHomalgRingRelations,
                IsRingRelationsRep and IsHomalgRingRelationsAsGeneratorsOfRightIdeal ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( DegreesOfGenerators,
        "for sets of ring relations",
        [ IsHomalgRingRelations ],
        
  function( rel )
    
    if IsBound(rel!.DegreesOfGenerators) then
        return rel!.DegreesOfGenerators;
    fi;
    
    return fail;
    
end );

##
InstallMethod( EvaluatedMatrixOfRingRelations,
        "for sets of ring relations",
        [ IsHomalgRingRelations and HasEvalMatrixOfRingRelations ],
        
  function( rel )
    local func_arg;
    
    func_arg := EvalMatrixOfRingRelations( rel );
    
    ResetFilterObj( rel, EvalMatrixOfRingRelations );
    
    ## delete the component which was left over by GAP
    Unbind( rel!.EvalMatrixOfRingRelations );
    
    return CallFuncList( func_arg[1], func_arg[2] );
    
end );

##
InstallMethod( MatrixOfRelations,
        "for sets of ring relations",
        [ IsHomalgRingRelations ],
        
  function( rel )
    
    return EvaluatedMatrixOfRingRelations( rel );
    
end );

##
InstallMethod( \=,
        "for homalg relations",
        [ IsHomalgRingRelationsAsGeneratorsOfRightIdeal, IsHomalgRingRelationsAsGeneratorsOfRightIdeal ],
        
  function( rel1, rel2 )
    
    return MatrixOfRelations( rel1 ) = MatrixOfRelations( rel2 );
    
end );

##
InstallMethod( \=,
        "for homalg relations",
        [ IsHomalgRingRelationsAsGeneratorsOfLeftIdeal, IsHomalgRingRelationsAsGeneratorsOfLeftIdeal ],
        
  function( rel1, rel2 )
    
    return MatrixOfRelations( rel1 ) = MatrixOfRelations( rel2 );
    
end );

##
InstallMethod( HomalgRing,
        "for sets of ring relations",
        [ IsHomalgRingRelations ],
        
  function( rel )
    
    return HomalgRing( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( HomalgRing,
        "for sets of ring relations",
        [ IsHomalgRingRelations and HasEvalMatrixOfRingRelations ],
        
  function( rel )
    
    return HomalgRing( EvalMatrixOfRingRelations( rel )[2][1] );
    
end );

##
InstallMethod( HasNrRelations,
        "for sets of ring relations",
        [ IsHomalgRingRelationsAsGeneratorsOfRightIdeal ],
        
  function( rel )
    
    if HasEvaluatedMatrixOfRingRelations( rel ) then
        return HasNrColumns( MatrixOfRelations( rel ) );
    fi;
    
    return false;
    
end );

##
InstallMethod( HasNrRelations,
        "for sets of ring relations",
        [ IsHomalgRingRelationsAsGeneratorsOfLeftIdeal ],
        
  function( rel )
    
    if HasEvaluatedMatrixOfRingRelations( rel ) then
        return HasNrRows( MatrixOfRelations( rel ) );
    fi;
    
    return false;
    
end );

##
InstallMethod( NrRelations,			### defines: NrRelations (NumberOfRows)
        "for sets of ring relations",
        [ IsHomalgRingRelationsAsGeneratorsOfRightIdeal ],
        
  function( rel )
    
    return NrColumns( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( NrRelations,			### defines: NrRelations (NumberOfRows)
        "for sets of ring relations",
        [ IsHomalgRingRelationsAsGeneratorsOfLeftIdeal ],
        
  function( rel )
    
    return NrRows( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( CertainRelations,		### defines: CertainRelations
        "for sets of ring relations",
        [ IsHomalgRingRelationsAsGeneratorsOfRightIdeal, IsList ],
        
  function( rel, plist )
    local sub_rel;
    
    sub_rel := CertainColumns( MatrixOfRelations( rel ), plist );
    
    ## take care of gradings
    if IsList( DegreesOfGenerators( rel ) ) then
        sub_rel!.DegreesOfGenerators := DegreesOfGenerators( rel );
    fi;
    
    return HomalgRingRelationsAsGeneratorsOfRightIdeal( sub_rel );
    
end );

##
InstallMethod( CertainRelations,		### defines: CertainRelations
        "for sets of ring relations",
        [ IsHomalgRingRelationsAsGeneratorsOfLeftIdeal, IsList ],
        
  function( rel, plist )
    local sub_rel;
    
    sub_rel := CertainRows( MatrixOfRelations( rel ), plist );
    
    ## take care of gradings
    if IsList( DegreesOfGenerators( rel ) ) then
        sub_rel!.DegreesOfGenerators := DegreesOfGenerators( rel );
    fi;
    
    return HomalgRingRelationsAsGeneratorsOfLeftIdeal( sub_rel );
    
end );

##
InstallMethod( UnionOfRelations,		### defines: UnionOfRelations (SumRelations)
        "for sets of ring relations",
        [ IsHomalgMatrix, IsHomalgRingRelationsAsGeneratorsOfRightIdeal ],
        
  function( mat1, rel2 )
    local rel;
    
    rel := UnionOfColumns( mat1, MatrixOfRelations( rel2 ) );
    
    rel := HomalgRingRelationsAsGeneratorsOfRightIdeal( rel );
    
    ## take care of gradings
    if IsList( DegreesOfGenerators( rel2 ) ) then
        rel!.DegreesOfGenerators := DegreesOfGenerators( rel2 );
    fi;
    
    return rel;
    
end );

##
InstallMethod( UnionOfRelations,
        "for sets of ring relations",
        [ IsHomalgRingRelationsAsGeneratorsOfRightIdeal, IsHomalgMatrix ],
        
  function( rel1, mat2 )
    
    return UnionOfRelations( mat2, rel1 );
    
end );

##
InstallMethod( UnionOfRelations,
        "for sets of ring relations",
        [ IsHomalgRingRelationsAsGeneratorsOfRightIdeal, IsHomalgRingRelationsAsGeneratorsOfRightIdeal ],
        
  function( rel1, rel2 )
    
    return UnionOfRelations( MatrixOfRelations( rel1 ), rel2 );
    
end );

##
InstallMethod( UnionOfRelations,		### defines: UnionOfRelations (SumRelations)
        "for sets of ring relations",
        [ IsHomalgMatrix, IsHomalgRingRelationsAsGeneratorsOfLeftIdeal ],
        
  function( mat1, rel2 )
    local rel;
    
    rel := UnionOfRows( mat1, MatrixOfRelations( rel2 ) );
    
    rel := HomalgRingRelationsAsGeneratorsOfLeftIdeal( rel );
    
    ## take care of gradings
    if IsList( DegreesOfGenerators( rel2 ) ) then
        rel!.DegreesOfGenerators := DegreesOfGenerators( rel2 );
    fi;
    
    return rel;
    
end );

##
InstallMethod( UnionOfRelations,
        "for sets of ring relations",
        [ IsHomalgRingRelationsAsGeneratorsOfLeftIdeal, IsHomalgMatrix ],
        
  function( rel1, mat2 )
    
    return UnionOfRelations( mat2, rel1 );
    
end );

##
InstallMethod( UnionOfRelations,
        "for sets of ring relations",
        [ IsHomalgRingRelationsAsGeneratorsOfLeftIdeal, IsHomalgRingRelationsAsGeneratorsOfLeftIdeal ],
        
  function( rel1, rel2 )
    
    return UnionOfRelations( MatrixOfRelations( rel1 ), rel2 );
    
end );

##
InstallMethod( BasisOfModule,
        "for sets of ring relations",
        [ IsHomalgRingRelationsAsGeneratorsOfRightIdeal ],
        
  function( rel )
    local mat, bas, inj, M, rk;
    
    if not IsBound( rel!.BasisOfModule ) then
        mat := MatrixOfRelations( rel );
        
        bas := BasisOfColumns( mat );
        
        inj := HasIsRightRegularMatrix( bas ) and IsRightRegularMatrix( bas );
        
        if bas = mat then
            SetCanBeUsedToDecideZero( rel, true );
            rel!.EvaluatedMatrixOfRingRelations := bas;	## when computing over finite fields in Maple taking a basis normalizes the entries
            if inj then
                SetIsInjectivePresentation( rel, true );
            fi;
            return rel;
        else
            rel!.BasisOfModule := bas;
            SetCanBeUsedToDecideZero( rel, false );
        fi;
    else
        bas := rel!.BasisOfModule;
        inj := HasIsRightRegularMatrix( bas ) and IsRightRegularMatrix( bas );
    fi;
    
    bas := HomalgRingRelationsAsGeneratorsOfRightIdeal( bas );
    
    if inj then
        SetIsInjectivePresentation( bas, true );
    fi;
    
    SetCanBeUsedToDecideZero( bas, true );
    
    return bas;
end );

##
InstallMethod( BasisOfModule,
        "for sets of ring relations",
        [ IsHomalgRingRelationsAsGeneratorsOfLeftIdeal ],
        
  function( rel )
    local mat, bas, inj, M, rk;
    
    if not IsBound( rel!.BasisOfModule ) then
        mat := MatrixOfRelations( rel );
        
        bas := BasisOfRows( mat );
        
        inj := HasIsLeftRegularMatrix( bas ) and IsLeftRegularMatrix( bas );
        
        if bas = mat then
            SetCanBeUsedToDecideZero( rel, true );
            rel!.EvaluatedMatrixOfRingRelations := bas;	## when computing over finite fields in Maple taking a basis normalizes the entries
            if inj then
                SetIsInjectivePresentation( rel, true );
            fi;
            return rel;
        else
            rel!.BasisOfModule := bas;
            SetCanBeUsedToDecideZero( rel, false );
        fi;
    else
        bas := rel!.BasisOfModule;
        inj := HasIsLeftRegularMatrix( bas ) and IsLeftRegularMatrix( bas );
    fi;
    
    bas := HomalgRingRelationsAsGeneratorsOfLeftIdeal( bas );
    
    if inj then
        SetIsInjectivePresentation( bas, true );
    fi;
    
    SetCanBeUsedToDecideZero( bas, true );
    
    return bas;
end );

##
InstallMethod( BasisOfModule,
        "for sets of ring relations",
        [ IsHomalgRingRelations and CanBeUsedToDecideZero ],
        
  function( rel )
    
    return rel;
    
end );

##  <#GAPDoc Label="DecideZero:matrix_rel">
##  <ManSection>
##    <Oper Arg="mat, rel" Name="DecideZero" Label="for matrices and relations"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##    <Listing Type="Code"><![CDATA[
InstallMethod( DecideZero,
        "for sets of ring relations",
        [ IsHomalgMatrix, IsHomalgRingRelations ],
        
  function( mat, rel )
    local rel_mat;
    
    rel_mat := MatrixOfRelations( BasisOfModule( rel ) );
    
    if IsHomalgRingRelationsAsGeneratorsOfLeftIdeal( rel ) then
        return DecideZeroRows( mat, rel_mat );
    else
        return DecideZeroColumns( mat, rel_mat );
    fi;
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##

##
InstallMethod( DecideZero,
        "for sets of ring relations",
        [ IsHomalgRingRelationsAsGeneratorsOfRightIdeal, IsHomalgRingRelationsAsGeneratorsOfRightIdeal ],
        
  function( rel_, rel )
    
    return HomalgRingRelationsAsGeneratorsOfRightIdeal( DecideZero( MatrixOfRelations( rel_ ), rel ) );
    
end );

##
InstallMethod( DecideZero,
        "for sets of ring relations",
        [ IsHomalgRingRelationsAsGeneratorsOfLeftIdeal, IsHomalgRingRelationsAsGeneratorsOfLeftIdeal ],
        
  function( rel_, rel )
    
    return HomalgRingRelationsAsGeneratorsOfLeftIdeal( DecideZero( MatrixOfRelations( rel_ ), rel ) );
    
end );

##
InstallMethod( BasisCoeff,
        "for sets of ring relations",
        [ IsHomalgRingRelationsAsGeneratorsOfRightIdeal ],
        
  function( rel )
    local bas;
    
    if not IsBound( rel!.BasisOfModule ) then
        rel!.BasisOfModule := BasisOfColumnsCoeff( MatrixOfRelations( rel ) );
        SetCanBeUsedToDecideZero( rel, false );
    fi;
    
    bas := HomalgRingRelationsAsGeneratorsOfRightIdeal( rel!.BasisOfModule, HomalgRing( rel ) );
    
    SetCanBeUsedToDecideZero( bas, true );
    
    return bas;
    
end );

##
InstallMethod( BasisCoeff,
        "for sets of ring relations",
        [ IsHomalgRingRelationsAsGeneratorsOfLeftIdeal ],
        
  function( rel )
    local bas;
    
    if not IsBound( rel!.BasisOfModule ) then
        rel!.BasisOfModule := BasisOfRowsCoeff( MatrixOfRelations( rel ) );
        SetCanBeUsedToDecideZero( rel, false );
    fi;
    
    bas := HomalgRingRelationsAsGeneratorsOfLeftIdeal( rel!.BasisOfModule, HomalgRing( rel ) );
    
    SetCanBeUsedToDecideZero( bas, true );
    
    return bas;
    
end );

##
InstallMethod( RightDivide,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgRingRelationsAsGeneratorsOfLeftIdeal ],
        
  function( B, A, L )
    local BL;
    
    BL := BasisOfModule( L );
    
    return RightDivide( B, A, MatrixOfRelations( BL ) );
    
end );

##
InstallMethod( LeftDivide,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgRingRelationsAsGeneratorsOfRightIdeal ],
        
  function( A, B, L )
    local BL;
    
    BL := BasisOfModule( L );
    
    return LeftDivide( A, B, MatrixOfRelations( BL ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for sets of ring relations",
        [ IsHomalgRingRelationsAsGeneratorsOfRightIdeal ],
        
  function( rel )
    
    return HomalgRingRelationsAsGeneratorsOfRightIdeal( SyzygiesOfColumns( MatrixOfRelations( rel ) ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for sets of ring relations",
        [ IsHomalgMatrix, IsHomalgRingRelationsAsGeneratorsOfRightIdeal ],
        
  function( mat, rel )
    
    return HomalgRingRelationsAsGeneratorsOfRightIdeal( SyzygiesOfColumns( mat, MatrixOfRelations( rel ) ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for sets of ring relations",
        [ IsHomalgRingRelationsAsGeneratorsOfLeftIdeal ],
        
  function( rel )
    
    return HomalgRingRelationsAsGeneratorsOfLeftIdeal( SyzygiesOfRows( MatrixOfRelations( rel ) ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for sets of ring relations",
        [ IsHomalgMatrix, IsHomalgRingRelationsAsGeneratorsOfLeftIdeal ],
        
  function( mat, rel )
    
    return HomalgRingRelationsAsGeneratorsOfLeftIdeal( SyzygiesOfRows( mat, MatrixOfRelations( rel ) ) );
    
end );

##
InstallMethod( ReducedSyzygiesGenerators,
        "for sets of ring relations",
        [ IsHomalgRingRelationsAsGeneratorsOfRightIdeal ],
        
  function( rel )
    
    return HomalgRingRelationsAsGeneratorsOfRightIdeal( ReducedSyzygiesOfColumns( MatrixOfRelations( rel ) ) );
    
end );

##
InstallMethod( ReducedSyzygiesGenerators,
        "for sets of ring relations",
        [ IsHomalgMatrix, IsHomalgRingRelationsAsGeneratorsOfRightIdeal ],
        
  function( mat, rel )
    
    return HomalgRingRelationsAsGeneratorsOfRightIdeal( ReducedSyzygiesOfColumns( mat, MatrixOfRelations( rel ) ) );
    
end );

##
InstallMethod( ReducedSyzygiesGenerators,
        "for sets of ring relations",
        [ IsHomalgRingRelationsAsGeneratorsOfLeftIdeal ],
        
  function( rel )
    
    return HomalgRingRelationsAsGeneratorsOfLeftIdeal( ReducedSyzygiesOfRows( MatrixOfRelations( rel ) ) );
    
end );

##
InstallMethod( ReducedSyzygiesGenerators,
        "for sets of ring relations",
        [ IsHomalgMatrix, IsHomalgRingRelationsAsGeneratorsOfLeftIdeal ],
        
  function( mat, rel )
    
    return HomalgRingRelationsAsGeneratorsOfLeftIdeal( ReducedSyzygiesOfRows( mat, MatrixOfRelations( rel ) ) );
    
end );

##
InstallMethod( GetRidOfObsoleteRelations,	### defines: GetRidOfObsoleteRelations (BetterBasis)
        "for sets of ring relations",
        [ IsHomalgRingRelationsAsGeneratorsOfRightIdeal ],
        
  function( M )
    
    return HomalgRingRelationsAsGeneratorsOfRightIdeal( GetRidOfObsoleteColumns( MatrixOfRelations( M ) ) );
    
end );

##
InstallMethod( GetRidOfObsoleteRelations,	### defines: GetRidOfObsoleteRelations (BetterBasis)
        "for sets of ring relations",
        [ IsHomalgRingRelationsAsGeneratorsOfLeftIdeal ],
        
  function( M )
    
    return HomalgRingRelationsAsGeneratorsOfLeftIdeal( GetRidOfObsoleteRows( MatrixOfRelations( M ) ) );
    
end );

##
InstallMethod( POW,
        "for sets of ring relations",
        [ IsHomalgRingRelations, IsHomalgMatrix ],
        
  function( rel, mat )
    local relations;
    
    relations := MatrixOfRelations( rel );
    
    if IsHomalgRingRelationsAsGeneratorsOfLeftIdeal( rel ) then
        return relations * mat;
    else
        return mat * relations;
    fi;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( HomalgRingRelationsAsGeneratorsOfLeftIdeal,
  function( arg )
    local l, relations, mat, M;
    
    l := Length( arg );
    
    relations := rec( );
    
    if IsHomalgMatrix( arg[1] ) then
        mat := arg[1];
        ResetFilterObj( mat, IsMutableMatrix );
    elif IsFunction( arg[1] ) then
        
        if not ( l > 1 and IsList( arg[2] ) ) then
            Error( "if the first argument is a function then the second argument must be the list of arguments\n" );
        fi;
        
        ## Objectify:
        ObjectifyWithAttributes(
                relations, TheTypeHomalgRingRelationsAsGeneratorsOfLeftIdeal,
                EvalMatrixOfRingRelations, arg{[ 1 .. 2 ]} );
        
        return relations;
    else
        mat := CallFuncList( HomalgMatrix, arg );
    fi;
    
    ## Objectify:
    ObjectifyWithAttributes(
            relations, TheTypeHomalgRingRelationsAsGeneratorsOfLeftIdeal,
            EvaluatedMatrixOfRingRelations, mat );
    
    return relations;
    
end );

##
InstallGlobalFunction( HomalgRingRelationsAsGeneratorsOfRightIdeal,
        function( arg )
    local l, relations, mat, M;
    
    l := Length( arg );
    
    relations := rec( );
    
    if IsHomalgMatrix( arg[1] ) then
        mat := arg[1];
        ResetFilterObj( mat, IsMutableMatrix );
    elif IsFunction( arg[1] ) then
        
        if not ( l > 1 and IsList( arg[2] ) ) then
            Error( "if the first argument is a function then the second argument must be the list of arguments\n" );
        fi;
        
        ## Objectify:
        ObjectifyWithAttributes(
                relations, TheTypeHomalgRingRelationsAsGeneratorsOfRightIdeal,
                EvalMatrixOfRingRelations, arg{[ 1 .. 2 ]} );
        
        return relations;
    else
        mat := CallFuncList( HomalgMatrix, arg );
    fi;
    
    ## Objectify:
    ObjectifyWithAttributes(
            relations, TheTypeHomalgRingRelationsAsGeneratorsOfRightIdeal,
            EvaluatedMatrixOfRingRelations, mat );
    
    return relations;
    
end );

##
InstallMethod( ShallowCopy,
        "for homalg relations",
        [ IsHomalgRingRelations ],
        
  function( rel )
    local rel_new, c;
    
    if HasEvaluatedMatrixOfRingRelations( rel ) then
        if IsHomalgRingRelationsAsGeneratorsOfLeftIdeal( rel ) then
            rel_new := HomalgRingRelationsAsGeneratorsOfLeftIdeal( EvaluatedMatrixOfRingRelations( rel ) );
        else
            rel_new := HomalgRingRelationsAsGeneratorsOfRightIdeal( EvaluatedMatrixOfRingRelations( rel ) );
        fi;
    elif HasEvalMatrixOfRingRelations( rel ) then
        if IsHomalgRingRelationsAsGeneratorsOfLeftIdeal( rel ) then
            rel_new := CallFuncList( HomalgRingRelationsAsGeneratorsOfLeftIdeal, EvalMatrixOfRingRelations( rel ) );
        else
            rel_new := CallFuncList( HomalgRingRelationsAsGeneratorsOfRightIdeal, EvalMatrixOfRingRelations( rel ) );
        fi;
    fi;
    
    for c in [ "DegreesOfGenerators", "BasisOfModule", "MaximumNumberOfResolutionSteps" ] do
        if IsBound( rel!.( c ) ) then
            rel_new!.( c ) := rel!.( c );
        fi;
    od;
    
    return rel_new;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( ViewObj,
        "for homalg relations",
        [ IsHomalgRingRelations ],
        
  function( o )
    local m;
    
    if HasNrRelations( o ) then
        m := NrRelations( o );
    else
        m := "unknown number";
    fi;
    
    if IsString( m ) then
        Print( "<A set of ring relations " );
    elif m = 0 then
        Print( "<An empty set of ring relations " );
    elif m = 1 then
        Print( "<A set containing a single ring relation " );
    else
        Print( "<A set of ", m, " ring relations " );
    fi;
    
    Print( "as generators of a " );
    
    if IsHomalgRingRelationsAsGeneratorsOfLeftIdeal( o ) then
        Print( "left " );
    else
        Print( "right " );
    fi;
    
    Print( "ideal>" );
    
end );

InstallMethod( Display,
        "for homalg relations",
        [ IsHomalgRingRelations ],
        
  function( o )
    local m;
    
    m := NrRelations( o );
    
    if m = 0 then
        Print( "an empty set of ring relations\n" );
    else
        Display( MatrixOfRelations( o ) );
        
        Print( "\n" );
        
        if m = 1 then
            Print( "a single ring relation " );
        else
            Print( m, " relations " );
        fi;
        
        Print( "given by " );
        
        if m = 1 then
            Print( "(" );
        fi;
        
        Print( "the " );
        
        if IsHomalgRingRelationsAsGeneratorsOfLeftIdeal( o ) then
            Print( "row" );
        else
            Print( "column" );
        fi;
        
        if m = 1 then
            Print( " of)" );
        else
            Print( "s of" );
        fi;
        
        Print( " the above matrix\n" );
        
    fi;
    
end );
