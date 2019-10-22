namespace stellar
{

struct CreateReviewableRequestOp
{
    union switch (OperationType type)
    {
    case CREATE_ACCOUNT:
        CreateAccountOp createAccount;
    case CREATE_RULE:
        CreateRuleOp createRule;
    } operation;

    EmptyExt ext;
};

}