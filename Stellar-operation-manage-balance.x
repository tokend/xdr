

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* ManageBalance

Threshold: med

Result: ManageBalanceResult

*/

//: Actions could be applied to the balance
enum ManageBalanceAction
{
    //: Create new balance
    CREATE = 0,
    //: Delete existing balance by ID
    DELETE_BALANCE = 1,
    //: Ensure that balance will not be created if one for such asset and account exists
	CREATE_UNIQUE = 2
};

//: `ManageBalanceOp` applies `action` of type `ManageBalanceAction` to the `destination` account (referenced by its AccountID) to the balance of the specific `asset` (referenced by its AssetCode)
struct ManageBalanceOp
{
    //: Defines a ManageBalanceAction action to apply it
    ManageBalanceAction action;
    //: Defines the account `action` would be applied to
    AccountID destination;
    //: Defines the asset of the balance to which `action` would be applied
    AssetCode asset;
	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageBalance Result ********/

//: Result codes for ManageBalance operation
enum ManageBalanceResultCode
{
    // codes considered as "success" for the operation
    //: Indicates that `ManageBalanceOp` successfully applied
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: Invalid input (e.g. invalid `destination`)
    MALFORMED = -1,
    //: (deprecated)
    NOT_FOUND = -2,
    //: Cannot find account defined by `destination` AccountID
    DESTINATION_NOT_FOUND = -3,
    //: Cannot find asset by `asset` set in operation
    ASSET_NOT_FOUND = -4,
    //: AssetCode `asset` is invalid (e.g. `AssetCode` which not consists of alphanumeric symbols or zeros in `AssetCode` are not trailing)
    INVALID_ASSET = -5,
    //: Balance of the provided `asset` already exists and owned by `destination` account
	BALANCE_ALREADY_EXISTS = -6,
	//: version specified in request is not supported yet
	VERSION_IS_NOT_SUPPORTED_YET = -7
};

// `ManageBalanceSuccess` represents the successful result of the `ManageBalanceOp`
struct ManageBalanceSuccess {
    //: ID of the balance which was managed
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
