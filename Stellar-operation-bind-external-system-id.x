%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/*BindExternalSystemAccountId

Threshold: low

Result: BindExternalSystemAccountIdResult

*/

//: BindExternalSystemAccountIdOp is used to bind a particular account to the external system account which is represented by account ID taken from the pool
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
    //: Source account has been successfully bound to external system ID taken from the pool
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: (deprecated)
    MALFORMED = -1,
    //: There are no available IDs from external system in the pool of such an external system type
    NO_AVAILABLE_ID = -2
};

//: `BindExternalSystemAccountIdSuccess` represents details of successful result of operation applying
struct BindExternalSystemAccountIdSuccess
{
    //: `data` is used to pass data about account from external system ID
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
    //: `success` is used to pass useful fields after successful operation applying
    BindExternalSystemAccountIdSuccess success;
default:
    void;
};

}
