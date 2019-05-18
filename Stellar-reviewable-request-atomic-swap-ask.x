%#include "xdr/Stellar-types.h"

namespace stellar
{

//: CreateAtomicSwapAskRequest is used to atomic swap ask request with passed fields
struct CreateAtomicSwapAskRequest
{
    //: ID of existing bid
    uint64 bidID;
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