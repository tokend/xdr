%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/*BindExternalSystemAccountId

Threshold: low

Result: BindExternalSystemAccountIdResult

*/

struct BindExternalSystemAccountIdOp
{
    int32 externalSystemType;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* BindExternalSystemAccountId Result ********/

enum BindExternalSystemAccountIdResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    MALFORMED = -1,
    NO_AVAILABLE_ID = -2,
    AUTO_GENERATED_TYPE_NOT_ALLOWED = -3
};

struct BindExternalSystemAccountIdSuccess {
    longstring data;
    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union BindExternalSystemAccountIdResult switch (BindExternalSystemAccountIdResultCode code)
{
case SUCCESS:
    BindExternalSystemAccountIdSuccess success;
default:
    void;
};

}
