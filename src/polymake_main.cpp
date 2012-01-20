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
#include "polymake_fan.h"

using std::cerr;
using std::endl;
using std::string;
using std::map;
using std::pair;


static Polymake_Data akt_data;

static Obj TheTypeExternalPolymakeCone;
static Obj TheTypeExternalPolymakeFan;
static Obj TheTypeExternalPolymakePolytope;

void POLYMAKE_FREE(void *data) {
  delete data;
}

Obj POLYMAKE_TYPEFUNC_CONE(void *data) {
  return TheTypeExternalPolymakeCone;
}

Obj POLYMAKE_TYPEFUNC_FAN(void *data) {
  return TheTypeExternalPolymakeFan;
}

Obj POLYMAKE_TYPEFUNC_POLYTOPE(void *data) {
  return TheTypeExternalPolymakePolytope;
}

Obj FuncPOLYMAKE_CREATE_CONE_BY_RAYS( Obj self, Obj rays ) {

  return REAL_CREATE_CONE_BY_RAYS( &akt_data,rays);

}


Obj FuncPOLYMAKE_CREATE_CONE_BY_INEQUALITIES( Obj self, Obj rays ) {

  return REAL_CREATE_CONE_BY_INEQUALITIES( &akt_data,rays);

}



Obj FuncPOLYMAKE_CREATE_DUAL_CONE_OF_CONE( Obj self, Obj cone ) {

  return REAL_CREATE_DUAL_CONE_OF_CONE( &akt_data, cone );

}


Obj FuncPOLYMAKE_IS_NONEMPTY_POLYTOPE( Obj self, Obj cone ){

  //return REAL_IS_SIMPLICIAL_OBJECT( &akt_data, cone );
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, cone, "FEASIBLE" );

}


Obj FuncPOLYMAKE_IS_SIMPLICIAL_OBJECT( Obj self, Obj cone ){

  //return REAL_IS_SIMPLICIAL_OBJECT( &akt_data, cone );
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, cone, "SIMPLICIAL" );

}


Obj FuncPOLYMAKE_IS_SIMPLE_OBJECT( Obj self, Obj cone ){

  //return REAL_IS_SIMPLICIAL_OBJECT( &akt_data, cone );
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, cone, "SIMPLE" );

}


Obj FuncPOLYMAKE_IS_SIMPLICIAL_CONE( Obj self, Obj cone ){

  //return REAL_IS_SIMPLICIAL_OBJECT( &akt_data, cone );
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, cone, "SIMPLICIAL_CONE" );

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


Obj FuncPOLYMAKE_IS_SMOOTH_CONE( Obj self, Obj cone){

  return REAL_OBJECT_HAS_PROPERTY( &akt_data, cone, "SMOOTH_CONE" );

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

Obj FuncPOLYMAKE_AMBIENT_DIM_OF_CONE( Obj self, Obj cone ){
  
  return REAL_OBJECT_HAS_INT_PROPERTY( &akt_data, cone, "CONE_AMBIENT_DIM" );
  
}

Obj FuncPOLYMAKE_DIM_OF_CONE( Obj self, Obj cone ){
  
  return REAL_OBJECT_HAS_INT_PROPERTY( &akt_data, cone, "CONE_DIM" );
  
}

Obj FuncPOLYMAKE_AMBIENT_DIM_OF_FAN( Obj self, Obj fan ){
  
  return REAL_OBJECT_HAS_INT_PROPERTY( &akt_data, fan, "FAN_AMBIENT_DIM" );
  
}

Obj FuncPOLYMAKE_DIM_OF_FAN( Obj self, Obj fan ){
  
  return REAL_OBJECT_HAS_INT_PROPERTY( &akt_data, fan, "FAN_DIM" );
  
}

Obj FuncPOLYMAKE_HILBERT_BASIS_OF_CONE( Obj self, Obj cone ){
  
  return REAL_HILBERT_BASIS_OF_CONE( &akt_data, cone );
  
}

Obj FuncPOLYMAKE_RAYS_IN_FACETS( Obj self, Obj cone ){
  
  return REAL_RAYS_IN_FACETS( &akt_data, cone );
  
}

Obj FuncPOLYMAKE_LATTICE_POINTS_OF_POLYTOPE( Obj self, Obj polytope ){
  
  return REAL_LATTICE_POINTS_OF_POLYTOPE( &akt_data, polytope );
  
}

Obj FuncPOLYMAKE_FAN_BY_CONES( Obj self, Obj cones ){
  
  return REAL_FAN_BY_CONES( &akt_data, cones );
  
}

Obj FuncPOLYMAKE_FAN_BY_RAYS_AND_CONES( Obj self, Obj rays, Obj cones ){
  
  return REAL_FAN_BY_RAYS_AND_CONES( &akt_data, rays, cones );
  
}

Obj FuncPOLYMAKE_RAYS_IN_MAXCONES_OF_FAN( Obj self, Obj fan){
  
  return REAL_RAYS_IN_MAXCONES_OF_FAN( &akt_data, fan );
  
}

Obj FuncPOLYMAKE_RAYS_OF_FAN( Obj self, Obj fan){
  
  return REAL_GENERATING_RAYS_OF_CONE( &akt_data, fan );
  
}

Obj FuncPOLYMAKE_IS_POINTED_FAN( Obj self, Obj fan){
  
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, fan, "POINTED" );
  
}

