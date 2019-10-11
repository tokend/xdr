namespace stellar
{
//: CreateSignerRuleData is used to pass necessary params to create a new signer rule
struct CreateRuleOp
{
    //: Resource is used to specify an entity (for some, with properties) that can be managed through operations
    RuleResource resource;
    //: Value from enum that can be applied to `resource`
    RuleAction action;
    //: Indicate whether or not an `action` on the provided `resource` is prohibited
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

//: Result codes of ManageSignerRuleOp
enum CreateRuleResultCode
{
    //: Specified action in `data` of ManageSignerRuleOp was successfully executed
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: Passed details have invalid json structure
    INVALID_DETAILS = -1
};

//: Result of operation application
union CreateRuleResult switch (CreateRuleResultCode code)
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
default:
    void;
};
}