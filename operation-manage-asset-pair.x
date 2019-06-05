

%#include "xdr/ledger-entries.h"

namespace stellar
{

//: Actions that can be performed on the asset pair
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
//: `ManageAssetPairOp` either creates new asset pairs or updates prices or policies of existing [asset pairs](#operation/assetPairResources)
struct ManageAssetPairOp
{
    //: Defines a ManageBalanceAction that will be performed on an asset pair
    ManageAssetPairAction action;
    //: Defines a base asset of an asset pair
    AssetCode base;
    //: Defines a base asset of an asset pair
    AssetCode quote;

    //: New physical price of the asset pair which would be set after successful `ManageAssetPairOp` application
    int64 physicalPrice;

    //: New correction of the asset pair physical price in percents
    int64 physicalPriceCorrection;
    //: New maximal price step of asset pair
    int64 maxPriceStep;

    //: Bitmask of asset policies set by the creator or corrected by manage asset operations
    int32 policies;

    //: reserved for future use
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
    //: Indicates that `ManageAssetPairOp` has been successfully applied
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: Failed to find an asset pair with given `base` and `quote` asset codes
    NOT_FOUND = -1,
    //: Asset pair with given `base` and `quote` asset codes is already present in the system
    ALREADY_EXISTS = -2,
    //: Invalid input (e.g. physicalPrice < 0 or physicalPriceCorrection < 0 or maxPriceStep is not in an interval [0..100])
    MALFORMED = -3,
    //: Either `base` or `quote`  asset code  (or both) is invalid 
    //: (e.g. asset code does not consist of alphanumeric symbols)
    INVALID_ASSET = -4,
    //: `action` is not in the set of valid actions (see `ManageAssetPairAction`)
    INVALID_ACTION = -5,
    //: `policies` field is invalid (`policies < 0`)
    INVALID_POLICIES = -6,
    //: Asset with such code is not found
    ASSET_NOT_FOUND = -7,
    //: Not allowed for base and quote asset to be the same
    SAME_ASSET = -8
};

//: `ManageAssetPairSuccess` represents a successful result of `ManageAssetPairOp`
struct ManageAssetPairSuccess
{
    //: Price of an asset pair after the operation
    int64 currentPrice;
    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: `ManageAssetPairResult` defines the result of `ManageBalanceOp` based on given `ManageAssetPairResultCode`
union ManageAssetPairResult switch (ManageAssetPairResultCode code)
{
case SUCCESS:
    ManageAssetPairSuccess success;
default:
    void;
};

}
