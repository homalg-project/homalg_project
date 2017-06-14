#############################################################################
##
##  SymmetricDifference.gi     Gauss package                Sebastian Gutsche
##
##  Copyright 2017, University of Siegen
##
##  Fallback for symmetric difference operation
##
#############################################################################

InstallGlobalFunction( SYMMETRIC_DIFFERENCE_OF_ORDERED_SETS_OF_SMALL_INTEGERS,
  
  function( a, b )
    local length_a, length_b, a_run, b_run, complete_run, result, a_current, b_current;
    
    if a = [] then
        return b;
    elif b = [] then
        return a;
    fi;
    
    length_a := Length( a );
    length_b := Length( b );
    
    a_run := 1;
    b_run := 1;
    
    complete_run := 1;
    
    result := [];
    result[ length_a + length_b + 1 ] := fail;
    
    a_current := a[ 1 ];
    b_current := b[ 1 ];
    
    while true do
        if a_current < b_current then
            result[ complete_run ] := a_current;
            a_run := a_run + 1;
            complete_run := complete_run + 1;
            if a_run > length_a then
                break;
            fi;
            a_current := a[ a_run ];
        elif b_current < a_current then
            result[ complete_run ] := b_current;
            b_run := b_run + 1;
            complete_run := complete_run + 1;
            if b_run > length_b then
                break;
            fi;
            b_current := b[ b_run ];
        else
            a_run := a_run + 1;
            b_run := b_run + 1;
            if a_run > length_a then
                break;
            fi;
            if b_run > length_b then
                break;
            fi;
            a_current := a[ a_run ];
            b_current := b[ b_run ];
        fi;
    od;
    
    Unbind( result[length_a + length_b + 1] );
    
    if a_run <= length_a then
        Append( result, a{[ a_run .. length_a ]} );
    elif b_run <= length_b then
        Append( result, b{[ b_run .. length_b ]} );
    fi;
    
    
    return result;
    
end );
