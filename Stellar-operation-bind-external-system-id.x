%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/*BindExternalSystemAccountId

Threshold: low

Result: BindExternalSystemAccountIdResult

*/

//: BindExternalSystemAccountIdOp is used to bind a particular account to an external system account which is represented by account ID taken from the pool.
struct BindExternalSystemAccountIdOp
{
    //: Type of an external system to bind
    int32 externalSystemType;

    //: Reserved for future use
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
    //: Source account has been successfully bound to external system ID taken from the pool
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: (deprecated)
    MALFORMED = -1,
    //: There is no available external system account ID pool entry for such an external system type
    NO_AVAILABLE_ID = -2
};

//: `BindExternalSystemAccountIdSuccess` represents details of operation application successful result
struct BindExternalSystemAccountIdSuccess
{
    //: `data` is used to pass the account data from external system ID
    longstring data;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result of operation application
union BindExternalSystemAccountIdResult switch (BindExternalSystemAccountIdResultCode code)
{
case SUCCESS:
    BindExternalSystemAccountIdSuccess success;
default:
    void;
};

}
