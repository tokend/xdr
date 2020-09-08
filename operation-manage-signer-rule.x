%#include "xdr/ledger-entries.h"
%#include "xdr/resource-signer-rule.h"

namespace stellar
{
/* ManageSignerRuleOp

 Creates, updates or deletes signer rule

 Result: ManageSignerRuleResult
*/

//: Actions that can be performed with a signer rule
enum ManageSignerRuleAction
{
    CREATE = 0,
    UPDATE = 1,
    REMOVE = 2
};

//: CreateSignerRuleData is used to pass necessary params to create a new signer rule
struct CreateSignerRuleData
{
    //: Resource is used to specify an entity (for some, with properties) that can be managed through operations
    SignerRuleResource resource;
    //: Value from enum that can be applied to `resource`
    SignerRuleAction action;
    //: Indicate whether or not an `action` on the provided `resource` is prohibited
    bool forbids;
    //: True means that such rule will be automatically added to each new or updated signer role
    bool isDefault;
    //: Indicates whether or not a rule can be modified in the future
    bool isReadOnly;
    //: Arbitrary stringified json object with details that will be attached to a rule
    longstring details;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: UpdateSignerRuleData is used to pass necessary params to update an existing signer rule
struct UpdateSignerRuleData
{
    //: Identifier of an existing signer rule
    uint64 ruleID;
    //: Resource is used to specify entity (for some, with properties) that can be managed through operations
    SignerRuleResource resource;
    //: Value from enum that can be applied to `resource`
    SignerRuleAction action;
    //: True means that such rule will be automatically added to each new or updated signer role
    bool forbids;
    //: True means that no one can manage such rule after creating
    bool isDefault;
    //: Arbitrary stringified json object with details that will be attached to a rule
    longstring details;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: RemoveSignerRuleData is used to pass necessary params to remove existing signer rule
struct RemoveSignerRuleData
{
    //: Identifier of an existing signer rule
    uint64 ruleID;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: ManageSignerRuleOp is used to create, update or remove signer rule
struct ManageSignerRuleOp
{
    //: data is used to pass one of `ManageSignerRuleAction` with required params
    union switch (ManageSignerRuleAction action)
    {
    case CREATE:
        CreateSignerRuleData createData;
    case UPDATE:
        UpdateSignerRuleData updateData;
    case REMOVE:
        RemoveSignerRuleData removeData;
    } data;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageSignerRuleOp Result ********/

//: Result codes of ManageSignerRuleOp
enum ManageSignerRuleResultCode
{
    //: Specified action in `data` of ManageSignerRuleOp was successfully executed
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: There is no signer rule with such id or source cannot manage the rule
    NOT_FOUND = -1, // does not exists or owner mismatched
    //: It is not allowed to remove the rule if it is attached to at least one role
    RULE_IS_USED = -2,
    //: Passed details have invalid json structure
    INVALID_DETAILS = -3,
    //: Custom rule action can not be used with entries other than CUSTOM
    INVALID_ACTION = -4
};

//: Result of operation application
union ManageSignerRuleResult switch (ManageSignerRuleResultCode code)
{
    case SUCCESS:
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
        //: ids of roles which use a rule that cannot be removed
        uint64 roleIDs<>;
    default:
        void;
};

}
