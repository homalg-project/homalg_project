#############################################################################
##
##  HomalgToCAS.gi           HomalgToCAS package           Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for HomalgToCAS.
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
            show_banners := true,
            variable_name := "homalg_variable_",
            InformAboutCASystemsWithoutActiveRings := true,
            SaveHomalgMaximumBackStream := false,
            color_display := false,
            DirectoryForTemporaryFiles := "/dev/shm/",
            DoNotFigureOutAnAlternativeDirectoryForTemporaryFiles := false,
            DoNotDeleteTemporaryFiles := false,
            ListOfAlternativeDirectoryForTemporaryFiles := [ "/dev/shm/", "/var/tmp/", "/tmp/", "./" ],
            FileNameCounter := 1,
            DeletePeriod := 500,
            PID := IO_getpid(),
            save_CAS_commands_to_file := false,
            suppress_CAS := false,
            suppress_PID := false,
            Pictograms := rec(
                
                ## colors:
                color_need_command		:= "\033[1;33;44m",	## pictogram color of a "need_command" or assignment operation
                color_need_output		:= "\033[1;34;43m",	## pictogram color of a "need_output" or "need_display" operation
                
                ## good morning computer algebra system:
                initialize				:= "ini",	## initialize
                define					:= "def",	## define macros
                
                ## don't add more weight than necessary:
                delete					:= "xxx",	## delete a variable
                multiple_delete				:= "XXX",	## delete serveral variables
                garbage_collector			:= "grb",	## trigger the garbage collector
                
                ## create lists:
                CreateList				:= "lst",	## define a list
                
                ## create rings:
                CreateHomalgRing			:= "R:=",	## define a ring
                variables				:= "var",	## get the names of the "variables" defining the ring
                Zero					:= "0:=",	## define zero
                One					:= "1:=",	## define one
                MinusOne				:= "-:=",	## define minus one
                
                ## mandatory ring operations:
                homalgSetName				:= "\"a\"",	## get the name of an element (important if the CAS pretty-prints ring elements, we need names that can be used as input!)
                							## (install a method instead of a homalgTable entry)
                IsZero					:= "a=0",	## a = 0 ?
                IsOne					:= "a=1",	## a = 1 ?
                Minus					:= "a-b",	## substract two ring elements (needed by SimplerEquivalentMatrix in case CopyRow/ColumnToIdentityMatrix are not defined)
                DivideByUnit				:= "a/u",	## divide the element a by the unit u (needed by SimplerEquivalentMatrix in case DivideEntryByUnit is not defined)
                DegreeMultivariatePolynomial		:= "deg",	## degree of the polynomial
                
                ## important ring operations:
                ## (important for performance since existing fall-back methods cause a lot of traffic):
                IsUnit					:= "?/u",	## is u a unit? (mainly needed by the fall-back methods for matrices, see below)
                
                ## optional ring operations:
                Sum					:= "a+b",	## add two ring elements
                Product					:= "a*b",	## multiply two ring elements
                
                Gcd					:= "gcd",	## the (greatest) common divisor
                CancelGcd				:= "ccd",	## cancel the (greatest) common divisor
                
                ## create matrices:
                HomalgMatrix				:= "A:=",	## define a matrix
                CopyMatrix				:= "A>A",	## copy a matrix
                LoadHomalgMatrixFromFile 		:= "A<<",	## load a matrix from file
                SaveHomalgMatrixToFile			:= "A>>",	## save a matrix to file
                GetEntryOfHomalgMatrix			:= "<ij",	## get a matrix entry as a string
                SetEntryOfHomalgMatrix			:= ">ij",	## set a matrix entry from a string
                AddToEntryOfHomalgMatrix		:= "+ij",	## add to a matrix entry from a string
                GetListOfHomalgMatrixAsString		:= "\"A\"",	## get a list of the matrix entries as a string
                GetListListOfHomalgMatrixAsString	:= "\"A\"",	## get a listlist of the matrix entries as a string
                GetSparseListOfHomalgMatrixAsString	:= ".A.",	## get a "sparse" list of the matrix entries as a string
                sparse					:= "spr",	## assign a "sparse" list of matrix entries to a variable
                
                ## mandatory matrix operations:
                IsZeroMatrix				:= "A=0",	## test if a matrix is the zero matrix
                                                                        ## CAUTION: the external system must be able to check
                                                                        ## if the matrix is zero modulo possible ring relations
                                                                        ## only known to the external system!
                NrRows					:= "#==",	## number of rows
                NrColumns				:= "#||",	## number of columns
                Determinant				:= "det",	## determinant of a matrix over a (commutative) ring
                
                ZeroMatrix				:= "(0)",	## create a zero matrix
                IdentityMatrix				:= "(1)",	## create an identity matrix
                
                Involution				:= "A^*",	## "transpose" a matrix (with "the" involution of the ring)
                CertainRows				:= "===",	## get certain rows of a matrix
                CertainColumns				:= "|||",	## get certain columns of a matrix
                UnionOfRows				:= "A_B",	## stack to matrices vertically
                UnionOfColumns				:= "A|B",	## glue to matrices horizontally
                DiagMat					:= "A\\B",	## create a block diagonal matrix
                KroneckerMat				:= "AoB",	## the Kronecker (tensor) product of two matrices
                MulMat					:= "a*A",	## multiply a matrix with a ring element
                AddMat					:= "A+B",	## add two matrices
                SubMat					:= "A-B",	## substract two matrices
                Compose					:= "A*B",	## multiply two matrices
                
                ## important matrix operations:
                ## (important for performance since existing fallback methods cause a lot of traffic):
                AreEqualMatrices			:= "A=B",	## test if two matrices are equal
                                                                        ## CAUTION: the external system must be able to check
                                                                        ## equality of the two matrices modulo possible ring relations
                                                                        ## only known to the external system!
                IsIdentityMatrix			:= "A=1",	## test if a matrix is the identity matrix
                IsDiagonalMatrix			:= "A=\\",	## test if a matrix is diagonal (needed by the display method)
                
                ZeroRows				:= "0==",	## get the positions of the zero rows
                ZeroColumns				:= "0||",	## get the positions of the zero columns
                GetColumnIndependentUnitPositions	:= "ciu",	## get "column-independent" unit positions (needed by ReducedBasisOfModule)
                GetRowIndependentUnitPositions		:= "riu",	## get "row-independent" unit positions (needed by ReducedBasisOfModule)
                TransposedMatrix			:= "^tr",	## transposed matrix
                GetUnitPosition				:= "gup",	## get the position of the "first" unit in the matrix (needed by SimplerEquivalentMatrix)
                DivideEntryByUnit			:= "ij/",	## divide an entry of a matrix by a unit (needed by SimplerEquivalentMatrix in case DivideRow/ColumnByUnit are not defined)
                DivideRowByUnit				:= "-/u",	## divide a row by a unit (needed by SimplerEquivalentMatrix)
                DivideColumnByUnit			:= "|/u",	## divide a column by a unit (needed by SimplerEquivalentMatrix)
                CopyRowToIdentityMatrix			:= "->-",	## divide a row by a unit (needed by SimplerEquivalentMatrix)
                CopyColumnToIdentityMatrix		:= "|>|",	## divide a column by a unit (needed by SimplerEquivalentMatrix)
                SetColumnToZero				:= "|=0",	## set a column (except a certain row) to zero (needed by SimplerEquivalentMatrix)
                GetCleanRowsPositions			:= "crp",	## get the positions of the rows with a single one (needed by SimplerEquivalentMatrix)
                ConvertRowToMatrix			:= "-%A",	## convert a single row matrix into a matrix with specified number of rows/columns (need by the display methods for homomorphisms)
                ConvertColumnToMatrix			:= "|%A",	## convert a single column matrix into a matrix with specified number of rows/columns (need by the display methods for homomorphisms)
                ConvertMatrixToRow			:= "A%-",	## convert a matrix into a single row matrix
                ConvertMatrixToColumn			:= "A%|",	## convert a matrix into a single column matrix
                
                ## basic module operations:
                ReducedEchelonForm			:= "ref",	## compute a (r)educed (e)chelon (f)orm
                BasisOfModule				:= "bas",	## compute a "(bas)is" of a given set of module elements
                ReducedBasisOfModule			:= "Bas",	## compute a reduced "(Bas)is" of a given set of module elements
                DecideZero				:= "dc0",	## (d)e(c)ide the ideal/submodule membership problem, i.e. if an element is (0) modulo the ideal/submodule
                SyzygiesGenerators			:= "syz",	## compute a generating set of (syz)ygies
                ReducedSyzygiesGenerators		:= "Syz",	## compute a generating set of reduced (Syz)ygies
                ReducedEchelonFormC			:= "REF",	## compute a (R)educed (E)chelon (F)orm together with the matrix of coefficients
                BasisCoeff				:= "BAS",	## compute a "(BAS)is" of a given set of module elements together with the matrix of coefficients
                DecideZeroEffectively			:= "DC0",	## (D)e(C)ide the ideal/submodule membership problem, i.e. write an element effectively as (0) modulo the ideal/submodule
                
                ## optional module operations:
                BestBasis				:= "(\\)",	## compute a better equivalent matrix (field -> row+col Gauss, PIR -> Smith, Dedekind domain -> Krull, etc ...)
                ElementaryDivisors			:= "div",	## compute elementary divisors
                
                ## for the eye:
                Display					:= "dsp",	## display whatever you want ;)
                homalgLaTeX				:= "TeX",	## the LaTeX code of the mathematical entity
                
              )
           )
);

