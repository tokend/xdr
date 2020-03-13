%#include "xdr/types.h"


namespace stellar 
{
struct DataEntry 
{
    //: ID of the data entry
    uint64 id;
    //: Numeric type, used for access control
    uint64 type;
    //: Value stored
    longstring value;

    //: Creator of the entry
    AccountID owner;
    //: Reserved for future extension
    EmptyExt ext;
};
}