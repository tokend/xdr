%#include "xdr/reviewable-request-create-data.h"

namespace stellar
{
struct CreateDataRequestOp
{
    CreateDataRequest createDataRequest;

    uint32* allTasks;

    //: Reserved for future extension
    EmptyExt ext;
};

enum CreateDataRequestResultCode
{
    SUCCESS = 0
};

struct CreateDataRequestResponse {
    uint64 requestID;
    bool fulfilled;

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

union CreateDataRequestResult switch (CreateDataRequestResultCode code)
{
case SUCCESS:
    CreateDataRequestResponse createDataRequestResponse;
default:
    void;
};

}