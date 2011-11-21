#ifndef LOADGAP_H
#define LOADGAP_H

/* Try to use as much of the GNU C library as possible: */
#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif

extern "C" {
#include <src/compiled.h>          /* GAP headers                */

/* The following seems to be necessary to run under modern gcc compilers
 * which have the ssp stack checking enabled. Hopefully this does not
 * hurt in future or other versions... */
#ifdef __GNUC__
#if (__GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 1))
extern void __stack_chk_fail();
#endif
#endif
}

#endif
# define MORE_TESTS 1
