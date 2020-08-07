%#include "xdr/reviewable-request-update-data.h"

namespace stellar
{
struct UpdateDataRequestOp
{
    UpdateDataRequest updateDataRequest;

    uint32* allTasks;

    //: Reserved for future extension
    EmptyExt ext;
};

enum UpdateDataRequestResultCode
{
    SUCCESS = 0
};

struct UpdateDataRequestResponse {
    uint64 requestID;
    bool fulfilled;

    AccountID owner;
    uint64 dataID;
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

union UpdateDataRequestResult switch (UpdateDataRequestResultCode code)
{
case SUCCESS:
    UpdateDataRequestResponse updateDataRequestResponse;
default:
    void;
};
}