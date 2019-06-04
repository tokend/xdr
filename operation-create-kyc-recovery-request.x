%#include "xdr/operation-manage-signer.h"


namespace stellar
{

//: CreateKYCRecoveryRequestOp to create KYC recovery request and set new signers for account
struct CreateKYCRecoveryRequestOp
{
    //: ID of a reviewable request. If set 0, request is created, else - request is updated
    uint64 requestID;
    //: Account for which signers will be set
    AccountID targetAccount;
    //: New signers to set
    UpdateSignerData signersData<>;

     //: Arbitrary stringified json object that can be used to attach data to be reviewed by an admin
    longstring creatorDetails; // details set by requester

    //: (optional) Bit mask whose flags must be cleared in order for KYC recovery request to be approved, which will be used by key `create_kyc_recovery_tasks`
    //: instead of key-value
    uint32* allTasks;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: Result codes of CreateKYCRecoveryRequestOp
enum CreateKYCRecoveryRequestResultCode
{
    //: KYC Recovery request was successfully created
    SUCCESS = 0,

    //: Creator details are not in a valid JSON format
    INVALID_CREATOR_DETAILS = -1,
    //: KYC recovery tasks are not set in the system
    KYC_RECOVERY_TASKS_NOT_FOUND = -2,
    //: Not allowed to provide empty slice of signers
    NO_SIGNER_DATA = -3,
    //: SignerData contains duplicates
    SIGNER_DUPLICATION = -4,
    //: Signer has weight > threshold
    INVALID_WEIGHT = -5,
    //: Signer has invalid details
    INVALID_DETAILS = -6,
    //: Request with provided parameters already exists
    REQUEST_ALREADY_EXISTS = -7,
    //: Account with provided account address does not exist
    TARGET_ACCOUNT_NOT_FOUND = -8,
    //: System configuration forbids KYC recovery
    RECOVERY_NOT_ALLOWED = -10,
    //: Only target account can update request
    NOT_ALLOWED_TO_UPDATE_REQUEST = -11,
    //: There is no request with such ID
    REQUEST_NOT_FOUND = -12,
    //: It is forbidden to change target account on update
    INVALID_UPDATE_DATA = -13,
    //: It is forbidden to set `allTasks` on update
    NOT_ALLOWED_TO_SET_TASKS_ON_UPDATE = -14
};

//: Result of operation applying
union CreateKYCRecoveryRequestResult switch (CreateKYCRecoveryRequestResultCode code)
{
case SUCCESS:
    //: Is used to pass useful params if operation is success
    struct {
        //: id of the created request
        uint64 requestID;

        //: Indicates whether or not the KYC Recovery request was auto approved and fulfilled
        bool fulfilled;

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
