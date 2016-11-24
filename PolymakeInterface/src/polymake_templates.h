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

template<typename T>
void POLYMAKE_RATIONAL_MATRIX_GAP_MATRIX( T* polymake_matrix, Obj gap_matrix ){
  
  int rows = LEN_PLIST( gap_matrix );
  Obj current = ELM_PLIST( gap_matrix, 1 );
  Obj elem;
  
#ifdef MORE_TESTS
  if( !IS_PLIST( current ) ){
    ErrorMayQuit( "first ray is not a plain list", 0, 0);
    return;
  }
#endif
  
  int columns = LEN_PLIST( current );
  
  polymake_matrix->resize( rows, columns );
  
  for(int i=0;i<rows;i++){
      current = ELM_PLIST( gap_matrix, i+1 );
#ifdef MORE_TESTS
      if( !IS_PLIST( current ) ){
        ErrorMayQuit( "one row is not a plain list", 0, 0);
        return;
      }
      if( LEN_PLIST( current ) != columns  ){
        ErrorMayQuit( "rows are not of the same length", 0, 0);
        return;
      }
#endif
      for(int j = 0; j < columns; j++){
        elem = ELM_PLIST( current, j+1);
#ifdef MORE_TESTS
        if( ! IS_INTOBJ( elem ) ){
          ErrorMayQuit( "entry is not an integer", 0, 0);
          return;
        }
#endif
        (*polymake_matrix)(i,j) = INT_INTOBJ( elem );
      }
  }
}

template<typename T>
Obj GAP_MATRIX_POLYMAKE_INTEGER_MATRIX( T* polymake_matrix ){
  
  Obj RETLI = NEW_PLIST( T_PLIST , polymake_matrix->rows() );
  UInt matr_rows = polymake_matrix->rows();
  SET_LEN_PLIST( RETLI , matr_rows );
  
  Obj LIZeil;
  
  UInt matr_cols = polymake_matrix->cols();
  for(int i = 0;i<polymake_matrix->rows();i++){
    LIZeil = NEW_PLIST( T_PLIST, polymake_matrix->cols() );
    SET_LEN_PLIST( LIZeil ,matr_cols);
    for(int j = 0;j<polymake_matrix->cols();j++){
      SET_ELM_PLIST(LIZeil,j+1,INTOBJ_INT(static_cast<int>((*polymake_matrix)(i,j))));
    }
    SET_ELM_PLIST(RETLI,i+1,LIZeil);
  }
  return RETLI;
}
