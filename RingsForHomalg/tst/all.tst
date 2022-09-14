#@exec LoadPackage( "RingsForHomalg", false );
#@exec LoadPackage( "IO_ForHomalg", false );

gap> HOMALG_IO.show_banners := false;;
gap> HOMALG_IO.suppress_PID := true;;
gap> ReadPackage( "RingsForHomalg", "examples/homalg.g" );;
gap> ReadPackage( "RingsForHomalg", "examples/singular_C_vs_c.g" );;
If this test does not finish, Singular uses a bad ordering...
gap> ReadPackage( "RingsForHomalg", "examples/Coefficients.g" );;

## gap_ZZ.g
gap> ReadPackage( "RingsForHomalg", "examples/gap_ZZ.g" );;
<An external ring residing in the CAS GAP>
gap> ByASmallerPresentation( W );
<A non-torsion left module presented by 2 relations for 3 generators>
gap> B := BasisOfModule( W );
<A set of 2 relations for 3 generators of a homalg left module>
gap> Display( B );
[ [   2,   0,   0 ],
  [   0,  12,   0 ] ]

2 relations for 3 generators given by the rows of the above matrix
gap> Display( W );
Z/< 2 > + Z/< 12 > + Z^(1 x 1)

## magma_ZZ.g
#@if IsBound( TryLaunchCAS_IO_ForHomalg( HOMALG_IO_MAGMA ).stdout )
gap> ReadPackage( "RingsForHomalg", "examples/magma_ZZ.g" );;
<An external ring residing in the CAS MAGMA>
gap> ByASmallerPresentation( W );
<A rank 1 left module presented by 2 relations for 3 generators>
gap> B := BasisOfModule( W );
<A set of 2 relations for 3 generators of a homalg left module>
gap> Display( B );
[ 2  0  0]
[ 0 12  0]

2 relations for 3 generators given by the rows of the above matrix
gap> Display( W );
Z/< 2 > + Z/< 12 > + Z^(1 x 1)
#@fi

## maple_ZZ.g
#@if IsBound( TryLaunchCAS_IO_ForHomalg( HOMALG_IO_Maple ).stdout )
gap> ReadPackage( "RingsForHomalg", "examples/maple_ZZ.g" );;
<An external ring residing in the CAS Maple>
gap> ByASmallerPresentation( W );
<A non-torsion left module presented by 2 relations for 3 generators>
gap> B := BasisOfModule( W );
<A set of 2 relations for 3 generators of a homalg left module>
gap> Display( B );
                                 [2     0    0]
                                 [            ]
                                 [0    12    0]



2 relations for 3 generators given by the rows of the above matrix
gap> Display( W );
Z/< 2 > + Z/< 12 > + Z^(1 x 1)
#@fi

## sage_ZZ.g, Sage 9.0: the interface is broken
#@if IsBound( TryLaunchCAS_IO_ForHomalg( HOMALG_IO_Sage ).stdout )
gap> #ReadPackage( "RingsForHomalg", "examples/sage_ZZ.g" );;
gap> #ByASmallerPresentation( W );
gap> #B := BasisOfModule( W );
gap> #Display( B );
gap> #Display( W );
#@fi

## magma_Qx.g
#@if IsBound( TryLaunchCAS_IO_ForHomalg( HOMALG_IO_MAGMA ).stdout )
gap> ReadPackage( "RingsForHomalg", "examples/magma_Qx.g" );;
<An external ring residing in the CAS MAGMA>
gap> ByASmallerPresentation( W );
<A rank 1 left module presented by 2 relations for 3 generators>
gap> B := BasisOfModule( W );
<A set of 2 relations for 3 generators of a homalg left module>
gap> Display( B );
[              x               0               0]
[              0 x^3 - 2*x^2 + x               0]

2 relations for 3 generators given by the rows of the above matrix
gap> Display( W );
Q[x]/< x > + Q[x]/< x^3-2*x^2+x > + Q[x]^(1 x 1)
#@fi

## maple_Qx.g
#@if IsBound( TryLaunchCAS_IO_ForHomalg( HOMALG_IO_Maple ).stdout )
gap> ReadPackage( "RingsForHomalg", "examples/maple_Qx.g" );;
<An external ring residing in the CAS Maple>
gap> ByASmallerPresentation( W );
<A non-torsion left module presented by 2 relations for 3 generators>
gap> B := BasisOfModule( W );
<A set of 2 relations for 3 generators of a homalg left module>
gap> Display( B );
                           [x          0          0]
                           [                       ]
                           [      3      2         ]
                           [0    x  - 2 x  + x    0]



2 relations for 3 generators given by the rows of the above matrix
gap> Display( W );
Q[x]/< x > + Q[x]/< x^3-2*x^2+x > + Q[x]^(1 x 1)
#@fi

## sage_Qx.g, Sage 4.1.1: no Hermite normal form implemented yet, Sage 9.0: the interface is broken
#@if IsBound( TryLaunchCAS_IO_ForHomalg( HOMALG_IO_Sage ).stdout )
gap> #ReadPackage( "RingsForHomalg", "examples/sage_Qx.g" );;
gap> #ByASmallerPresentation( W );
gap> #B := BasisOfModule( W );
gap> #Display( B );
gap> #Display( W );
#@fi

## singular_Qx.g, Singular 3-0-4: buggy Smith normal form of non-quadratic matrices
#@if IsBound( TryLaunchCAS_IO_ForHomalg( HOMALG_IO_Singular ).stdout )
gap> #ReadPackage( "RingsForHomalg", "examples/singular_Qx.g" );;
gap> #ByASmallerPresentation( W );
gap> #B := BasisOfModule( W );
gap> #Display( B );
gap> #Display( W );
#@fi
