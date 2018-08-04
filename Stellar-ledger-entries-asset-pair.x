// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-types.h"

namespace stellar
{


enum AssetPairPolicy
{
	TRADEABLE_SECONDARY_MARKET = 1, // if not set pair can not be traided on secondary market
	PHYSICAL_PRICE_RESTRICTION = 2, // if set, then prices for new offers must be greater then physical price with correction
	CURRENT_PRICE_RESTRICTION = 4 // if set, then price for new offers must be in interval of (1 +- maxPriceStep)*currentPrice
};

struct AssetPairEntry
{
    AssetCode base;
	AssetCode quote;

    int64 currentPrice;
    int64 physicalPrice;

	int64 physicalPriceCorrection; // correction of physical price in percents. If physical price is set and restriction by physical price set, mininal price for offer for this pair will be physicalPrice * physicalPriceCorrection
	int64 maxPriceStep; // max price step in percent. User is allowed to set offer with price < (1 - maxPriceStep)*currentPrice and > (1 + maxPriceStep)*currentPrice


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
