Print( "S := " );

Display( StringView( S ) );

Display( S );

convert_commands := [
                     "ConvertHomalgMatrixViaListListString",
                     "ConvertHomalgMatrixViaListString",
                     "ConvertHomalgMatrixViaSparseString",
                     "ConvertHomalgMatrixViaFile"
                     ];

for convert in convert_commands do
    
    Print( "\n", convert, ":\n" );
    
    convert := ValueGlobal( convert );
    
    ## a copy of the original imat
    omat := ShallowCopy( imat );
    
    ## omat converted
    cmat := convert( omat, S );
    
    Print( "\n" );
    Display( cmat );
    
    Print( "\nand back:\n" );
    
    ## and back
    bmat := convert( cmat, R );
    
    Print( "\n" );
    Display( bmat );
    
    b := b and bmat = omat;
    
od;

Assert( 0, b );
