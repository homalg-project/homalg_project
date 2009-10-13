Print( "S := " );

Display( S );

convert_commands := [
                     "ConvertHomalgMatrixViaListListString",
                     "ConvertHomalgMatrixViaListString",
                     "ConvertHomalgMatrixViaSparseString",
                     "ConvertHomalgMatrixViaFile"
                     ];

for c in convert_commands do
    
    Print( "\n## ", c, ":\n" );
    
    c := ValueGlobal( c );
    
    ## a copy of the original imat
    omat := ShallowCopy( imat );
    
    ## omat converted
    cmat := c( omat, S );
    
    Print( "\n" );
    Display( cmat );
    
    Print( "\n## and back:\n" );
    
    ## and back
    bmat := c( cmat, R );
    
    Print( "\n" );
    Display( bmat );
    
    b := b and bmat = omat;
    
od;

Assert( 0, b );
