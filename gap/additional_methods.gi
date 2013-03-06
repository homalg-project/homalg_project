#############################################################################
##
##  additional_methods.gi  PolymakeInterface package       Sebastian Gutsche
##                                                            Thomas Bächler
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Additional GAP methods.
##
#############################################################################

##
InstallMethod( POLYMAKE_SKETCH_WITH_OPTIONS,
               [ IsExternalPolymakeObject, IsString ],
               
  function( cone, filename )
    
    return POLYMAKE_SKETCH_WITH_OPTIONS_KERNEL( cone, filename, [ ] );
    
end );

##
InstallMethod( POLYMAKE_SKETCH_WITH_OPTIONS,
               [ IsExternalPolymakeObject, IsList ],
               
  function( cone, options )
    
    return POLYMAKE_SKETCH_WITH_OPTIONS_KERNEL( cone, false, options );
    
end );

##
InstallMethod( POLYMAKE_SKETCH_WITH_OPTIONS,
               [ IsExternalPolymakeObject, IsString, IsList ],
               
  function( cone, filename, options )
    
    return POLYMAKE_SKETCH_WITH_OPTIONS_KERNEL( cone, filename, options );
    
end );

##
InstallMethod( POLYMAKE_CREATE_TIKZ_FILE_WITH_SKETCH_OPTIONS,
               [ IsExternalPolymakeObject, IsString, IsList, IsString  ],
               
  function( cone, filename, options, sketch_opts )
    local path, sketch, temp_file, filestream, input_stream;
    
    path := DirectoriesSystemPrograms();
    
    sketch := Filename( path, "sketch" );
    
    temp_file := Concatenation( filename, "GAPTMP.sk" );
    
    POLYMAKE_SKETCH_WITH_OPTIONS( cone, temp_file, options );
    
#     temp_file := Concatenation( temp_file, ".sk" );
    
    Exec( Concatenation( "sketch ", sketch_opts, " ", temp_file, ">", filename ) );
    
    Exec( Concatenation( "rm ", temp_file ) );
    
end );

##
InstallMethod( POLYMAKE_CREATE_TIKZ_FILE,
               [ IsExternalPolymakeObject, IsString, IsList ],
               
  function( cone, filename, options )
    
    POLYMAKE_CREATE_TIKZ_FILE_WITH_SKETCH_OPTIONS( cone, filename, options, "" );
    
end );

##
InstallMethod( POLYMAKE_CREATE_TIKZ_FILE,
               [ IsExternalPolymakeObject, IsString ],
               
  function( cone, filename )
    
    POLYMAKE_CREATE_TIKZ_FILE_WITH_SKETCH_OPTIONS( cone, filename, false, "" );
    
end );
