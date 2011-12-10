/***************************************************************************
**
**  polymake_main.cpp       Sebastian Gutsche       A file to provide Polymake
**                                                  to GAP.
**
*/

#include "loadgap.h"

static const char * Revision_polymake_main_c =
   "polymake_main.cpp, V0.1";

# define MORE_TESTS 1


// This is the include of the polymake headers,
// make shure that you have installed polymake properly

#include <polymake/Main.h>
#include <polymake/Matrix.h>
#include <polymake/Rational.h>

#include <iostream>
#include <map>
#include <utility>

#include "polymake_fktn.h"
#include "polymake_polytopes.h"
#include "polymake_cone.h"

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

// static polymake::Main *main_polymake_session;
// static polymake::perl::Scope *main_polymake_scope;
// static map<int, pm::perl::Object*> *polymake_objects;
// static int new_polymake_object_number;

// struct Polymake_Data{
//   polymake::Main *main_polymake_session;
//   polymake::perl::Scope *main_polymake_scope;
//   map<int, pm::perl::Object*> *polymake_objects;
//   int new_polymake_object_number;
// };

static Polymake_Data akt_data;



/* GAP stuff */ /* but of the old kind
#ifdef __GNUC__
#if (__GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 1))
void __stack_chk_fail_local (void)
{
  __stack_chk_fail ();
}
#endif
#endif
*/


Obj FuncPOLYMAKE_CREATE_CONE_BY_RAYS( Obj self, Obj rays ) {

  return REAL_CREATE_CONE_BY_RAYS( &akt_data,rays);

}



Obj FuncPOLYMAKE_CREATE_DUAL_CONE_OF_CONE( Obj self, Obj cone ) {

  return REAL_CREATE_DUAL_CONE_OF_CONE( &akt_data, cone );

}


Obj FuncPOLYMAKE_IS_SIMPLICIAL_OBJECT( Obj self, Obj cone ){

  //return REAL_IS_SIMPLICIAL_OBJECT( &akt_data, cone );
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, cone, "SIMPLICIAL" );

}



Obj FuncPOLYMAKE_IS_LATTICE_OBJECT( Obj self, Obj cone ) {

  //return REAL_IS_LATTICE_OBJECT( &akt_data, cone );
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, cone, "LATTICE" );

}


Obj FuncPOLYMAKE_IS_NORMAL_OBJECT( Obj self, Obj cone ) {

  //return REAL_IS_NORMAL_OBJECT( &akt_data, cone );
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, cone, "NORMAL" );

}


Obj FuncPOLYMAKE_IS_VERYAMPLE_OBJECT( Obj self, Obj cone ) {

  //return REAL_IS_VERYAMPLE_OBJECT( &akt_data, cone );
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, cone, "VERY_AMPLE" );

}


Obj FuncPOLYMAKE_IS_SMOOTH_OBJECT( Obj self, Obj cone ) {

  //return REAL_IS_SMOOTH_OBJECT( &akt_data, cone );
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, cone, "SMOOTH" );

}



Obj FuncPOLYMAKE_IS_STRICTLY_CONVEX_CONE( Obj self, Obj cone){

  //return REAL_IS_STRICTLY_CONVEX_CONE( &akt_data, cone );
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, cone, "POINTED" );

}



Obj FuncPOLYMAKE_GENERATING_RAYS_OF_CONE( Obj self, Obj cone){

  return REAL_GENERATING_RAYS_OF_CONE( &akt_data, cone );

}

Obj FuncPOLYMAKE_CREATE_POLYTOPE_BY_POINTS( Obj self, Obj polytope ){
  
  return REAL_CREATE_POLYTOPE_BY_POINTS( &akt_data, polytope );
  
}

Obj FuncPOLYMAKE_VERTICES_OF_POLYTOPE( Obj self, Obj polytope){
  
  return REAL_VERTICES_OF_POLYTOPE( &akt_data, polytope);
  
}

Obj FuncPOLYMAKE_CREATE_POLYTOPE_BY_INEQUALITIES( Obj self, Obj polytope ){
  
  return REAL_CREATE_POLYTOPE_BY_INEQUALITIES( &akt_data, polytope );
  
}






