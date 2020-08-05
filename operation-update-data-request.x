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

union UpdateDataRequestResult switch (UpdateDataRequestResultCode code)
{
case SUCCESS:
    struct {
        // Reserved for future use
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
	} success;
default:
    void;
};
}