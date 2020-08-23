%#include "xdr/reviewable-request-create-data.h"

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
    UPDATE_DATA_TASKS_NOT_FOUND = -2
};

struct CreateDataUpdateRequestResponse {
    uint64 requestID;
    bool fulfilled;
    AccountID owner;
    uint64 id;
    uint64 type;
    longstring value;

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
    CreateDataUpdateRequestResponse createDataUpdateRequestResponse;
default:
    void;
};

}