####################################
#
# global functions and operations:
#
####################################

##
InstallGlobalFunction( FigureOutAnAlternativeDirectoryForTemporaryFiles,
  function( arg )
    local nargs, file, list, separator, pos_sep, l, directory, filename, fs;
    
    nargs := Length( arg );
    
    if nargs = 0 then
        Error( "empty input" );
    fi;
    
    file := arg[1];
    
    if IsBound( HOMALG_IO.ListOfAlternativeDirectoryForTemporaryFiles ) then
        list := HOMALG_IO.ListOfAlternativeDirectoryForTemporaryFiles;
    else
        list := [ "/dev/shm/", "/var/tmp/", "/tmp/" ];
    fi;
    
    ## figure out the directory separtor:
    if IsBound( GAPInfo.UserHome ) then
        separator := GAPInfo.UserHome[1];
    else
        separator := '/';
    fi;
    
    if nargs > 1 then
        pos_sep := PositionProperty( Reversed( file ), c -> c = separator );
        if pos_sep <> fail then
            l := Length( file );
            file := file{[ l - pos_sep + 2 .. l ]};
        fi;
    fi;
    
    for directory in list do
        
        if directory[Length( directory )] <> separator then
            filename := Concatenation( directory, [ separator ], file );
        else
            filename := Concatenation( directory, file );
        fi;
        
        fs := IO_File( filename, "w" );
        
        if fs <> fail then
            IO_Close( fs );
            if nargs > 1 and arg[2] = "with_filename" then
                return filename;
            else
                return directory;
            fi;
        fi;
        
    od;
    
    return fail;
    
end );

