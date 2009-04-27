#############################################################################
##
##  HomalgComplex.gi            homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for homalg complexes.
##
#############################################################################

####################################
#
# representations:
#
####################################

# two new representations for the GAP-category IsHomalgComplex

##  <#GAPDoc Label="IsComplexOfFinitelyPresentedObjectsRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="C" Name="IsComplexOfFinitelyPresentedObjectsRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; representation of complexes of finitley generated &homalg; modules. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgComplex"/>,
##       which is a subrepresentation of the &GAP; representation <C>IsFinitelyPresentedObjectRep</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsComplexOfFinitelyPresentedObjectsRep",
        IsHomalgComplex and IsFinitelyPresentedObjectRep,
        [  ] );

##  <#GAPDoc Label="IsCocomplexOfFinitelyPresentedObjectsRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="C" Name="IsCocomplexOfFinitelyPresentedObjectsRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; representation of cocomplexes of finitley generated &homalg; modules. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgComplex"/>,
##       which is a subrepresentation of the &GAP; representation <C>IsFinitelyPresentedObjectRep</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsCocomplexOfFinitelyPresentedObjectsRep",
        IsHomalgComplex and IsFinitelyPresentedObjectRep,
        [  ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgComplexes",
        NewFamily( "TheFamilyOfHomalgComplexes" ) );

