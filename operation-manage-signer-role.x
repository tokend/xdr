%#include "xdr/ledger-entries.h"
%#include "xdr/resource-signer-rule.h"

namespace stellar
{
/* ManageSignerRoleOp

 Creates, updates or deletes signer rule

 Result: ManageSignerRuleResult
*/

//: Actions that can be performed on a signer role
enum ManageSignerRoleAction
{
    CREATE = 0,
    UPDATE = 1,
    REMOVE = 2
};

//: CreateSignerRoleData is used to pass necessary params to create a new signer role
struct CreateSignerRoleData
{
    //: Array of ids of existing, unique and not default rules
    uint64 ruleIDs<>;
    //: Indicates whether or not a rule can be modified in the future
    bool isReadOnly;
    //: Arbitrary stringified json object with details to attach to the role
    longstring details;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: UpdateSignerRoleData is used to pass necessary params to update an existing signer role
struct UpdateSignerRoleData
{
    //: ID of an existing signer role
    uint64 roleID;
    //: Array of ids of existing, unique and not default rules
    uint64 ruleIDs<>;

    //: Arbitrary stringified json object with details to attach to the role
    longstring details;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: RemoveSignerRoleData is used to pass necessary params to remove existing signer role
struct RemoveSignerRoleData
{
    //: Identifier of an existing signer role
    uint64 roleID;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: ManageSignerRoleOp is used to create, update or remove a signer role
struct ManageSignerRoleOp
{
    //: data is used to pass one of `ManageSignerRoleAction` with required params
    union switch (ManageSignerRoleAction action)
    {
    case CREATE:
        CreateSignerRoleData createData;
    case UPDATE:
        UpdateSignerRoleData updateData;
    case REMOVE:
        RemoveSignerRoleData removeData;
    } data;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageSignerRoleOp Result ********/

//: Result codes of ManageSignerRoleResultCode
enum ManageSignerRoleResultCode
{
    //: Means that the specified action in `data` of ManageSignerRoleOp was successfully executed
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: There is no signer role with such id or the source cannot manage a role
    NOT_FOUND = -1, // does not exist or owner mismatched
    //: It is not allowed to remove role if it is attached to at least one singer
    ROLE_IS_USED = -2,
    //: Passed details have invalid json structure
    INVALID_DETAILS = -3,
    //: There is no rule with id passed through `ruleIDs`
    NO_SUCH_RULE = -4,
    //: It is not allowed to duplicate ids in `ruleIDs` array
    RULE_ID_DUPLICATION = -5,
    //: It is not allowed to pass ids of default rules on `ruleIDs` array
    DEFAULT_RULE_ID_DUPLICATION = -6,
    //: It is not allowed to pass ruleIDs that are more than maxSignerRuleCount (by default, 128)
    TOO_MANY_RULE_IDS = -7
};

//: Result of operation application
union ManageSignerRoleResult switch (ManageSignerRoleResultCode code)
{
    case SUCCESS:
        struct
        {
            //: id of a role that was managed
            uint64 roleID;

            //: reserved for future use
            union switch (LedgerVersion v)
            {
            case EMPTY_VERSION:
                void;
            }
            ext;
        } success;
    case RULE_ID_DUPLICATION:
    case DEFAULT_RULE_ID_DUPLICATION:
    case NO_SUCH_RULE:
        //: ID of a rule that was either duplicated or is default or does not exist
        uint64 ruleID;
    case TOO_MANY_RULE_IDS:
        //: max count of rule ids that can be passed in `ruleIDs` array
        uint64 maxRuleIDsCount;
    default:
        void;
};

}
