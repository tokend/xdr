%#include "xdr/types.h"

namespace stellar
{

/* RemoveAssetOp

    Removes existing asset pair

    Result: `RemoveAssetResult`
*/
//: `RemoveAssetOp` changes the state of specified asset to removed 
struct RemoveAssetOp
{
    //: Defines an asset
    AssetCode code;
    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result codes for `RemoveAssetOp`
enum RemoveAssetResultCode
{
    //: Operation is successfully applied
    SUCCESS = 0,
    //: Asset code is invalid
    INVALID_ASSET_CODE = -1,
    //: Asset can't be deleted as there exist asset pairs with it
    HAS_PAIR = -2,
    //: Asset can't be deleted as it has active offers
    HAS_ACTIVE_OFFERS = -3,
    //: Asset can't be deleted as it has active sales
    HAS_ACTIVE_SALES = -4,
    //: Asset can't be deleted as it has active atomic swaps
    HAS_ACTIVE_ATOMIC_SWAPS = -5,
    //: Asset can't be deleted as it has active swaps
    HAS_ACTIVE_SWAPS = -6,
    //: Asset can't be deleted as it is stats quote asset
    CANNOT_REMOVE_STATS_QUOTE_ASSET = -7,
    //: Cannot delete asset, as some balances in target asset have non-empty locked amount
    HAS_PENDING_MOVEMENTS = -8
};

//: Result of successful `RemoveAssetOp` application
struct RemoveAssetSuccess
{
    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result of RemoveAsset operation application along with the result code
union RemoveAssetResult switch (RemoveAssetResultCode code) {
    case SUCCESS:
        RemoveAssetSuccess success;
    default:
        void;
};

}
