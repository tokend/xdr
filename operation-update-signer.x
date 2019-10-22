namespace stellar
{
struct UpdateSignerOp
{
    SignerData data;

    EmptyExt ext;
};

enum UpdateSignerResultCode
{
    //: Specified action in `data` of ManageSignerOp was successfully executed
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: Passed details have invalid json structure
    INVALID_DETAILS = -1, // invalid json details
    //: Signer with such public key is already attached to the source account
    ALREADY_EXISTS = -2, // signer already exist
    //: There is no role with such id
    NO_SUCH_ROLE = -3,
    //: It is not allowed to set weight more than 1000
    INVALID_WEIGHT = -4, // more than 1000
    //: Source account does not have a signer with the provided public key
    NOT_FOUND = -5 // there is no signer with such public key
};

union UpdateSignerResult switch (UpdateSignerResultCode code)
{
case SUCCESS:
    EmptyExt ext;
default:
    void;
};
}