

%#include "xdr/ledger-entries.h"

namespace stellar
{

/* ManageBalance

Threshold: med

Result: ManageBalanceResult

*/

//: Actions that can be performed on balances
enum ManageBalanceAction
{
    //: Create new balance
    CREATE = 0,
    //: Delete existing balance by ID. Is reserved and not implemented yet.
    DELETE_BALANCE = 1,
    //: Ensures that the balance will not be created if the balance of the provided asset exists and is attached to the provided account
    CREATE_UNIQUE = 2
};

//: `ManageBalanceOp` applies an `action` of the `ManageBalanceAction` type on the balance of a particular `asset` (referenced to by its AssetCode)
//: of the `destination` account (referenced to by its AccountID)
struct ManageBalanceOp
{
    //: Defines a ManageBalanceAction to be performed. `DELETE_BALANCE` is reserved and not implemented yet.
    ManageBalanceAction action;
    //: Defines an account whose balance will be managed
    AccountID destination;
    //: Defines an asset code of the balance to which `action` will be applied
    AssetCode asset;
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageBalance Result ********/

//: Result codes for the ManageBalance operation
enum ManageBalanceResultCode
{
    // codes considered as "success" for the operation
    //: Indicates that `ManageBalanceOp` is successfully applied
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: It is not allowed to delete a balance
    MALFORMED = -1,
    //: (deprecated)
    NOT_FOUND = -2,
    //: Cannot find an account provided by the `destination` AccountID
    DESTINATION_NOT_FOUND = -3,
    //: Cannot find an asset with a provided asset code
    ASSET_NOT_FOUND = -4,
    //: AssetCode `asset` is invalid (e.g. `AssetCode` does not consist of alphanumeric symbols)
    INVALID_ASSET = -5,
    //: Balance of the provided `asset` already exists and is owned by the `destination` account
    BALANCE_ALREADY_EXISTS = -6,
    //: version specified in the request is not supported yet
    VERSION_IS_NOT_SUPPORTED_YET = -7
};

// `ManageBalanceSuccess` represents the successful result of the `ManageBalanceOp`
struct ManageBalanceSuccess {
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
union ManageBalanceResult switch (ManageBalanceResultCode code)
{
case SUCCESS:
    ManageBalanceSuccess success;
default:
    void;
};

}
