%#include "xdr/types.h"

namespace stellar
{

struct PutDataOp
{
    MaskedDataType type;

    longstring value;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

enum PutDataResultCode
{
    //: PutData was successfully applied
    SUCCESS = 0
};

struct PutDataSuccess
{
    uint64 id;

    EmptyExt ext;
};


//: Result of operation applying
union PutDataResult switch (PutDataResultCode code)
{
case SUCCESS:
    PutDataSuccess success;
default:
    void;
};

}
