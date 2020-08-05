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
}