namespace stellar
{

struct SignerData
{
    //: Public key of a signer
    PublicKey publicKey;
    //: id of the role that will be attached to a signer
    uint64 roleIDs<>;

    //: weight that signer will have, threshold for all SignerRequirements equals 1000
    uint32 weight;
    //: If there are some signers with equal identity, only one signer will be chosen
    //: (either the one with the biggest weight or the one who was the first to satisfy a threshold)
    uint32 identity;

    //: Arbitrary stringified json object with details that will be attached to signer
    longstring details;

    //: reserved for future extension
    EmptyExt ext;
};

struct CreateSignerOp
{
    SignerData data;

    //: reserved for future extension
    EmptyExt ext;
};

enum CreateSignerResultCode
{
    SUCCESS = 0,

    //: Passed details have invalid json structure
    INVALID_DETAILS = -1, // invalid json details
    //: Signer with such public key is already attached to the source account
    ALREADY_EXISTS = -2, // signer already exist
    //: There is no role with such id
    NO_SUCH_ROLE = -3,
    //: It is not allowed to set weight more than 1000
    INVALID_WEIGHT = -4, // more than 1000
    NO_ROLE_IDS = -5,
    ROLE_ID_DUPLICATION = -6,
    TOO_MANY_ROLES = -7
};

union CreateSignerResult switch (CreateSignerResultCode code)
{
case SUCCESS:
    EmptyExt ext;
case NO_SUCH_ROLE:
case ROLE_ID_DUPLICATION:
    uint64 roleID;
case TOO_MANY_ROLES:
    uint32 maxRolesCount;
default:
    void;
};
}