#############################################################################
##
##  HomalgMorphism.gi             homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for homalg morphisms.
##
#############################################################################

####################################
#
# representations:
#
####################################

# a new representation for the category IsHomalgMorphism:
DeclareRepresentation( "IsMorphismOfFinitelyGeneratedModulesRep",
        IsHomalgMorphism,
        [ "source", "target", "list_of_source_target_indices" ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "HomalgMorphismsFamily",
        NewFamily( "HomalgMorphismsFamily" ) );

# a new type:
BindGlobal( "HomalgMorphismOfLeftModulesType",
        NewType( HomalgMorphismsFamily ,
                IsMorphismOfFinitelyGeneratedModulesRep and IsHomalgMorphismOfLeftModules ) );

BindGlobal( "HomalgMorphismOfRightModulesType",
        NewType( HomalgMorphismsFamily ,
                IsMorphismOfFinitelyGeneratedModulesRep and IsHomalgMorphismOfRightModules ) );

####################################
#
# logical implications methods:
#
####################################

##
InstallTrueMethod( IsRightInvertibleMorphism, IsHomalgMorphism and IsIsomorphism );

##
InstallTrueMethod( IsLeftInvertibleMorphism, IsHomalgMorphism and IsIsomorphism );

## a surjective and an injective morphism between two free modules of finite rank is invertible
InstallTrueMethod( IsInvertibleMorphism, IsHomalgMorphism and IsLeftInvertibleMorphism and IsRightInvertibleMorphism );

####################################
#
# immediate methods for properties:
#
####################################

####################################
#
# immediate methods for attributes:
#
####################################

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( IsZeroMorphism,
        "for homalg morphisms",
        [ IsHomalgMorphism ],
        
  function( phi )
    
    IsZeroMatrix( AnyMatrixOfMorphism( phi ) );
    
end );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( HomalgRing,
        "for homalg morphisms",
        [ IsHomalgMorphism ],
        
  function( phi )
    
    return HomalgRing( SourceOfMorphism( phi ) );
    
end );

##
InstallMethod( SourceOfMorphism,
        "for homalg morphisms",
        [ IsHomalgMorphism ],
        
  function( phi )
    
    return phi!.source;
    
end );

##
InstallMethod( TargetOfMorphism,
        "for homalg morphisms",
        [ IsHomalgMorphism ],
        
  function( phi )
    
    return phi!.target;
    
end );

##
InstallMethod( MatrixOfMorphism,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep and IsHomalgMorphismOfLeftModules ],
        
  function( phi )
    local pos_s, pos_t, l, pos, matrix;
    
    pos_s := PositionOfTheDefaultSetOfRelations( SourceOfMorphism( phi ) );
    pos_t := PositionOfTheDefaultSetOfRelations( TargetOfMorphism( phi ) );
    
    l := phi!.list_of_source_target_indices;
    
    if not [ pos_s, pos_t ] in l then
        
        pos := PositionProperty( l, a -> a[1] = pos_s );
        
        if IsPosInt( pos ) then
            matrix := phi.( String( l[pos] ) ) * TargetOfMorphism( phi )!.TransitionMatrices.( String( [ l[pos][2], pos_t ] ) );
        else
            
            pos := PositionProperty( l, a -> a[2] = pos_t );
            
            if IsPosInt( pos ) then
                matrix := SourceOfMorphism( phi )!.TransitionMatrices.( String( [ pos_s, l[pos][1] ] ) ) * phi.( String( l[pos] ) );
            else
                Error( "Something went wrong: No way to compute the morphism matrix relative to the ", pos_s, ". set of relations of the source and the ", pos_t, ". of the target\n" );
            fi;
            
        fi;
        
        phi.( String( l[pos] ) ) := matrix;
        
    fi;
    
    return phi!.( String( [ pos_s, pos_t ] ) );
    
end );

##
InstallMethod( AreComparableMorphisms,
        "for homalg morphisms",
        [ IsHomalgMorphism, IsHomalgMorphism ],
        
  function( phi1, phi2 )
    
    return IsIdenticalObj( SourceOfMorphism( phi1 ), SourceOfMorphism( phi2 ) )
           and IsIdenticalObj( TargetOfMorphism( phi1 ), TargetOfMorphism( phi2 ) );
    
end );

##
InstallMethod( \=,
        "for homalg comparable morphisms",
        [ IsHomalgMorphism, IsHomalgMorphism ],
        
  function( phi1, phi2 )
    
    if not AreComparableMorphisms( phi1, phi2 ) then
        return false;
    fi;
    
    return MatrixOfMorphism( phi1 ) = MatrixOfMorphism( phi2 );
    
end );

