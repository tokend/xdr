%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/*BindExternalSystemAccountId

Threshold: low

Result: BindExternalSystemAccountIdResult

*/

//: BindExternalSystemAccountIdOp is used to bind source account to
//: external system account ID pool
struct BindExternalSystemAccountIdOp
{
    //: Type of external system to bind
    int32 externalSystemType;

    //: Reserved for the future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* BindExternalSystemAccountId Result ********/

//: Result codes of BindExternalSystemAccountIdOp
enum BindExternalSystemAccountIdResultCode
{
    // codes considered as "success" for the operation
    //: Source account successfully bound to pool
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: deprecated
    MALFORMED = -1,
    //: There is no available external system account ID pool for such external system type
    NO_AVAILABLE_ID = -2
};

//: Success result of operation applying
struct BindExternalSystemAccountIdSuccess
{
    //: `data` is used to pass data from external system account ID pool
    longstring data;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result of operation applying
union BindExternalSystemAccountIdResult switch (BindExternalSystemAccountIdResultCode code)
{
case SUCCESS:
    //: `success` is used to pass useful fields after operation applying
    BindExternalSystemAccountIdSuccess success;
default:
    void;
};

}
