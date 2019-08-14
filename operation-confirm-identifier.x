%#include "xdr/types.h"

namespace stellar
{

struct ConfirmIdentifierOp
{
    uint64 id;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

enum ConfirmIdentifierResultCode
{
    SUCCESS = 0
};

struct ConfirmIdentifierSuccess
{
    uint64 id;

    EmptyExt ext;
};


//: Result of operation applying
union ConfirmIdentifierResult switch (ConfirmIdentifierResultCode code)
{
case SUCCESS:
    ConfirmIdentifierSuccess success;
default:
    void;
};

}
