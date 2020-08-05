%#include "xdr/reviewable-request-remove-data.h"

namespace stellar
{

// todo comment
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
};

union RemoveDataRequestResult switch (RemoveDataRequestResultCode code)
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