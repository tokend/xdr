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
    //: Not enough locked funds on the provided balance
    UNDERFUNDED = -1,
    //: There is no lock entry with ID provided in `lockID`
    LOCK_NOT_FOUND = -2,
    //: Amount should be greater than zero and less than amount provided in the lock entry
    INVALID_AMOUNT = -3,
    //: Amount precision and asset precision are mismatched
    INCORRECT_AMOUNT_PRECISION = -4,
    //: After the unlock fulfillment, the destination balance will exceed the limit (total amount on the balance will be greater than UINT64_MAX)
    LINE_FULL = -5,
    //: Amount of locked entry is less than amount to unlock
    LOCK_UNDERFUNDED = -6
};

enum UnlockEffect
{
    UNLOCKED = 0,
    //: Lock fulfilled, i.e. all funds locked by a particular lock entry were unlocked and lock entry can be deleted
    LOCK_FULFILLED = 1
};

struct UnlockSuccess
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
    //: `entry`, performing actions on which, operation failure has occurred
    LedgerEntryType problemEntryType;
};

}