##
InstallMethod( ZeroMutable,
        "for homalg morphisms",
        [ IsHomalgMorphism ],
        
  function( phi )
    
    return HomalgMorphism( "zero", NrRows( phi ), NrColumns( phi ), HomalgRing( phi ) );
    
end );

##
InstallMethod( \*,
        "of two homalg morphisms",
        [ IsRingElement, IsHomalgMorphism ], 1001, ## it could otherwise run into the method ``PROD: negative integer * additive element with inverse'', value: 24
        
  function( a, A )
    local R, C;
    
    R := HomalgRing( A );
    
    C := HomalgMorphism( R );
    
    SetEvalMulMat( C, [ a, A ] );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) );
    
    return C;
    
end );

##
InstallMethod( \+,
        "of two homalg morphisms",
        [ IsHomalgMorphism, IsHomalgMorphism ],
        
  function( A, B )
    local R, C;
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two morphisms are not summable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two morphisms are not summable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    R := HomalgRing( A );
    
    C := HomalgMorphism( R );
    
    SetEvalAddMat( C, [ A, B ] );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) );
    
    return C;
    
end );

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "of homalg morphisms",
        [ IsHomalgMorphism ],
        
  function( A )
    local R, C;
    
    R := HomalgRing( A );
    
    C := MinusOne( R ) * A;
    
    if HasIsZeroMorphism( A ) then
        SetIsZeroMorphism( C, IsZeroMorphism( A ) );
    fi;
    
    return C;
    
end );

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "of homalg morphisms",
        [ IsHomalgMorphism and IsZeroMorphism ],
        
  function( A )
    
    return A;
    
end );

##
InstallMethod( \-,
        "of two homalg morphisms",
        [ IsHomalgMorphism, IsHomalgMorphism ],
        
  function( A, B )
    local R, C;
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two morphisms are not substractable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two morphisms are not substractable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    R := HomalgRing( A );
    
    C := HomalgMorphism( R );
    
    SetEvalSubMat( C, [ A, B ] );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) );
    
    return C;
    
end );

##
InstallMethod( \*,
        "of two homalg morphisms",
        [ IsHomalgMorphism, IsHomalgMorphism ],
        
  function( A, B )
    local R, C;
    
    if NrColumns( A ) <> NrRows( B ) then
        Error( "the two morphisms are not composable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrRows( B ), " row(s)\n" );
    fi;
    
    R := HomalgRing( A );
    
    C := HomalgMorphism( R );
    
    SetEvalCompose( C, [ A, B ] );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( B ) );
    
    return C;
    
end );

##
InstallMethod( LeftInverse,
        "for homalg morphisms",
        [ IsHomalgMorphism ],
        
  function( phi )
    local R, C;
    
    R := HomalgRing( phi );
    
    C := HomalgMorphism( R );
    
    if NrRows( phi ) < NrColumns( phi ) then
        Error( "the number of rows ", NrRows( phi ), "is smaller than the number of columns ", NrColumns( phi ), "\n" );
    fi;
    
    SetEvalLeftInverse( C, M );
    SetEvalRightInverse( M, C );
    
    SetNrRows( C, NrColumns( phi ) );
    SetNrColumns( C, NrRows( phi ) );
    
    return C;
    
end );

##
InstallMethod( LeftInverse,
        "for homalg morphisms",
        [ IsHomalgMorphism and IsZeroMorphism ],
        
  function( phi )
    
    if NrColumns( phi ) = 0 then
        return HomalgMorphism( "zero", 0, NrRows( phi ), HomalgRing( phi ) );
    else
        Error( "a zero matrix with positive number of columns has no left inverse!" );
    fi;
    
end );

##
InstallMethod( RightInverse,
        "for homalg morphisms",
        [ IsHomalgMorphism ],
        
  function( phi )
    local R, C;
    
    R := HomalgRing( phi );
    
    C := HomalgMorphism( R );
    
    if NrColumns( phi ) < NrRows( phi ) then
        Error( "the number of columns ", NrColumns( phi ), "is smaller than the number of rows ", NrRows( phi ), "\n" );
    fi;
    
    SetEvalRightInverse( C, M );
    SetEvalLeftInverse( M, C );
    
    SetNrColumns( C, NrRows( phi ) );
    SetNrRows( C, NrColumns( phi ) );
    
    return C;
    
end );

