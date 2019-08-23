%#include "xdr/types.h"

namespace stellar
{

/* RemoveAssetOp

    Removes existing asset pair

    Result: `RemoveAssetResult`
*/
//: `RemoveAssetOp` removes specified asset pair
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
    //: Asset not found
    //: Asset can't be deleted as there exist asset pairs with it
    HAS_PAIR = -1,
    //: Asset can't be deleted as it has active offers
    HAS_ACTIVE_OFFERS = -2,
    //: Asset can't be deleted as it has active sales
    HAS_ACTIVE_SALES = -3
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
