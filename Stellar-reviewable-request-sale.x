// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-types.h"
%#include "xdr/Stellar-ledger-entries-sale.h"

namespace stellar
{

struct SaleCreationRequestQuoteAsset {
	AssetCode quoteAsset; // asset in which participation will be accepted
	uint64 price; // price for 1 baseAsset in terms of quote asset
	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct SaleCreationRequest {
	AssetCode baseAsset; // asset for which sale will be performed
	AssetCode defaultQuoteAsset; // asset for soft and hard cap
	uint64 startTime; // start time of the sale
	uint64 endTime; // close time of the sale
	uint64 softCap; // minimum amount of quote asset to be received at which sale will be considered a successful
	uint64 hardCap; // max amount of quote asset to be received
	longstring details; // sale specific details

	SaleCreationRequestQuoteAsset quoteAssets<100>;

	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
	case TYPED_SALE:
		SaleTypeExt saleTypeExt;
    case ALLOW_TO_SPECIFY_REQUIRED_BASE_ASSET_AMOUNT_FOR_HARD_CAP:
        struct {
            SaleTypeExt saleTypeExt;
            uint64 requiredBaseAssetForHardCap;
        } extV2;
    }
    ext;
};

}
