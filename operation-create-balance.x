

%#include "xdr/ledger-entries.h"

namespace stellar
{

//: `ManageBalanceOp` applies an `action` of the `ManageBalanceAction` type on the balance of a particular `asset` (referenced to by its AssetCode)
//: of the `destination` account (referenced to by its AccountID)
struct CreateBalanceOp
{
    //: Defines an account whose balance will be managed
    AccountID destination;
    //: Defines an asset code of the balance to which `action` will be applied
    AssetCode asset;

    bool additional;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageBalance Result ********/

//: Result codes for the ManageBalance operation
enum CreateBalanceResultCode
{
    // codes considered as "success" for the operation
    //: Indicates that `ManageBalanceOp` is successfully applied
    SUCCESS = 0,

    //: AssetCode `asset` is invalid (e.g. `AssetCode` does not consist of alphanumeric symbols)
    INVALID_ASSET = -1,
    //: Cannot find an asset with a provided asset code
    ASSET_NOT_FOUND = -2,
    //: Cannot find an account provided by the `destination` AccountID
    DESTINATION_NOT_FOUND = -3,
    ALREADY_EXISTS = -4
};

// `ManageBalanceSuccess` represents the successful result of the `ManageBalanceOp`
struct CreateBalanceSuccess {
    //: ID of the balance that was managed
    BalanceID balanceID;
    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

// `ManageBalanceResult` defines the result of the `ManageBalanceOp` based on the given `ManageBalanceResultCode`
union CreateBalanceResult switch (CreateBalanceResultCode code)
{
case SUCCESS:
    CreateBalanceSuccess success;
default:
    void;
};

}
