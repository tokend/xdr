%#include "xdr/reviewable-request-update-data.h"

namespace stellar
{
struct CreateDataUpdateRequestOp
{
    //: ID of the DataUpdateRequest. If set to 0, a new request is created
    uint64 requestID;

    DataUpdateRequest dataUpdateRequest;

    uint32* allTasks;

    //: Reserved for future extension
    EmptyExt ext;
};

enum CreateDataUpdateRequestResultCode
{
    SUCCESS = 0,
    INVALID_VALUE = -1,
    UPDATE_DATA_TASKS_NOT_FOUND = -2,
    DATA_NOT_FOUND = -3,
    INVALID_CREATOR_DETAILS = -4,
    REQUEST_NOT_FOUND = -5
};

struct CreateDataUpdateRequestSuccess {
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

union CreateDataUpdateRequestResult switch (CreateDataUpdateRequestResultCode code)
{
case SUCCESS:
    CreateDataUpdateRequestSuccess success;
default:
    void;
};

}
