

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
    uint32 securityType;
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
    //: Expected fee and actual fee mismatch
    FEE_MISMATCHED = -5,
    //: Trying to lock balance, locked amount would exceed UINT64_MAX
    BALANCE_LOCK_OVERFLOW = -6,
    //: Insufficient balance to withdraw the requested amount
    UNDERFUNDED = -7,
    //: Applying operation would overflow statistics
    STATS_OVERFLOW = -8,
    //: Applying operation would exceed limits set in the system
    LIMITS_EXCEEDED = -9,
    //: Amount withdrawn is smaller than the minimal withdrawable amount set in the system
    LOWER_BOUND_NOT_EXCEEDED = -10,
};

//: Result of the successful withdrawal request creation
struct DestructionSuccess {
    EmptyExt ext;
};

//: Result of applying Destruction operation along with the result code
union DestructionResult switch (DestructionResultCode code)
{
    case SUCCESS:
        DestructionSuccess success;
    default:
        void;
};

}

