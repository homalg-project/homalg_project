#@exec LoadPackage( "RingsForHomalg", false );
#@exec LoadPackage( "IO_ForHomalg", false );

gap> HOMALG_IO.show_banners := false;;
gap> HOMALG_IO.suppress_PID := true;;
gap> ReadPackage( "RingsForHomalg", "examples/homalg.g" );;
gap> LoadPackage( "HomalgToCAS", false );
true
gap> b := true;;
gap> nr := NumberRows( imat );
5
gap> nc := NumberColumns( imat );
4

##
## GAP -> GAP (Gauss Q)
##
gap> S := HomalgFieldOfRationals( );
Q
gap> ReadPackage( "RingsForHomalg", "examples/convert_test.g" );;
S := Q
<An internal ring>

ConvertHomalgMatrixViaListListString:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

ConvertHomalgMatrixViaListString:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

ConvertHomalgMatrixViaSparseString:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

ConvertHomalgMatrixViaFile:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

##
## GAP -> GAP (Gauss GF(32003))
##
gap> S := HomalgRingOfIntegers( 32003 );
GF(32003)
gap> ReadPackage( "RingsForHomalg", "examples/convert_test.g" );;
S := GF(32003)
<An internal ring>

ConvertHomalgMatrixViaListListString:

   262    33    75    40
   682    86   196   104
  1186   151   341   180
  1932   248   556   292
  1018   127   293   156

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

ConvertHomalgMatrixViaListString:

   262    33    75    40
   682    86   196   104
  1186   151   341   180
  1932   248   556   292
  1018   127   293   156

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

ConvertHomalgMatrixViaSparseString:

   262    33    75    40
   682    86   196   104
  1186   151   341   180
  1932   248   556   292
  1018   127   293   156

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

ConvertHomalgMatrixViaFile:

   262    33    75    40
   682    86   196   104
  1186   151   341   180
  1932   248   556   292
  1018   127   293   156

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

##
## GAP -> GAP (Gauss Z/2^15)
##
gap> S := HomalgRingOfIntegers( 2^15 );
Z/32768Z
gap> ReadPackage( "RingsForHomalg", "examples/convert_test.g" );;
S := Z/32768Z
<An internal ring>

ConvertHomalgMatrixViaListListString:

   262    33    75    40
   682    86   196   104
  1186   151   341   180
  1932   248   556   292
  1018   127   293   156

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

ConvertHomalgMatrixViaListString:

   262    33    75    40
   682    86   196   104
  1186   151   341   180
  1932   248   556   292
  1018   127   293   156

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

ConvertHomalgMatrixViaSparseString:

   262    33    75    40
   682    86   196   104
  1186   151   341   180
  1932   248   556   292
  1018   127   293   156

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

ConvertHomalgMatrixViaFile:

   262    33    75    40
   682    86   196   104
  1186   151   341   180
  1932   248   556   292
  1018   127   293   156

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

##
## GAP -> GAP
##
gap> S := HomalgRingOfIntegers( ) / 32003;
Z/( 32003 )
gap> ReadPackage( "RingsForHomalg", "examples/convert_test.g" );;
S := Z/( 32003 )
<A residue class ring>

ConvertHomalgMatrixViaListListString:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

modulo [ 32003 ]

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

ConvertHomalgMatrixViaListString:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

modulo [ 32003 ]

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

ConvertHomalgMatrixViaSparseString:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

modulo [ 32003 ]

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

ConvertHomalgMatrixViaFile:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

modulo [ 32003 ]

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]
gap> LoadPackage( "RingsForHomalg", false );
true
gap> LoadPackage( "IO_ForHomalg", false );
true

##
## GAP <-> External GAP
##
gap> S := HomalgRingOfIntegersInExternalGAP( );
Z
gap> ReadPackage( "RingsForHomalg", "examples/convert_test.g" );;
S := Z
<An external ring residing in the CAS GAP>

ConvertHomalgMatrixViaListListString:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

ConvertHomalgMatrixViaListString:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

ConvertHomalgMatrixViaSparseString:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

ConvertHomalgMatrixViaFile:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

##
## GAP <-> Maple
##
#@if IsBound( TryLaunchCAS_IO_ForHomalg( HOMALG_IO_Maple ).stdout )
gap> S := HomalgRingOfIntegersInMaple( );
Z
gap> ReadPackage( "RingsForHomalg", "examples/convert_test.g" );;
S := Z
<An external ring residing in the CAS Maple>

ConvertHomalgMatrixViaListListString:


                          [ 262     33     75     40]
                          [                         ]
                          [ 682     86    196    104]
                          [                         ]
                          [1186    151    341    180]
                          [                         ]
                          [1932    248    556    292]
                          [                         ]
                          [1018    127    293    156]


and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

ConvertHomalgMatrixViaListString:


                          [ 262     33     75     40]
                          [                         ]
                          [ 682     86    196    104]
                          [                         ]
                          [1186    151    341    180]
                          [                         ]
                          [1932    248    556    292]
                          [                         ]
                          [1018    127    293    156]


and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

