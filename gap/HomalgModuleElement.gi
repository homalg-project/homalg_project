#############################################################################
##
##  HomalgModuleElement.gi                                   Modules package
##
##  Copyright 2011 Mohamed Barakat, University of Kaiserslautern
##
##  Implementations for module elements.
##
#############################################################################

##  <#GAPDoc Label="ModuleElements:intro">
##  An element of a module <M>M</M> is internally represented by a module map from the (distinguished)
##  rank 1 free module to the module <M>M</M>. In particular, the data structure for module elements
##  automatically profits from the intrinsic realization of morphisms in the &homalg; project.
##  <#/GAPDoc>

####################################
#
# representations:
#
####################################

##  <#GAPDoc Label="IsElementOfAModuleGivenByAMorphismRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="M" Name="IsElementOfAModuleGivenByAMorphismRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of elements of modules. <P/>
##      (It is a subrepresentation of <Ref BookName="homalg" Filt="IsElementOfAnObjectGivenByAMorphismRep"/>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsElementOfAModuleGivenByAMorphismRep",
        IsHomalgModuleElement and
        IsElementOfAnObjectGivenByAMorphismRep,
        [ ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgModuleElements",
        NewFamily( "TheFamilyOfHomalgModuleElements" ) );

# a new type:
BindGlobal( "TheTypeHomalgModuleElement",
        NewType( TheFamilyOfHomalgModuleElements,
                IsElementOfAModuleGivenByAMorphismRep ) );

HOMALG_MODULES.category.TypeOfElements := TheTypeHomalgModuleElement;

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( IsElementOfIntegers,
        "for module elements",
        [ IsHomalgModuleElement ],
        
  function( m )
    local T, R;
    
    T := Range( UnderlyingMorphism( m ) );
    
    R := HomalgRing( T );
    
    return HasIsIntegersForHomalg( R ) and IsIntegersForHomalg( R ) and
           HasRankOfObject( T ) and RankOfObject( T ) = 1 and
           IsBound( T!.distinguished ) and T!.distinguished = true;
    
end );

####################################
#
# methods for operations:
#
####################################

##  <#GAPDoc Label="HomalgRing:module_element">
##  <ManSection>
##    <Oper Arg="m" Name="HomalgRing" Label="for module elements"/>
##    <Returns>a &homalg; ring</Returns>
##    <Description>
##      The &homalg; ring of the &homalg; module element <A>m</A>.
##      <#Include Label="HomalgRing:module_element:example">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( HomalgRing,
        "for module elements",
        [ IsElementOfAModuleGivenByAMorphismRep ],
        
  function( m )
    
    return HomalgRing( Source( UnderlyingMorphism( m ) ) );
    
end );


##  <#GAPDoc Label="UnderlyingListOfRingElements">
##  <ManSection>
##    <Oper Arg="m" Name="UnderlyingListOfRingElements" Label="for module elements"/>
##    <Returns>a list of Integers</Returns>
##    <Description>
##      The list of ring elements of the module element <A>m</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( UnderlyingListOfRingElements,
       "for module elements",
       [ IsHomalgModuleElement ],
       
  function ( m )
    
    return EntriesOfHomalgMatrix( MatrixOfMap( UnderlyingMorphism( m ) ) );
    
end );

##  <#GAPDoc Label="UnderlyingListOfRingElementsInCurrentPresentation">
##  <ManSection>
##    <Oper Arg="m" Name="UnderlyingListOfRingElementsInCurrentRepresentation" Label="for module elements"/>
##    <Returns>a list of Integers</Returns>
##    <Description>
##      The list of ring elements of the module element <A>m</A> in the current representation of the module.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( UnderlyingListOfRingElementsInCurrentPresentation,
       "for module elements",
       [ IsHomalgModuleElement ],
       
  function ( m )
    
    return EntriesOfHomalgMatrix( MatrixOfMap( UnderlyingMorphism( m ) ) );
    
end );

