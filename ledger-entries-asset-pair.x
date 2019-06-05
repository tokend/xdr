

%#include "xdr/types.h"

namespace stellar
{

//: Policies that could be applied to AssetPair entry and define applicable operations for AssetPair
enum AssetPairPolicy
{
    //: If not set pair can not be traded on secondary market
	TRADEABLE_SECONDARY_MARKET = 1,
	//: If set, then prices for new offers must be greater then physical price with correction
	PHYSICAL_PRICE_RESTRICTION = 2,
	//: if set, then price for new offers must be in interval of (1 ± maxPriceStep)*currentPrice
	CURRENT_PRICE_RESTRICTION = 4
};

//: `AssetPairEntry` is used in system to group different assets into pairs and set particular policies and properties for them
struct AssetPairEntry
{
    //: Code of base asset of the asset pair
    AssetCode base;
    //: Code of quote asset of the asset pair
    AssetCode quote;

    //: defines an asset pair price as quote asset divided by base asset (i.e., amount of quote asset per 1 base asset)
    int64 currentPrice;
    //: Price of the asset pair assigned on creation. Can only be updated by application
    //: the `ManageAssetPair` operation with action `UPDATE_PRICE`
    int64 physicalPrice;

    //: Price of the asset pair assigned on creation. Can only be updated by application
    //: the `ManageAssetPair` operation with action `UPDATE_PRICE`
    int64 physicalPriceCorrection;

    //: Max price step in percent. User is allowed to set offer only if both of
    //: `price < (1 - maxPriceStep) * currentPrice` and `price > (1 + maxPriceStep) * currentPrice` are `true`
    int64 maxPriceStep;

    //: Bitmask of asset policies set by creator or corrected by `ManageAssetPair` operations
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
