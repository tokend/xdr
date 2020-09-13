%#include "xdr/reviewable-request-create-data.h"

namespace stellar
{
struct CreateDataCreationRequestOp
{
    //: ID of the DataCreationRequest. If set to 0, a new request is created
    uint64 requestID;

    DataCreationRequest dataCreationRequest;

    uint32* allTasks;

    //: Reserved for future extension
    EmptyExt ext;
};

enum CreateDataCreationRequestResultCode
{
    SUCCESS = 0,
    INVALID_VALUE = -1,
    CREATE_DATA_TASKS_NOT_FOUND = -2,
    REQUEST_NOT_FOUND = -3,
    INVALID_CREATOR_DETAILS = -4
};

struct CreateDataCreationRequestSuccess {
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

union CreateDataCreationRequestResult switch (CreateDataCreationRequestResultCode code)
{
case SUCCESS:
    CreateDataCreationRequestSuccess success;
default:
    void;
};

}
