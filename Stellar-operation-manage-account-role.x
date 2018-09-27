%#include "xdr/Stellar-ledger-entries.h"

namespace stellar {

/* ManageAccountRole

    Create or delete policy attachment for any account, specific account type or account id

    Threshold: high

    Result: ManageAccountRoleResult
*/

enum ManageAccountRoleOpAction
{
    CREATE = 0,
    REMOVE = 1
};

struct CreateAccountRoleData
{
    longstring name;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct RemoveAccountRoleData
{
    uint64 accountRoleID;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct ManageAccountRoleOp
{
    union switch (ManageAccountRoleOpAction action)
    {
    case CREATE:
        CreateAccountRoleData createData;
    case REMOVE:
        RemoveAccountRoleData removeData;
    } data;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageAccountRoleOp Result ********/

enum ManageAccountRoleResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    NOT_FOUND = -1
};

union ManageAccountRoleResult switch (ManageAccountRoleResultCode code)
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