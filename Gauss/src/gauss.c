/***************************************************************************
**
*A  gauss.c               gauss-package                      Max Neunhoeffer
**
*/

/* Try to use as much of the GNU C library as possible: */
#define _GNU_SOURCE

#include "src/compiled.h"          /* GAP headers                */

/* The following seems to be necessary to run under modern gcc compilers
 * which have the ssp stack checking enabled. Hopefully this does not
 * hurt in future or other versions... */
#if 0
#ifdef __GNUC__
#if (__GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 1))
extern void __stack_chk_fail();
void __stack_chk_fail_local (void)
{
  __stack_chk_fail ();
}
#endif
#endif
#endif

Obj FuncSYMMETRIC_DIFFERENCE_OF_ORDERED_SETS_OF_SMALL_INTEGERS( Obj self, Obj a, Obj b )
{
  Obj c;   /* for the result */
  Int len,lena,lenb;
  Int i,j,k;
  Int x,y;

  lena = LEN_PLIST(a);
  lenb = LEN_PLIST(b);
  len = lena+lenb;
  if (len == 0) {
      return NEW_PLIST(T_PLIST_EMPTY,0);
  }
  c = NEW_PLIST(T_PLIST_CYC_SSORT,len);
  SET_LEN_PLIST(c,len);
  i = 1;
  j = 1;
  k = 1;
  if (i <= lena && j <= lenb) {
      x = INT_INTOBJ(ELM_PLIST(a,i));
      y = INT_INTOBJ(ELM_PLIST(b,j));
      while (1) {
          if (x < y) {
              SET_ELM_PLIST(c,k,INTOBJ_INT(x));
              k++;
              i++;
              if (i > lena) 
                  break;
              else
                  x = INT_INTOBJ(ELM_PLIST(a,i));
          } else if (y < x) {
              SET_ELM_PLIST(c,k,INTOBJ_INT(y));
              k++;
              j++;
              if (j > lenb)
                  break;
              else
                  y = INT_INTOBJ(ELM_PLIST(b,j));
          } else {
              i++;
              j++;
              if (i > lena)
                  break;
              else
                  x = INT_INTOBJ(ELM_PLIST(a,i));
              if (j > lenb)
                  break;
              else
                  y = INT_INTOBJ(ELM_PLIST(b,j));
          }
      }
  }
  /* Only one of the following will happen: */
  while (i <= lena) {
      SET_ELM_PLIST(c,k,ELM_PLIST(a,i));
      i++;
      k++;
  }
  while (j <= lenb) {
      SET_ELM_PLIST(c,k,ELM_PLIST(b,j));
      j++;
      k++;
  }
  SET_LEN_PLIST(c,k-1);
  SHRINK_PLIST(c,k-1);
  return c;
}


/*F * * * * * * * * * * * * * initialize package * * * * * * * * * * * * * * */

/******************************************************************************
*V  GVarFuncs . . . . . . . . . . . . . . . . . . list of functions to export
*/
static StructGVarFunc GVarFuncs [] = {

  { "SYMMETRIC_DIFFERENCE_OF_ORDERED_SETS_OF_SMALL_INTEGERS", 2, "a, b",
    FuncSYMMETRIC_DIFFERENCE_OF_ORDERED_SETS_OF_SMALL_INTEGERS,
    "gauss.c:SYMMETRIC_DIFFERENCE_OF_ORDERED_SETS_OF_SMALL_INTEGERS" },

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
    /* init functions */
    InitGVarFuncsFromTable(GVarFuncs);

    /* return success                                                      */
    return 0;
}

/******************************************************************************
*F  InitInfopl()  . . . . . . . . . . . . . . . . . table of init functions
*/
static StructInitInfo module = {
#ifdef GAUSSSTATIC
    .type = MODULE_STATIC,
#else
    .type = MODULE_DYNAMIC,
#endif
    .name = "gauss",
    .initKernel = InitKernel,
    .initLibrary = InitLibrary,
};

#ifndef GAUSSSTATIC
StructInitInfo * Init__Dynamic ( void )
{
  return &module;
}
#endif

StructInitInfo * Init__gauss ( void )
{
  return &module;
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
