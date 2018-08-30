// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-types.h"

namespace stellar
{

enum SaleState {
	NONE = 0, // default state
	VOTING = 1, // not allowed to invest
	PROMOTION = 2 // not allowed to invest, but allowed to change all the details
};

enum SaleType {
	BASIC_SALE = 1, // sale creator specifies price for each quote asset
	CROWD_FUNDING = 2, // sale creator does not specify price,
	                  // price is defined on sale close based on amount of base asset to be sold and amount of quote assets collected
    FIXED_PRICE=3
};

struct FixedPriceSale {
	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct CrowdFundingSale {
	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct BasicSale {
	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};


struct SaleTypeExt {
	union switch (SaleType saleType)
    {
	case BASIC_SALE:
		BasicSale basicSale;
    case CROWD_FUNDING:
        CrowdFundingSale crowdFundingSale;
    case FIXED_PRICE:
        FixedPriceSale fixedPriceSale;
    }
    typedSale;
};

struct StatableSaleExt {
	SaleTypeExt saleTypeExt;
	SaleState state;
};


struct SaleQuoteAsset {
	AssetCode quoteAsset; // asset in which participation will be accepted
	uint64 price; // price for 1 baseAsset in terms of quote asset
	BalanceID quoteBalance;
	uint64 currentCap; // current capitalization
	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct SaleEntry
{
	uint64 saleID;
	AccountID ownerID;
    AssetCode baseAsset; // asset for which sale will be performed
	uint64 startTime; // start time of the sale
	uint64 endTime; // close time of the sale
	AssetCode defaultQuoteAsset; // asset for soft and hard cap
	uint64 softCap; // minimum amount of quote asset to be received at which sale will be considered a successful
	uint64 hardCap; // max amount of quote asset to be received
	uint64 currentCapInBase;
	uint64 maxAmountToBeSold;
	longstring details; // sale specific details
	SaleQuoteAsset quoteAssets<100>;

	BalanceID baseBalance;

	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
	case TYPED_SALE:
		SaleTypeExt saleTypeExt;
	case STATABLE_SALES:
		StatableSaleExt statableSaleExt;
    }
    ext;
};

}
