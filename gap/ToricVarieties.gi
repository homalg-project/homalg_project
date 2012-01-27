#############################################################################
##
##  ToricVariety.gi         ToricVarieties package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  The Category of toric Varieties
##
#############################################################################

#################################
##
## Global Variables
##
#################################

InstallValue( TORIC_VARIETIES,
              rec( ) );

#################################
##
## Representations
##
#################################

DeclareRepresentation( "IsSheafRep",
                       IsToricVariety and IsAttributeStoringRep,
                       [ "Sheaf" ]
                      );

DeclareRepresentation( "IsCombinatoricalRep",
                       IsToricVariety and IsAttributeStoringRep,
                       [ FanOfVariety ]
                      );

DeclareRepresentation( "IsFanRep",
                       IsCombinatoricalRep,
                       []
                      );

##################################
##
## Family and Type
##
##################################

BindGlobal( "TheFamilyOfToricVarietes",
        NewFamily( "TheFamilyOfToricVarietes" , IsToricVariety ) );

BindGlobal( "TheTypeFanToricVariety",
        NewType( TheFamilyOfToricVarietes,
                 IsFanRep ) );

##################################
##
## Properties
##
##################################

##
InstallMethod( IsNormalVariety,
               " for convex varieties",
               [ IsFanRep ],
               
  function( vari )
    
    return true;
    
end );

##
InstallMethod( IsAffine,
               " for convex varieties",
               [ IsFanRep ],
               
  function( vari )
    local conv;
    
    conv := FanOfVariety( vari );
    
    if Length( MaximalCones( conv ) ) = 1 then
        
        return true;
        
    fi;
    
    return false;
    
end );

##
InstallMethod( IsProjective,
               " for convex varieties",
               [ IsFanRep and IsComplete ],
               
  function( vari )
    
    if Dimension( vari ) <= 2 then
        
        return true;
        
    fi;
    
    return IsRegularFan( FanOfVariety );
    
end );

##
InstallMethod( IsProjective,
               " for convex varieties",
               [ IsToricVariety ],
               
  function( vari )
    
    if not IsComplete( vari ) then
        
        return false;
        
    fi;
    
    TryNextMethod();
    
end );

##
RedispatchOnCondition( IsProjective, true, [ IsToricVariety ], [ IsComplete ], 0 );

##
InstallMethod( IsSmooth,
               " for convex varieties",
               [ IsCombinatoricalRep ],
               
  function( vari )
    
    return IsSmooth( FanOfVariety( vari ) );
    
end );

##
InstallMethod( IsComplete,
               " for convex varieties",
               [ IsFanRep ],
               
  function( vari )
    
    return IsComplete( FanOfVariety( vari ) );
    
end );

##
InstallMethod( HasTorusfactor,
               " for convex varieties",
               [ IsFanRep ],
               
  function( vari )
    local ret;
    
    ret := IsFullDimensional( FanOfVariety( vari ) );
    
    return not ret;
    
end );

##
InstallMethod( IsOrbifold,
               " for convex varieties",
               [ IsFanRep ],
               
  function( vari )
    
    return IsSimplicial( FanOfVariety( vari ) );
    
end );

##################################
##
## Attributes
##
##################################

##
InstallMethod( Dimension,
               " for convex varieties",
               [ IsFanRep ],
               
  function( vari )
    
    return AmbientSpaceDimension( FanOfVariety( vari ) );
    
end );

##
InstallMethod( DimensionOfTorusfactor,
               "for convex varieties",
               [ IsFanRep ],
               
  function( vari )
    local dim, cdim;
    
    if not HasTorusfactor( vari ) then
        
        return 0;
    fi;
    
    dim := Dimension( FanOfVariety( vari ) );
    
    cdim := Dimension( vari );
    
    return cdim - dim;
    
end );

##
InstallMethod( AffineOpenCovering,
               " for convex varieties",
               [ IsFanRep ],
               
  function( vari )
    local cones;
    
    cones := MaximalCones( FanOfVariety( vari ) );
    
    cones := List( cones, ToricVariety );
    
    cones := List( cones, i -> ToricSubvariety( i, vari ) );
    
    return cones;
    
end );

##
InstallMethod( IsProductOf,
               " for convex varieties",
               [ IsToricVariety ],
               
  function( vari )
    
    return [ vari ];
    
end );

##
InstallMethod( DivisorGroup,
               "for toric varieties",
               [ IsFanRep ],
               
  function( vari )
    local rays;
    
    rays := Length( RayGenerators( FanOfVariety( vari ) ) );
    
    return rays * HOMALG_MATRICES.ZZ;
    
end );