##  <#GAPDoc Label="LT:module_element">
##  <ManSection>
##    <Oper Arg="m,n" Name="LT" Label="for module elements"/>
##    <Returns>a &homalg; ring</Returns>
##    <Description>
##      Check if <A>m</A> is <Q>less than</Q> <A>n</A>.
##    <Listing Type="Code"><![CDATA[
InstallMethod( LT,
        "for two module elements in Z",
        [ IsHomalgElement, IsHomalgElement ], 1001,
        
  function( m, n )
    
    if IsElementOfIntegers( m ) then
        
        return EvalString( String( m ) ) < EvalString( String( n ) );
        
    fi;
    
    TryNextMethod( );
    
end );
##  ]]></Listing>
##      <#Include Label="LT:module_element:example">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##
InstallMethod( One,
        "for module elements in cyclic groups",
        [ IsHomalgElement ],
        
  function( m )
    local T, o, S;
    
    T := Range( UnderlyingMorphism( m ) );
    
    if HasIsCyclic( T ) and IsCyclic( T ) then
        o := HomalgIdentityMatrix( 1, HomalgRing( T ) );
        S := HomalgRing( T );
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( T ) then
            S := 1 * S;
        else
            S := S * 1;
        fi;
        o := HomalgMap( o, S, T );
        return HomalgElement( o );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( TheZeroElement,
        "for homalg modules",
        [ IsHomalgModule ],
        
  function( A )
    
    return HomalgElement( TheZeroMorphism( HomalgRing( A ), A ) );
    
end );

##
InstallMethod( IsIdenticalObjForFunctors,
        "for module elements",
        [ IsHomalgModuleElement, IsHomalgModuleElement ],
        
  function( element1, element2 )
    
    return element1 = element2;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( HomalgModuleElement,
        "for a homalg matrix and a homalg module",
        [ IsHomalgMatrix, IsFinitelyPresentedModuleRep ],
        
  function( mat, M )
    local R, map;
    
    R := HomalgRing( M );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        R := 1 * R;
    else
        R := R * 1;
    fi;
    
    map := HomalgMap( mat, R, M );
    
    if HasIsZero( mat ) and NrRelations( M ) = 0 then
        SetIsZero( map, IsZero( mat ) );
    fi;
    
    return HomalgElement( map );
    
end );

##
InstallMethod( HomalgModuleElement,
        "for a string and a homalg left module",
        [ IsList, IsFinitelyPresentedModuleRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( s, M )
    
    return HomalgModuleElement( s, 1, NrGenerators( M ), M );
    
end );

##
InstallMethod( HomalgModuleElement,
        "for a string and a homalg right module",
        [ IsList, IsFinitelyPresentedModuleRep and IsHomalgRightObjectOrMorphismOfRightObjects ],
        
  function( s, M )
    
    return HomalgModuleElement( s, NrGenerators( M ), 1, M );
    
end );

##
InstallMethod( HomalgModuleElement,
        "for a string, two integers and a homalg module",
        [ IsList, IsInt, IsInt, IsFinitelyPresentedModuleRep ],
        
  function( s, i, j, M )
    local mat;
    
    mat := HomalgMatrix( s, i, j, HomalgRing( M ) );
    
    if not IsString( s ) then
        SetIsZero( mat, IsZero( s ) );
    fi;
    
    return HomalgModuleElement( mat, M );
    
end );

##
InstallMethod( \*,
        "for homalg elements",
        [ IsInt, IsHomalgModuleElement ],
        
  function( a, m )
    
    return HomalgElement( a * UnderlyingMorphism( m ) );
    
end );

##
InstallMethod( ZERO_MUT,
        "for homalg elements",
        [ IsHomalgModuleElement ],
        
  function( m )
    
    return HomalgElement( 0 * UnderlyingMorphism( m ) );
    
end );

## Max: LT assumes a total ordering!
InstallMethod( LT,
        "for Z-Modules",
        [ IsHomalgModuleElement, IsHomalgModuleElement ],
        
  function( m, n )
    local M, R;
    
    M := SuperObject( m );
    
    R := HomalgRing( M );
    
    if HasIsIntegersForHomalg( R ) and IsIntegersForHomalg( R ) and
       NrGenerators( M ) = 1 and IsTorsionFree( M ) and IsIdenticalObj( M, SuperObject( n ) ) then
        
        return UnderlyingListOfRingElements( m )[ 1 ] < UnderlyingListOfRingElements( n )[ 1 ];
        
    fi;
    
    TryNextMethod();
    
end );

## Max: LT assumes a total ordering!
InstallMethod( LT,
        "for Z-Modules",
        [ IsInt, IsHomalgModuleElement ],
        
  function( m, n )
    local M, R;
    
    M := SuperObject( n );
    
    R := HomalgRing( M );
    
    if HasIsIntegersForHomalg( R ) and IsIntegersForHomalg( R ) and
       NrGenerators( M ) = 1 and IsTorsionFree( M ) then
        
        return m < UnderlyingListOfRingElements( n )[ 1 ];
        
    fi;
    
    TryNextMethod();
    
end );

## Max: LT assumes a total ordering!
InstallMethod( LT,
        "for Z-Modules",
        [ IsHomalgModuleElement, IsInt ],
        
  function( m, n )
    local M, R;
    
    M := SuperObject( m );
    
    R := HomalgRing( M );
    
    if HasIsIntegersForHomalg( R ) and IsIntegersForHomalg( R ) and
       NrGenerators( M ) = 1 and IsTorsionFree( M ) then
        
        return UnderlyingListOfRingElements( m )[ 1 ] < n;
        
    fi;
    
    TryNextMethod();
    
end );

##
InstallMethod( LessThan,
        "for Z as homalg module",
        [ IsHomalgModuleElement, IsHomalgModuleElement ],
        
  function( m, n )
    local M, R;
    
    M := SuperObject( m );
    
    if not IsIdenticalObj( M, SuperObject( n ) ) then
        
        Error( "cannot compare elements which are not in the same module" );
        
    fi;
    
    R := HomalgRing( M );
    
    if HasIsIntegersForHomalg( R ) and IsIntegersForHomalg( R ) and
       NrGenerators( M ) > 1 or not IsTorsionFree( M ) then
        
        TryNextMethod();
        
    fi;
    
    return UnderlyingListOfRingElements( m )[ 1 ] < UnderlyingListOfRingElements( n )[ 1 ];
    
end );

##
InstallMethod( LessThanOrEqual,
        "for Z as homalg module",
        [ IsHomalgModuleElement, IsHomalgModuleElement ],
        
  function( m, n )
    
    return ( m = n ) or LessThan( m, n );
    
end );

##
InstallMethod( GreaterThan,
        "for Z as homalg module",
        [ IsHomalgModuleElement, IsHomalgModuleElement ],
        
  function( m, n )
    
    return LessThan( n, m );
    
end );

##
InstallMethod( GreaterThanOrEqual,
        "for Z as homalg module",
        [ IsHomalgModuleElement, IsHomalgModuleElement ],
        
  function( m, n )
    
    return ( m = n ) or LessThan( n, m );
    
end );

##
InstallMethod( HomalgElementToInteger,
        "for an homalg element that represents an integer",
        [ IsHomalgModuleElement ],
        
  function( m )
    local M, R;
    
    M := SuperObject( m );
    
    R := HomalgRing( M );
    
    if HasIsIntegersForHomalg( R ) and IsIntegersForHomalg( R ) then
        if NrGenerators( M ) = 1 and IsTorsionFree( M ) then
            
            return UnderlyingListOfRingElements( m )[ 1 ];
            
        elif NrGenerators( M ) = 0 then
            
            return 0;
            
        fi;
    fi;
    
    TryNextMethod();
    
end );

##
InstallMethod( HomalgElementToInteger,
        "do nothing for integers",
        [ IsInt ],
        
  IdFunc );

## I am not sure if this method in this position is
## a good idea. Had to delete declarations to make this possible.
## Maybe we should make this method more special.
InstallMethod( POW,
        "for integers",
        [ IsRingElement, IsHomalgModuleElement ],
        
  function( a, m )
    local M, R;
    
    M := SuperObject( m );
    
    R := HomalgRing( M );
    
    if HasIsIntegersForHomalg( R ) and IsIntegersForHomalg( R ) and
       NrGenerators( M ) = 1 and IsTorsionFree( M ) then
        
        return POW( a, UnderlyingListOfRingElements( m )[ 1 ] );
        
    fi;
    
    Error( "the degree group is not presented on a free generator" );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( String,
        "for homalg elements",
        [ IsHomalgModuleElement ],
        
  function( o )
    local m, mat, T, R;
    
    ## LT relies on Sting calling DecideZero
    DecideZero( o );
    
    m := UnderlyingMorphism( o );
    
    mat := MatrixOfMap( m );
    
    T := Range( m );
    
    R := HomalgRing( T );
    
    if NrGenerators( T ) = 1 then
        return String( EntriesOfHomalgMatrix( mat )[1] );
    fi;
    
    mat := EntriesOfHomalgMatrix( mat ) ;
    
    return String( mat );
    
end );

##
InstallMethod( ViewString,
        "for homalg elements",
        [ IsHomalgModuleElement ],
        
  function( o )
    local m, mat, T, R;
    
    DecideZero( o );
    
    m := UnderlyingMorphism( o );
    
    mat := MatrixOfMap( m );
    
    T := Range( m );
    
    R := HomalgRing( T );
    
    if NrGenerators( T ) = 1 then
        mat := EntriesOfHomalgMatrix( mat )[1];
        if IsHomalgInternalRingRep( R ) then
            return String( mat );
        else
            return Name( mat );
        fi;
    fi;
    
    mat := EntriesOfHomalgMatrix( mat ) ;
    
    if IsHomalgInternalRingRep( R ) then
        return String( mat );
    else
        return Concatenation( "[ ", JoinStringsWithSeparator( List( mat, Name ), ", " ), " ]" );
    fi;
    
end );

##
InstallMethod( ViewObj,
        "for homalg elements",
        [ IsHomalgModuleElement ],
        
  function( o )
    
    if IsZero( o ) then
        ViewObj( o );
        return;
    fi;
    
    Print( ViewString( o ) );
    
end );

##
InstallMethod( Display,
        "for homalg elements",
        [ IsHomalgModuleElement ],
        
  function( o )
    
    if IsZero( o ) then
        Display( o );
        return;
    fi;
    
    Print( ViewString( o ), "\n" );
    
end );

