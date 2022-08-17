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
    INVALID_VALUE = -1,
    UPDATE_DATA_TASKS_NOT_FOUND = -2,
    DATA_NOT_FOUND = -3,
    INVALID_CREATOR_DETAILS = -4,
    REQUEST_NOT_FOUND = -5
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