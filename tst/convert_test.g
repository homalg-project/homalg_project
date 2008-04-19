## via listlist
tmat := HomalgMatrix( imat, R );
smat := HomalgMatrix( tmat, S );
if IsHomalgInternalRingRep( S ) then
    b := b and ( Eval( tmat ) = Eval( smat ) );
else
    kmat := HomalgMatrix( smat, R );
    Print( "\n" );
    Display( kmat );
    b := b and ( Eval( tmat ) = Eval( kmat ) );
fi;
Print( "\n" );
Display( smat );
## via list
tmat := HomalgMatrix( imat, R );
smat := HomalgMatrix( tmat, nr, nc, S );
if IsHomalgInternalRingRep( S ) then
    b := b and ( Eval( tmat ) = Eval( smat ) );
else
    kmat := HomalgMatrix( smat, nr, nc, R );
    Print( "\n" );
    Display( kmat );
    b := b and ( Eval( tmat ) = Eval( kmat ) );
fi;
Print( "\n" );
Display( smat );
## via sparse (listlist)
tmat := HomalgMatrix( imat, R );
SetExtractHomalgMatrixAsSparse( tmat, true );
smat := HomalgMatrix( tmat, S );
if IsHomalgInternalRingRep( S ) then
    b := b and ( Eval( tmat ) = Eval( smat ) );
else
    SetExtractHomalgMatrixAsSparse( smat, true );
    kmat := HomalgMatrix( smat, R );
    Print( "\n" );
    Display( kmat );
    b := b and ( Eval( tmat ) = Eval( kmat ) );
fi;
Print( "\n" );
Display( smat );
## via sparse (list)
tmat := HomalgMatrix( imat, R );
SetExtractHomalgMatrixAsSparse( tmat, true );
smat := HomalgMatrix( tmat, nr, nc, S );
if IsHomalgInternalRingRep( S ) then
    b := b and ( Eval( tmat ) = Eval( smat ) );
else
    SetExtractHomalgMatrixAsSparse( smat, true );
    kmat := HomalgMatrix( smat, nr, nc, R );
    Print( "\n" );
    Display( kmat );
    b := b and ( Eval( tmat ) = Eval( kmat ) );
fi;
Print( "\n" );
Display( smat );
## via file
tmat := HomalgMatrix( imat, R );
SetExtractHomalgMatrixToFile( tmat, true );
smat := HomalgMatrix( tmat, S );
if IsHomalgInternalRingRep( S ) then
    b := b and ( Eval( tmat ) = Eval( smat ) );
else
    SetExtractHomalgMatrixToFile( smat, true );
    kmat := HomalgMatrix( smat, R );
    Print( "\n" );
    Display( kmat );
    b := b and ( Eval( tmat ) = Eval( kmat ) );
fi;
Print( "\n" );
Display( smat );
