namespace stellar
{

struct ChangeAccountRolesOp
{
    AccountID destinationAccount;

    //: ID of account role that will be attached to `destinationAccount`
    uint64 rolesToSet<>;
    //: Arbitrary stringified json object that can be used to attach data to be reviewed by an admin
    longstring details;

    EmptyExt ext;
};

enum ChangeAccountRolesResultCode
{
    SUCCESS = 0,

    INVALID_DETAILS = -1,
    ACCOUNT_NOT_FOUND = -2,
    TOO_MANY_ROLES = -3,
    NO_SUCH_ROLE = -4,
    NO_ROLE_IDS = -5,
    ROLE_ID_DUPLICATION = -6
};

union ChangeAccountRolesResult switch (ChangeAccountRolesResultCode code)
{
case SUCCESS:
    EmptyExt ext;
case TOO_MANY_ROLES:
    uint32 maxRolesCount;
case NO_SUCH_ROLE:
case ROLE_ID_DUPLICATION:
    uint64 roleID;
default:
    void;
};

}