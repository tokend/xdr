%#include "xdr/types.h"

struct DataEntry 
{
    uint64 id;
    longstring data;

    EmptyExt ext;
};