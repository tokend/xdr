

%#include "xdr/ledger-entries.h"

namespace stellar
{

/* CreateWithdrawalRequestOp

    Creates withdrawal request

    Threshold: high

    Result: CreateWithdrawalRequestResult
*/
//: CreateWithdrawalRequest operation is used to create a reviewable request,
//: which, after reviewer's approval, will charge the specified amount from balance and send it to external wallet/account
struct CreateWithdrawalRequestOp
{
    //: Withdrawal request to create 
    WithdrawalRequest request;
    //: (optional) Bit mask whose flags must be cleared in order for WithdrawalRequest to be approved, which will be used by key withdrawal_tasks:<asset_code> 
    //: instead of key-value
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
//: CreateWithdrawalRequest operation result codes
enum CreateWithdrawalRequestResultCode
{
    // codes considered as "success" for the operation
    //: CreateWithdrawalRequest operation successfully applied
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: Trying to create a withdrawal with a 0 amount 
    INVALID_AMOUNT = -1,
    //: Creator details are not in a valid JSON format
    INVALID_CREATOR_DETAILS = -2,
    //: Source balance to withdraw from is not found 
    BALANCE_NOT_FOUND = -3, // balance not found
    //: Asset cannot be withdrawn because AssetPolicy::WITHDRAWABLE is not set
    ASSET_IS_NOT_WITHDRAWABLE = -4,
    //: Deprecated
    CONVERSION_PRICE_IS_NOT_AVAILABLE = -5, // failed to find conversion price - conversion is not allowed
    //: Expected fee and actual fee mismatch
    FEE_MISMATCHED = -6,
    //: Deprecated
    CONVERSION_OVERFLOW = -7,
    //: Deprecated
    CONVERTED_AMOUNT_MISMATCHED = -8,
    //: Trying to lock balance, locked amount would exceed UINT64_MAX
    BALANCE_LOCK_OVERFLOW = -9,
    //: Insufficient balance to withdraw the requested amount
    UNDERFUNDED = -10,
    //: Non zero universal amount
    INVALID_UNIVERSAL_AMOUNT = -11,
    //: Applying operation would overflow statistics
    STATS_OVERFLOW = -12,
    //: Applying operation would exceed limits set in the system
    LIMITS_EXCEEDED = -13,
    //: Deprecated
    INVALID_PRE_CONFIRMATION_DETAILS = -14, // it's not allowed to pass pre confirmation details
    //: Amount withdrawn is smaller than the minimal withdrawable amount set in the system
    LOWER_BOUND_NOT_EXCEEDED = -15,
    //: Withdrawal tasks are not set in the system, i.e. it's not allowed to perform withdraw operations
    WITHDRAWAL_TASKS_NOT_FOUND = -16,
    //: Not allowed to set withdrawal tasks on the request creation
    NOT_ALLOWED_TO_SET_WITHDRAWAL_TASKS = -17,
    //: Not allowed to set zero tasks
    WITHDRAWAL_ZERO_TASKS_NOT_ALLOWED = -18
};

//: Result of the successful withdrawal request creation
struct CreateWithdrawalSuccess {
    //: ID of a newly created WithdrawalRequest
    uint64 requestID;
    //: Indicates whether or not the withdrawal request was auto approved and fulfilled
    bool fulfilled;
    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result of applying CreateWithdrawalRequst operation along with the result code
union CreateWithdrawalRequestResult switch (CreateWithdrawalRequestResultCode code)
{
    case SUCCESS:
        CreateWithdrawalSuccess success;
    default:
        void;
};

}

