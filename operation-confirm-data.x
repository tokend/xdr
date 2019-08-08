%#include "xdr/types.h"

namespace stellar
{

struct ConfirmDataOp
{
    AccountID targetAccount;
    
    MaskedData data;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

enum ConfirmDataResultCode
{
    SUCCESS = 0
};

//: Result of operation applying
union ConfirmDataResult switch (ConfirmDataResultCode code)
{
case SUCCESS:
    EmptyExt ext;
default:
    void;
};

}
