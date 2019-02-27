

%#include "xdr/Stellar-types.h"
%#include "xdr/Stellar-ledger-entries-sale.h"

namespace stellar
{
//: SaleCreationRequestQuoteAsset is a structure used to provide asset code - price pairs to SaleCreationRequest
struct SaleCreationRequestQuoteAsset {
    //: AssetCode of quote asset 
    AssetCode quoteAsset; // asset in which participation will be accepted
    //: Price of sale base asset in terms of quote
	  uint64 price; // price for 1 baseAsset in terms of quote asset
    //: Reserved for future use
	  union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};
//: SaleCreationRequest is used to create sale with provided parameters
struct SaleCreationRequest
{   
    //: Type of the sale
    //: 1: basic sale
    //: 2: crowdfunding sale
    //: 3: fixed price sale
    uint64 saleType;
    //: Asset code of asset to sell on sale
    AssetCode baseAsset; // asset for which sale will be performed
    //: Asset code of the asset used to calculcate soft cap and hard cap
	  AssetCode defaultQuoteAsset; // asset for soft and hard cap
    //: Time when sale should start
	  uint64 startTime; // start time of the sale
    //: Time when sale should end
	  uint64 endTime; // close time of the sale
    //: Minimal amount in default quote asset to be acquired on sale for it to be considered successful
	  uint64 softCap; // minimum amount of quote asset to be received at which sale will be considered a successful
    //: Maximal amount in default quote asset to be received during sale. On reaching hard cap, sale immediately closes.
	  uint64 hardCap; // max amount of quote asset to be received
    //: Arbitrary stringified JSON object that can be used to attach data to be reviewed by the admin
    longstring creatorDetails; // details set by requester
    //: Parameters specific to concrete sale type
    SaleTypeExt saleTypeExt;
    //: 
    uint64 requiredBaseAssetForHardCap;
    //: Used to keep track of rejected requests update. On each rejected SaleCreationRequest update, sequenceNumber increases
    uint32 sequenceNumber;
    //: Array of quote assets, in which pariticapation is possible
	  SaleCreationRequestQuoteAsset quoteAssets<100>;
    //: Reserved for future use
	  union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
	  }
    ext;
};

}
