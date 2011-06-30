#############################################################################
##
##  GaussForHomalg.gi          GaussForHomalg package        Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Matrix operations
##
#############################################################################

####################################
#
# constructor functions and methods:
#
####################################

##  <#GAPDoc Label="GetEntryOfHomalgMatrix">
##  <ManSection>
##  <Meth Arg="M, r, c, R" Name="GetEntryOfHomalgMatrix"/>
##  <Returns><A>M</A>[<A>r</A>,<A>c</A>]</Returns>
##  <Description>
##  If the Eval attribute of the homalg matrix <A>M</A> over the &homalg;
##  ring <A>R</A> is sparse, this calls the corresponding &Gauss;
##  command <C>GetEntry</C>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( GetEntryOfHomalgMatrix,
        [ IsHomalgInternalMatrixRep, IsInt, IsInt, IsHomalgInternalRingRep ],
  function( M, i, j, R )
    local m;
    m := Eval( M );
    if IsSparseMatrix( m ) then
        return GetEntry( m, i, j ); #calls GetEntry for sparse matrices
    fi;
    TryNextMethod();
  end
);
  
##  <#GAPDoc Label="SetEntryOfHomalgMatrix">
##  <ManSection>
##  <Meth Arg="M, r, c, e, R" Name="SetEntryOfHomalgMatrix"/>
##  <Returns>nothing</Returns>
##  <Description>
##  If the Eval attribute of the homalg matrix <A>M</A> over the &homalg;
##  ring <A>R</A> is sparse, this calls the corresponding &Gauss;
##  command <C>GetEntry</C>, to achieve <C><A>M</A>[<A>r</A>,<A>c</A>]:=<A>e</A></C>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( SetEntryOfHomalgMatrix,
        [ IsHomalgInternalMatrixRep and IsMutable, IsInt, IsInt, IsRingElement, IsHomalgInternalRingRep ],
  function( M, i, j, e, R )
    local m;
    m := Eval( M );
    if IsSparseMatrix( m ) then
        SetEntry( m, i, j, e ); #calls SetEntry for sparse matrices
    else
        TryNextMethod();
    fi;
  end
);

##  <#GAPDoc Label="AddToEntryOfHomalgMatrix">
##  <ManSection>
##  <Meth Arg="M, r, c, e, R" Name="AddToEntryOfHomalgMatrix"/>
##  <Returns>nothing</Returns>
##  <Description>
##  If the Eval attribute of the homalg matrix <A>M</A> over the &homalg;
##  ring <A>R</A> is sparse, this calls the corresponding &Gauss;
##  command <C>AddToEntry</C>, to achieve <C><A>M</A>[<A>r</A>,<A>c</A>] 
##  := <A>M</A>[<A>r</A>,<A>c</A>] + <A>e</A></C>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( AddToEntryOfHomalgMatrix,
        [ IsHomalgInternalMatrixRep and IsMutable, IsInt, IsInt, IsRingElement, IsHomalgInternalRingRep ],
  function( M, i, j, e, R )
    local m;
    m := Eval( M );
    if IsSparseMatrix( m ) then
        AddToEntry( m, i, j, e ); #calls AddToEntry for sparse matrices
    else
        TryNextMethod();
    fi;
  end
);

##
InstallMethod( GetListOfHomalgMatrixAsString,
        "for sparse matrices",
        [ IsHomalgInternalMatrixRep, IsHomalgInternalRingRep ],
        
  function( M, R )
    local m, r;
    
    m := Eval( M );
    
    if IsSparseMatrix( m ) then
        r := HomalgRing( R );
        m := ConvertSparseMatrixToMatrix( m );
        if Characteristic( m ) > 0 then
            return String( Concatenation( List( m, r -> List( r, Int ) ) ) );
        fi;
        return String( Concatenation( m ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( GetListListOfHomalgMatrixAsString,
        "for sparse matrices",
        [ IsHomalgInternalMatrixRep, IsHomalgInternalRingRep ],
        
  function( M, R )
    local m, r;
    
    m := Eval( M );
    
    if IsSparseMatrix( m ) then
        r := HomalgRing( R );
        m := ConvertSparseMatrixToMatrix( m );
        if Characteristic( m ) > 0 then
            return String( List( m, r -> List( r, Int ) ) );
        fi;
        return String( m );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( GetSparseListOfHomalgMatrixAsString,
        "for sparse matrices",
        [ IsHomalgInternalMatrixRep, IsHomalgInternalRingRep ],
        
  function( M, R )
    local m, r, s, c, i, j, e;
    
    m := Eval( M );
    
    if IsSparseMatrix( m ) then
        r := HomalgRing( R );
	s := [ ];
        m := ConvertSparseMatrixToMatrix( m );
        if Characteristic( m ) > 0 then
            m := List( m, r -> List( r, Int ) );
        fi;
        c := Length( m[1] );
        for i in [ 1 .. Length( m ) ] do
            for j in [ 1 .. c ] do
                e := m[i][j];
                if not IsZero( e ) then
                    Add( s, [ String( i ), String( j ), String( e ) ] );
                fi;
            od;
        od;
        s := JoinStringsWithSeparator( List( s, JoinStringsWithSeparator ), "],[" );
        
        return Concatenation( "[[", s, "]]" );
    fi;
    
    TryNextMethod( );
    
end );

