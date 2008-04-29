#############################################################################
##
##  HomalgExternalRing.gi     IO_ForHomalg package           Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for IO_ForHomalg.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( HOMALG_IO,
        rec(
            SaveHomalgMaximumBackStream := false,
            color_display := false,
	    DirectoryForTemporaryFiles := "./",
	    DoNotFigureOutAnAlternativeDirectoryForTemporaryFiles := false,
	    DoNotDeleteTemporaryFiles := false,
	    ListOfAlternativeDirectoryForTemporaryFiles := [ "/dev/shm/", "/var/tmp/", "/tmp/" ],
	    FileNameCounter := 1
	    # HOMALG_IO.PID is not bound, so that it is initialized with a random 5-digit-integer
           )
);

####################################
#
# global functions and operations:
#
####################################

##
InstallGlobalFunction( FigureOutAnAlternativeDirectoryForTemporaryFiles,
  function( file )
    local list, separator, directory, filename, fs;
    
    if IsBound( HOMALG_IO.ListOfAlternativeDirectoryForTemporaryFiles ) then
        list := HOMALG_IO.ListOfAlternativeDirectoryForTemporaryFiles;
    else
        list := [ "/dev/shm/", "/var/tmp/", "/tmp/" ];
    fi;
    
    ## figure out the directory separtor:
    if IsBound( GAPInfo.UserHome ) then
        separator := GAPInfo.UserHome{[1]};
    else
        separator := "/";
    fi;
    
    for directory in list do
        
        if directory{[Length(directory)]} <> separator then
            filename := Concatenation( directory, separator, file );
        else
            filename := Concatenation( directory, file );
        fi;
        
        fs := IO_File( filename, "w" );
        
        if fs <> fail then
	    IO_Close( fs );
            return directory;
        fi;
        
    od;
    
    return fail;
    
end );
