namespace stellar
{
//: CreateSignerRoleData is used to pass necessary params to create a new signer role
struct CreateRoleOp
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

//: Result codes of ManageSignerRoleResultCode
enum CreateRoleResultCode
{
    //: Means that the specified action in `data` of ManageSignerRoleOp was successfully executed
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: Passed details have invalid json structure
    INVALID_DETAILS = -1,
    //: There is no rule with id passed through `ruleIDs`
    NO_SUCH_RULE = -2,
    //: It is not allowed to duplicate ids in `ruleIDs` array
    RULE_ID_DUPLICATION = -3,
    //: It is not allowed to pass ruleIDs that are more than maxSignerRuleCount (by default, 128)
    TOO_MANY_RULE_IDS = -4
};

//: Result of operation application
union CreateRoleResult switch (CreateRoleResultCode code)
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