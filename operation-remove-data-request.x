%#include "xdr/reviewable-request-remove-data.h"

namespace stellar
{
struct RemoveDataRequestOp
{
    RemoveDataRequest removeDataRequest;

    uint32* allTasks;

    //: Reserved for future extension
    EmptyExt ext;
};

enum RemoveDataRequestResultCode
{
    SUCCESS = 0,
    NOT_FOUND = -2,
};

struct RemoveDataRequestResponse {
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

union RemoveDataRequestResult switch (RemoveDataRequestResultCode code)
{
case SUCCESS:
    RemoveDataRequestResponse removeDataRequestResponse;
default:
    void;
};
}