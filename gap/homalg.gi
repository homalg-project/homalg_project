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
            color_BOT := "\033[1;37;40m",		## (T)riangular basis: TriangularBasisOfRows/Columns
            color_BOW := "\033[1;37;40m",		## Triangular basis: TriangularBasisOfRows/Columns( M, W )
            color_BOB := "\033[1;37;45m",		## (B)asis: BasisOfRow/ColumnModule
            color_BOC := "\033[1;37;45m",		## Basis: BasisOfRows/Columns(C)oeff
            color_BOD := "\033[1;37;42m",		## existence of a particular solution: (D)ecideZeroRows/Columns
            color_BOP := "\033[1;37;42m",		## (P)articular solution: DecideZeroRows/Columns(Effectively)
            color_BOH := "\033[1;37;41m",		## solutions of the (H)omogeneous system: SyzygiesGeneratorsOfRows/Columns
            color_busy := "\033[01m\033[4;31;40m",
            color_done := "\033[01m\033[4;32;40m",
           )
);

InstallGlobalFunction( homalgTotalRuntimes,
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

InstallGlobalFunction( homalgNamesOfComponentsToIntLists,
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