# four new types:
BindGlobal( "TheTypeHomalgComplexOfLeftObjects",
        NewType( TheFamilyOfHomalgComplexes,
                IsComplexOfFinitelyPresentedObjectsRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgComplexOfRightObjects",
        NewType( TheFamilyOfHomalgComplexes,
                IsComplexOfFinitelyPresentedObjectsRep and IsHomalgRightObjectOrMorphismOfRightObjects ) );

BindGlobal( "TheTypeHomalgCocomplexOfLeftObjects",
        NewType( TheFamilyOfHomalgComplexes,
                IsCocomplexOfFinitelyPresentedObjectsRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgCocomplexOfRightObjects",
        NewType( TheFamilyOfHomalgComplexes,
                IsCocomplexOfFinitelyPresentedObjectsRep and IsHomalgRightObjectOrMorphismOfRightObjects ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( homalgResetFilters,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local property;
    
    if not IsBound( HOMALG.PropertiesOfComplexes ) then
        HOMALG.PropertiesOfComplexes :=
          [ IsZero,
            IsSequence,
            IsComplex,
            IsAcyclic,
            IsRightAcyclic,
            IsLeftAcyclic,
            IsGradedObject,
            IsExactSequence,
            IsShortExactSequence,
            IsTriangle,
            IsExactTriangle,
            IsSplitShortExactSequence ];
    fi;
    
    for property in HOMALG.PropertiesOfComplexes do
        ResetFilterObj( C, property );
    od;
    
    if HasBettiDiagram( C ) then
        ResetFilterObj( C, BettiDiagram );
        Unbind( C!.BettiDiagram );
    fi;
    
    if IsBound( C!.HomologyGradedObject ) then
        Unbind( C!.HomologyGradedObject );
    fi;
    
    if IsBound( C!.CohomologyGradedObject ) then
        Unbind( C!.CohomologyGradedObject );
    fi;
    
    if IsBound( C!.free_resolutions ) then
        Unbind( C!.free_resolutions );
    fi;
    
end );

##
InstallMethod( PositionOfTheDefaultSetOfRelations,	## provided to avoid branching in the code and always returns fail
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    return fail;
    
end );

##
InstallMethod( ObjectDegreesOfComplex,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    return C!.degrees;
    
end );

##
InstallMethod( MorphismDegreesOfComplex,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local degrees, l;
    
    degrees := ObjectDegreesOfComplex( C );
    
    l := Length( degrees );
    
    if l = 1 then
        return [  ];
    elif IsComplexOfFinitelyPresentedObjectsRep( C ) then
        return degrees{[ 2 .. l ]};
    else
        return degrees{[ 1 .. l - 1 ]};
    fi;
    
end );

##
InstallMethod( CertainMorphism,
        "for homalg complexes",
        [ IsHomalgComplex, IsInt ],
        
  function( C, i )
    
    if IsBound( C!.(String( i )) ) and IsHomalgMorphism( C!.(String( i )) ) then
        return C!.(String( i ));
    fi;
    
    return fail;
    
end );

##
InstallMethod( CertainObject,
        "for homalg complexes",
        [ IsHomalgComplex, IsInt ],
        
  function( C, i )
    local degrees, l;
    
    if IsBound( C!.(String( i )) ) then
        if IsHomalgObject( C!.(String( i )) ) then
            return C!.(String( i ));
        else
            return Source( C!.(String( i )) );
        fi;
    fi;
    
    degrees := ObjectDegreesOfComplex( C );
    l := Length( degrees );
    
    if IsComplexOfFinitelyPresentedObjectsRep( C ) and degrees[1] = i then
        return Range( CertainMorphism( C, i + 1 ) );
    elif IsCocomplexOfFinitelyPresentedObjectsRep( C ) and degrees[l] = i then
        return Range( CertainMorphism( C, i - 1 ) );
    fi;
    
    return fail;
    
end );

##
InstallMethod( MorphismsOfComplex,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local degrees;
    
    degrees := MorphismDegreesOfComplex( C );
    
    if Length( degrees ) = 0 then
        return [  ];
    fi;
    
    return List( degrees, i -> CertainMorphism( C, i ) );
    
end );

##
InstallMethod( ObjectsOfComplex,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local morphisms, l, modules;
    
    morphisms := MorphismsOfComplex( C );
    
    l := Length( morphisms );
    
    if l = 0 then
        return [ CertainObject( C, ObjectDegreesOfComplex( C )[1] ) ];
    elif IsComplexOfFinitelyPresentedObjectsRep( C ) then
        modules := List( morphisms, Range );
        Add( modules, Source( morphisms[l] ) );
    else
        modules := List( morphisms, Source );
        Add( modules, Range( morphisms[l] ) );
    fi;
    
    return modules;
    
end );

##
InstallMethod( LowestDegree,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    return ObjectDegreesOfComplex( C )[1];
    
end );

##
InstallMethod( HighestDegree,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local degrees;
    
    degrees := ObjectDegreesOfComplex( C );
    
    return degrees[Length( degrees )];
    
end );

##
InstallMethod( LowestDegreeObject,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    return CertainObject( C, LowestDegree( C ) );
    
end );

##
InstallMethod( HighestDegreeObject,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local degrees;
    
    degrees := ObjectDegreesOfComplex( C );
    
    return CertainObject( C, HighestDegree( C ) );
    
end );

##
InstallMethod( LowestDegreeMorphism,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local degrees;
    
    degrees := MorphismDegreesOfComplex( C );
    
    return CertainMorphism( C, degrees[1] );
    
end );

##
InstallMethod( HighestDegreeMorphism,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local degrees;
    
    degrees := MorphismDegreesOfComplex( C );
    
    return CertainMorphism( C, degrees[Length( degrees )] );
    
end );

##
InstallMethod( HomalgRing,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    return HomalgRing( LowestDegreeObject( C ) );
    
end );

##
InstallMethod( SupportOfComplex,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local degrees, l, modules;
    
    degrees := ObjectDegreesOfComplex( C );
    
    l := Length( degrees );
    
    modules := ObjectsOfComplex( C );
    
    return degrees{ Filtered( [ 1 .. l ], i -> not IsZero( modules[i] ) ) };
    
end );

##  <#GAPDoc Label="Add:complex">
##  <ManSection>
##    <Oper Arg="C, phi" Name="Add" Label="to complexes given a map"/>
##    <Oper Arg="C, mat" Name="Add" Label="to complexes given a matrix"/>
##    <Returns>a &homalg; complex</Returns>
##    <Description>
##    In the first syntax the map <A>phi</A> is added to the (co)chain complex <A>C</A>
##    (&see; <Ref Sect="Complexes:Constructors"/>) as the new <E>highest</E> degree
##    morphism and the altered argument <A>C</A> is returned. In case <A>C</A> is a chain complex, the highest degree
##    module in <A>C</A> and the target of <A>phi</A> must be <E>identical</E>. In case <A>C</A> is a <E>co</E>chain
##    complex, the highest degree module in <A>C</A> and the source of <A>phi</A>  must be <E>identical</E>. <P/>
##    In the second syntax the matrix <A>mat</A> is interpreted as the matrix of the new <E>highest</E> degree morphism
##    <M>psi</M>, created according to the following rules:
##    In case <A>C</A> is a chain complex, the highest degree left (resp. right) module <M>C_d</M> in <A>C</A>
##    is declared as the target of <M>psi</M>, while its source is taken to be a free left (resp. right) module of rank
##    equal to <C>NrRows</C>(<A>mat</A>) (resp. <C>NrColumns</C>(<A>mat</A>)). For this <C>NrColumns</C>(<A>mat</A>)
##    (resp. <C>NrRows</C>(<A>mat</A>)) must coincide with the <C>NrGenerators</C>(<M>C_d</M>).
##    In case <A>C</A> is a <E>co</E>chain complex, the highest degree left (resp. right) module <M>C^d</M> in <A>C</A>
##    is declared as the source of <M>psi</M>, while its target is taken to be a free left (resp. right) module of rank
##    equal to <C>NrColumns</C>(<A>mat</A>) (resp. <C>NrRows</C>(<A>mat</A>)). For this <C>NrRows</C>(<A>mat</A>)
##    (resp. <C>Columns</C>(<A>mat</A>)) must coincide with the <C>NrGenerators</C>(<M>C^d</M>).
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> mat := HomalgMatrix( "[ 0, 1,   0, 0 ]", 2, 2, ZZ );
##  <A homalg internal 2 by 2 matrix>
##  gap> phi := HomalgMap( mat );
##  <A homomorphism of left modules>
##  gap> C := HomalgComplex( phi );
##  <A non-zero acyclic complex containing a single morphism of left modules at de\
##  grees [ 0 .. 1 ]>
##  gap> Add( C, mat );
##  gap> C;
##  <A sequence containing 2 morphisms of left modules at degrees [ 0 .. 2 ]>
##  gap> Display( C );
##  -------------------------
##  at homology degree: 0
##  Z^(1 x 2)
##  ------------^------------
##  [ [  0,  1 ],
##    [  0,  0 ] ]
##  
##  the map is currently represented by the above 2 x 2 matrix
##  -------------------------
##  at homology degree: 1
##  Z^(1 x 2)
##  ------------^------------
##  [ [  0,  1 ],
##    [  0,  0 ] ]
##  
##  the map is currently represented by the above 2 x 2 matrix
##  -------------------------
##  at homology degree: 2
##  Z^(1 x 2)
##  -------------------------
##  gap> IsComplex( C );
##  true
##  gap> IsAcyclic( C );
##  true
##  gap> IsExactSequence( C );
##  false
##  gap> C;
##  <A non-zero acyclic complex containing 2 morphisms of left modules at degrees
##  [ 0 .. 2 ]>
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Add,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedObjectsRep, IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( C, phi )
    local degrees, l, psi;
    
    if HasIsATwoSequence( C ) and IsATwoSequence( C ) then
        Error( "this complex is write-protected since IsATwoSequence = true\n" );
    fi;
    
    degrees := ObjectDegreesOfComplex( C );
    
    l := Length( degrees );
    
    if l = 1 then
        
        if IsHomalgChainMap( phi ) then
            if CertainObject( C, degrees[1] ) <> Range( phi ) then
                Error( "the unique object in the complex and the target of the new chain map are not equal\n" );
            fi;
        else
            if not IsIdenticalObj( CertainObject( C, degrees[1] ), Range( phi ) ) then
                Error( "the unique object in the complex and the target of the new map are not identical\n" );
            fi;
        fi;
        
        Unbind( C!.(String( degrees[1] )) );
        
        Add( degrees, degrees[1] + 1 );
        
        C!.(String( degrees[1] + 1 )) := phi;
        
    else
        
        l := degrees[l];
        
        if IsHomalgChainMap( phi ) then
            if Source( CertainMorphism( C, l ) ) <> Range( phi ) then
                Error( "the source of the ", l, ". chain map in the complex (i.e. the highest one) and the target of the new one are not equal\n" );
            fi;
        else
            if not IsIdenticalObj( Source( CertainMorphism( C, l ) ), Range( phi ) ) then
                Error( "the source of the ", l, ". map in the complex (i.e. the highest one) and the target of the new one are not identical\n" );
            fi;
        fi;
        
        Add( degrees, l + 1 );
        
        C!.(String( l + 1 )) := phi;
        
    fi;
    
    ConvertToRangeRep( degrees );
    
    if HasIsGradedObject( C ) and IsGradedObject( C ) and
       HasIsMorphism( phi ) and IsMorphism( phi ) then
        homalgResetFilters( C );
        SetIsComplex( C, true );
    elif HasIsSequence( C ) and IsSequence( C ) and
       HasIsMorphism( phi ) and IsMorphism( phi ) then
        homalgResetFilters( C );
        SetIsSequence( C, true );
    else
        homalgResetFilters( C );
    fi;
    
    if Length( degrees ) = 3 then
        psi := LowestDegreeMorphism( C );
        if HasIsEpimorphism( psi ) and IsEpimorphism( psi ) and
           ( ( HasKernelEmb( psi ) and IsIdenticalObj( KernelEmb( psi ), phi ) ) or
             ( HasCokernelEpi( phi ) and IsIdenticalObj( CokernelEpi( phi ), psi ) ) ) then
            SetIsShortExactSequence( C, true );
        fi;
    fi;
    
    return C;
    
end );

##
InstallMethod( Add,
        "for homalg complexes",
        [ IsCocomplexOfFinitelyPresentedObjectsRep, IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( C, phi )
    local degrees, l, psi;
    
    degrees := ObjectDegreesOfComplex( C );
    
    l := Length( degrees );
    
    if l = 1 then
        
        if IsHomalgChainMap( phi ) then
            if CertainObject( C, degrees[1] ) <> Source( phi ) then
                Error( "the unique object in the cocomplex and the source of the new chain map are not equal\n" );
            fi;
        else
            if not IsIdenticalObj( CertainObject( C, degrees[1] ), Source( phi ) ) then
                Error( "the unique object in the cocomplex and the source of the new map are not identical\n" );
            fi;
        fi;
        
        Add( degrees, degrees[1] + 1 );
        
        C!.(String( degrees[1] )) := phi;
        
    else
        
        l := degrees[l - 1];
        
        if IsHomalgChainMap( phi ) then
            if Range( CertainMorphism( C, l ) ) <>  Source( phi ) then
                Error( "the target of the ", l, ". chain map in the cocomplex (i.e. the highest one) and the source of the new one are not equal\n" );
            fi;
        else
            if not IsIdenticalObj( Range( CertainMorphism( C, l ) ), Source( phi ) ) then
                Error( "the target of the ", l, ". map in the cocomplex (i.e. the highest one) and the source of the new one are not identical\n" );
            fi;
        fi;
        
        Add( degrees, l + 2 );
        
        C!.(String( l + 1 )) := phi;
        
    fi;
    
    ConvertToRangeRep( degrees );
    
    if HasIsGradedObject( C ) and IsGradedObject( C ) and
       HasIsMorphism( phi ) and IsMorphism( phi ) then
        homalgResetFilters( C );
        SetIsComplex( C, true );
    elif HasIsSequence( C ) and IsSequence( C ) and
       HasIsMorphism( phi ) and IsMorphism( phi ) then
        homalgResetFilters( C );
        SetIsSequence( C, true );
    else
        homalgResetFilters( C );
    fi;
    
    if Length( degrees ) = 3 then
        psi := LowestDegreeMorphism( C );
        if HasIsMonomorphism( psi ) and IsMonomorphism( psi ) and
           ( ( HasCokernelEpi( psi ) and IsIdenticalObj( CokernelEpi( psi ), phi ) ) or
             ( HasKernelEmb( phi ) and IsIdenticalObj( KernelEmb( phi ), psi ) ) ) then
            SetIsShortExactSequence( C, true );
        fi;
    fi;
    
    return C;
    
end );

##
InstallMethod( Add,
        "for homalg complexes",
        [ IsMorphismOfFinitelyGeneratedModulesRep, IsCocomplexOfFinitelyPresentedObjectsRep ],
        
  function( phi, C )
    local degrees, l, psi;
    
    degrees := ObjectDegreesOfComplex( C );
    
    l := Length( degrees );
    
    if l = 1 then
        
        if IsHomalgChainMap( phi ) then
            if CertainObject( C, degrees[1] ) <> Range( phi ) then
                Error( "the unique object in the cocomplex and the range of the new chain map are not equal\n" );
            fi;
        else
            if not IsIdenticalObj( CertainObject( C, degrees[1] ), Range( phi ) ) then
                Error( "the unique object in the cocomplex and the range of the new map are not identical\n" );
            fi;
        fi;
        
        C!.degrees := Concatenation( [ degrees[1] - 1 ], degrees );
        
        C!.(String( degrees[1] - 1 )) := phi;
        
    else
        
        l := degrees[1];
        
        if IsHomalgChainMap( phi ) then
            if Source( CertainMorphism( C, l ) ) <>  Range( phi ) then
                Error( "the source of the ", l, ". chain map in the cocomplex (i.e. the lowest one) and the target of the new one are not equal\n" );
            fi;
        else
            if not IsIdenticalObj( Source( CertainMorphism( C, l ) ), Range( phi ) ) then
                Error( "the source of the ", l, ". map in the cocomplex (i.e. the lowest one) and the target of the new one are not identical\n" );
            fi;
        fi;
        
        C!.degrees := Concatenation( [ l - 1 ], degrees );
        
        C!.(String( l - 1 )) := phi;
        
    fi;
    
    degrees := C!.degrees;
    
    ConvertToRangeRep( degrees );
    
    if HasIsSequence( C ) and IsSequence( C ) and
       HasIsMorphism( phi ) and IsMorphism( phi ) then
        homalgResetFilters( C );
        SetIsSequence( C, true );
    else
        homalgResetFilters( C );
    fi;
    
    ## FIXME: insert a SetIsShortExactSequence statement, analogous to the above Add method
    
    return C;
    
end );

##
InstallMethod( Add,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedObjectsRep, IsFinitelyPresentedModuleRep ],
        
  function( C, M )
    local T, grd, cpx, seq;
    
    T := HighestDegreeObject( C );
    
    if HasIsGradedObject( C ) then
        grd := IsGradedObject( C );
    elif HasIsComplex( C ) then
        cpx := IsComplex( C );
    elif HasIsSequence( C ) then
        seq := IsSequence ( C );
    fi;
    
    Add( C, TheZeroMap( M, T ) );
    
    if IsBound( grd ) then
        SetIsGradedObject( C, grd );
    elif IsBound( cpx ) then
        SetIsComplex( C, cpx );
    elif IsBound( seq ) then
        SetIsSequence( C, seq );
    fi;
    
end );

##
InstallMethod( Add,
        "for homalg complexes",
        [ IsCocomplexOfFinitelyPresentedObjectsRep, IsFinitelyPresentedModuleRep ],
        
  function( C, M )
    local S, grd, cpx, seq;
    
    S := HighestDegreeObject( C );
    
    if HasIsGradedObject( C ) then
        grd := IsGradedObject( C );
    elif HasIsComplex( C ) then
        cpx := IsComplex( C );
    elif HasIsSequence( C ) then
        seq := IsSequence ( C );
    fi;
    
    Add( C, TheZeroMap( S, M ) );
    
    if IsBound( grd ) then
        SetIsGradedObject( C, grd );
    elif IsBound( cpx ) then
        SetIsComplex( C, cpx );
    elif IsBound( seq ) then
        SetIsSequence( C, seq );
    fi;
    
end );

##
InstallMethod( Add,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedObjectsRep, IsHomalgMatrix ],
        
  function( C, mat )
    local T;
    
    T := HighestDegreeObject( C );
    
    Add( C, HomalgMap( mat, "free", T ) );
    
end );

##
InstallMethod( Add,
        "for homalg complexes",
        [ IsCocomplexOfFinitelyPresentedObjectsRep, IsHomalgMatrix ],
        
  function( C, mat )
    local S;
    
    S := HighestDegreeObject( C );
    
    Add( C, HomalgMap( mat, S, "free" ) );
    
end );

##
InstallMethod( Shift,
        "for homalg complexes",
        [ IsHomalgComplex, IsInt ],
        
  function( C, s )
    local d, Cd, Cs;
    
    d := LowestDegree( C );
    
    Cd := LowestDegreeObject( C );
    
    if IsComplexOfFinitelyPresentedObjectsRep( C ) then
        Cs := HomalgComplex( Cd, d - s );
    else
        Cs := HomalgCocomplex( Cd, d - s );
    fi;
    
    Perform ( MorphismsOfComplex( C ), function( m ) Add( Cs, m ); end );
    
    if HasIsGradedObject( C ) and IsGradedObject( C ) then
        SetIsGradedObject( Cs, true );
    elif HasIsComplex( C ) and IsComplex( C ) then
        SetIsComplex( Cs, true );
    elif HasIsSequence( C ) and IsSequence( C ) then
        SetIsSequence( Cs, true );
    fi;
    
    return Cs;
    
end );

##
InstallMethod( Reflect,
        "for homalg complexes",
        [ IsHomalgComplex, IsInt ],
        
  function( C, s )
    local d, Cd, Cs;
    
    d := HighestDegree( C );
    
    Cd := HighestDegreeObject( C );
    
    if IsComplexOfFinitelyPresentedObjectsRep( C ) then
        Cs := HomalgCocomplex( Cd, - d - s );
    else
        Cs := HomalgComplex( Cd, - d - s );
    fi;
    
    Perform ( Reversed( MorphismsOfComplex( C ) ), function( m ) Add( Cs, m ); end );
    
    if HasIsGradedObject( C ) and IsGradedObject( C ) then
        SetIsGradedObject( Cs, true );
    elif HasIsComplex( C ) and IsComplex( C ) then
        SetIsComplex( Cs, true );
    elif HasIsSequence( C ) and IsSequence( C ) then
        SetIsSequence( Cs, true );
    fi;
    
    return Cs;
    
end );

##
InstallMethod( Reflect,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    return Reflect( C, 0 );
    
end );

##
InstallMethod( \+,
        "for two homalg complexes",
        [ IsHomalgComplex and IsGradedObject, IsHomalgComplex and IsGradedObject ],
        
  function( C1, C2 )
    local cpx, d1, d2, d, Cd, Cs, i;
    
    if IsComplexOfFinitelyPresentedObjectsRep( C1 ) and IsComplexOfFinitelyPresentedObjectsRep( C2 ) then
        cpx := true;
    elif IsCocomplexOfFinitelyPresentedObjectsRep( C1 ) and IsCocomplexOfFinitelyPresentedObjectsRep( C2 ) then
        cpx := false;
    else
        Error( "first and second argument must either be both complexes or both cocomplexes\n" );
    fi;
    
    d1 := LowestDegree( C1 );
    d2 := LowestDegree( C2 );
    
    d := Minimum( d1, d2 );
    
    if d1 < d2 then
        Cd := LowestDegreeObject( C1 );
    elif d2 < d1 then
        Cd := LowestDegreeObject( C2 );
    else
        Cd := LowestDegreeObject( C1 ) + LowestDegreeObject( C2 );
    fi;
    
    if cpx then
        Cs := HomalgComplex( Cd, d );
    else
        Cs := HomalgCocomplex( Cd, d );
    fi;
    
    d1 := ObjectDegreesOfComplex( C1 );
    d2 := ObjectDegreesOfComplex( C2 );
    
    for i in [ d + 1 .. Maximum( List( [ C1, C2 ], HighestDegree ) ) ] do
        if not i in d2 then
            Cd := CertainObject( C1, i );
        elif not i in d1 then
            Cd := CertainObject( C2, i );
        else
            Cd := CertainObject( C1, i ) + CertainObject( C2, i );
        fi;
        
        Add( Cs, Cd );
    od;
    
    SetIsGradedObject( Cs, true );
    
    return Cs;
    
end );

##
InstallMethod( CertainMorphismAsSubcomplex,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedObjectsRep, IsInt ],
        
  function( C, i )
    local m, A;
    
    m := CertainMorphism( C, i );
    
    if m = fail then
        m := CertainMorphism( C, i + 1 );
        if m = fail then
            return fail;
        fi;
        m := CokernelEpi( m );
    fi;
    
    A := HomalgComplex( m, i );
    
    if HasIsZero( C ) and IsZero( C ) then
        SetIsZero( A, true );
    elif HasIsGradedObject( C ) and IsGradedObject( C ) then
        SetIsGradedObject( A, true );
    elif HasIsComplex( C ) and IsComplex( C ) then
        SetIsComplex( A, true );
    elif HasIsSequence( C ) and IsSequence( C ) then
        SetIsComplex( A, true );	## this is not a mistake
    fi;
    
    return A;
    
end );

##
InstallMethod( CertainMorphismAsSubcomplex,
        "for homalg complexes",
        [ IsCocomplexOfFinitelyPresentedObjectsRep, IsInt ],
        
  function( C, i )
    local m, A;
    
    m := CertainMorphism( C, i );
    
    if m = fail then
        return fail;
    fi;
    
    A := HomalgCocomplex( m, i );
    
    if HasIsZero( C ) and IsZero( C ) then
        SetIsZero( A, true );
    elif HasIsGradedObject( C ) and IsGradedObject( C ) then
        SetIsGradedObject( A, true );
    elif HasIsComplex( C ) and IsComplex( C ) then
        SetIsComplex( A, true );
    elif HasIsSequence( C ) and IsSequence( C ) then
        SetIsComplex( A, true );	## this is not a mistake
    fi;
    
    return A;
    
end );

##
InstallMethod( CertainTwoMorphismsAsSubcomplex,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedObjectsRep, IsInt ],
        
  function( C, i )
    local m, A;
    
    m := CertainMorphism( C, i );
    
    if m = fail then
        return fail;
    fi;
    
    A := HomalgComplex( m, i );
    
    Add( A, CertainMorphism( C, i + 1 ) );
    
    if HasIsZero( C ) and IsZero( C ) then
        SetIsZero( A, true );
    elif HasIsGradedObject( C ) and IsGradedObject( C ) then
        SetIsGradedObject( A, true );
    elif HasIsComplex( C ) and IsComplex( C ) then
        SetIsComplex( A, true );
    elif HasIsSequence( C ) and IsSequence( C ) then
        SetIsSequence( A, true );
    fi;
    
    SetIsATwoSequence( A, true );
    
    return A;
    
end );

