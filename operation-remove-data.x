%#include "xdr/types.h"

namespace stellar 
{

struct RemoveDataOp 
{
    uint64 dataID;

    EmptyExt ext;
};

enum RemoveDataResultCode 
{
    SUCCESS = 0,

    NOT_FOUND = -1
};

union RemoveDataResult switch (RemoveDataResultCode code)
{
case SUCCESS:
    EmptyExt ext;
default:
    void;
};
}