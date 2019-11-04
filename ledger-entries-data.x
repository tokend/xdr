%#include "xdr/types.h"


namespace stellar 
{
struct DataEntry 
{
    uint64 id;
    uint64 securityType;
    longstring value;

    EmptyExt ext;
};
}