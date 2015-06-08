#############################################################################
##
##  HomalgFiltration.gi         homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for a filtration.
##
#############################################################################

####################################
#
# representations:
#
####################################

# a new representation for the GAP-category IsHomalgFiltration:
DeclareRepresentation( "IsFiltrationOfFinitelyPresentedObjectRep",
        IsHomalgFiltration,
        [ "degrees" ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgFiltrations",
        NewFamily( "TheFamilyOfHomalgFiltrations" ) );

# four new types:
BindGlobal( "TheTypeHomalgDescendingFiltrationOfLeftObject",
        NewType(  TheFamilyOfHomalgFiltrations,
                IsFiltrationOfFinitelyPresentedObjectRep and
                IsHomalgFiltrationOfLeftObject and
                IsDescendingFiltration ) );

BindGlobal( "TheTypeHomalgAscendingFiltrationOfLeftObject",
        NewType(  TheFamilyOfHomalgFiltrations,
                IsFiltrationOfFinitelyPresentedObjectRep and
                IsHomalgFiltrationOfLeftObject and
                IsAscendingFiltration ) );

BindGlobal( "TheTypeHomalgDescendingFiltrationOfRightObject",
        NewType(  TheFamilyOfHomalgFiltrations,
                IsFiltrationOfFinitelyPresentedObjectRep and
                IsHomalgFiltrationOfRightObject and
                IsDescendingFiltration ) );

BindGlobal( "TheTypeHomalgAscendingFiltrationOfRightObject",
        NewType(  TheFamilyOfHomalgFiltrations,
                IsFiltrationOfFinitelyPresentedObjectRep and
                IsHomalgFiltrationOfRightObject and
                IsAscendingFiltration ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( StructureObject,
        "for filtration of homalg objects",
        [ IsFiltrationOfFinitelyPresentedObjectRep ],
        
  function( filt )
    
    return StructureObject( LowestDegreeMorphism( filt ) );
    
end );

##
InstallMethod( DegreesOfFiltration,
        "for filtrations of homalg objects",
        [ IsFiltrationOfFinitelyPresentedObjectRep ],
        
  function( filt )
    
    return filt!.degrees;
    
end );

##
InstallMethod( LowestDegree,
        "for filtrations of homalg objects",
        [ IsFiltrationOfFinitelyPresentedObjectRep ],
        
  function( filt )
    
    return DegreesOfFiltration( filt )[1];
    
end );

##
InstallMethod( HighestDegree,
        "for filtrations of homalg objects",
        [ IsFiltrationOfFinitelyPresentedObjectRep ],
        
  function( filt )
    local degrees;
    
    degrees := DegreesOfFiltration( filt );
    
    return degrees[Length( degrees )];
    
end );

##
InstallMethod( CertainMorphism,
        "for filtrations of homalg objects",
        [ IsFiltrationOfFinitelyPresentedObjectRep, IsInt ],
        
  function( filt, p )
    
    if not IsBound( filt!.(String( p )) ) then
        return fail;
    fi;
    
    return filt!.(String( p ));
    
end );

##
InstallMethod( CertainObject,
        "for filtrations of homalg objects",
        [ IsFiltrationOfFinitelyPresentedObjectRep, IsInt ],
        
  function( filt, p )
    
    return Source( CertainMorphism( filt, p ) );
    
end );

##
InstallMethod( ObjectsOfFiltration,
        "for filtrations of homalg objects",
        [ IsFiltrationOfFinitelyPresentedObjectRep ],
        
  function( filt )
    
    return List( DegreesOfFiltration( filt ), p -> CertainObject( filt, p ) );
    
end );

##
InstallMethod( LowestDegreeObject,
        "for filtrations of homalg objects",
        [ IsFiltrationOfFinitelyPresentedObjectRep ],
        
  function( filt )
    
    return CertainObject( filt, LowestDegree( filt ) );
    
end );

##
InstallMethod( HighestDegreeObject,
        "for filtrations of homalg objects",
        [ IsFiltrationOfFinitelyPresentedObjectRep ],
        
  function( filt )
    
    return CertainObject( filt, HighestDegree( filt ) );
    
end );

##
InstallMethod( MorphismsOfFiltration,
        "for filtrations of homalg objects",
        [ IsFiltrationOfFinitelyPresentedObjectRep ],
        
  function( filt )
    
    return List( DegreesOfFiltration( filt ), p -> CertainMorphism( filt, p ) );
    
end );

##
InstallMethod( LowestDegreeMorphism,
        "for filtrations of homalg objects",
        [ IsFiltrationOfFinitelyPresentedObjectRep ],
        
  function( filt )
    
    return CertainMorphism( filt, LowestDegree( filt ) );
    
end );

##
InstallMethod( HighestDegreeMorphism,
        "for filtrations of homalg objects",
        [ IsFiltrationOfFinitelyPresentedObjectRep ],
        
  function( filt )
    
    return CertainMorphism( filt, HighestDegree( filt ) );
    
end );

##
InstallMethod( UnderlyingObject,
        "for filtration of homalg objects",
        [ IsFiltrationOfFinitelyPresentedObjectRep ],
        
  function( filt )
    
    return Range( LowestDegreeMorphism( filt ) );
    
end );

##
InstallMethod( UnlockObject,
        "for homalg filtrations",
        [ IsHomalgFiltration ],
        
  function( filt )
    
    UnlockObject( UnderlyingObject( filt ) );
    
    return filt;
    
end );

##
InstallMethod( UnlockObject,
        "for homalg filtrations",
        [ IsHomalgFiltration ],
        
  function( filt )
    
    UnlockObject( filt );
    
    Perform( ObjectsOfFiltration( filt ), UnlockObject );
    
    return filt;
    
end );

##
InstallMethod( \*,
        "for a homalg filtration and a homalg epimorphism",
        [ IsHomalgFiltration, IsHomalgStaticMorphism ],
        
  function( filt, epi )
    local img_filt, degrees, p;
    
    if not IsEpimorphism( epi ) then
        Error( "the second argument must be an epimorphism\n" );
    fi;
    
    degrees := DegreesOfFiltration( filt );
    
    img_filt := rec( degrees := degrees );
    
    for p in degrees do
        img_filt.(String( p )) := PreCompose( CertainMorphism( filt, p ), epi );
    od;
    
    if IsAscendingFiltration( filt ) then
        img_filt := HomalgAscendingFiltration( img_filt );
    else
        img_filt := HomalgDescendingFiltration( img_filt );
    fi;
    
    if HasIsFiltration( filt ) and IsFiltration( filt ) then
        SetIsFiltration( img_filt, true );
    fi;
    
    return img_filt;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( HomalgFiltration,
  function( arg )
    local nargs, ascending, pre_filtration, degrees, l, filtration, i,
          gen_emb, monomorphism_aid, gen_map, left, type, properties, ar;
    
    nargs := Length( arg );
    
    if nargs = 0 then
        Error( "empty arguments\n" );
    fi;
    
    if arg[nargs] = "ascending" then
        ascending := true;
    elif arg[nargs] = "descending" then
        ascending := false;
    else
        Error( "the last argument must be either \"ascending\" or \"descending\"\n" );
    fi;
    
    pre_filtration := arg[1];
    
    if IsRecord( pre_filtration ) and not IsBound( pre_filtration!.degrees ) and IsList( pre_filtration!.degrees ) and not IsEmpty( pre_filtration!.degrees ) then
        Error( "the first argument must be a record containing, as a component, a non-empty list of degrees\n" );
    fi;
    
    if IsBound( pre_filtration.telescope ) and pre_filtration.telescope = true then
        return CallFuncList( HomalgFiltrationFromTelescope, arg );
    elif IsBound( pre_filtration.tower ) and pre_filtration.tower = true then
        return CallFuncList( HomalgFiltrationFromTower, arg );
    fi;
    
    degrees := pre_filtration!.degrees;
    
    if degrees = [ ] then
        Error( "empty range\n" );
    fi;
    
    ConvertToRangeRep( degrees );
    
    l := Length( degrees );
    
    ## construct the filtration out of the pre_filtration
    filtration := rec( );
    
    filtration.degrees := degrees;
    
    if IsBound( pre_filtration.bidegrees ) then
        filtration.bidegrees := pre_filtration.bidegrees;
    fi;
    
    i := String( degrees[1] );
    
    if not IsBound( pre_filtration!.(String( i )) ) then
        Error( "cannot find a morphism at degree ", i, "\n" );
    fi;
    
    gen_emb := pre_filtration!.(String( i ));
    
    if  l = 1 then
        
        ## check assertion
        Assert( 3, IsIsomorphism( gen_emb ) );
        
        SetIsIsomorphism( gen_emb, true );
        
    else
        
        ## the bottom map must be a monomorphism
        Assert( 3, IsMonomorphism( gen_emb ) );
        
        SetIsMonomorphism( gen_emb, true );
        
    fi;
    
    filtration.(String( i )) := gen_emb;
    
    monomorphism_aid := gen_emb;
    
    for i in degrees{[ 2 .. l - 1 ]} do
        
        gen_map := pre_filtration!.(String( i ));
        
        gen_emb := GeneralizedMorphism( gen_map, monomorphism_aid );
        
        ## check assertion
        Assert( 3, IsGeneralizedMonomorphism( gen_emb ) );
        
        SetIsGeneralizedMonomorphism( gen_emb, true );
        
        filtration.(String( i )) := gen_emb;
        
        ## prepare the next step
        monomorphism_aid := CoproductMorphism( monomorphism_aid, gen_map );
        
    od;
    
    if l > 1 then
        
        ## the last step
        i := degrees[l];
        
        gen_map := pre_filtration!.(String( i ));
        
        gen_emb := GeneralizedMorphism( gen_map, monomorphism_aid );
        
        ## the upper one but be a generalized isomorphism
        Assert( 3, IsGeneralizedIsomorphism( gen_emb ) );
        
        SetIsGeneralizedIsomorphism( gen_emb, true );
        
        filtration.(String( i )) := gen_emb;
        
    fi;
    
    ## finalize
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( gen_emb );
    
    if left then
        if ascending then
            type := TheTypeHomalgAscendingFiltrationOfLeftObject;
        else
            type := TheTypeHomalgDescendingFiltrationOfLeftObject;
        fi;
    else
        if ascending then
            type := TheTypeHomalgAscendingFiltrationOfRightObject;
        else
            type := TheTypeHomalgDescendingFiltrationOfRightObject;
        fi;
    fi;
    
    properties := arg{[ 2 .. nargs - 1 ]};
    
    ar := Concatenation( [ filtration, type ], properties );
    
    ## Objectify:
    CallFuncList( ObjectifyWithAttributes, ar );
    
    return filtration;
    
end );

##
InstallGlobalFunction( HomalgFiltrationFromTelescope,
  function( arg )
    local telescope, degrees, l, pre_filtration, rev_degrees, i,
          coker_emb, ar;
    
    telescope := arg[1];
    
    if IsBound( telescope.degrees ) then
        degrees := telescope.degrees;
    else
        Error( "the telescope does not contain a component called degrees\n" );
    fi;
    
    l := Length( degrees );
    
    pre_filtration := rec( degrees := degrees );
    
    rev_degrees := Reversed( degrees );
    
    pre_filtration.(String( rev_degrees[1] )) := telescope.(String( rev_degrees[1] ));
    
    for i in rev_degrees{[ 2 .. l ]} do
        pre_filtration.(String( i )) :=
          PreCompose( telescope.(String( i )), pre_filtration.(String( i + 1 )) );
    od;
    
    pre_filtration.(String( degrees[1] )) := ImageObjectEmb( pre_filtration.(String( degrees[1] )) );
    
    ByASmallerPresentation( Source( pre_filtration.(String( degrees[1] )) ) );
    
    for i in degrees{[ 2 .. l ]} do
        coker_emb := CokernelNaturalGeneralizedIsomorphism( telescope.(String( i - 1 )) );
        ByASmallerPresentation( Source( coker_emb ) );
        pre_filtration.(String( i )) :=
          PreCompose( coker_emb, pre_filtration.(String( i )) );
    od;
    
    ar := Concatenation( [ pre_filtration ], arg{[ 2 .. Length( arg ) ]} );
    
    return CallFuncList( HomalgFiltration, ar );
    
end );

#
InstallGlobalFunction( HomalgFiltrationFromTower,
  function( arg )
    local tower, degrees, l, pre_filtration, i, emb, ar;
    
    tower := arg[1];
    
    if IsBound( tower.degrees ) then
        degrees := tower.degrees;
    else
        Error( "the tower does not contain a component called degrees\n" );
    fi;
    
    l := Length( degrees );
    
    pre_filtration := rec( degrees := degrees );
    
    pre_filtration.(String( degrees[1] )) := ImageObjectEmb( tower.(String( degrees[1] )) );
    
    ByASmallerPresentation( Source( pre_filtration.(String( degrees[1] )) ) );
    
    for i in degrees{[ 2 .. l ]} do
        emb :=
          NaturalGeneralizedEmbedding(
                  ImageSubobject( tower.(String( i )) ) / ImageSubobject( tower.(String( i - 1 )) ) );
        ByASmallerPresentation( Source( emb ) );
        pre_filtration.(String( i )) := emb;
    od;
    
    ar := Concatenation( [ pre_filtration ], arg{[ 2 .. Length( arg ) ]} );
    
    return CallFuncList( HomalgFiltration, ar );
    
end );

##
InstallGlobalFunction( HomalgDescendingFiltration,
  function( arg )
    
    return CallFuncList( HomalgFiltration, Concatenation( arg, [ "descending" ] ) );
    
end );

##
InstallGlobalFunction( HomalgAscendingFiltration,
  function( arg )
    
    return CallFuncList( HomalgFiltration, Concatenation( arg, [ "ascending" ] ) );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for homalg filtration",
        [ IsFiltrationOfFinitelyPresentedObjectRep ],
        
  function( o )
    local degrees, l, plural, purity, the, p, s;
    
    degrees := DegreesOfFiltration( o );
    
    l := Length( degrees );
    
    plural := l > 1;
    
    purity := HasIsPurityFiltration( o ) and IsPurityFiltration( o );
    
    the := purity;
    
    if the then
        Print( "<The" );
    else
        Print( "<A" );
    fi;
    
    if IsDescendingFiltration( o ) then
        Print( " de" );
    else
        if the then
            Print( " a" );
        else
            Print( "n a" );
        fi;
    fi;
    
    Print( "scending " );
    
    if purity then
        Print( "purity " );
    fi;
    
    if IsDescendingFiltration( o ) then
        degrees := Reversed( degrees );		## we want to start with the highest (sub)factor
    fi;
    
    if plural then
        Print( "filtration with degrees ", degrees, " and graded parts:\n" );
    else
        Print( "trivial filtration with degree ", degrees, " and graded part:\n" );
    fi;
    
    if IsAscendingFiltration( o ) then
        degrees := Reversed( degrees );		## we want to start with the highest (sub)factor
    fi;
    
    for p in degrees do
        s := ListWithIdenticalEntries( 4 - Length( String( p ) ), ' ' );
        ConvertToStringRep( s );
        Print( s, p, ":\t" );
        ViewObj( CertainObject( o, p ) );
        Print( "\n" );
    od;
    
    Print( "of\n" );
    ViewObj( UnderlyingObject( o ) );
    Print( ">" );
    
end );

##
InstallMethod( Display,
        "for homalg filtration",
        [ IsFiltrationOfFinitelyPresentedObjectRep ],
        
  function( o )
    local degrees, l, d;
    
    degrees := DegreesOfFiltration( o );
    
    degrees := Reversed( degrees );		## we want to start with the highest (sub)factor
    
    l := Length( degrees );
    
    for d in degrees{[ 1 .. l - 1 ]} do
        Print( "Degree ", d, ":\n\n" );
        Display( CertainObject( o, d ) );
        Print( "----------\n" );
    od;
    
    Print( "Degree ", degrees[l], ":\n\n" );
    Display( CertainObject( o, degrees[l] ) );
    
end );