##
InstallMethod( CertainTwoMorphismsAsSubcomplex,
        "for homalg complexes",
        [ IsCocomplexOfFinitelyPresentedObjectsRep, IsInt ],
        
  function( C, i )
    local m, A;
    
    m := CertainMorphism( C, i - 1 );
    
    if m = fail then
        return fail;
    fi;
    
    A := HomalgCocomplex( m, i - 1 );
    
    Add( A, CertainMorphism( C, i ) );
    
    if HasIsZero( C ) and IsZero( C ) then
        SetIsZero( A, true );
    elif HasIsGradedObject( C ) and IsGradedObject( C ) then
        SetIsGradedObject( A, true );
    elif HasIsComplex( C ) and IsComplex( C ) then
        SetIsComplex( A, true );
    elif HasIsSequence( C ) and IsSequence( C ) then
        SetIsSequence( A, true );
    fi;
    
    SetIsATwoSequence( A, true );
    
    return A;
    
end );

##
InstallMethod( LongSequence,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedObjectsRep and IsTriangle ],
        
  function( T )
    local mor, deg, C, j;
    
    mor := MorphismsOfComplex( T );
    
    deg := DegreesOfChainMap( mor[1] );
    
    C := HomalgComplex( CertainMorphism( mor[1], deg[1] ) );
    Add( C, CertainMorphism( mor[2], deg[1] ) );
    
    for j in deg{[ 2 .. Length( deg ) ]} do
        
        Add( C, CertainMorphism( mor[3], j ) );
        Add( C, CertainMorphism( mor[1], j ) );
        Add( C, CertainMorphism( mor[2], j ) );
        
    od;
    
    return C;
    
