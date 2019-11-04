%#include "xdr/types.h"

namespace stellar 
{

struct UpdateDataOp 
{
    uint64 dataID;

    longstring value;

    EmptyExt ext;
};

enum UpdateDataResultCode 
{
    SUCCESS = 0,

    INVALID_DATA = -1,
    NOT_FOUND = -2
};

union UpdateDataResult switch (UpdateDataResultCode code)
{
case SUCCESS:
    EmptyExt ext;
default:
    void;
};
}