##
InstallMethod( RightInverse,
        "for homalg morphisms",
        [ IsHomalgMorphism and IsZeroMorphism ],
        
  function( phi )
    
    if NrRows( phi ) = 0 then
        return HomalgMorphism( "zero", NrColumns( phi ), 0, HomalgRing( phi ) );
    else
        Error( "a zero matrix with positive number of rows has no left inverse!" );
    fi;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

InstallGlobalFunction( HomalgMorphism,
  function( arg )
    local nargs, R, type, ar, morphism, M;
    
    nargs := Length( arg );
    
    R := arg[nargs];
    
    if not IsHomalgRing( R ) then
        Error( "the last argument must be an IsHomalgRing" );
    fi;
    
    type := HomalgMorphismType;
    
    morphism := rec( ring := R );
    
    if nargs = 1 then ## only the ring is given
    ## an empty morphism
        
        ## Objectify:
        Objectify( type, morphism );
        
        return morphism;
        
    elif IsString( arg[1] ) and Length( arg[1] ) > 2 then
    ## it can get obscure ;)
        
        if LowercaseString( arg[1]{[1..3]} ) = "int" then
            
            ## Objectify:
            Objectify( HomalgMorphismType, morphism );
            
            return morphism;
            
        elif LowercaseString( arg[1]{[1..3]} ) = "ext" then
            
            ## Objectify:
            Objectify( HomalgMorphismType, morphism );
            
            return morphism;
            
        fi;
        
    fi; ## CAUTION: don't make an elif here!!!
    
    if IsString( arg[1] ) and Length( arg[1] ) > 1 and  LowercaseString( arg[1]{[1..2]} ) = "id" then
    ## the identity morphism:
        
        ## Objectify:
        ObjectifyWithAttributes(
                morphism, type,
                IsIdentityMorphism, true );
        
        if Length( arg ) > 2 and arg[2] in NonnegativeIntegers then
            SetNrRows( morphism, arg[2] );
            SetNrColumns( morphism, arg[2] );
        fi;
        
        return morphism;
        
    elif IsString( arg[1] ) and Length( arg[1] ) > 3 and LowercaseString( arg[1]{[1..4]} ) = "init" then
    ## an initial morphism having the flag IsInitialMorphism
    ## and filled with zeros BUT NOT marked as an IsZeroMorphism:
        
        ## Objectify:
        ObjectifyWithAttributes(
                morphism, type,
                IsInitialMorphism, true );
        
        if Length( arg ) > 2 and arg[2] in NonnegativeIntegers then
            SetNrRows( morphism, arg[2] );
        fi;
        
        if Length( arg ) > 3 and arg[3] in NonnegativeIntegers then
            SetNrColumns( morphism, arg[3] );
        fi;
        
        return morphism;
        
    elif IsString( arg[1] ) and Length( arg[1] ) > 3 and LowercaseString( arg[1]{[1..4]} ) = "void" then
    ## a void morphism filled with nothing having the flag IsVoidMorphism:
        
        ## Objectify:
        ObjectifyWithAttributes(
                morphism, type,
                IsVoidMorphism, true );
        
        if Length( arg ) > 2 and arg[2] in NonnegativeIntegers then
            SetNrRows( morphism, arg[2] );
        fi;
        
        if Length( arg ) > 3 and arg[3] in NonnegativeIntegers then
            SetNrColumns( morphism, arg[3] );
        fi;
            
        return morphism;
        
    elif IsString( arg[1] ) and Length( arg[1] ) > 3 and LowercaseString( arg[1]{[1..4]} ) = "zero" then
    ## the zero morphism:
        
        ## Objectify:
        ObjectifyWithAttributes(
                morphism, type,
                IsZeroMorphism, true );
        
        if Length( arg ) > 2 and arg[2] in NonnegativeIntegers then
            SetNrRows( morphism, arg[2] );
        fi;
        
        if Length( arg ) > 3 and arg[3] in NonnegativeIntegers then
            SetNrColumns( morphism, arg[3] );
        fi;
        
        return morphism;
        
    fi;
    
    if IsList( arg[1] ) and Length( arg[1] ) <> 0 and not IsList( arg[1][1] ) then
        M := List( arg[1], a -> [a] ); ## NormalizeInput
    else
        M := arg[1];
    fi;
    
    if IsList( arg[1] ) then ## HomalgMorphismType
        
        ## Objectify:
        ObjectifyWithAttributes(
                morphism, HomalgMorphismType,
                Eval, M );
        
        if Length( arg[1] ) = 0 then
            SetNrRows( morphism, 0 );
            SetNrColumns( morphism, 0 );
        elif arg[1][1] = [] then
            SetNrRows( morphism, Length( arg[1] ) );
            SetNrColumns( morphism, 0 );
        elif not IsList( arg[1][1] ) then
            SetNrRows( morphism, Length( arg[1] ) );
            SetNrColumns( morphism, 1 );
        elif IsMorphism( arg[1] ) then
            SetNrRows( morphism, Length( arg[1] ) );
            SetNrColumns( morphism, Length( arg[1][1] ) );
        fi;
    else ## HomalgMorphismType
        
        ## Objectify:
        ObjectifyWithAttributes(
                morphism, HomalgMorphismType,
                Eval, M );
        
    fi;
    
    return morphism;
    
end );
  
####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( ViewObj,
        "for homalg morphisms",
        [ IsHomalgMorphism and IsZeroMorphism ],
        
  function( o )
    
    if HasEval( o ) then
        Print( "<A" );
    else
        Print( "<An unevaluated" );
    fi;
    
    Print( " homalg " );
    
    Print( "zero morphism>" );
    
end );

