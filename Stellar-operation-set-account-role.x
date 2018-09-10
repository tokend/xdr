%#include "xdr/Stellar-ledger-entries.h"

namespace stellar {

/* SetAccountRole

    Create or delete policy attachment for any account, specific account type or account id

    Threshold: high

    Result: SetAccountRoleResult
*/

struct SetAccountRoleData
{
    string name<>;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct SetAccountRoleOp
{
    uint64 id;
    SetAccountRoleData *data;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* SetAccountRole Result ********/

enum SetAccountRoleResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    MALFORMED = -1,
    NOT_FOUND = -2
};

union SetAccountRoleResult switch (SetAccountRoleResultCode code)
{
    case SUCCESS:
        struct {
            uint64 accountRoleID;

            // reserved for future use
            union switch (LedgerVersion v)
            {
            case EMPTY_VERSION:
                void;
            }
            ext;
        } success;
    default:
        void;
};

}