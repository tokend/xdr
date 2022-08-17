%#include "xdr/types.h"

namespace stellar
{

struct UpdateDataOwnerOp
{
    //: ID of the data entry to update an owner
    uint64 dataID;
    //: A new owner of the entry
    AccountID owner;
    //: Reserved for future extension
    EmptyExt ext;
};

enum UpdateDataOwnerResultCode
{
    //: An owner of the data was successfully updated
    SUCCESS = 0,
    //: `owner` must be in a valid format
    INVALID_DATA = -1,
    //: Entry with provided ID does not exist
    NOT_FOUND = -2,
    //: Only owner can update data entry
    NOT_AUTHORIZED = -3
};

//: Result of operation application
union UpdateDataOwnerResult switch (UpdateDataOwnerResultCode code)
{
case SUCCESS:
    //: Reserved for future extension
    EmptyExt ext;
default:
    void;
};
}