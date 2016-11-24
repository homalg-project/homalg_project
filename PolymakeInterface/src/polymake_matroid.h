// The usual Header.
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

Obj REAL_CREATE_MATROID_BY_MATRIX( Polymake_Data*, Obj );

Obj REAL_IS_ISOMORPHIC_MATROID( Polymake_Data*, Obj, Obj );

Obj REAL_CREATE_MATROID_ABSTRACT( Polymake_Data*, Obj, Obj );
