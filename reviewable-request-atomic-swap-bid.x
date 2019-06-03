%#include "xdr/types.h"

namespace stellar
{

//: CreateAtomicSwapBidRequest is used to create atomic swap bid request with passed fields
struct CreateAtomicSwapBidRequest
{
    //: ID of existing bid
    uint64 askID;
    //: Amount in base asset to ask
    uint64 baseAmount;
    //: Code of asset which will be used to ask base asset
    AssetCode quoteAsset;
    //: Arbitrary stringified json object provided by a requester
    longstring creatorDetails; // details set by requester

    //: reserved for the future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

}