%#include "xdr/types.h"


struct CreateDataOp 
{
    longstring data;

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