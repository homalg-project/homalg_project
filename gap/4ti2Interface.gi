#############################################################################
##
##  4ti2Interface.gi                                    4ti2Interface package
##
##  Copyright 2013,               Sebastian Gutsche, RWTH-Aachen University
##
##  Reading the declaration part of the 4ti2Interface package.
##
#############################################################################

##
InstallGlobalFunction( 4ti2Interface_Read_Matrix_From_File,
                       
  function( filename )
    local filestream, matrix, string, nr_rows, nr_cols;
    
    if not IsExistingFile( filename ) then
        
        Error( "file does not exist" );
        
        return fail;
        
    fi;
    
    filestream := InputTextFile( filename );
    
    matrix := [ ];
    
    string := ReadLine( filestream );
    
    while string <> fail do
        
        string := SplitString( string, " ", " \n" );
        
        string := List( string, Int );
        
        matrix := Concatenation( matrix, string );
        
        string := ReadLine( filestream );
        
    od;
    
    CloseStream( filestream );
    
    nr_rows := Remove( matrix, 1 );
    
    nr_cols := Remove( matrix, 1 );
    
    if not Length( matrix ) = nr_cols * nr_rows then
        
        Error( "wrong input matrix dimension" );
        
        return [ fail, [ nr_rows, nr_cols ], matrix ];
        
    fi;
    
    matrix := CutVector( matrix, nr_rows );
    
    return matrix;
    
end );

##
InstallGlobalFunction( 4ti2Interface_Write_Matrix_To_File,
                       
  function( matrix, string )
    local filestream, i, j;
    
    filestream := OutputTextFile( string, false );
    
    i := Length( matrix );
    
    if i = 0 then
        
        return matrix;
        
    fi;
    
    j := Length( matrix[ 1 ] );
    
    if j = 0 then
        
        return matrix;
        
    fi;
    
    if not ForAll( matrix, k -> Length( k ) = j ) then
        
        Error( "Input is not a matrix" );
        
        return fail;
        
    fi;
    
    WriteAll( filestream, Concatenation( String( i ), " ", String( j ), "\n"  ) );
    
    for i in matrix do
        
        for j in i do
            
            WriteAll( filestream, Concatenation( String( j ), " " ) );
            
        od;
        
        WriteAll( filestream, "\n" );
        
    od;
    
    CloseStream( filestream );
    
end );

InstallGlobalFunction( 4ti2Interface_groebner_matrix,
                       
  function( matrix )
    local dir, filename;
    
    dir := DirectoryTemporary();
    
    filename := Filename( dir, "gap_4ti2_temp_matrix" );
    
    4ti2Interface_Write_Matrix_To_File( matrix, Concatenation( filename, ".mat" ) );
    
    Exec( Concatenation( "groebner ", filename ) );
    
    matrix := 4ti2Interface_Read_Matrix_From_File( Concatenation( filename, ".gro" ) );
    
    Exec( Concatenation( "rm ", Concatenation( filename, ".gro" ) ) );
    
    return matrix;
    
end );

InstallGlobalFunction( 4ti2Interface_groebner_basis,
                       
  function( matrix )
    local dir, filename;
    
    dir := DirectoryTemporary();
    
    filename := Filename( dir, "gap_4ti2_temp_lattice" );
    
    4ti2Interface_Write_Matrix_To_File( matrix, Concatenation( filename, ".lat" ) );
    
    Exec( Concatenation( "groebner ", filename ) );
    
    matrix := 4ti2Interface_Read_Matrix_From_File( Concatenation( filename, ".gro" ) );
    
    Exec( Concatenation( "rm ", Concatenation( filename, ".gro" ) ) );
    
    return matrix;
    
end );
