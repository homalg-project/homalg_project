#include "loadgap.h"
#include "polymake_data.h"

#include <polymake/Main.h>
#include <polymake/Matrix.h>
#include <polymake/Rational.h>

#include <iostream>
#include <map>
#include <utility>

using std::cerr;
using std::endl;
using std::string;
using std::map;
using std::pair;


// Next lines set some few static Variables
// to handle polymake.
// All of them will be initialized in
// the main method called by gap to
// load the package.

//static polymake::Main *main_polymake_session;
//static polymake::perl::Scope *main_polymake_scope;
//static map<int, pm::perl::Object*> *polymake_objects;
//static int new_polymake_object_number;


// Just declaring functions. Stay tuned, All Methods get the Polymake_Data
// struct as first argument.

Obj REAL_IS_SIMPLICIAL_OBJECT( Polymake_Data*, Obj );


Obj REAL_IS_LATTICE_OBJECT( Polymake_Data*, Obj );


//THIS METHOD CAN ONLY HANDLE LATTICE OBJECTS
Obj REAL_IS_NORMAL_OBJECT( Polymake_Data*, Obj );


Obj REAL_IS_SMOOTH_OBJECT( Polymake_Data*, Obj );


Obj REAL_IS_VERYAMPLE_OBJECT( Polymake_Data*, Obj );


Obj REAL_OBJECT_HAS_PROPERTY( Polymake_Data*, Obj, const char* );


Obj REAL_OBJECT_HAS_INT_PROPERTY( Polymake_Data*, Obj, const char* );


Obj REAL_POLYMAKE_DRAW( Polymake_Data*, Obj );
