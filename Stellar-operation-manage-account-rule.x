%#include "xdr/Stellar-ledger-entries.h"
%#include "xdr/Stellar-ledger-entries-account-rule.h"

namespace stellar
{
/* ManageAccountRolePermissionOp

 Creates, updates or deletes account role permission

 Threshold: med

 Result: ManageAccountRolePermissionResult
*/

enum ManageAccountRuleAction
{
    CREATE = 0,
    UPDATE = 1,
    REMOVE = 2
};

struct CreateAccountRuleData
{
    AccountRuleResource resource;
    AccountRuleAction action;
    bool forbids;
    longstring details;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct UpdateAccountRuleData
{
    uint64 accountRuleID;
    AccountRuleResource resource;
    AccountRuleAction action;
    bool forbids;
    longstring details;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct RemoveAccountRuleData
{
    uint64 accountRuleID;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct ManageAccountRuleOp
{
    union switch (ManageAccountRuleAction action)
    {
    case CREATE:
        CreateAccountRuleData createData;
    case UPDATE:
        UpdateAccountRuleData updateData;
    case REMOVE:
        RemoveAccountRuleData removeData;
    } data;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageAccountRolePermissionOp Result ********/

enum ManageAccountRuleResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    NOT_FOUND = -1,
    RULE_IS_USED = -2,
    INVALID_DETAILS = -3
};

union ManageAccountRuleResult switch (ManageAccountRuleResultCode code)
{
    case SUCCESS:
        struct {
            uint64 ruleID;

            // reserved for future use
            union switch (LedgerVersion v)
            {
            case EMPTY_VERSION:
                void;
            }
            ext;
        } success;
    case RULE_IS_USED:
        uint64 roleIDs<>;
    default:
        void;
};

}
