#############################################################################
##
#W    read.g                 The polymake interface package  Sebastian Gutsche
#W                                                                
##

#############################################################################
##
#R  Read the install files.
##
#ReadPackage( "example", "gap/files.gi" );

# load kernel function if it is installed:
if (not IsBound(POLYMAKE_CREATE_CONE_BY_RAYS)) and
   (Filename(DirectoriesPackagePrograms("PolymakeInterface"), "polymake_main.so") <> fail) then
  LoadDynamicModule(Filename(DirectoriesPackagePrograms("PolymakeInterface"), "polymake_main.so"));
fi;

if (not IsBound(POLYMAKE_CREATE_CONE_BY_RAYS)) then
    Error( "Failed to load compiled dynamic module.\n" );
fi;

#E  read.g . . . . . . . . . . . . . . . . . . . . . . . . . . . .  ends here

ReadPackage( "PolymakeInterface", "gap/types.gi" );

ReadPackage( "PolymakeInterface", "gap/additional_methods.gi" );
