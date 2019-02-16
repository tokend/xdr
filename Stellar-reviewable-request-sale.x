

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

struct SaleCreationRequest
{
    uint64 saleType;
	AssetCode baseAsset; // asset for which sale will be performed
	AssetCode defaultQuoteAsset; // asset for soft and hard cap
	uint64 startTime; // start time of the sale
	uint64 endTime; // close time of the sale
	uint64 softCap; // minimum amount of quote asset to be received at which sale will be considered a successful
	uint64 hardCap; // max amount of quote asset to be received
    longstring creatorDetails; // details set by requester
    SaleTypeExt saleTypeExt;
    uint64 requiredBaseAssetForHardCap;

    uint32 sequenceNumber;
	SaleCreationRequestQuoteAsset quoteAssets<100>;

	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
	}
    ext;
};

}
