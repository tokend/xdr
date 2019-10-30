%#include "xdr/ledger-entries.h"
%#include "xdr/resource-signer-rule.h"

namespace stellar
{
//: UpdateSignerRoleData is used to pass necessary params to update an existing signer role
struct UpdateRoleOp
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

/******* ManageSignerRoleOp Result ********/

//: Result codes of ManageSignerRoleResultCode
enum UpdateRoleResultCode
{
    //: Means that the specified action in `data` of ManageSignerRoleOp was successfully executed
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: There is no signer role with such id or the source cannot manage a role
    NOT_FOUND = -1, // does not exist or owner mismatched
    //: Passed details have invalid json structure
    INVALID_DETAILS = -2,
    //: There is no rule with id passed through `ruleIDs`
    NO_SUCH_RULE = -3,
    //: It is not allowed to duplicate ids in `ruleIDs` array
    RULE_ID_DUPLICATION = -4,
    //: It is not allowed to pass ruleIDs that are more than maxSignerRuleCount (by default, 128)
    TOO_MANY_RULE_IDS = -5
};

//: Result of operation application
union UpdateRoleResult switch (UpdateRoleResultCode code)
{
case SUCCESS:
    EmptyExt ext;
case RULE_ID_DUPLICATION:
case NO_SUCH_RULE:
    //: ID of a rule that was either duplicated or is default or does not exist
    uint64 ruleID;
case TOO_MANY_RULE_IDS:
    //: max count of rule ids that can be passed in `ruleIDs` array
    uint32 maxRuleIDsCount;
default:
    void;
};

}
