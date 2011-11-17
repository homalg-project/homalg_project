#############################################################################
##
#W    read.g                 The Example package                Werner Nickel
#W                                                                Greg Gamble
##
##    @(#)$Id: read.g,v 4.5 2006/01/31 11:18:12 gap Exp $
##

#############################################################################
##
#R  Read the install files.
##
#ReadPackage( "example", "gap/files.gi" );

# load kernel function if it is installed:
if (not IsBound(POLYMAKE_CREATE_CONE_BY_RAYS)) and
   (Filename(DirectoriesPackagePrograms("PolymakeForHomalg"), "polymake_main.so") <> fail) then
  LoadDynamicModule(Filename(DirectoriesPackagePrograms("PolymakeForHomalg"), "polymake_main.so"));
fi;

if (not IsBound(POLYMAKE_CREATE_CONE_BY_RAYS)) then
    Error( "Could not load PolymakeForHomalg plugin.\n" );
fi;

#E  read.g . . . . . . . . . . . . . . . . . . . . . . . . . . . .  ends here