end );

##
InstallMethod( LongSequence,
        "for homalg complexes",
        [ IsCocomplexOfFinitelyPresentedObjectsRep and IsTriangle ],
        
  function( T )
    local mor, deg, C, j;
    
    mor := MorphismsOfComplex( T );
    
    deg := DegreesOfChainMap( mor[1] );
    
    C := HomalgCocomplex( CertainMorphism( mor[1], deg[1] ) );
    Add( C, CertainMorphism( mor[2], deg[1] ) );
    
    for j in deg{[ 2 .. Length( deg ) ]} do
        
        Add( C, CertainMorphism( mor[3], j - 1 ) );
        Add( C, CertainMorphism( mor[1], j ) );
        Add( C, CertainMorphism( mor[2], j ) );
        
    od;
    
    return C;
    
end );

##
InstallMethod( PreCompose,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedObjectsRep,
          IsComplexOfFinitelyPresentedObjectsRep ],
        
  function( C1, C2 )
    local mor2, mor1, deg, C, l, m;
    
    mor2 := MorphismsOfComplex( C2 );
    
    if mor2 = [ ] then
        return C1;
    fi;
    
    mor1 := MorphismsOfComplex( C1 );
    
    if mor1 = [ ] then
        return C2;
    fi;
    
    deg := LowestDegree( C2 ) + 1;
    
    C := HomalgComplex( mor2[1], deg );
    
    l := Length( mor2 );
    
    for m in mor2{[ 2 .. l - 1 ]} do
        Add( C, m );
    od;
    
    Add( C, PreCompose( mor1[1], mor2[l] ) );
    
    for m in mor1{[ 2 .. Length( mor1 ) ]} do
        Add( C, m );
    od;
    
    return C;
    