##  <#GAPDoc Label="homalgIOMode">
##  <ManSection>
##    <Func Arg="str[, str2[, str3]]" Name="homalgIOMode"/>
##    <Description>
##      This function sets different modes which influence how much of the communication becomes visible.
##      Handling the string <A>str</A> is <E>not</E> case-sensitive. <C>homalgIOMode</C> invokes
##      the global function <C>homalgMode</C> defined in the &homalg; package with an <Q>appropriate</Q> argument (see code below).
##      Alternatively, if a second or more strings are given, then <C>homalgMode</C> is invoked with the remaining strings
##      <A>str2</A>, <A>str3</A>, ... at the end. In particular, you can use <C>homalgIOMode</C>( <A>str</A>, "" ) to reset the effect
##      of invoking <C>homalgMode</C>.
##      <Table Align="l|c|l">
##      <Row>
##        <Item><A>str</A></Item>
##        <Item><A>str</A> (long form)</Item>
##        <Item>mode description</Item>
##      </Row>
##      <HorLine/>
##      <Row><Item></Item><Item></Item><Item></Item></Row>
##      <Row>
##        <Item>""</Item>
##        <Item>""</Item>
##        <Item>the default mode, i.e. the communication protocol won't be visible</Item>
##      </Row>
##      <Row>
##        <Item></Item>
##        <Item></Item>
##        <Item>(<C>homalgIOMode</C>( ) is a short form for <C>homalgIOMode</C>( "" ))</Item>
##      </Row>
##      <Row><Item></Item><Item></Item><Item></Item></Row>
##      <Row>
##        <Item>"a"</Item>
##        <Item>"all"</Item>
##        <Item>combine the modes "debug" and "file"</Item>
##      </Row>
##      <Row><Item></Item><Item></Item><Item></Item></Row>
##      <Row>
##        <Item>"b"</Item>
##        <Item>"basic"</Item>
##        <Item>the same as "picto" + <C>homalgMode</C>( "basic" )</Item>
##      </Row>
##      <Row><Item></Item><Item></Item><Item></Item></Row>
##      <Row>
##        <Item>"d"</Item>
##        <Item>"debug"</Item>
##        <Item>view the complete communication protocol</Item>
##      </Row>
##      <Row><Item></Item><Item></Item><Item></Item></Row>
##      <Row>
##        <Item>"f"</Item>
##        <Item>"file"</Item>
##        <Item>dump the communication protocol into a file with the name</Item>
##      </Row>
##      <Row>
##        <Item></Item>
##        <Item></Item>
##        <Item><C>Concatenation</C>( "commands_file_of_", CAS, "_with_PID_", PID )</Item>
##      </Row>
##      <Row><Item></Item><Item></Item><Item></Item></Row>
##      <Row>
##        <Item>"p"</Item>
##        <Item>"picto"</Item>
##        <Item>view the abbreviated communication protocol</Item>
##      </Row>
##      <Row>
##        <Item></Item>
##        <Item></Item>
##        <Item>using the preassigned pictograms</Item>
##      </Row>
##      <Row><Item></Item><Item></Item><Item></Item></Row>
##      <HorLine/>
##      </Table>
##      All modes other than the "default"-mode only set their specific values and leave
##      the other values untouched, which allows combining them to some extent. This also means that
##      in order to get from one mode to a new mode (without the aim to combine them)
##      one needs to reset to the "default"-mode first. <Br/><Br/>
##      <E>Caution</E>:
##      <List>
##        <Item>In case you choose one of the modes "file" or "all" you might want to set
##          the global variable <C>HOMALG_IO.DoNotDeleteTemporaryFiles</C> := <C>true</C>;
##          this is only important if during the computations some matrices get converted via files
##          (using <C>ConvertHomalgMatrixViaFile</C>), as reading these files will be part of the protocol!</Item>
##        <Item>It makes sense for the dumped communication protocol to be (re)executed with the respective external system,
##          only in case the latter is deterministic (i.e. same-input-same-output).</Item>
##      </List>
##      <Listing Type="Code"><![CDATA[
InstallGlobalFunction( homalgIOMode,
  function( arg )
    local nargs, mode, s;
    
    nargs := Length( arg );
    
    if nargs = 0 or ( IsString( arg[1] ) and arg[1] = "" ) then
        mode := "default";
    elif IsString( arg[1] ) then	## now we know, the string is not empty
        s := arg[1];
        if LowercaseString( s{[1]} ) = "a" then
            mode := "all";
        elif LowercaseString( s{[1]} ) = "b" then
            mode := "basic";
        elif LowercaseString( s{[1]} ) = "d" then
            mode := "debug";
        elif LowercaseString( s{[1]} ) = "f" then
            mode := "file";
        elif LowercaseString( s{[1]} ) = "p" then
            mode := "picto";
        else
            mode := "";
        fi;
    else
        Error( "the first argument must be a string\n" );
    fi;
    
    if mode = "default" then
        ## reset to the default values
        HOMALG_IO.color_display := false;
        HOMALG_IO.show_banners := true;
        HOMALG_IO.save_CAS_commands_to_file := false;
        HOMALG_IO.DoNotDeleteTemporaryFiles := false;
        HOMALG_IO.SaveHomalgMaximumBackStream := false;
        HOMALG_IO.InformAboutCASystemsWithoutActiveRings := true;
        SetInfoLevel( InfoHomalgToCAS, 1 );
	homalgMode( );
    elif mode = "all" then
        homalgIOMode( "debug" );
        homalgIOMode( "file" );
    elif mode = "basic" then
        HOMALG_IO.color_display := true;
        HOMALG_IO.show_banners := true;
        SetInfoLevel( InfoHomalgToCAS, 4 );
        homalgMode( "basic" );	## use homalgIOMode( "basic", "" ) to reset
    elif mode = "debug" then
        HOMALG_IO.color_display := true;
        HOMALG_IO.show_banners := true;
        SetInfoLevel( InfoHomalgToCAS, 8 );
        homalgMode( "debug" );	## use homalgIOMode( "debug", "" ) to reset
    elif mode = "file" then
        HOMALG_IO.save_CAS_commands_to_file := true;
    elif mode = "picto" then
        HOMALG_IO.color_display := true;
        HOMALG_IO.show_banners := true;
        SetInfoLevel( InfoHomalgToCAS, 4 );
	homalgMode( "logic" );	## use homalgIOMode( "picto", "" ) to reset
    fi;
    
    if nargs > 1 and IsString( arg[2] ) then
        CallFuncList( homalgMode, arg{[ 2 .. nargs ]} );
    fi;
    
end );
##  ]]></Listing>
##    </Description>
##    <#Include Label="homalgSendBlocking:view_communication">
##  </ManSection>
##  <#/GAPDoc>
