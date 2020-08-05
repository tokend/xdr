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
}