end );

##
InstallMethod( PreCompose,
        "for homalg complexes",
        [ IsCocomplexOfFinitelyPresentedObjectsRep,
          IsCocomplexOfFinitelyPresentedObjectsRep ],
        
  function( C1, C2 )
    local mor1, mor2, deg, C, l, m;
    
    mor1 := MorphismsOfComplex( C1 );
    
    if mor1 = [ ] then
        return C2;
    fi;
    
    mor2 := MorphismsOfComplex( C2 );
    
    if mor2 = [ ] then
        return C1;
    fi;
    
    deg := LowestDegree( C1 );
    
    C := HomalgCocomplex( mor1[1], deg );
    
    l := Length( mor1 );
    
    for m in mor1{[ 2 .. l - 1 ]} do
        Add( C, m );
    od;
    
    Add( C, PreCompose( mor1[l], mor2[1] ) );
    
    for m in mor2{[ 2 .. Length( mor2 ) ]} do
        Add( C, m );
    od;
    
    return C;
    
end );

##
InstallMethod( BasisOfModule,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    List( ObjectsOfComplex( C ), BasisOfModule );
    
    return C;
    
end );

##
InstallMethod( DecideZero,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    List( ObjectsOfComplex( C ), DecideZero );
    
    if Length( ObjectDegreesOfComplex( C ) ) > 1 then
        List( MorphismsOfComplex( C ), DecideZero );
    fi;
    
    IsZero( C );
    
    return C;
    
end );

##
InstallMethod( OnLessGenerators,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    List( ObjectsOfComplex( C ), OnLessGenerators );
    
    return C;
    
end );

##  <#GAPDoc Label="ByASmallerPresentation:complex">
##  <ManSection>
##    <Meth Arg="C" Name="ByASmallerPresentation" Label="for complexes"/>
##    <Returns>a &homalg; complex</Returns>
##    <Description>
##    See <Ref Meth="ByASmallerPresentation" Label="for modules"/> on modules.
##      <Listing Type="Code"><![CDATA[
InstallMethod( ByASmallerPresentation,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    List( ObjectsOfComplex( C ), ByASmallerPresentation );
    
    if Length( ObjectDegreesOfComplex( C ) ) > 1 then
        List( MorphismsOfComplex( C ), DecideZero );
    fi;
    
    IsZero( C );
    
    return C;
    
end );
##  ]]></Listing>
##      This method performs side effects on its argument <A>C</A> and returns it.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> M := HomalgMatrix( "[ 2, 3, 4,   5, 6, 7 ]", 2, 3, ZZ );
##  <A homalg internal 2 by 3 matrix>
##  gap> M := LeftPresentation( M );
##  <A non-zero left module presented by 2 relations for 3 generators>
##  gap> N := HomalgMatrix( "[ 2, 3, 4, 5,   6, 7, 8, 9 ]", 2, 4, ZZ );
##  <A homalg internal 2 by 4 matrix>
##  gap> N := LeftPresentation( N );
##  <A non-zero left module presented by 2 relations for 4 generators>
##  gap> mat := HomalgMatrix( "[  0, 3, 6, 9,   0, 2, 4, 6,   0, 3, 6, 9 ]", 3, 4, ZZ );
##  <A homalg internal 3 by 4 matrix>
##  gap> phi := HomalgMap( mat, M, N );
##  <A "homomorphism" of left modules>
##  gap> IsMorphism( phi );
##  true
##  gap> phi;
##  <A homomorphism of left modules>
##  gap> C := HomalgComplex( phi );
##  <A non-zero acyclic complex containing a single morphism of left modules at de\
##  grees [ 0 .. 1 ]>
##  gap> Display( C );
##  -------------------------
##  at homology degree: 0
##  [ [  2,  3,  4,  5 ],
##    [  6,  7,  8,  9 ] ]
##  Cokernel of the map
##  
##  Z^(1x2) --> Z^(1x4),
##  
##  currently represented by the above matrix
##  ------------^------------
##  [ [  0,  3,  6,  9 ],
##    [  0,  2,  4,  6 ],
##    [  0,  3,  6,  9 ] ]
##  
##  the map is currently represented by the above 3 x 4 matrix
##  -------------------------
##  at homology degree: 1
##  [ [  2,  3,  4 ],
##    [  5,  6,  7 ] ]
##  Cokernel of the map
##  
##  Z^(1x2) --> Z^(1x3),
##  
##  currently represented by the above matrix
##  -------------------------
##  ]]></Example>
##      And now:
##      <Example><![CDATA[
##  gap> ByASmallerPresentation( C );
##  <A non-zero acyclic complex containing a single morphism of left modules at de\
##  grees [ 0 .. 1 ]>
##  gap> Display( C );
##  -------------------------
##  at homology degree: 0
##  Z/< 4 > + Z^(1 x 2)
##  ------------^------------
##  [ [  0,  0,  0 ],
##    [  2,  0,  0 ] ]
##  
##  the map is currently represented by the above 2 x 3 matrix
##  -------------------------
##  at homology degree: 1
##  Z/< 3 > + Z^(1 x 1)
##  -------------------------
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

