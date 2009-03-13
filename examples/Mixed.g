LoadPackage( "RingsForHomalg" );

Q := HomalgFieldOfRationalsInSingular( );

rp := homalgSendBlocking( "0,(n,x,Sn,Dx),wp(1,1,10,10)", [ "ring" ], Q, HOMALG_IO.Pictograms.initialize );

homalgSendBlocking( "option(redSB)", "need_command", rp, HOMALG_IO.Pictograms.initialize );
homalgSendBlocking( "option(redTail)", "need_command", rp, HOMALG_IO.Pictograms.initialize );
homalgSendBlocking( "matrix @M[4][4]", "need_command", rp, HOMALG_IO.Pictograms.initialize );
homalgSendBlocking( "@M[1,3] = Sn", "need_command", rp, HOMALG_IO.Pictograms.initialize );
homalgSendBlocking( "@M[2,4] = 1", "need_command", rp, HOMALG_IO.Pictograms.initialize );
ext_obj := homalgSendBlocking( "nc_algebra(1,@M)", [ "def" ], TheTypeHomalgExternalRingObjectInSingular, rp, HOMALG_IO.Pictograms.CreateHomalgRing );
S := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInSingular );
_Singular_SetRing( S );

RP := homalgTable( S );

RP!.SetInvolution :=
  function( R )
    homalgSendBlocking( Concatenation(
            [ "\nproc Involution (matrix M)\n{\n" ],
            [ "  map F = ", R, ", -n, x, Sn, -Dx" ],
            [ ";\n  return( transpose( involution( M, F ) ) );\n}\n\n" ]
            ), "need_command", HOMALG_IO.Pictograms.define );
end;

## reseting the "Involution" must be after "imapall":
RP!.SetInvolution( S );

RP!.Compose :=
  function( A, B )
    
    return homalgSendBlocking( [ "transpose( transpose(", A, ") * transpose(", B, ") )" ], [ "matrix" ], HOMALG_IO.Pictograms.Compose ); # FIXME : this has to be extensively documented to be understandable!
    
end;
    
A := HomalgMatrix( "[ \
(x^2-1)*Dx^2 + 2*x*Dx - n*(1+n), \
(n+2)*Sn^2 - (2*n+3)*x*Sn + n+1 \
]", 2, 1, S );

V := LeftPresentation( A );

