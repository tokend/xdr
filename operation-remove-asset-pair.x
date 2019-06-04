%#include "xdr/types.h"

namespace stellar
{

/* RemoveAssetPairOp

    Removes existing asset pair

    Result: `RemoveAssetPairResult`
*/
//: `RemoveAssetPairOp` removes specified asset pair
struct RemoveAssetPairOp
{
    //: Defines a base asset of an asset pair
    AssetCode base;
    //: Defines a base asset of an asset pair
    AssetCode quote;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result codes for `RemoveAssetPairOp`
enum RemoveAssetPairResultCode
{
    //: Operation is successfully applied
    SUCCESS = 0,
    //: Asset pair not found
    NOT_FOUND = -1,
    //: Asset pair can't be deleted as it has active orders
    HAS_ACTIVE_OFFERS = -2,
    //: Asset pair can't be deleted as it has active sales
    HAS_ACTIVE_SALES = -3,
    //: Base or Quote asset is invalid
    INVALID_ASSET_CODE = -4
};

//: Result of successful `RemoveAssetPairOp` application
struct RemoveAssetPairSuccess
{
    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result of RemoveAssetPair operation application along with the result code
union RemoveAssetPairResult switch (RemoveAssetPairResultCode code) {
    case SUCCESS:
        RemoveAssetPairSuccess success;
    default:
        void;
};

}