####################################
#
# constructor functions and methods:
#
####################################

##  <#GAPDoc Label="HomalgComplex">
##  <ManSection>
##    <Func Arg="M[, d]" Name="HomalgComplex" Label="constructor for complexes given a module"/>
##    <Func Arg="phi[, d]" Name="HomalgComplex" Label="constructor for complexes given a map"/>
##    <Func Arg="C[, d]" Name="HomalgComplex" Label="constructor for complexes given a complex"/>
##    <Func Arg="cm[, d]" Name="HomalgComplex" Label="constructor for complexes given a chain map"/>
##    <Returns>a &homalg; complex</Returns>
##    <Description>
##      The first syntax creates a complex (i.e. chain complex) with the single &homalg; module <A>M</A>
##      (&see; <Ref Sect="Modules:Constructors"/>) at (homological) degree <A>d</A>. <P/>
##      The second syntax creates a complex with the single &homalg; map <A>phi</A>
##      (&see; <Ref Func="HomalgMap" Label="constructor for maps"/>), its source placed at
##      (homological) degree <A>d</A> (and its target at <A>d</A><M>-1</M>). <P/>
##      The third syntax creates a complex (i.e. chain complex) with the single &homalg; (co)complex <A>C</A>
##      at (homological) degree <A>d</A>. <P/>
##      The fourth syntax creates a complex with the single &homalg; (co)chain map <A>cm</A>
##      (&see; <Ref Func="HomalgChainMap" Label="constructor for chain maps given a map"/>), its source placed at
##      (homological) degree <A>d</A> (and its target at <A>d</A><M>-1</M>). <P/>
##      If <A>d</A> is not provided it defaults to zero in all cases. <Br/>
##      To add a map (resp. (co)chain map) to a complex use <Ref Oper="Add" Label="to complexes given a map"/>.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> M := HomalgMatrix( "[ 2, 3, 4,   5, 6, 7 ]", 2, 3, ZZ );
##  <A homalg internal 2 by 3 matrix>
##  gap> M := LeftPresentation( M );
##  <A non-zero left module presented by 2 relations for 3 generators>
##  gap> N := HomalgMatrix( "[ 2, 3, 4, 5,   6, 7, 8, 9 ]", 2, 4, ZZ );
##  <A homalg internal 2 by 4 matrix>
##  gap> N := LeftPresentation( N );
##  <A non-zero left module presented by 2 relations for 4 generators>
##  gap> mat := HomalgMatrix( "[  0, 3, 6, 9,   0, 2, 4, 6,   0, 3, 6, 9 ]", 3, 4, ZZ );
##  <A homalg internal 3 by 4 matrix>
##  gap> phi := HomalgMap( mat, M, N );
##  <A "homomorphism" of left modules>
##  gap> IsMorphism( phi );
##  true
##  gap> phi;
##  <A homomorphism of left modules>
##  ]]></Example>
##  The first possibility:
##      <Example><![CDATA[
##  <A homomorphism of left modules>
##  gap> C := HomalgComplex( N );
##  <A non-zero graded homology object consisting of a single left module at degre\
##  e 0>
##  gap> Add( C, phi );
##  gap> C;
##  <A complex containing a single morphism of left modules at degrees [ 0 .. 1 ]>
##  ]]></Example>
##  The second possibility:
##      <Example><![CDATA[
##  gap> C := HomalgComplex( phi );
##  <A non-zero acyclic complex containing a single morphism of left modules at de\
##  grees [ 0 .. 1 ]>
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( HomalgComplex,
  function( arg )
    local nargs, C, complex, degrees, object, obj_or_mor, left, type;
    
    nargs := Length( arg );
    
    if nargs = 0 then
        Error( "empty input\n" );
    fi;
    
    C := rec( );
    
    if IsStringRep( arg[nargs] ) and ( arg[nargs] = "co" or arg[nargs] = "cocomplex" ) then
        complex := false;
    else
        complex := true;
    fi;
    
    if nargs > 1 and ( IsInt( arg[2] )
               or ( IsList( arg[2] ) and Length( arg[2] ) > 0 and ForAll( arg[2], IsInt ) ) ) then
        degrees := [ arg[2] ];
    elif complex and IsMorphismOfFinitelyGeneratedModulesRep( arg[1] ) then
        degrees := [ 1 ];
    else
        degrees := [ 0 ];
    fi;
    
    if IsHomalgRingOrFinitelyPresentedObjectRep( arg[1] ) then
        object := true;
        if IsHomalgRing( arg[1] ) then
            obj_or_mor := AsLeftModule( arg[1] );
        else
            obj_or_mor := arg[1];
        fi;
        C.degrees := degrees;
        left := IsHomalgLeftObjectOrMorphismOfLeftObjects( obj_or_mor );
    elif IsMorphismOfFinitelyGeneratedModulesRep( arg[1] ) then
        object := false;
        obj_or_mor := arg[1];
        if complex then
            C.degrees := [ degrees[1] - 1, degrees[1] ];
        else
            C.degrees := [ degrees[1], degrees[1] + 1 ];
        fi;
    else
        Error( "the first argument must be either a homalg object or a homalg morphism\n" );
    fi;
    
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( obj_or_mor );
    
    C.( String( degrees[1] ) ) := obj_or_mor;
    
    if complex then
        if left then
            type := TheTypeHomalgComplexOfLeftObjects;
        else
            type := TheTypeHomalgComplexOfRightObjects;
        fi;
    else
        if left then
            type := TheTypeHomalgCocomplexOfLeftObjects;
        else
            type := TheTypeHomalgCocomplexOfRightObjects;
        fi;
    fi;
    
    ConvertToRangeRep( C.degrees );
    
    ## Objectify
    Objectify( type, C );
    
    if object then
        SetIsRightAcyclic( C, true );
        if HasIsZero( obj_or_mor ) then
            SetIsLeftAcyclic( C, IsZero( obj_or_mor ) );
            SetIsZero( C, IsZero( obj_or_mor ) );
        fi;
        SetIsGradedObject( C, true );
    elif HasIsIsomorphism( obj_or_mor ) and IsIsomorphism( obj_or_mor ) then
        SetIsExactSequence( C, true );
    elif HasIsEpimorphism( obj_or_mor ) and IsEpimorphism( obj_or_mor ) then
        if complex then
            SetIsLeftAcyclic( C, true );
        else
            SetIsRightAcyclic( C, true );
        fi;
    elif HasIsMonomorphism( obj_or_mor ) and IsMonomorphism( obj_or_mor ) then
        if complex then
            SetIsRightAcyclic( C, true );
        else
            SetIsLeftAcyclic( C, true );
        fi;
    elif HasIsMorphism( obj_or_mor ) and IsMorphism( obj_or_mor ) then
        SetIsAcyclic( C, true );
    fi;
    
    return C;
    
end );

