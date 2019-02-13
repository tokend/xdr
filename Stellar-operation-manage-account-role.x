%#include "xdr/Stellar-ledger-entries.h"

namespace stellar {

/* ManageAccountRole

    Create or delete policy attachment for any account, specific account type or account id

    Threshold: high

    Result: ManageAccountRoleResult
*/

enum ManageAccountRoleAction
{
    CREATE = 0,
    UPDATE = 1,
    REMOVE = 2
};

struct CreateAccountRoleData
{
    longstring details;
    uint64 accountRuleIDs<>;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct UpdateAccountRoleData
{
    uint64 roleID;
    longstring details;
    uint64 accountRuleIDs<>;

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
    union switch (ManageAccountRoleAction action)
    {
    case CREATE:
        CreateAccountRoleData createData;
    case UPDATE:
        UpdateAccountRoleData updateData;
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
    NOT_FOUND = -1,
    ROLE_IS_USED = -2,
    INVALID_DETAILS = -3,
    NO_SUCH_RULE = -4,
    RULE_ID_DUPLICATION = -5
};

union ManageAccountRoleResult switch (ManageAccountRoleResultCode code)
{
    case SUCCESS:
        struct {
            uint64 roleID;

            // reserved for future use
            union switch (LedgerVersion v)
            {
            case EMPTY_VERSION:
                void;
            }
            ext;
        } success;
    case RULE_ID_DUPLICATION:
    case NO_SUCH_RULE:
        uint64 ruleID;
    default:
        void;
};

}