LoadPackage( "Sheaves" );

Q := HomalgFieldOfRationalsInDefaultCAS( );

R := Q * "a,b";

P1 := Proj( R );

d := 3;

d_uple_Embedding := function( d )
    local L, f, imP1, M, S;
    
    L := HomalgSheaf( R^d );
    
    f := InducedMorphismToProjectiveSpace( L );
    
    imP1 := ImageScheme( f );
    
    M := UnderlyingModule( imP1 );
    
    S := HomalgRing( M );
    
    KoszulDualRing( S, List( [ 0 .. Length( Indeterminates( S ) ) - 1 ], e -> Concatenation( "e", String( e ) ) ) );
    
    return imP1;
    
end;

imP1 := d_uple_Embedding( d );

Degree( imP1 );
ArithmeticGenus( imP1 );

T := TateResolution( imP1, -3, 3 );
