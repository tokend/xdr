%#include "xdr/types.h"

namespace stellar
{

struct PutDataOp
{
    MaskedData data;

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


//: Result of operation applying
union PutDataResult switch (PutDataResultCode code)
{
case SUCCESS:
    EmptyExt ext;
default:
    void;
};

}
