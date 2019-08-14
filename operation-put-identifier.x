%#include "xdr/types.h"

namespace stellar
{

struct PutIdentifierOp
{
    longstring value;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

enum PutIdentifierResultCode
{
    //: PutIdentifier was successfully applied
    SUCCESS = 0
};

struct PutIdentifierSuccess
{
    uint64 id;

    EmptyExt ext;
};


//: Result of operation applying
union PutIdentifierResult switch (PutIdentifierResultCode code)
{
case SUCCESS:
    PutIdentifierSuccess success;
default:
    void;
};

}
