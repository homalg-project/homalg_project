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

####################################
#
# constructor functions and methods:
#
####################################

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

