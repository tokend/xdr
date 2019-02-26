

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* CreateWithdrawalRequestOp

    Creates withdrawal request

    Threshold: high

    Result: CreateWithdrawalRequestResult
*/
//: CreateWitthdrawalRequest operation creates withdrawal request
struct CreateWithdrawalRequestOp
{
    //: Withdrawal request to create 
    WithdrawalRequest request;
    //: Tasks to set, optional, can be NULL
    uint32* allTasks;
    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;

};

/******* CreateWithdrawalRequest Result ********/
//: CreateWithdrawalRequest result codes
enum CreateWithdrawalRequestResultCode
{
    // codes considered as "success" for the operation
    //: CreateWithdrawalRequest operation successfully applied
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: Trying to create withdrawal with amount of 0
    INVALID_AMOUNT = -1,
    //: Creator details either are not valid JSON or it's size exceeds 4096 bytes
    INVALID_CREATOR_DETAILS = -2,
    //: Source balance to withdraw from not found 
    BALANCE_NOT_FOUND = -3, // balance not found
    //: Asset can not be withdrawn
    ASSET_IS_NOT_WITHDRAWABLE = -4,
    //: Deprecated
    CONVERSION_PRICE_IS_NOT_AVAILABLE = -5, // failed to find conversion price - conversion is not allowed
    //: Expected fee and calculated fee are mismatched
    FEE_MISMATCHED = -6,
    //: Deprecated
    CONVERSION_OVERFLOW = -7,
    //: Deprecated
    CONVERTED_AMOUNT_MISMATCHED = -8,
    //: Trying to lock balance, locked amount would exceed UINT64_MAX
    BALANCE_LOCK_OVERFLOW = -9,
    //: Insuffiecient balance to withdraw requested amount
    UNDERFUNDED = -10,
    //: Non zero universal amount
    INVALID_UNIVERSAL_AMOUNT = -11,
    //: Applying operation would overflow statistics
    STATS_OVERFLOW = -12,
    //: Applying operation would exceed limits set in the system
    LIMITS_EXCEEDED = -13,
    //: Deprecated
    INVALID_PRE_CONFIRMATION_DETAILS = -14, // it's not allowed to pass pre confirmation details
    //: Amount to withdraw does not exceed lower bound set in the system
    LOWER_BOUND_NOT_EXCEEDED = -15,
    //: Default withdrawal tasks are not set in the system 
    WITHDRAWAL_TASKS_NOT_FOUND = -16,
    //: Not allowed to set withdrawal tasks on request creation
    NOT_ALLOWED_TO_SET_WITHDRAWAL_TASKS = -17,
    //: Not allowed to set zero tasks
    WITHDRAWAL_ZERO_TASKS_NOT_ALLOWED = -18
};

//: Result of the successful withdrawal request creation
struct CreateWithdrawalSuccess {
    //: ID of the newly created WithdrawalRequest
    uint64 requestID;
    //: Boolean indication whether the withdrawal request was approved and applied on creation
    bool fulfilled;
    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result of applying CreateWithdrawalRequst operation along with result code
union CreateWithdrawalRequestResult switch (CreateWithdrawalRequestResultCode code)
{
    case SUCCESS:
        CreateWithdrawalSuccess success;
    default:
        void;
};

}

