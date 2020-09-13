%#include "xdr/ledger-entries.h"
%#include "xdr/ledger-entries-account-rule.h"

namespace stellar
{
/* ManageAccountRolePermissionOp

 Creates, updates or deletes account role permission

 Threshold: med

 Result: ManageAccountRolePermissionResult
*/

//: Actions that can be performed with account rule
enum ManageAccountRuleAction
{
    CREATE = 0,
    UPDATE = 1,
    REMOVE = 2
};

//: CreateAccountRuleData is used to pass necessary params to create a new account rule
struct CreateAccountRuleData
{
    //: Resource is used to specify an entity (for some - with properties) that can be managed through operations
    AccountRuleResource resource;
    //: Value from enum that can be applied to `resource`
    AccountRuleAction action;
    //: True if such `action` on such `resource` is prohibited, otherwise allows
    bool forbids;
    //: Arbitrary stringified json object that will be attached to rule
    longstring details;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: UpdateAccountRuleData is used to pass necessary params to update existing account rule
struct UpdateAccountRuleData
{
    //: Identifier of existing signer rule
    uint64 ruleID;
    //: Resource is used to specify entity (for some - with properties) that can be managed through operations
    AccountRuleResource resource;
    //: Value from enum that can be applied to `resource`
    AccountRuleAction action;
    //: True if such `action` on such `resource` is prohibited, otherwise allows
    bool forbids;
    //: Arbitrary stringified json object that will be attached to rule
    longstring details;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: RemoveAccountRuleData is used to pass necessary params to remove existing account rule
struct RemoveAccountRuleData
{
    //: Identifier of existing account rule
    uint64 ruleID;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: ManageAccountRuleOp is used to create, update or remove account rule
struct ManageAccountRuleOp
{
    //: data is used to pass one of `ManageAccountRuleAction` with required params
    union switch (ManageAccountRuleAction action)
    {
    case CREATE:
        CreateAccountRuleData createData;
    case UPDATE:
        UpdateAccountRuleData updateData;
    case REMOVE:
        RemoveAccountRuleData removeData;
    } data;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageAccountRolePermissionOp Result ********/

//: Result codes of ManageAccountRuleResultCode
enum ManageAccountRuleResultCode
{
    //: Means that specified action in `data` of ManageAccountRuleOp was successfully performed
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: There is no account rule with such id
    NOT_FOUND = -1,
    //: It is not allowed to remove the rule if it is used at least in one role
    RULE_IS_USED = -2,
    //: Passed details has invalid json structure
    INVALID_DETAILS = -3,
    //: Custom rule action can not be used with entries other than CUSTOM
    INVALID_ACTION = -4
};

//: Result of operation applying
union ManageAccountRuleResult switch (ManageAccountRuleResultCode code)
{
    case SUCCESS:
        //: Is used to pass useful params if operation is success
        struct {
            //: id of the rule that was managed
            uint64 ruleID;

            //: reserved for future use
            union switch (LedgerVersion v)
            {
            case EMPTY_VERSION:
                void;
            }
            ext;
        } success;
    case RULE_IS_USED:
        //: ids of roles that use the rule that cannot be removed
        uint64 roleIDs<>;
    default:
        void;
};

}
