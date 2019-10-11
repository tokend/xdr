%#include "xdr/ledger-entries.h"
%#include "xdr/resource-signer-rule.h"

namespace stellar
{
//: UpdateSignerRuleData is used to pass necessary params to update an existing signer rule
struct UpdateRuleOp
{
    //: Identifier of an existing signer rule
    uint64 ruleID;
    //: Resource is used to specify entity (for some, with properties) that can be managed through operations
    RuleResource resource;
    //: Value from enum that can be applied to `resource`
    RuleAction action;
    //: True means that such rule will be automatically added to each new or updated signer role
    bool forbids;
    //: Arbitrary stringified json object with details that will be attached to a rule
    longstring details;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

/******* ManageSignerRuleOp Result ********/

//: Result codes of ManageSignerRuleOp
enum UpdateRuleResultCode
{
    //: Specified action in `data` of ManageSignerRuleOp was successfully executed
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: There is no signer rule with such id or source cannot manage the rule
    NOT_FOUND = -1, // does not exists or owner mismatched
    //: Passed details have invalid json structure
    INVALID_DETAILS = -2
};

//: Result of operation application
union UpdateRuleResult switch (UpdateRuleResultCode code)
{
case SUCCESS:
    EmptyExt ext;
default:
    void;
};
}