/******************************************************************************
*V  GVarFuncs . . . . . . . . . . . . . . . . . . list of functions to export
*/
static StructGVarFunc GVarFuncs [] = {

    { "POLYMAKE_CREATE_CONE_BY_RAYS", 1, "rays",
    (Obj(*)())FuncPOLYMAKE_CREATE_CONE_BY_RAYS,
    "polymake_main.cpp:POLYMAKE_CREATE_CONE_BY_RAYS" },
    
    { "POLYMAKE_CREATE_DUAL_CONE_OF_CONE", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_CREATE_DUAL_CONE_OF_CONE,
    "polymake_main.cpp:POLYMAKE_CREATE_DUAL_CONE_OF_CONE" },
     
    { "POLYMAKE_IS_SIMPLICIAL_OBJECT", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_IS_SIMPLICIAL_OBJECT,
    "polymake_main.cpp:POLYMAKE_IS_SIMPLICIAL_OBJECT" },
    
    { "POLYMAKE_IS_LATTICE_OBJECT", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_IS_LATTICE_OBJECT,
    "polymake_main.cpp:POLYMAKE_IS_LATTICE_OBJECT" },
    
    { "POLYMAKE_IS_NORMAL_OBJECT", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_IS_NORMAL_OBJECT,
    "polymake_main.cpp:POLYMAKE_IS_NORMAL_OBJECT" },
    
    { "POLYMAKE_IS_VERYAMPLE_OBJECT", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_IS_VERYAMPLE_OBJECT,
    "polymake_main.cpp:POLYMAKE_IS_VERYAMPLE_OBJECT" },
    
    { "POLYMAKE_IS_SMOOTH_OBJECT", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_IS_SMOOTH_OBJECT,
    "polymake_main.cpp:POLYMAKE_IS_SMOOTH_OBJECT" },
    
    { "POLYMAKE_IS_STRICTLY_CONVEX_CONE", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_IS_STRICTLY_CONVEX_CONE,
    "polymake_main.cpp:POLYMAKE_IS_STRICTLY_CONVEX_CONE" },
    
    { "POLYMAKE_GENERATING_RAYS_OF_CONE", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_GENERATING_RAYS_OF_CONE,
    "polymake_main.cpp:POLYMAKE_GENERATING_RAYS_OF_CONE" },
    
    { "POLYMAKE_CREATE_POLYTOPE_BY_POINTS", 1, "polytope",
    (Obj(*)())FuncPOLYMAKE_CREATE_POLYTOPE_BY_POINTS,
    "polymake_main.cpp:POLYMAKE_CREATE_POLYTOPE_BY_POINTS" },
    
    { "POLYMAKE_VERTICES_OF_POLYTOPE", 1, "polytope",
    (Obj(*)())FuncPOLYMAKE_VERTICES_OF_POLYTOPE,
    "polymake_main.cpp:POLYMAKE_VERTICES_OF_POLYTOPE" },
    
    { "POLYMAKE_CREATE_POLYTOPE_BY_INEQUALITIES", 1, "polytope",
    (Obj(*)())FuncPOLYMAKE_CREATE_POLYTOPE_BY_INEQUALITIES,
    "polymake_main.cpp:POLYMAKE_CREATE_POLYTOPE_BY_INEQUALITIES" },
  { 0 }

};

/******************************************************************************
*F  InitKernel( <module> )  . . . . . . . . initialise kernel data structures
*/
static Int InitKernel ( StructInitInfo *module )
{
    /* init filters and functions                                          */
    InitHdlrFuncsFromTable( GVarFuncs );

    /* return success                                                      */
    return 0;
}

/******************************************************************************
*F  InitLibrary( <module> ) . . . . . . .  initialise library data structures
*/
static Int InitLibrary ( StructInitInfo *module )
{
    Int i, gvar;
    
    // We start with initialising the polymake classes.
    akt_data.main_polymake_session = new polymake::Main;
    akt_data.main_polymake_scope = new polymake::perl::Scope(akt_data.main_polymake_session->newScope());
    //This is pretty slow.
    akt_data.polymake_objects = new map<int, pm::perl::Object*>;
    akt_data.new_polymake_object_number=0;
    // We now have everything to handle polymake, lets do the gapthings

    /* init filters and functions
       we assign the functions to components of a record "IO"         */
    for ( i = 0; GVarFuncs[i].name != 0;  i++ ) {
      gvar = GVarName(GVarFuncs[i].name);
      AssGVar(gvar,NewFunctionC( GVarFuncs[i].name, GVarFuncs[i].nargs,
                                 GVarFuncs[i].args, GVarFuncs[i].handler ));
      MakeReadOnlyGVar(gvar);
    }

    /* return success                                                      */
    return 0;
}

/******************************************************************************
*F  InitInfopl()  . . . . . . . . . . . . . . . . . table of init functions
*/
static StructInitInfo module = {
 /* type        = */ MODULE_DYNAMIC,
 /* name        = */ "polymake_main",
 /* revision_c  = */ 0,
 /* revision_h  = */ 0,
 /* version     = */ 0,
 /* crc         = */ 0,
 /* initKernel  = */ InitKernel,
 /* initLibrary = */ InitLibrary,
 /* checkInit   = */ 0,
 /* preSave     = */ 0,
 /* postSave    = */ 0,
 /* postRestore = */ 0
};

extern "C" {

StructInitInfo * Init__Dynamic ( void )
{
  module.revision_c = Revision_polymake_main_c;
  return &module;
}

}


/*
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; version 2 of the License.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 */
