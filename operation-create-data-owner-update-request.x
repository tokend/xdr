%#include "xdr/reviewable-request-update-data-owner.h"

namespace stellar
{
struct CreateDataOwnerUpdateRequestOp
{
    //: ID of the DataOwnerUpdateRequest. If set to 0, a new request is created
    uint64 requestID;

    DataOwnerUpdateRequest dataOwnerUpdateRequest;

    uint32* allTasks;

    //: Reserved for future extension
    EmptyExt ext;
};

enum CreateDataOwnerUpdateRequestResultCode
{
    SUCCESS = 0,
    UPDATE_DATA_OWNER_TASKS_NOT_FOUND = -1,
    DATA_NOT_FOUND = -2,
    INVALID_CREATOR_DETAILS = -3,
    REQUEST_NOT_FOUND = -4
};

struct CreateDataOwnerUpdateRequestSuccess {
    uint64 requestID;
    bool fulfilled;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union CreateDataOwnerUpdateRequestResult switch (CreateDataOwnerUpdateRequestResultCode code)
{
case SUCCESS:
    CreateDataOwnerUpdateRequestSuccess success;
default:
    void;
};

}