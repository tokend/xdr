%#include "xdr/reviewable-request-remove-data.h"

namespace stellar
{
struct CreateDataRemoveRequestOp
{
    //: ID of the DataRemoveRequest. If set to 0, a new request is created
    uint64 requestID;

    DataRemoveRequest dataRemoveRequest;

    uint32* allTasks;

    //: Reserved for future extension
    EmptyExt ext;
};

enum CreateDataRemoveRequestResultCode
{
    SUCCESS = 0,
    REMOVE_DATA_TASKS_NOT_FOUND = -1,
    DATA_NOT_FOUND = -2,
    INVALID_CREATOR_DETAILS = -3,
    REQUEST_NOT_FOUND = -4
};

struct CreateDataRemoveRequestSuccess {
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

union CreateDataRemoveRequestResult switch (CreateDataRemoveRequestResultCode code)
{
case SUCCESS:
    CreateDataRemoveRequestSuccess success;
default:
    void;
};

}
