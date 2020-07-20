%#include "xdr/types.h"

namespace stellar
{

struct UpdateDataOp
{
    //: ID of the data entry to update
    uint64 dataID;
    //: New value to set
    longstring value;
    //: Reserved for future extension
    EmptyExt ext;
};

enum UpdateDataResultCode
{
    //: Data was successfully updated
    SUCCESS = 0,
    //: `value` must be in a valid JSON format
    INVALID_DATA = -1,
    //: Entry with provided ID does not exist
    NOT_FOUND = -2,
    //: Only owner or admin can update data entry
    NOT_AUTHORIZED = -3
};


//: Result of operation application
union UpdateDataResult switch (UpdateDataResultCode code)
{
case SUCCESS:
    //: Reserved for future extension
    EmptyExt ext;
default:
    void;
};
}