##
InstallMethod( MapFromCharacterToPrincipalDivisor,
               " for convex varieties",
               [ IsFanRep ],
               
  function( vari )
    local dims, rays, M;
    
    dims := Dimension( vari );
    
    rays := RayGenerators( FanOfVariety( vari ) );
    
    M := HomalgMatrix( Flat( rays ), Length( rays ), dims, HOMALG_MATRICES.ZZ );
    
    M := Involution( M );
    
    return HomalgMap( M, CharacterGrid( vari ), DivisorGroup( vari ) );
    
end );

##
InstallMethod( ClassGroup,
               " for convex varieties",
               [ IsFanRep ],
               
  function( vari )
    local dims, rays, M, grou;
    
    if Length( IsProductOf( vari ) ) > 1 then
        
        return Sum( List( IsProductOf( vari ), ClassGroup ) );
        
    fi;
    
    return Cokernel( MapFromCharacterToPrincipalDivisor( vari ) );
    
end );

##
InstallMethod( PicardGroup,
               " for affine varieties",
               [ IsToricVariety and IsAffine ],
               
  function( vari )
    
    return 0 * HOMALG_MATRICES.ZZ;
    
end );

##
InstallMethod( PicardGroup,
               " for smooth varieties",
               [ IsToricVariety and IsSmooth and HasClassGroup ],
               
  function( vari )
    
    return ClassGroup( vari );
    
end );

##
InstallMethod( PicardGroup,
               " for simplicial varieties",
               [ IsFanRep and IsOrbifold ],
               
  function( vari )
    
    if not HasTorusfactor( vari ) then
        
        return TorsionFreeFactor( ClassGroup( vari ) );
        
    fi;
    
    TryNextMethod();
    
end );

##
InstallMethod( PicardGroup,
               " for toric varieties",
               [ IsFanRep ],
               
  function( vari )
    local carts, morph;
    
    carts := CartierDivisorGroup( vari );
    
    morph := CokernelEpi( MapFromCharacterToPrincipalDivisor( vari ) );
    
    carts := MorphismHavingSubobjectAsItsImage( carts );
    
    carts := PreCompose( carts, morph );
    
    return ImageSubobject( carts );
    
end );

##
RedispatchOnCondition( PicardGroup, true, [ IsToricVariety ], [ IsOrbifold ], 2 );

##
RedispatchOnCondition( PicardGroup, true, [ IsToricVariety ], [ IsSmooth ], 1 );

##
RedispatchOnCondition( PicardGroup, true, [ IsToricVariety ], [ IsAffine ], 0 );

##
InstallMethod( CharacterGrid,
               " for convex toric varieties.",
               [ IsCombinatoricalRep ],
               
  function( vari )
    
    return ContainingGrid( FanOfVariety( vari ) );
    
end );

##
InstallMethod( CoxRing,
               " for convex varieties.",
               [ IsFanRep ],
               
  function( vari )
    
    Error( "variable needed to create Coxring." );
    
end );

##
InstallMethod( CoxRing,
               " for convex toric varieties.",
               [ IsFanRep, IsString ],
               
  function( vari, var )
    local raylist, rays, indets, ring;
    
    raylist := RayGenerators( FanOfVariety( vari ) );
    
    rays := [ 1 .. Length( raylist ) ];
    
    indets := List( rays, i -> JoinStringsWithSeparator( [ var, i ], "_" ) );
    
    indets := JoinStringsWithSeparator( indets, "," );
    
    ring := GradedRing( DefaultFieldForToricVarieties() * indets );
    
    SetDegreeGroup( ring, ClassGroup( vari ) );
    
    indets := Indeterminates( ring );
    
    raylist := List( PrimeDivisors( vari ), i -> ClassOfDivisor( i ) );
    
    SetWeightsOfIndeterminates( ring, raylist );
    
    SetCoxRing( vari, ring );
    
    return ring;
    
end );

##
InstallMethod( IrrelevantIdeal,
               " for toric varieties",
               [ IsFanRep ],
               
  function( vari )
    local ring, maxcones, gens, irr, i, j;
    
    if not HasCoxRing( vari ) then
        
        Error( "must specify cox ring before specifying irrelevant ideal." );
        
    fi;
    
    ring := CoxRing( vari );
    
    maxcones := RaysInMaximalCones( FanOfVariety( vari ) );
    
    gens :=Indeterminates( ring );
    
    irr := [ 1 .. Length( maxcones ) ];
    
    for i in [ 1 .. Length( maxcones ) ] do
        
        irr[ i ] := 1;
        
        for j in [ 1 .. Length( maxcones[ i ] ) ] do
            
            irr[ i ] := irr[ i ] * gens[ j ]^( 1 - maxcones[ i ][ j ] );
            
        od;
        
    od;
    
    irr := HomalgMatrix( irr, Length( irr ), 1, CoxRing( vari ) );
    
    irr := HomalgMap( irr, "free", "free" );
    
    return ImageSubobject( irr );
    
end );