##  <#GAPDoc Label="HomalgCocomplex">
##  <ManSection>
##    <Func Arg="M[, d]" Name="HomalgCocomplex" Label="constructor for cocomplexes given a module"/>
##    <Func Arg="phi[, d]" Name="HomalgCocomplex" Label="constructor for cocomplexes given a map"/>
##    <Func Arg="C[, d]" Name="HomalgCocomplex" Label="constructor for cocomplexes given a complex"/>
##    <Func Arg="cm[, d]" Name="HomalgCocomplex" Label="constructor for cocomplexes given a chain map"/>
##    <Returns>a &homalg; complex</Returns>
##    <Description>
##      The first syntax creates a cocomplex (i.e. cochain complex) with the single &homalg; module <A>M</A> at
##      (cohomological) degree <A>d</A>. <P/>
##      The second syntax creates a cocomplex with the single &homalg; map <A>phi</A>
##      (&see; <Ref Func="HomalgMap" Label="constructor for maps"/>), its source placed at (cohomological)
##      degree <A>d</A> (and its target at <A>d</A><M>+1</M>). <P/>
##      The third syntax creates a cocomplex (i.e. cochain complex) with the single &homalg; cocomplex <A>C</A> at
##      (cohomological) degree <A>d</A>. <P/>
##      The fourth syntax creates a cocomplex with the single &homalg; (co)chain map <A>cm</A>
##      (&see; <Ref Func="HomalgChainMap" Label="constructor for chain maps given a map"/>), its source placed at
##      (cohomological) degree <A>d</A> (and its target at <A>d</A><M>+1</M>). <P/>
##      If <A>d</A> is not provided it defaults to zero in all cases. <Br/>
##      To add a map (resp. (co)chain map) to a cocomplex use <Ref Oper="Add" Label="to complexes given a map"/>.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> M := HomalgMatrix( "[ 2, 3, 4,   5, 6, 7 ]", 2, 3, ZZ );
##  <A homalg internal 2 by 3 matrix>
##  gap> M := RightPresentation( Involution( M ) );
##  <A non-zero right module on 3 generators satisfying 2 relations>
##  gap> N := HomalgMatrix( "[ 2, 3, 4, 5,   6, 7, 8, 9 ]", 2, 4, ZZ );
##  <A homalg internal 2 by 4 matrix>
##  gap> N := RightPresentation( Involution( N ) );
##  <A non-zero right module on 4 generators satisfying 2 relations>
##  gap> mat := HomalgMatrix( "[  0, 3, 6, 9,   0, 2, 4, 6,   0, 3, 6, 9 ]", 3, 4, ZZ );
##  <A homalg internal 3 by 4 matrix>
##  gap> phi := HomalgMap( Involution( mat ), M, N );
##  <A "homomorphism" of right modules>
##  gap> IsMorphism( phi );
##  true
##  gap> phi;
##  <A homomorphism of right modules>
##  ]]></Example>
##  The first possibility:
##      <Example><![CDATA[
##  <A homomorphism of right modules>
##  gap> C := HomalgCocomplex( M );
##  <A non-zero graded cohomology object consisting of a single right module at de\
##  gree 0>
##  gap> Add( C, phi );
##  gap> C;
##  <A cocomplex containing a single morphism of right modules at degrees
##  [ 0 .. 1 ]>
##  ]]></Example>
##  The second possibility:
##      <Example><![CDATA[
##  gap> C := HomalgCocomplex( phi );
##  <A non-zero acyclic cocomplex containing a single morphism of right modules at\
##   degrees [ 0 .. 1 ]>
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( HomalgCocomplex,
  function( arg )
    
    return CallFuncList( HomalgComplex, Concatenation( arg, [ "cocomplex" ] ) );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( o )
    local cpx, first_attribute, degrees, l, oi;
    
    cpx := IsComplexOfFinitelyPresentedObjectsRep( o );
    
    first_attribute := false;
    
    Print( "<A" );
    
    if HasIsZero( o ) then ## if this method applies and HasIsZero is set we already know that o is a non-zero homalg (co)complex
        Print( " non-zero" );
        first_attribute := true;
    fi;
    
    if HasIsExactTriangle( o ) and IsExactTriangle( o ) then
        if not first_attribute then
            Print( "n" );
        fi;
        if cpx then
            Print( " exact triangle" );
        else
            Print( " exact cotriangle" );
        fi;
    elif HasIsSplitShortExactSequence( o ) and IsSplitShortExactSequence( o ) then
        if cpx then
            Print( " split short exact sequence" );
        else
            Print( " split short exact cosequence" );
        fi;
    elif HasIsShortExactSequence( o ) and IsShortExactSequence( o ) then
        if cpx then
            Print( " short exact sequence" );
        else
            Print( " short exact cosequence" );
        fi;
    elif HasIsExactSequence( o ) and IsExactSequence( o ) then
        if not first_attribute then
            Print( "n" );
        fi;
        if cpx then
            Print( " exact sequence" );
        else
            Print( " exact cosequence" );
        fi;
    elif HasIsRightAcyclic( o ) and IsRightAcyclic( o ) then
        if cpx then
            Print( " right acyclic complex" );
        else
            Print( " right acyclic cocomplex" );
        fi;
    elif HasIsLeftAcyclic( o ) and IsLeftAcyclic( o ) then
        if cpx then
            Print( " left acyclic complex" );
        else
            Print( " left acyclic cocomplex" );
        fi;
    elif HasIsAcyclic( o ) and IsAcyclic( o ) then
        if not first_attribute then
            Print( "n" );
        fi;
        if cpx then
            Print( " acyclic complex" );
        else
            Print( " acyclic cocomplex" );
        fi;
    elif HasIsComplex( o ) then
        if IsComplex( o ) then
            if cpx then
                Print( " complex" );
            else
                Print( " cocomplex" );
            fi;
        else
            if cpx then
                Print( " non-complex" );
            else
                Print( " non-cocomplex" );
            fi;
        fi;
    elif HasIsSequence( o ) then
        if IsSequence( o ) then
            if cpx then
                Print( " sequence" );
            else
                Print( " cosequence" );
            fi;
        else
            if cpx then
                Print( " sequence of non-well-definded morphisms" );
            else
                Print( " cosequence of non-well-definded morphisms" );
            fi;
        fi;
    else
        if cpx then
            Print( " \"complex\"" );
        else
            Print( " \"cocomplex\"" );
        fi;
    fi;
    
    Print( " containing " );
    
    degrees := ObjectDegreesOfComplex( o );
    
    l := Length( degrees );
    
    oi := CertainObject( o, degrees[1] );
    
    if l = 1 then
        
        Print( "a single " );
        
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
            Print( "left" );
        else
            Print( "right" );
        fi;
        
        if IsHomalgModule( oi ) then
            Print( " module" );
        else
            if IsComplexOfFinitelyPresentedObjectsRep( oi ) then
                Print( " complex" );
            else
                Print( " cocomplex" );
            fi;
        fi;
        
        Print( " at degree ", degrees[1], ">" );
        
    else
        
        if l = 2 then
            Print( "a single morphism" );
        else
            Print( l - 1, " morphisms" );
        fi;
        
        Print( " of " );
        
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
            Print( "left" );
        else
            Print( "right" );
        fi;
        
        if IsHomalgModule( oi ) then
            Print( " modules" );
        else
            if IsComplexOfFinitelyPresentedObjectsRep( oi ) then
                Print( " complexes" );
            else
                Print( " cocomplexes" );
            fi;
        fi;
        
        if HasIsExactTriangle( o ) and IsExactTriangle( o ) then
            if cpx then
                Print( " at degrees ", [ degrees[2], degrees[3], degrees[4], degrees[2] ], ">" );
            else
                Print( " at degrees ", [ degrees[1], degrees[2], degrees[3], degrees[1] ], ">" );
            fi;
        else
            Print( " at degrees ", degrees, ">" );
        fi;
        
    fi;
    
end );

