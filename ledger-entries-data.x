%#include "xdr/types.h"


namespace stellar 
{
struct DataEntry 
{
    uint64 id;
    uint32 securityType;
    longstring value;

    AccountID owner;

    EmptyExt ext;
};
}