##
InstallMethod( MorphismFromCoxVariety,
               [ IsFanRep ],
               
  function( vari )
    local fan, rays, newrays, maxcones, newfan, i, j;
    
    fan := FanOfVariety( vari );
    
    rays := RayGenerators( fan );
    
    newrays := IdentityMat( Length( rays ) );
    
    maxcones := RaysInMaximalCones( fan );
    
    newfan := List( maxcones, i -> [ ] );
    
    for i in [ 1 .. Length( maxcones ) ] do
        
        for j in [ 1 .. Length( rays ) ] do
            
            if maxcones[ i ][ j ] = 1 then
                
                Add( newfan[ i ], newrays[ j ] );
                
            fi;
            
        od;
        
    od;
    
    newfan := HomalgFan( newfan );
    
    newfan := ToricVariety( newfan );
    
    newfan := ToricMorphism( newfan, rays, vari );
    
    return newfan;
    
end );

##
InstallMethod( CoxVariety,
               " for toric varieties",
               [ IsToricVariety ],
               
  function( vari )
    
    return SourceObject( MorphismFromCoxVariety( vari ) );
    
end );

##
InstallMethod( CartierDivisorGroup,
               " for conv toric varieties",
               [ IsCombinatoricalRep ],
               
  function( vari )
    local rays, maxcones, nrays, ncones, charrank, newgrid, dimnewgrid, matr1, i, j, k, matr2, currrow, matr3;
    
    if HasTorusfactor( vari ) then
        
        Error( "warning, computation may be wrong" );
        
    fi;
    
    rays := RayGenerators( FanOfVariety( vari ) );
    
    maxcones := RaysInMaximalCones( FanOfVariety( vari ) );
    
    nrays := Length( rays );
    
    ncones := Length( maxcones );
    
    charrank := Rank( CharacterGrid( vari ) );
    
    newgrid := ncones * CharacterGrid( vari );
    
    dimnewgrid := ncones * charrank;
    
    matr1 := [ ];
    
    matr2 := [ ];
    
    for i in [ 2 .. ncones ] do
        
        for j in [ 1 .. i-1 ] do
            
            currrow := List( [ 1 .. dimnewgrid ], function( k )
                                                      if i*charrank >= k and k > (i-1)*charrank then
                                                          return 1;
                                                      elif j*charrank >= k and k > (j-1)*charrank then
                                                          return -1;
                                                      fi;
                                                      return 0;
                                                    end );
            
            Add( matr1, currrow );
            
            currrow := maxcones[ i ] + maxcones[ j ];
            
            currrow := List( currrow, function( k ) if k = 2 then return 1; fi; return 0; end );
            
            currrow := List( [ 1 .. nrays ], k -> currrow[ k ] * rays[ k ] );
            
            Add( matr2, Flat( currrow ) );
            
        od;
        
    od;
    
    matr1 := Involution( HomalgMatrix( matr1, HOMALG_MATRICES.ZZ ) );
    
    matr2 := HomalgMatrix( matr2, HOMALG_MATRICES.ZZ );
    
    matr3 := matr1 * matr2;
    
    matr3 := HomalgMap( matr3, newgrid, "free" );
    
    matr3 := KernelSubobject( matr3 );
    
    matr3 := MorphismHavingSubobjectAsItsImage( matr3 );
    
    matr1 := List( [ 1 .. charrank ], i -> 0 );
    
    matr2 := [ ];
    
    for i in [ 1 .. nrays ] do
        
        currrow := [ ];
        
        j := 1;
        
        while maxcones[ j ][ i ] = 0 and j <= ncones do
            
            Add( currrow, matr1 );
            
            j := j + 1;
            
        od;
        
        if j > ncones then
            
            Error( " there seems to be a ray which is in no max cone. Something went wrong!" );
            
        fi;
        
        Add( currrow, rays[ i ] );
        
        j := j + 1;
        
        while j <= ncones do
            
            Add( currrow, matr1 );
            
            j := j + 1;
            
        od;
        
        currrow := Flat( currrow );
        
        Add( matr2, currrow );
        
    od;
    
    matr2 := HomalgMatrix( matr2, HOMALG_MATRICES.ZZ );
    
    matr2 := Involution( matr2 );
    
    matr2 := HomalgMap( matr2, Range( matr3 ), DivisorGroup( vari ) );
    
    return ImageSubobject( matr2 );
    
end );