##
InstallMethod( ViewObj,
        "for homalg complexes",
        [ IsHomalgComplex and IsGradedObject ],
        
  function( o )
    local degrees, l, oi;
    
    Print( "<A" );
    
    if HasIsZero( o ) then ## if this method applies and HasIsZero is set we already know that o is a non-zero homology object
        Print( " non-zero" );
    fi;
    
    Print( " graded " );
    
    if IsCocomplexOfFinitelyPresentedObjectsRep( o ) then
        Print( "co" );
    fi;
    
    Print( "homology object consisting of " );
    
    degrees := ObjectDegreesOfComplex( o );
    
    l := Length( degrees );
    
    if l = 1 then
        Print( "a single" );
    else
        Print( l );
    fi;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        Print( " left" );
    else
        Print( " right" );
    fi;
    
    oi := CertainObject( o, degrees[1] );
    
    if IsHomalgModule( oi ) then
        Print( " module" );
        if l > 1 then
            Print( "s" );
        fi;
    else
        if IsComplexOfFinitelyPresentedObjectsRep( oi ) then
            Print( " complex" );
        else
            Print( " cocomplex" );
        fi;
        if l > 1 then
            Print( "es" );
        fi;
    fi;
    
    Print( " at degree" );
    
    if l = 1 then
        Print( " ", degrees[1] );
    else
        Print( "s ", degrees );
    fi;
    
    Print( ">" );
    
end );

##
InstallMethod( ViewObj,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedObjectsRep and IsZero ],
        
  function( o )
    local degrees, l;
    
    degrees := ObjectDegreesOfComplex( o );
    
    l := Length( degrees );
    
    Print( "<A zero " );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        Print( "left" );
    else
        Print( "right" );
    fi;
    
    Print( " complex with degree" );
    
    if l > 1 then
        Print( "s" );
    fi;
    
    Print( " ", degrees, ">" );
    
end );

##
InstallMethod( ViewObj,
        "for homalg complexes",
        [ IsCocomplexOfFinitelyPresentedObjectsRep and IsZero ],
        
  function( o )
    local degrees, l;
    
    degrees := ObjectDegreesOfComplex( o );
    
    l := Length( degrees );
    
    Print( "<A zero " );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        Print( "left" );
    else
        Print( "right" );
    fi;
    
    Print( " cocomplex with degree" );
    
    if l > 1 then
        Print( "s" );
    fi;
    
    Print( " ", degrees, ">" );
    
end );

##
InstallMethod( Display,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedObjectsRep ],
        
  function( o )
    local i, degrees;
    
    degrees := ObjectDegreesOfComplex( o );
    
    Print( "-------------------------\n" );
    Print( "at homology degree: ", degrees[1], "\n" );
    Display( CertainObject( o, degrees[1] ) );
    
    for i in degrees{[ 2 .. Length( degrees ) ]} do
        Print( "------------^------------\n" );
        Display( CertainMorphism( o, i ) );
        Print( "-------------------------\n" );
        Print( "at homology degree: ", i, "\n" );
        Display( CertainObject( o, i ) );
    od;
    
    Print( "-------------------------\n" );
    
end );

##
InstallMethod( Display,
        "for homalg complexes",
        [ IsCocomplexOfFinitelyPresentedObjectsRep ],
        
  function( o )
    local i, degrees, l;
    
    degrees := ObjectDegreesOfComplex( o );
    
    l := Length( degrees );
    
    Print( "-------------------------\n" );
    
    for i in degrees{[ 1 .. l - 1 ]} do
        Print( "at cohomology degree: ", i, "\n" );
        Display( CertainObject( o, i ) );
        Print( "-------------------------\n" );
        Display( CertainMorphism( o, i ) );
        Print( "------------v------------\n" );
    od;
    
    Print( "at cohomology degree: ", degrees[l], "\n" );
    Display( CertainObject( o, degrees[l] ) );
    Print( "-------------------------\n" );
    
end );

##
InstallMethod( Display,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedObjectsRep and IsGradedObject ],
        
  function( o )
    local i;
    
    for i in ObjectDegreesOfComplex( o ) do
        Print( "-------------------------\n" );
        Print( "at homology degree: ", i, "\n" );
        Display( CertainObject( o, i ) );
    od;
    
    Print( "-------------------------\n" );
    
end );

##
InstallMethod( Display,
        "for homalg complexes",
        [ IsCocomplexOfFinitelyPresentedObjectsRep and IsGradedObject ],
        
  function( o )
    local i;
    
    for i in ObjectDegreesOfComplex( o ) do
        Print( "---------------------------\n" );
        Print( "at cohomology degree: ", i, "\n" );
        Display( CertainObject( o, i ) );
    od;
    
    Print( "---------------------------\n" );
    
end );

##
InstallMethod( Display,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedObjectsRep and IsZero ],
        
  function( o )
    
    Print( "0\n" );
    
end );

##
InstallMethod( Display,
        "for homalg complexes",
        [ IsCocomplexOfFinitelyPresentedObjectsRep and IsZero ],
        
  function( o )
    
    Print( "0\n" );
    
end );

