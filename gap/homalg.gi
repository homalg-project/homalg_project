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

InstallValue( HOMALG, rec( ) );

# a global function for logical implications:

InstallGlobalFunction( LogicalImplicationsForHomalg,
  function( arg )
    local property;
    
    for property in arg do;
        
        if Length( property ) = 3 then
            
            InstallTrueMethod( property[3],
                    property[1] );
            
            InstallImmediateMethod( property[1],
                    IsModuleForHomalg and Tester( property[3] ), 0, ## NOTE: don't drop the Tester here!
                    
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
                    IsModuleForHomalg and Tester( property[3] ) and Tester( property[5] ), 0, ## NOTE: don't drop the Testers here!
                    
              function( M )
                if Tester( property[3] )( M ) and Tester( property[5] )( M )  ## FIXME: find a way to get rid of the Testers here
                   and property[3]( M ) and not property[5]( M ) then
                    return false;
                fi;
                
                TryNextMethod( );
                
            end );
            
            InstallImmediateMethod( property[3],
                    IsModuleForHomalg and Tester( property[1] ) and Tester( property[5] ), 0, ## NOTE: don't drop the Testers here!
                    
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

