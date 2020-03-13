%#include "xdr/types.h"


namespace stellar 
{
struct DataEntry 
{
    uint64 id;
    uint64 type;
    longstring value;

    EmptyExt ext;
};
}