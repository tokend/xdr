%#include "xdr/types.h"

namespace stellar
{

struct UpdateDataOwnerOp
{
    //: ID of the data entry to update an owner
    uint64 dataID;
    //: A new owner of the entry
    AccountID new_owner;
    //: Reserved for future extension
    EmptyExt ext;
};

enum UpdateDataOwnerResultCode
{
    //: An owner of the data was successfully updated
    SUCCESS = 0,
    //: Entry with provided ID does not exist
    NOT_FOUND = -1,
    //: Only owner can update data entry
    NOT_AUTHORIZED = -2
};

//: Result of successful application of `UpdateDataOwner` operation
struct UpdateDataOwnerSuccess
{
    //: A new owner of the entry
    AccountID new_owner;
    //: Reserved for future extension
    EmptyExt ext;
};

//: Result of operation application
union UpdateDataOwnerResult switch (UpdateDataOwnerResultCode code)
{
case SUCCESS:
    UpdateDataOwnerSuccess success;
default:
    void;
};
}