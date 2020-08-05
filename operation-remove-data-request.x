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
}