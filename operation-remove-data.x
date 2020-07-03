%#include "xdr/types.h"

namespace stellar 
{

struct RemoveDataOp 
{
    //: ID of the data to remove
    uint64 dataID;
    //: Reserved for future extension
    EmptyExt ext;
};

enum RemoveDataResultCode 
{
    //: Data successfully removed
    SUCCESS = 0,
    //: Entry with provided ID does not exist
    NOT_FOUND = -1,
    //: Only owner or admin can remove data.
    NOT_AUTHORIZED = -2
};

//: Result of operation application
union RemoveDataResult switch (RemoveDataResultCode code)
{
case SUCCESS:
    //: Reserved for future extension
    EmptyExt ext;
default:
    void;
};
}