##################################
##
## Methods
##
##################################

##
InstallMethod( UnderlyingSheaf,
               " getter for the sheaf",
               [ IsToricVariety ],
               
  function( var )
    
    if IsBound( var!.Sheaf ) then
        
        return var!.Sheaf;
        
    else
        
        Error( " no sheaf." );
        
    fi;
    
end );

##
InstallMethod( CoordinateRingOfTorus,
               " for affine convex varieties",
               [ IsToricVariety, IsList ],
               
  function( vari, vars )
    local n, ring, i, rels;
    
    if HasCoordinateRingOfTorus( vari ) then
        
        return CoordinateRingOfTorus( vari );
        
    fi;
    
#     if Length( IsProductOf( vari ) ) > 1 then
#         
#         n := IsProductOf( vari );
#         
#         if ForAll( n, HasCoordinateRingOfTorus ) then
#             
#             ring := Product( List( n, CoordinateRingOfTorus ) );
#             
#             SetCoordinateRingOfTorus( vari, ring );
#             
#             return ring;
#             
#         fi;
#     
#     fi;
    
    n := Dimension( vari );
    
    if ( not Length( vars ) = 2 * n ) and ( not Length( vars ) = n ) then
        
        Error( " incorrect number of indets." );
        
    fi;
    
    if Length( vars ) = n then
        
        vars := List( vars, i -> [ i, JoinStringsWithSeparator( [i,"1"], "" ) ] );
        
        vars := List( vars, i -> JoinStringsWithSeparator( i, "," ) );
        
    fi;
    
    vars := JoinStringsWithSeparator( vars );
    
    ring := DefaultFieldForToricVarieties() * vars;
    
    vars := Indeterminates( ring );
    
    rels := [ 1..n ];
    
    for i in [ 1 .. n ] do
        
        rels[ i ] := vars[ 2*i - 1 ] * vars[ 2*i ] - 1;
        
    od;
    
    ring := ring / rels;
    
    SetCoordinateRingOfTorus( vari, ring );
    
    return ring;
    
end );

##
InstallMethod( CoordinateRingOfTorus,
               " for toric varieties and a string",
               [ IsToricVariety, IsString ],
               
  function( vari, str )
    local varlist;
    
    varlist := Dimension( vari );
    
    varlist := List( [ 1 .. varlist ], i -> JoinStringsWithSeparator( [ str, i ], "_" ) );
    
    return CoordinateRingOfTorus( vari, varlist );
    
end );

##
InstallMethod( \*,
               "for toric varieties",
               [ IsFanRep, IsFanRep ],
               
  function( var1, var2 )
    local produ;
  
    produ := ToricVariety( FanOfVariety( var1 ) * FanOfVariety( var2 ) );
    
    SetIsProductOf( produ, Flat( [ IsProductOf( var1 ), IsProductOf( var2 ) ] ) );
    
    return produ;
    
end );

##
InstallMethod( CharacterToRationalFunction,
               "for toric varieties",
               [ IsHomalgElement, IsToricVariety ],
               
  function( elem, vari )
    
    return CharacterToRationalFunction( UnderlyingListOfRingElements( elem ), vari );
    
end );

##
InstallMethod( CharacterToRationalFunction,
               " for toric varieties",
               [ IsList, IsToricVariety ],
               
  function( elem, vari )
    local ring, gens, el, i;
    
    if not HasCoordinateRingOfTorus( vari ) then
        
        Error( "cannot compute rational function without coordinate ring of torus, please specify first.");
        
        return 0;
        
    fi;
    
    ring := CoordinateRingOfTorus( vari );
    
    gens := Indeterminates( ring );
    
    el := One( ring );
    
    for i in [ 1 .. Length( elem ) ] do
        
        if elem[ i ] < 0 then
            
            el := el * gens[ 2 * i ]^( - elem[ i ] );
            
        else
            
            el := el * gens[ 2 * i - 1 ]^( elem[ i ] );
            
        fi;
        
    od;
    
    return el;
    
end );

##
InstallMethod( PrimeDivisors,
               " for toric varieties",
               [ IsToricVariety ],
               
  function( vari )
    local divs;
    
    divs := DivisorGroup( vari );
    
    divs := GeneratingElements( divs );
    
    Apply( divs, i -> Divisor( i, vari ) );
    
    List( divs, function( j ) SetIsPrimedivisor( j, true ); return 0; end );
    
    return divs;
    
end );

