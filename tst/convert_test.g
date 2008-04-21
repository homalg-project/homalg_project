## via listlist
tmat := HomalgMatrix( imat, R );
smat := HomalgMatrix( tmat, S );
Print( "\n" );
Display( smat );
if IsHomalgInternalRingRep( S ) then
    b := b and ( Eval( tmat ) = Eval( smat ) );
else
    kmat := HomalgMatrix( smat, R );
    Print( "\n" );
    Display( kmat );
    b := b and ( Eval( tmat ) = Eval( kmat ) );
fi;

## via list
tmat := HomalgMatrix( imat, R );
smat := HomalgMatrix( tmat, nr, nc, S );
Print( "\n" );
Display( smat );
if IsHomalgInternalRingRep( S ) then
    b := b and ( Eval( tmat ) = Eval( smat ) );
else
    kmat := HomalgMatrix( smat, nr, nc, R );
    Print( "\n" );
    Display( kmat );
    b := b and ( Eval( tmat ) = Eval( kmat ) );
fi;

## via sparse (2 arguments call of (Convert)HomalgMatrix)
tmat := HomalgMatrix( imat, R );
SetExtractHomalgMatrixAsSparse( tmat, true );
smat := HomalgMatrix( tmat, S );
Print( "\n" );
Display( smat );
if IsHomalgInternalRingRep( S ) then
    b := b and ( Eval( tmat ) = Eval( smat ) );
else
    SetExtractHomalgMatrixAsSparse( smat, true );
    kmat := HomalgMatrix( smat, R );
    Print( "\n" );
    Display( kmat );
    b := b and ( Eval( tmat ) = Eval( kmat ) );
fi;

## via sparse (2 arguments call of (Convert)HomalgMatrix)
tmat := HomalgMatrix( imat, R );
SetExtractHomalgMatrixAsSparse( tmat, true );
smat := HomalgMatrix( tmat, nr, nc, S );
Print( "\n" );
Display( smat );
if IsHomalgInternalRingRep( S ) then
    b := b and ( Eval( tmat ) = Eval( smat ) );
else
    SetExtractHomalgMatrixAsSparse( smat, true );
    kmat := HomalgMatrix( smat, nr, nc, R );
    Print( "\n" );
    Display( kmat );
    b := b and ( Eval( tmat ) = Eval( kmat ) );
fi;

## via file
tmat := HomalgMatrix( imat, R );
SetExtractHomalgMatrixToFile( tmat, true );
smat := HomalgMatrix( tmat, S );
Print( "\n" );
Display( smat );
if IsHomalgInternalRingRep( S ) then
    b := b and ( Eval( tmat ) = Eval( smat ) );
else
    SetExtractHomalgMatrixToFile( smat, true );
    kmat := HomalgMatrix( smat, R );
    Print( "\n" );
    Display( kmat );
    b := b and ( Eval( tmat ) = Eval( kmat ) );
fi;