ConvertHomalgMatrixViaSparseString:


                          [ 262     33     75     40]
                          [                         ]
                          [ 682     86    196    104]
                          [                         ]
                          [1186    151    341    180]
                          [                         ]
                          [1932    248    556    292]
                          [                         ]
                          [1018    127    293    156]


and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

ConvertHomalgMatrixViaFile:


                          [ 262     33     75     40]
                          [                         ]
                          [ 682     86    196    104]
                          [                         ]
                          [1186    151    341    180]
                          [                         ]
                          [1932    248    556    292]
                          [                         ]
                          [1018    127    293    156]



and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]
#@fi

##
## GAP <-> Sage, Sage 9.0: the interface is broken
##
#@if IsBound( TryLaunchCAS_IO_ForHomalg( HOMALG_IO_Sage ).stdout )
gap> #S := HomalgRingOfIntegersInSage( );
gap> #ReadPackage( "RingsForHomalg", "examples/convert_test.g" );;
#@fi

##
## GAP <-> MAGMA
##
#@if IsBound( TryLaunchCAS_IO_ForHomalg( HOMALG_IO_MAGMA ).stdout )
gap> S := HomalgRingOfIntegersInMAGMA( );
Z
gap> ReadPackage( "RingsForHomalg", "examples/convert_test.g" );;
S := Z
<An external ring residing in the CAS MAGMA>

ConvertHomalgMatrixViaListListString:

[ 262   33   75   40]
[ 682   86  196  104]
[1186  151  341  180]
[1932  248  556  292]
[1018  127  293  156]

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

ConvertHomalgMatrixViaListString:

[ 262   33   75   40]
[ 682   86  196  104]
[1186  151  341  180]
[1932  248  556  292]
[1018  127  293  156]

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

ConvertHomalgMatrixViaSparseString:

[ 262   33   75   40]
[ 682   86  196  104]
[1186  151  341  180]
[1932  248  556  292]
[1018  127  293  156]

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

ConvertHomalgMatrixViaFile:

[ 262   33   75   40]
[ 682   86  196  104]
[1186  151  341  180]
[1932  248  556  292]
[1018  127  293  156]

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]
#@fi

##
## GAP <-> Singular
##
#@if IsBound( TryLaunchCAS_IO_ForHomalg( HOMALG_IO_Singular ).stdout )
gap> S := HomalgFieldOfRationalsInSingular( );
Q
gap> ReadPackage( "RingsForHomalg", "examples/convert_test.g" );;
S := Q
<An external ring residing in the CAS Singular>

ConvertHomalgMatrixViaListListString:

262, 33, 75, 40, 
682, 86, 196,104,
1186,151,341,180,
1932,248,556,292,
1018,127,293,156 

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

ConvertHomalgMatrixViaListString:

262, 33, 75, 40, 
682, 86, 196,104,
1186,151,341,180,
1932,248,556,292,
1018,127,293,156 

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

ConvertHomalgMatrixViaSparseString:

262, 33, 75, 40, 
682, 86, 196,104,
1186,151,341,180,
1932,248,556,292,
1018,127,293,156 

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

ConvertHomalgMatrixViaFile:

262, 33, 75, 40, 
682, 86, 196,104,
1186,151,341,180,
1932,248,556,292,
1018,127,293,156 

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]
#@fi

##
## GAP <-> Macaulay2
##
#@if IsBound( TryLaunchCAS_IO_ForHomalg( HOMALG_IO_Macaulay2 ).stdout )
gap> S := HomalgFieldOfRationalsInMacaulay2( );
Q
gap> ReadPackage( "RingsForHomalg", "examples/convert_test.g" );;
S := Q
<An external ring residing in the CAS Macaulay2>

ConvertHomalgMatrixViaListListString:

        | 262  33  75  40  |
      | 682  86  196 104 |
      | 1186 151 341 180 |
      | 1932 248 556 292 |
      | 1018 127 293 156 |

               5        4
o64 : Matrix QQ  <--- QQ

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

ConvertHomalgMatrixViaListString:

        | 262  33  75  40  |
       | 682  86  196 104 |
       | 1186 151 341 180 |
       | 1932 248 556 292 |
       | 1018 127 293 156 |

                5        4
o108 : Matrix QQ  <--- QQ

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

ConvertHomalgMatrixViaSparseString:

        | 262  33  75  40  |
       | 682  86  196 104 |
       | 1186 151 341 180 |
       | 1932 248 556 292 |
       | 1018 127 293 156 |

                5        4
o192 : Matrix QQ  <--- QQ

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]

ConvertHomalgMatrixViaFile:

        | 262  33  75  40  |
       | 682  86  196 104 |
       | 1186 151 341 180 |
       | 1932 248 556 292 |
       | 1018 127 293 156 |

                5        4
o316 : Matrix QQ  <--- QQ

and back:

[ [   262,    33,    75,    40 ],
  [   682,    86,   196,   104 ],
  [  1186,   151,   341,   180 ],
  [  1932,   248,   556,   292 ],
  [  1018,   127,   293,   156 ] ]
#@fi

##
## result:
##
gap> b;
true
