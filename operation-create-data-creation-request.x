%#include "xdr/reviewable-request-create-data.h"

namespace stellar
{
struct CreateDataCreationRequestOp
{
    //: ID of the DataCreationRequest. If set to 0, a new request is created
    uint64 requestID;

    CreateDataRequest createDataRequest;

    uint32* allTasks;

    //: Reserved for future extension
    EmptyExt ext;
};

enum CreateDataCreationRequestResultCode
{
    SUCCESS = 0,
    INVALID_VALUE = -1
};

struct CreateDataCreationRequestResponse {
    uint64 requestID;
    bool fulfilled;
    //todo add owner
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

union CreateDataCreationRequestResult switch (CreateDataRequestResultCode code)
{
case SUCCESS:
    CreateDataRequestResponse createDataRequestResponse;
default:
    void;
};

}