##################################
##
## Constructors
##
##################################

##
InstallMethod( ToricVariety,
               " for homalg fans",
               [ IsHomalgFan ],
               
  function( fan )
    local var;
    
    if not IsPointed( fan ) then
        
        Error( " input fan must only contain strictly convex cones." );
        
    fi;
    
    var := rec( );
    
    ObjectifyWithAttributes(
                             var, TheTypeFanToricVariety,
                             FanOfVariety, fan
                            );
    
    return var;
    
end );

#################################
##
## Display
##
#################################

##
InstallMethod( ViewObj,
               " for toric varieties",
               [ IsToricVariety ],
               
  function( var )
    
    Print( "<A" );
    
    if HasIsAffine( var ) then
        
        if IsAffine( var ) then
            
            Print( "n affine");
            
        fi;
        
    fi;
    
    if HasIsProjective( var ) then
        
        if IsProjective( var ) then
            
            Print( " projective");
            
        fi;
        
    fi;
    
    if HasIsNormalVariety( var ) then
        
        if IsNormalVariety( var ) then
            
            Print( " normal");
            
        fi;
        
    fi;
    
    if HasIsSmooth( var ) then
        
        if IsSmooth( var ) then
            
            Print( " smooth");
            
        fi;
        
    fi;
    
    if HasIsComplete( var ) then
        
        if IsComplete( var ) then
            
            Print( " complete");
            
        fi;
        
    fi;
    
    if IsToricVariety( var ) then
        
        Print( " toric variety" );
        
    elif IsToricSubvariety( var ) then
        
        Print( " toric subvariety" );
        
    fi;
    
    if HasDimension( var ) then
        
        Print( " of dimension ", Dimension( var ) );
        
    fi;
    
    if HasHasTorusfactor( var ) then
        
        if HasTorusfactor( var ) then
            
            Print(" with a torus factor of dimension ", DimensionOfTorusfactor( var ) );
            
        fi;
        
    
    fi;
    
    if HasIsProductOf( var ) then
        
        if Length( IsProductOf( var ) ) > 1 then
            
            Print(" which is a product of ", Length( IsProductOf( var ) ), " toric varieties" );
            
        fi;
        
    fi;
    
    Print( ">" );
    
end );

##
InstallMethod( Display,
               " for toric varieties",
               [ IsToricVariety ],
               
  function( var )
    
    Print( "A" );
    
    if HasIsAffine( var ) then
        
        if IsAffine( var ) then
            
            Print( "n affine");
            
        fi;
        
    fi;
    
    if HasIsProjective( var ) then
        
        if IsProjective( var ) then
            
            Print( " projective");
            
        fi;
        
    fi;
    
    if HasIsNormalVariety( var ) then
        
        if IsNormalVariety( var ) then
            
            Print( " normal");
            
        fi;
        
    fi;
    
    if HasIsSmooth( var ) then
        
        if IsSmooth( var ) then
            
            Print( " smooth");
            
        fi;
        
    fi;
    
    if HasIsComplete( var ) then
        
        if IsComplete( var ) then
            
            Print( " complete");
            
        fi;
        
    fi;
    
    if IsToricVariety( var ) and not IsToricSubvariety( var ) then
        
        Print( " toric variety" );
        
    elif IsToricSubvariety( var ) then
        
        Print( " toric subvariety" );
        
    fi;
    
    if HasDimension( var ) then
        
        Print( " of dimension ", Dimension( var ) );
        
    fi;
    
    if HasHasTorusfactor( var ) then
        
        if HasTorusfactor( var ) then
            
            Print(" with a torus factor of dimension ", DimensionOfTorusfactor( var ) );
            
        fi;
        
    
    fi;
    
    if HasIsProductOf( var ) then
        
        if Length( IsProductOf( var ) ) > 1 then
            
            Print(" which is a product of ", Length( IsProductOf( var ) ), " toric varieties" );
            
        fi;
        
    fi;
    
    Print( ".\n" );
    
    if HasCoordinateRingOfTorus( var ) then
        
        Print( " The torus of the variety is ", CoordinateRingOfTorus( var ),".\n" );
        
    fi;
    
    if HasClassGroup( var ) then
        
        Print( " The class group is ", ClassGroup( var ) );
        
        if HasCoxRing( var ) then
            
            Print( " and the Cox ring is ", CoxRing( var ) );
            
        fi;
        
        Print( ".\n" );
        
    fi;
    
    if HasPicardGroup( var ) then
        
        Print( "The Picard group is ", PicardGroup( var ) );
        
    fi;
    
end );
