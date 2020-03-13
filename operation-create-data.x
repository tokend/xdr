%#include "xdr/types.h"

namespace stellar
{

struct CreateDataOp
{
    uint64 type;
    longstring value;

    EmptyExt ext;
};

enum CreateDataResultCode
{
    SUCCESS = 0,

    INVALID_DATA = -1
};

struct CreateDataSuccess
{
    uint64 dataID;

    EmptyExt ext;
};

union CreateDataResult switch (CreateDataResultCode code)
{
    case SUCCESS:
        CreateDataSuccess success;
    default:
        void;
};
}