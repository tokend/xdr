%#include "xdr/operation-manage-signer.h"


namespace stellar
{

//: KYCRecoveryOp to create KYC recovery request and set new signers for account
struct KYCRecoveryOp
{
    //: Account for which signers will be set
    AccountID targetAccount;
    //: New signers to set
    SignerData signersData<>;

     //: Arbitrary stringified json object that can be used to attach data to be reviewed by an admin
    longstring creatorDetails; // details set by requester

    EmptyExt ext;
};

//: Result codes of KYCRecoveryOp
enum KYCRecoveryResultCode
{
    //: KYC Recovery request was successfully created
    SUCCESS = 0,

    //: Creator details are not in a valid JSON format
    INVALID_CREATOR_DETAILS = -1,
    //: Not allowed to provide empty slice of signers
    NO_SIGNER_DATA = -2,
    //: SignerData contains duplicates
    SIGNER_DUPLICATION = -3,
    //: Signer has weight > threshold
    INVALID_WEIGHT = -4,
    //: Signer has invalid details
    INVALID_DETAILS = -5,
    //: Account with provided account address does not exist
    TARGET_ACCOUNT_NOT_FOUND = -9,
    //: System configuration forbids KYC recovery
    RECOVERY_NOT_ALLOWED = -10
};

//: Result of operation applying
union KYCRecoveryResult switch (KYCRecoveryResultCode code)
{
case SUCCESS:
    //: Is used to pass useful params if operation is success
    struct {
        //: reserved for future use
        EmptyExt ext;
    } success;
default:
    void;
};

}
