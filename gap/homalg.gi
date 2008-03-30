#############################################################################
##
##  homalg.gi                   homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for homalg.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( HOMALG,
        rec(
            TotalRuntimes := 0,
            color_start_FOB := "\033[1m\033[4;37;45m",
            color_end_FOB := "\033[1m\033[4;35;47m",
            color_start_FO := "\033[1;33;41m",
            color_end_FO := "\033[1;31;43m" ) );

InstallGlobalFunction( HomalgTotalRuntimes,
  function( arg )
    local r, t;
    
    r := Runtimes( );
    
    HOMALG.TotalRuntimes := r.user_time;
    
    if IsBound( r.system_time ) then
        HOMALG.TotalRuntimes := HOMALG.TotalRuntimes + r.system_time;
    fi;
    
    if IsBound( r.user_time_children ) then
        HOMALG.TotalRuntimes := HOMALG.TotalRuntimes + r.user_time_children;
    fi;
    
    if IsBound( r.system_time_children ) then
        HOMALG.TotalRuntimes := HOMALG.TotalRuntimes + r.system_time_children;
    fi;
    
    if Length( arg ) = 0 then
        return HOMALG.TotalRuntimes;
    fi;
    
    return TimeToString( HOMALG.TotalRuntimes - arg[1] );
    
end );

# a global function for logical implications:

InstallGlobalFunction( LogicalImplicationsForHomalg,
  function( arg )
    local property;
    
    for property in arg do;
        
        if Length( property ) = 3 then
            
            InstallTrueMethod( property[3],
                    property[1] );
            
            InstallImmediateMethod( property[1],
                    IsHomalgModule and Tester( property[3] ), 0, ## NOTE: don't drop the Tester here!
                    
              function( M )
                if Tester( property[3] )( M ) and not property[3]( M ) then  ## FIXME: find a way to get rid of the Tester here
                    return false;
                fi;
                
                TryNextMethod( );
                
            end );
            
        elif Length( property ) = 5 then
            
            InstallTrueMethod( property[5],
                    property[1] and property[3] );
            
            InstallImmediateMethod( property[1],
                    IsHomalgModule and Tester( property[3] ) and Tester( property[5] ), 0, ## NOTE: don't drop the Testers here!
                    
              function( M )
                if Tester( property[3] )( M ) and Tester( property[5] )( M )  ## FIXME: find a way to get rid of the Testers here
                   and property[3]( M ) and not property[5]( M ) then
                    return false;
                fi;
                
                TryNextMethod( );
                
            end );
            
            InstallImmediateMethod( property[3],
                    IsHomalgModule and Tester( property[1] ) and Tester( property[5] ), 0, ## NOTE: don't drop the Testers here!
                    
              function( M )
                if Tester( property[1] )( M ) and Tester( property[5] )( M )  ## FIXME: find a way to get rid of the Testers here
                   and property[1]( M ) and not property[5]( M ) then
                    return false;
                fi;
                
                TryNextMethod( );
                
            end );
            
        fi;
        
    od;
    
end );

InstallGlobalFunction( HomalgNamesOfComponentsToIntLists,
  function( arg )
    
    return Filtered(
                   List( NamesOfComponents( arg[1] ),
                         function( a )
                           local l;
                           l := SplitString( a, ",", "[ ]" );
                           if Length( l ) = 1 then
                               if Length( l[1] ) <= 24 then
                                   return Int( l[1] );
                               else
                                   return fail;
                               fi;
                           else
                               return List( l, Int );
                           fi;
                         end
                       ),
                  b -> b <> fail );
end );
