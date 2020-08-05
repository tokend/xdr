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
    SUCCESS = 0,
};

union CreateDataRequestResult switch (CreateDataRequestResultCode code)
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