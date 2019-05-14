%#include "xdr/Stellar-operation-manage-signer.h"


namespace stellar
{

//: CreateAccountSpecificRuleData is used to pass necessary params to create a new account specific rule
struct CreateKYCRecoveryRequestOp
{
    uint64 requestID;

    AccountID targetAccount;

    UpdateSignerData signersData<>;

     //: Arbitrary stringified json object that can be used to attach data to be reviewed by an admin
    longstring creatorDetails; // details set by requester

    //: (optional) Bit mask whose flags must be cleared in order for PreIssuanceRequest to be approved, which will be used by key `preissuance_tasks`
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
    //: Means that specified action in `data` of ManageAccountSpecificRuleOp was successfully performed
    SUCCESS = 0,

    //: Creator details are not in a valid JSON format
    INVALID_CREATOR_DETAILS = -1,
    //: KYC recovery tasks are not set in the system
    KYC_RECOVERY_TASKS_NOT_FOUND = -2,
    //: Not allowed to set tasks
    NOT_ALLOWED_TO_SET_KYC_RECOVERY_TASKS = -3,
    //: Not allowed to provide empty slice
    INVALID_SIGNER_DATA = -4,
    //: Signer has weight > threshold
    INVALID_WEIGHT = -5,
    //: Signer has invalid details
    INVALID_DETAILS = -6,
    //: Request with provided parameters already exists
    REQUEST_ALREADY_EXISTS = -7,
    //
    TARGET_ACCOUNT_NOT_FOUND = -8,
    NOT_AUTHORIZED = -9,
        //:
    RECOVERY_NOT_ALLOWED = -10,
    //: Either, there is no entry by key `kyc_recovery_account_role`, or such role does not exists
    RECOVERY_ACCOUNT_ROLE_NOT_FOUND = -11,

    TARGET_ACCOUNT_NOT_IN_RECOVERY_ROLE = -12,

    NOT_ALLOWED_TO_UPDATE_REQUEST = -13,

    PENDING_REQUEST_UPDATE_NOT_ALLOWED = -14,

    REQUEST_DOES_NOT_EXIST = -15,

    INVALID_UPDATE_DATA = -16
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
