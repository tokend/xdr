

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

//: Actions could be performed on the asset pair
enum ManageAssetPairAction
{
    //: Create new asset pair
    CREATE = 0,
    //: Update price of the asset pair
    UPDATE_PRICE = 1,
    //: Update asset pair policies bitmask
    UPDATE_POLICIES = 2
};


/* ManageAssetPairOp

    Creates or updates asset pair

    Threshold: high

    Result: ManageAssetPairResult
*/
//: `ManageAssetPairOp` either creates new asset pairs or update prices or policies of existing asset pairs
struct ManageAssetPairOp
{
    //: Defines a ManageBalanceAction which would be performed on an asset pair
    ManageAssetPairAction action;
    //: Defines a base asset of the asset pair
    AssetCode base;
    //: Defines a base asset of the asset pair
    AssetCode quote;

    //: Price of the asset pair assigned on creation. Can only be updated by the `UPDATE_PRICE` `ManageAssetPair` operation
    int64 physicalPrice;

    //: Correction of physical price in percents. If physical price is set and restriction by physical price set, mininal price for offer for this pair will be physicalPrice * physicalPriceCorrection
    int64 physicalPriceCorrection;
    //: Maximal amount of price change in percents
    int64 maxPriceStep;

    //: Bitmask of asset policies set by creator or corrected by manage asset operations
    int32 policies;

     // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageAsset Result ********/

//: Result codes for ManageAssetPair operation
enum ManageAssetPairResultCode
{
    // codes considered as "success" for the operation
    //: Indicates that `ManageAssetPair` was successfully applied
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: Failed to find asset pair with given exactly `base` and `quote` not found
    NOT_FOUND = -1,
    //: Asset pair with given `base` and `quote` asset codes is already present in the system
    ALREADY_EXISTS = -2,
    //: Invalid input (e.g. physicalPrice < 0 or physicalPriceCorrection < 0 or maxPriceStep is not in interval [0..100])
    MALFORMED = -3,
    //: AssetCode `base` or `quote` (or both) is invalid (e.g. `AssetCode` which not consists of alphanumeric symbols or zeros in `AssetCode` are not trailing)
    INVALID_ASSET = -4,
    //: `action` is not in the set of valid actions (see `ManageAssetPairAction`)
    INVALID_ACTION = -5,
    //: Field `policies` is invalid (e.g. `policies < 0`)
    INVALID_POLICIES = -6,
    //: Asset with such code not found
    ASSET_NOT_FOUND = -7
};

//: `ManageAssetPairSuccess` represents the successful result of the `ManageAssetPairOp`
struct ManageAssetPairSuccess
{
    //: Price of the asset pair after the operation
    int64 currentPrice;
    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: `ManageAssetPairResult` defines the result of the `ManageBalanceOp` based on the given `ManageAssetPairResultCode`
union ManageAssetPairResult switch (ManageAssetPairResultCode code)
{
case SUCCESS:
    ManageAssetPairSuccess success;
default:
    void;
};

}
