// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-types.h"

namespace stellar
{

struct SaleEntry
{
	uint64 saleID;
	AccountID ownerID;
    AssetCode baseAsset; // asset for which sale will be performed
	AssetCode quoteAsset; // asset in which participation will be accepted
	uint64 startTime; // start time of the sale
	uint64 endTime; // close time of the sale
	uint64 price; // price for 1 baseAsset in terms of quote asset
	uint64 softCap; // minimum amount of quote asset to be received at which sale will be considered a successful
	uint64 hardCap; // max amount of quote asset to be received
	longstring details; // sale specific details

	uint64 currentCap; // current capitalization

	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
