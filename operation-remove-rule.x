namespace stellar
{
//: RemoveSignerRuleData is used to pass necessary params to remove existing signer rule
struct RemoveRuleOp
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
//: Result codes of ManageSignerRuleOp
enum RemoveRuleResultCode
{
    //: Specified action in `data` of ManageSignerRuleOp was successfully executed
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: There is no signer rule with such id or source cannot manage the rule
    NOT_FOUND = -1, // does not exists or owner mismatched
    //: It is not allowed to remove the rule if it is attached to at least one role
    RULE_IS_USED = -2
};

//: Result of operation application
union RemoveRuleResult switch (RemoveRuleResultCode code)
{
case SUCCESS:
    EmptyExt ext;
case RULE_IS_USED:
    //: ids of roles which use a rule that cannot be removed
    uint64 roleIDs<>;
default:
    void;
};
}