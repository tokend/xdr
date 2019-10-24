

%#include "xdr/ledger-entries.h"

namespace stellar
{

/* DestructionOp

    Creates withdrawal request

    Threshold: high

    Result: DestructionResult
*/
//: Destruction operation will charge the specified amount from balance
struct DestructionOp
{
    //: security type
    uint64 type;
    //: Balance to withdraw from
    BalanceID balance; // balance id from which withdrawal will be performed
    //: Amount to withdraw
    uint64 amount; // amount to be withdrawn
    //: Total fee to pay, contains fixed amount and calculated percent of the withdrawn amount
    Fee fee; // expected fee to be paid
    //: Arbitrary stringified json object that can be used to attach data to be reviewed by an admin
    longstring creatorDetails; // details set by requester

    //: Reserved for future use
    EmptyExt ext;
};

/******* Destruction Result ********/
//: Destruction operation result codes
enum DestructionResultCode
{
    // codes considered as "success" for the operation
    //: Destruction operation successfully applied
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
struct DestructionSuccess {
    EmptyExt ext;
};

//: Result of applying CreateWithdrawalRequst operation along with the result code
union DestructionResult switch (DestructionResultCode code)
{
    case SUCCESS:
        DestructionSuccess success;
    default:
        void;
};

}

