%#include "xdr/ledger-entries.h"

namespace stellar
{

struct UnlockOp
{
    //: id of the lock entry to unlock amount
    uint64 lockID;
    //: amount to unlock
    uint64 amount;

    //: reserved for future extension
    EmptyExt ext;
};

enum UnlockResultCode
{
    //: Unlock was successful 
    SUCCESS = 0,
    //: There is no lock entry with ID provided in `lockID`
    LOCK_NOT_FOUND = -1,
    //: Amount should be greater than zero and less than amount provided in the lock entry
    INVALID_AMOUNT = -2,
    //: Amount precision and asset precision are mismatched
    INCORRECT_AMOUNT_PRECISION = -3,
    //: After the unlock fulfillment, the destination balance will exceed the limit (total amount on the balance will be greater than UINT64_MAX)
    LINE_FULL = -4
};

enum UnlockEffect
{
    //: Lock fulfilled and lock entry can be deleted
    FULFILLED = 0
};

struct UnlockResult
{
    //: Effect of the Unlock operation
    UnlockEffect effect;

    EmptyExt ext;
};

//: UnlockResult is a result of Unlock operation application
union UnlockResult switch (UnlockResultCode code)
{
case SUCCESS:
    UnlockSuccess success;
default:
    void;
};

}