%#include "xdr/types.h"

namespace stellar
{

struct ChangeDataOwnerOp
{
    //: ID of the data entry to change owner of
    uint64 dataID;
    //: ID of the new data owner account
    AccountID destination;

    //: Reserved for future extension
    EmptyExt ext;
};

enum ChangeDataOwnerResultCode
{
    //: Data owner has been successfully changed
    SUCCESS = 0,
    //: ID of the destination should be valid account ID and not equal to current data owner
    INVALID_DESTINATION = 1,
};

//: ChangeDataOwnerSuccess is a result of successful ChangeDataOwnerOp application
struct ChangeDataOwnerSuccess {
    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result of the ChangeDataOwner operation application
union ChangeDataOwnerResult switch (ChangeDataOwnerResultCode code)
{
case SUCCESS:
    ChangeDataOwnerSuccess success;
default:
    void;
};

}