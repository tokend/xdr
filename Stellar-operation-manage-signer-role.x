%#include "xdr/Stellar-ledger-entries.h"
%#include "xdr/Stellar-resource-signer-rule.h"

namespace stellar
{
/* ManageSignerRoleOp

 Creates, updates or deletes signer rule

 Result: ManageSignerRuleResult
*/

enum ManageSignerRoleAction
{
    CREATE = 0,
    UPDATE = 1,
    REMOVE = 2
};

struct CreateSignerRoleData
{
    uint64 ruleIDs<>;
    bool isReadOnly;
    longstring details;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct UpdateSignerRoleData
{
    uint64 roleID;
    uint64 ruleIDs<>;

    longstring details;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct RemoveSignerRoleData
{
    uint64 roleID;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct ManageSignerRoleOp
{
    union switch (ManageSignerRoleAction action)
    {
    case CREATE:
        CreateSignerRoleData createData;
    case UPDATE:
        UpdateSignerRoleData updateData;
    case REMOVE:
        RemoveSignerRoleData removeData;
    } data;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageSignerRoleOp Result ********/

enum ManageSignerRoleResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    NOT_FOUND = -1, // does not exists or owner mismatched
    ROLE_IS_USED = -2,
    INVALID_DETAILS = -3,
    NO_SUCH_RULE = -4
};

union ManageSignerRoleResult switch (ManageSignerRoleResultCode code)
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
    case NO_SUCH_RULE:
        uint64 ruleID;
    default:
        void;
};

}
