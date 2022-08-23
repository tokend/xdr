%#include "xdr/types.h"

namespace stellar
{

struct UpdateDataOwnerOp
{
    //: ID of the data entry to update an owner
    uint64 dataID;
    //: A new owner of the entry
    AccountID newOwner;
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
    NOT_AUTHORIZED = -2,
    //: A user does not exist
    USER_NOT_FOUND = -3,
    //: A user who changes a owner of data cannot changes it to himself
    OLD_AND_NEW_USERS_ARE_SAME = -4
};

//: Result of successful application of `UpdateDataOwner` operation
struct UpdateDataOwnerSuccess
{
    //: A new owner of the entry
    AccountID owner;
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