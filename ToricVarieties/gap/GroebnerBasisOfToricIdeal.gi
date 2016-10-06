#############################################################################
##
##  GroebnerBasisOfToricIdeal.gi     ToricVarieties       Sebastian Gutsche
##
##  Copyright 2012- 2016, Sebastian Gutsche, TU Kaiserslautern
##                        Martin Bies,       ITP Heidelberg
##
##  Functors for toric varieties.
##
#############################################################################

##
InstallGlobalFunction( cmp_forGeneratingSetOfToricIdealGivenByHilbertBasis,
                       
  function( v1, v2 )
    local n, sum1, sum2, j;
    
    n := Length( v1 );
    
    if n = 0 or n <> Length( v2 ) then
        
        Error( "the two have not the same length\n" );
        
        return fail;
        
    fi;
    
    if Maximum( v1[ 1 ], 0 ) < Maximum( v2[ 1 ], 0 ) then
        return true;
    elif Maximum( v1[ 1 ], 0 ) > Maximum( v2[ 1 ], 0 ) then
        return false;
    fi;
    
    sum1 := 0;
    sum2 := 0;
    
    sum1 := Sum( [ 2 .. n ], i -> Maximum( v1[ i ], 0 ) );
    sum2 := Sum( [ 2 .. n ], i -> Maximum( v2[ i ], 0 ) );
    
    if sum1 < sum2 then
        return true;
    elif sum1 > sum2 then
        return false;
    fi;
    
    for j in [ 0 .. n - 2 ] do
        
        if Maximum( v1[ n - j ], 0 ) > Maximum( v2[ n - j ], 0 ) then
            return true;
        elif Maximum( v1[ n - j ], 0 ) < Maximum( v2[ n - j ], 0 ) then
            return false;
        fi;
        
    od;
    
    return false;
    
end );

##
InstallGlobalFunction( normalize_forGeneratingSetOfToricIdealGivenByHilbertBasis,
                       
  function( v )
    
    if cmp_forGeneratingSetOfToricIdealGivenByHilbertBasis( v, -v ) then
        
        return -v;
        
    fi;
    
    return v;
    
end );

##
InstallGlobalFunction( prepareIdeal_forGeneratingSetOfToricIdealGivenByHilbertBasis,
                       
  function( gen_set )
    local n, extended_genset, i;
    
    if Length( gen_set ) = 0 then
        
        Error( "input must not be empty\n" );
        
    fi;
    
    n := Length( gen_set[ 1 ] );
    
    if not ForAll( gen_set, i -> Length( i ) = n ) then
        
        Error( "not all entries have the same length\n" );
        
    fi;
    
    extended_genset := [ List( [ 1 .. n + 1 ], i -> 1 ) ];
    
    Perform( gen_set, function( i ) Add( extended_genset, normalize_forGeneratingSetOfToricIdealGivenByHilbertBasis( Concatenation( [ 0 ], i ) ) ); end );
    
    return extended_genset;
    
end );

##
InstallGlobalFunction( divides_forGeneratingSetOfToricIdealGivenByHilbertBasis,
                       
  function( v1, v2 )
    local i;
    
    return not ForAny( [ 1 .. Length( v1 ) ], i -> Maximum( v1[ i ], 0 ) > Maximum( v2[ i ], 0 ) );
    
end );

##
InstallGlobalFunction( findDivisor_forGeneratingSetOfToricIdealGivenByHilbertBasis,
                       
  function( v, gen_set )
    local i;
    
    for i in gen_set do
        
        if divides_forGeneratingSetOfToricIdealGivenByHilbertBasis( i, v ) then
            
            return i;
            
        fi;
        
    od;
    
    return fail;
    
end );

##
InstallGlobalFunction( reduce_forGeneratingSetOfToricIdealGivenByHilbertBasis,
                       
  function( v, gen_set )
    local d;
    
    while true do
        
        d := findDivisor_forGeneratingSetOfToricIdealGivenByHilbertBasis( v, gen_set );
        
        if d = fail then
            break;
        fi;
        
        v := v - d;
        
        normalize_forGeneratingSetOfToricIdealGivenByHilbertBasis( v );
        
    od;
    
    while true do
        
        d := findDivisor_forGeneratingSetOfToricIdealGivenByHilbertBasis( -v, gen_set  );
        
        if d = fail then
            break;
        fi;
        
        v := v + d;
        
    od;
    
    return v;
    
end );

##
InstallMethod( GeneratingSetOfToricIdealGivenByHilbertBasis,
               "for a hilbert basis of a cone",
               [ IsList ],
               
  function( basis )
    local Q, gen_set, i, v;
    
    if Length( basis ) = 0 then
        
        return basis;
        
    fi;
    
    Q := prepareIdeal_forGeneratingSetOfToricIdealGivenByHilbertBasis( basis );
    
    gen_set := [ ];
    
    while Length( Q ) > 0 do
        
        v := Remove( Q, 1 );
        
        v := reduce_forGeneratingSetOfToricIdealGivenByHilbertBasis( v, gen_set );
        
        if IsZero( v ) then
            continue;
        fi;
        
        for i in [ 1 .. Length( gen_set ) ] do
            
            if divides_forGeneratingSetOfToricIdealGivenByHilbertBasis( v, gen_set[ i ] ) then
                
                Add( Q, Remove( gen_set, i ) );
                
            fi;
            
        od;
        
        for i in gen_set do
            
            if not ForAll( [ 1 .. Length( v ) ], j -> v[ j ] <= 0 or i[ j ] <= 0 ) then
                
                Add( Q, normalize_forGeneratingSetOfToricIdealGivenByHilbertBasis( v - i ) );
                
            fi;
            
        od;
        
        Add( gen_set, v );
        
    od;
    
    gen_set := Filtered( gen_set, i -> i[ 1 ] = 0 );
    
    return gen_set;
    
end );