%#include "xdr/Stellar-ledger-entries.h"
%#include "xdr/Stellar-resource-signer-rule.h"

namespace stellar
{
/* ManageSignerRuleOp

 Creates, updates or deletes signer rule

 Result: ManageSignerRuleResult
*/

enum ManageSignerRuleAction
{
    CREATE = 0,
    UPDATE = 1,
    REMOVE = 2
};

struct CreateSignerRuleData
{
    SignerRuleResource resource;
    string256 action;
    bool isForbid;
    bool isDefault;
    longstring details;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct UpdateSignerRuleData
{
    uint64 ruleID;
    AccountRuleResource resource;
    string256 action;
    bool isForbid;
    bool isDefault;
    longstring details;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct RemoveSignerRuleData
{
    uint64 ruleID;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct ManageSignerRuleOp
{
    union switch (ManageSignerRuleAction action)
    {
    case CREATE:
        CreateSignerRuleData createData;
    case UPDATE:
        UpdateSignerRuleData updateData;
    case REMOVE:
        RemoveSignerRuleData removeData;
    } data;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageSignerRuleOp Result ********/

enum ManageSignerRuleResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    NOT_FOUND = -1, // does not exists or owner mismatched
    RULE_IS_USED = -2,
    INVALID_DETAILS = -3
};

union ManageSignerRuleResult switch (ManageSignerRuleResultCode code)
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