Obj FuncPOLYMAKE_IS_SMOOTH_FAN( Obj self, Obj fan ){
  
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, fan, "SMOOTH_FAN" );
  
}

Obj FuncPOLYMAKE_IS_COMPLETE_FAN( Obj self, Obj fan ){
  
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, fan, "COMPLETE" );
  
}

Obj FuncPOLYMAKE_OBJECT_HAS_PROPERTY( Obj self, Obj conv, Obj prop){
  
  if( ! IS_STRING( prop ) )
      ErrorMayQuit(" given property is not a string", 0 ,0 );
  
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, conv, CSTR_STRING( prop ) );
  
}

Obj FuncPOLYMAKE_OBJECT_HAS_INT_PROPERTY( Obj self, Obj conv, Obj prop){
  
  if( ! IS_STRING( prop ) )
      ErrorMayQuit(" given property is not a string", 0 ,0 );
  
  return REAL_OBJECT_HAS_INT_PROPERTY( &akt_data, conv, CSTR_STRING( prop ) );
  
}

Obj FuncPOLYMAKE_IS_REGULAR_OBJECT( Obj self, Obj fan ){
  
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, fan, "REGULAR" );
  
}

Obj FuncPOLYMAKE_NORMALFAN_OF_POLYTOPE( Obj self, Obj polytope ){
  
  return REAL_NORMALFAN_OF_POLYTOPE( &akt_data, polytope );
  
}

Obj FuncPOLYMAKE_IS_FULL_DIMENSIONAL_OBJECT( Obj self, Obj cone ){
  
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, cone, "FULL_DIM" );
  
}

Obj FuncPOLYMAKE_DRAW( Obj self, Obj cone ){
  
  return REAL_POLYMAKE_DRAW( &akt_data, cone );
  
}

Obj FuncPOLYMAKE_DEFINING_INEQUALITIES_OF_CONE( Obj self, Obj cone ){
  
  return REAL_DEFINING_INEQUALITIES_OF_CONE( &akt_data, cone );
  
}

Obj FuncPOLYMAKE_FACET_INEQUALITIES_OF_POLYTOPE( Obj self, Obj poly ){
  
  return REAL_FACET_INEQUALITIES_OF_POLYTOPE( &akt_data, poly );
  
}

Obj FuncPOLYMAKE_RESET_WORKSPACE( Obj self ){
  
  delete akt_data.main_polymake_session;
  akt_data.main_polymake_session = new polymake::Main;
  akt_data.main_polymake_scope = new polymake::perl::Scope(akt_data.main_polymake_session->newScope());
  
  return True;
  
}

