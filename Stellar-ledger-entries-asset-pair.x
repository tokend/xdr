

%#include "xdr/Stellar-types.h"

namespace stellar
{

//: Policies that can be applied to an AssetPair entry; these policies define applicable operations for an asset pair.
enum AssetPairPolicy
{
    //: If not set, pair cannot be traded on the secondary market
	TRADEABLE_SECONDARY_MARKET = 1,
	//: If set, prices for new offers must be greater than the physical price with correction
	PHYSICAL_PRICE_RESTRICTION = 2,
	//: If set, prices for new offers must be in the interval of (1 ± maxPriceStep)*currentPrice
	CURRENT_PRICE_RESTRICTION = 4
};

//: `AssetPairEntry` is used in the system to group different assets into pairs and set particular policies and properties for them
struct AssetPairEntry
{
    //: Code of asset pair's base asset
    AssetCode base;
    //: Code of asset pair's quote asset
    AssetCode quote;

    //: defines the asset pair price as quote asset divided by base asset (i.e., amount of quote asset per 1 base asset)
    int64 currentPrice;
    //: Price of an asset pair assigned on the creation (can only be updated by application)
    //: `ManageAssetPair` operation with the `UPDATE_PRICE` action
    int64 physicalPrice;

    //: Price of an asset pair assigned on the creation (can only be updated by application)
    //: `ManageAssetPair` operation with the `UPDATE_PRICE` action
    int64 physicalPriceCorrection;

    //: Max price step in percent. A user is allowed to set an offer only if 
    //: `price < (1 - maxPriceStep) * currentPrice` and `price > (1 + maxPriceStep) * currentPrice` are `true`
    int64 maxPriceStep;

    //: Bitmask of asset policies set by the creator or corrected via `ManageAssetPair` operations
    int32 policies;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
