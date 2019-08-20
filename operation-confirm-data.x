%#include "xdr/types.h"

namespace stellar
{

struct ConfirmDataOp
{
    int64 dataID;

    int64 confirmationID;

    uint32 mask;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

enum ConfirmDataResultCode
{
    SUCCESS = 0,
    INVALID_TARGET = 1,
    DATA_MISSING = 2
};

struct ConfirmDataSuccess
{
    uint64 confirmationID;

    EmptyExt ext;
};

//: Result of operation applying
union ConfirmDataResult switch (ConfirmDataResultCode code)
{
case SUCCESS:
    ConfirmDataSuccess success;
default:
    void;
};

}