/******************************************************************************
*V  GVarFuncs . . . . . . . . . . . . . . . . . . list of functions to export
*/
static StructGVarFunc GVarFuncs [] = {

    { "POLYMAKE_CREATE_CONE_BY_RAYS", 1, "rays",
    (Obj(*)())FuncPOLYMAKE_CREATE_CONE_BY_RAYS,
    "polymake_main.cpp:POLYMAKE_CREATE_CONE_BY_RAYS" },

    { "POLYMAKE_CREATE_CONE_BY_INEQUALITIES", 1, "rays",
    (Obj(*)())FuncPOLYMAKE_CREATE_CONE_BY_INEQUALITIES,
    "polymake_main.cpp:POLYMAKE_CREATE_CONE_BY_INEQUALITIES" },
    
    { "POLYMAKE_CREATE_DUAL_CONE_OF_CONE", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_CREATE_DUAL_CONE_OF_CONE,
    "polymake_main.cpp:POLYMAKE_CREATE_DUAL_CONE_OF_CONE" },
     
    { "POLYMAKE_IS_NONEMPTY_POLYTOPE", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_IS_NONEMPTY_POLYTOPE,
    "polymake_main.cpp:POLYMAKE_IS_NONEMPTY_POLYTOPE" },
     
    { "POLYMAKE_IS_SIMPLICIAL_OBJECT", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_IS_SIMPLICIAL_OBJECT,
    "polymake_main.cpp:POLYMAKE_IS_SIMPLICIAL_OBJECT" },
     
    { "POLYMAKE_IS_SIMPLE_OBJECT", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_IS_SIMPLE_OBJECT,
    "polymake_main.cpp:POLYMAKE_IS_SIMPLE_OBJECT" },
     
    { "POLYMAKE_IS_SIMPLICIAL_CONE", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_IS_SIMPLICIAL_CONE,
    "polymake_main.cpp:POLYMAKE_IS_SIMPLICIAL_CONE" },
    
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
    
    { "POLYMAKE_IS_SMOOTH_CONE", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_IS_SMOOTH_CONE,
    "polymake_main.cpp:POLYMAKE_IS_SMOOTH_CONE" },
    
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
    
    { "POLYMAKE_AMBIENT_DIM_OF_CONE", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_AMBIENT_DIM_OF_CONE,
    "polymake_main.cpp:POLYMAKE_AMBIENT_DIM_OF_CONE" },
    
    { "POLYMAKE_DIM_OF_CONE", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_DIM_OF_CONE,
    "polymake_main.cpp:POLYMAKE_DIM_OF_CONE" },
    
    { "POLYMAKE_HILBERT_BASIS_OF_CONE", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_HILBERT_BASIS_OF_CONE,
    "polymake_main.cpp:POLYMAKE_HILBERT_BASIS_OF_CONE" },
    
    { "POLYMAKE_RAYS_IN_FACETS", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_RAYS_IN_FACETS,
    "polymake_main.cpp:POLYMAKE_RAYS_IN_FACETS" },
    
    { "POLYMAKE_LATTICE_POINTS_OF_POLYTOPE", 1, "polytope",
    (Obj(*)())FuncPOLYMAKE_LATTICE_POINTS_OF_POLYTOPE,
    "polymake_main.cpp:POLYMAKE_LATTICE_POINTS_OF_POLYTOPE" },
    
    { "POLYMAKE_FAN_BY_CONES", 1, "cones",
    (Obj(*)())FuncPOLYMAKE_FAN_BY_CONES,
    "polymake_main.cpp:POLYMAKE_FAN_BY_CONES" },
    
    { "POLYMAKE_FAN_BY_RAYS_AND_CONES", 2, "rays,cones",
    (Obj(*)())FuncPOLYMAKE_FAN_BY_RAYS_AND_CONES,
    "polymake_main.cpp:POLYMAKE_FAN_BY_RAYS_AND_CONES" },
    
    { "POLYMAKE_RAYS_IN_MAXCONES_OF_FAN", 1, "fan",
    (Obj(*)())FuncPOLYMAKE_RAYS_IN_MAXCONES_OF_FAN,
    "polymake_main.cpp:POLYMAKE_RAYS_IN_MAXCONES_OF_FAN" },
    
    { "POLYMAKE_RAYS_OF_FAN", 1, "fan",
    (Obj(*)())FuncPOLYMAKE_RAYS_OF_FAN,
    "polymake_main.cpp:POLYMAKE_RAYS_OF_FAN" },
    
    { "POLYMAKE_IS_POINTED_FAN", 1, "fan",
    (Obj(*)())FuncPOLYMAKE_IS_POINTED_FAN,
    "polymake_main.cpp:POLYMAKE_IS_POINTED_FAN" },
    
    { "POLYMAKE_IS_SMOOTH_FAN", 1, "fan",
    (Obj(*)())FuncPOLYMAKE_IS_SMOOTH_FAN,
    "polymake_main.cpp:POLYMAKE_IS_SMOOTH_FAN" },
    
    { "POLYMAKE_IS_COMPLETE_FAN", 1, "fan",
    (Obj(*)())FuncPOLYMAKE_IS_COMPLETE_FAN,
    "polymake_main.cpp:POLYMAKE_IS_COMPLETE_FAN" },
    
    { "POLYMAKE_OBJECT_HAS_PROPERTY", 2, "conv,prop",
    (Obj(*)())FuncPOLYMAKE_OBJECT_HAS_PROPERTY,
    "polymake_main.cpp:POLYMAKE_OBJECT_HAS_PROPERTY" },
    
    { "POLYMAKE_OBJECT_HAS_INT_PROPERTY", 2, "conv,prop",
    (Obj(*)())FuncPOLYMAKE_OBJECT_HAS_INT_PROPERTY,
    "polymake_main.cpp:POLYMAKE_OBJECT_HAS_INT_PROPERTY" },
    
    { "POLYMAKE_IS_REGULAR_OBJECT", 1, "fan",
    (Obj(*)())FuncPOLYMAKE_IS_REGULAR_OBJECT,
    "polymake_main.cpp:POLYMAKE_IS_REGULAR_OBJECT" },
    
    { "POLYMAKE_NORMALFAN_OF_POLYTOPE", 1, "polytope",
    (Obj(*)())FuncPOLYMAKE_NORMALFAN_OF_POLYTOPE,
    "polymake_main.cpp:POLYMAKE_NORMALFAN_OF_POLYTOPE" },
    
    { "POLYMAKE_AMBIENT_DIM_OF_FAN", 1, "fan",
    (Obj(*)())FuncPOLYMAKE_AMBIENT_DIM_OF_FAN,
    "polymake_main.cpp:POLYMAKE_AMBIENT_DIM_OF_FAN" },
    
    { "POLYMAKE_DIM_OF_FAN", 1, "fan",
    (Obj(*)())FuncPOLYMAKE_DIM_OF_FAN,
    "polymake_main.cpp:POLYMAKE_DIM_OF_FAN" },
    
    { "POLYMAKE_IS_FULL_DIMENSIONAL_OBJECT", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_IS_FULL_DIMENSIONAL_OBJECT,
    "polymake_main.cpp:POLYMAKE_IS_FULL_DIMENSIONAL_OBJECT" },
    
    { "POLYMAKE_DRAW", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_DRAW,
    "polymake_main.cpp:POLYMAKE_DRAW" },
    
    { "POLYMAKE_DEFINING_INEQUALITIES_OF_CONE", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_DEFINING_INEQUALITIES_OF_CONE,
    "polymake_main.cpp:POLYMAKE_DEFINING_INEQUALITIES_OF_CONE" },
    
    { "POLYMAKE_RESET_WORKSPACE", 0, "",
    (Obj(*)())FuncPOLYMAKE_RESET_WORKSPACE,
    "polymake_main.cpp:POLYMAKE_RESET_WORKSPACE" },
    
    { "POLYMAKE_FACET_INEQUALITIES_OF_POLYTOPE", 1, "poly",
    (Obj(*)())FuncPOLYMAKE_FACET_INEQUALITIES_OF_POLYTOPE,
    "polymake_main.cpp:POLYMAKE_FACET_INEQUALITIES_OF_POLYTOPE" },
    
  { 0 }
};

/******************************************************************************
*F  InitKernel( <module> )  . . . . . . . . initialise kernel data structures
*/
static Int InitKernel ( StructInitInfo *module )
{
    /* init filters and functions                                          */
    InitHdlrFuncsFromTable( GVarFuncs );

    InitCopyGVar( "TheTypeExternalPolymakeCone", &TheTypeExternalPolymakeCone );
    InitCopyGVar( "TheTypeExternalPolymakeFan", &TheTypeExternalPolymakeFan );
    InitCopyGVar( "TheTypeExternalPolymakePolytope", &TheTypeExternalPolymakePolytope );

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