InstallMethod( ViewObj,
        "for homalg morphisms",
        [ IsHomalgMorphism and IsIdentityMorphism ],
        
  function( o )
    
    if HasEval( o ) then
        Print( "<A " );
    else
        Print( "<An unevaluated " );
    fi;
    
    Print( "homalg " );
    
    Print( "identity morphism>" );
    
end );

InstallMethod( ViewObj,
        "for homalg morphisms",
        [ IsHomalgMorphism ],
        
  function( o )
    local first_attribute;
    
    first_attribute := true;
    
    if not HasEval( o ) then
        Print( "<An unevaluated" );
    else
        Print( "<A" );
        first_attribute := false;
    fi;
    
    if HasIsZeroMorphism( o ) then ## if this method applies and HasIsZeroMorphism is set we already know that o is a non-zero homalg matrix
        Print( " non-zero" );
        first_attribute := true;
    fi;
    
    if not ( HasNrRows( o ) and NrRows( o ) = 1 and HasNrColumns( o ) and NrColumns( o ) = 1 ) then
        if HasIsDiagonalMorphism( o ) and IsDiagonalMorphism( o ) then
            Print( " diagonal" );
        elif HasIsStrictUpperTriangularMorphism( o ) and IsStrictUpperTriangularMorphism( o ) then
            Print( " strict upper triangular" );
        elif HasIsStrictLowerTriangularMorphism( o ) and IsStrictLowerTriangularMorphism( o ) then
            Print( " strict lower triangular" );
        elif HasIsUpperTriangularMorphism( o ) and IsUpperTriangularMorphism( o ) then
            if not first_attribute then
                Print( "n upper triangular" );
            else
                Print( " upper triangular" );
            fi;
        elif HasIsLowerTriangularMorphism( o ) and IsLowerTriangularMorphism( o ) then
            Print( " lower triangular" );
        elif HasIsTriangularMorphism( o ) and IsTriangularMorphism( o ) then
            Print( " triangular" );
        elif not first_attribute then
            first_attribute := fail;
        fi;
        
        if first_attribute <> fail then
            first_attribute := true;
        else
            first_attribute := false;
        fi;
        
        if HasIsInvertibleMorphism( o ) and IsInvertibleMorphism( o ) then
            if not first_attribute then
                Print( "n invertible" );
            else
                Print( " invertible" );
            fi;
        else
            if HasIsRightInvertibleMorphism( o ) and IsRightInvertibleMorphism( o ) then
                Print( " right invertible" );
            elif HasIsFullRowRankMorphism( o ) and IsFullRowRankMorphism( o ) then
                Print( " full row rank" );
            fi;
            
            if HasIsLeftInvertibleMorphism( o ) and IsLeftInvertibleMorphism( o ) then
                Print( " left invertible" );
            elif HasIsFullColumnRankMorphism( o ) and IsFullColumnRankMorphism( o ) then
                Print( " full column rank" );
            fi;
        fi;
    fi;
    
    Print( " homalg " );
    
    if IsHomalgMorphismRep( o ) then
        Print( "internal " );
    else
        Print( "external " );
    fi;
    
    if HasNrRows( o ) then
        Print( NrRows( o ), " " );
        if not HasNrColumns( o ) then
            Print( "by (unknown number of columns) " );
        fi;
    fi;
    
    if HasNrColumns( o ) then
        if not HasNrRows( o ) then
            Print( "(unknown number of rows) " );
        fi;
        Print( "by ", NrColumns( o ), " " );
    fi;
    
    Print( "matrix>" );
    
end );

InstallMethod( Display,
        "for homalg morphisms",
        [ IsHomalgMorphismRep ],
        
  function( o )
    
    Display( MatrixOfMorphism( o ) );
    
end);

