%#include "xdr/Stellar-ledger-entries.h"
%#include "xdr/Stellar-ledger-entries-account-role-policy.h"

namespace stellar
{
/* ManageAccountRolePolicyOp

 Creates, updates or deletes account role policy

 Threshold: med

 Result: ManageAccountRolePolicyResult
*/

enum ManageAccountRolePolicyOpAction
{
    CREATE = 0,
    UPDATE = 1,
    REMOVE = 2
};

struct CreateAccountRolePolicyData
{
    uint64 roleID;
    string256 resource;
    string256 action;
    AccountRolePolicyEffect effect;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct UpdateAccountRolePolicyData
{
    uint64 policyID;
    uint64 roleID;
    string256 resource;
    string256 action;
    AccountRolePolicyEffect effect;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct RemoveAccountRolePolicyData
{
    uint64 policyID;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct ManageAccountRolePolicyOp
{
    union switch (ManageAccountRolePolicyOpAction action)
    {
    case CREATE:
        CreateAccountRolePolicyData createData;
    case UPDATE:
        UpdateAccountRolePolicyData updateData;
    case REMOVE:
        RemoveAccountRolePolicyData removeData;
    } data;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageAccountRolePolicyOp Result ********/

enum ManageAccountRolePolicyResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    NOT_FOUND = -1,
    POLICY_ALREADY_EXISTS = -2
};

union ManageAccountRolePolicyResult switch (ManageAccountRolePolicyResultCode code)
{
    case SUCCESS:
        struct {
            uint64 accountRolePolicyID;

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
