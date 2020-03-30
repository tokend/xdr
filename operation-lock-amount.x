%#include "xdr/ledger-entries.h"

namespace stellar 
{

struct LockOp 
{
    //: ID of the balance to lock funds on
    BalanceID balanceID;
    //: Amount to lock on balance
    uint64 amount;
    longstring reference;
    longstring details;

    //: reserved for future extension
    EmptyExt ext;
};

enum LockResultCode
{
    //: Lock was successful
    SUCCESS = 0,

    //: Not enough funds on the provided balance
    UNDERFUNDED = -1,
    //: There is no balance found with ID provided in `balanceID`
    BALANCE_NOT_FOUND = -2,
    //: Amount precision and asset precision are mismatched
    INCORRECT_AMOUNT_PRECISION = -3,
    //: Zero amount is not allowed
    INVALID_AMOUNT = -4,
    //: Duplicated references are not allowed
    REFERENCE_DUPLICATION = -5,
    //: After the lock fulfillment, the balance's locked amount will exceed the limit (total locked amount on the balance will be greater than UINT64_MAX)
    LINE_FULL = -6,
    //: Details must be valid JSON
    INVALID_DETAILS = -7
};

// LockSuccess is used to pass saved lock ID
struct LockSuccess
{
    //: id of the created lock entry
    uint64 lockID;
    //: id of the operational account
    AccountID opAccountID;
    //: code of the operational asset
    AssetCode opAssetCode;
    //: reserved for future extension
    EmptyExt ext;
};

//: LockResult is a result of Lock operation application
union LockResult switch (LockResultCode code)
{
case SUCCESS:
    LockSuccess success;
default:
    void;
};

}