namespace stellar
{
//: RemoveSignerRoleData is used to pass necessary params to remove existing signer role
struct RemoveRoleOp
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

//: Result codes of ManageSignerRoleResultCode
enum RemoveRoleResultCode
{
    //: Means that the specified action in `data` of ManageSignerRoleOp was successfully executed
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: There is no signer role with such id or the source cannot manage a role
    NOT_FOUND = -1, // does not exist or owner mismatched
    //: It is not allowed to remove role if it is attached to at least one singer
    ROLE_IS_USED = -2
};

//: Result of operation application
union RemoveRoleResult switch (RemoveRoleResultCode code)
{
case SUCCESS:
    EmptyExt ext;
default:
    void;
};
}