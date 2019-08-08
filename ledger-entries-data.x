%#include "xdr/types.h"


namespace stellar 
{
struct DataEntry 
{
    uint64 id;
    longstring value;

    EmptyExt ext;
};
}