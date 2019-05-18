%#include "xdr/Stellar-types.h"
%#include "xdr/Stellar-ledger-entries-atomic-swap-bid.h"

namespace stellar
{

//: CreateAtomicSwapBidRequest is used to create atomic swap bid entry with passed fields
struct CreateAtomicSwapBidRequest
{
    //: ID of balance with base asset
    BalanceID baseBalance;
    //: Amount to be sold through atomic swaps
    uint64 amount;
    //: Arbitrary stringified json object provided by a requester
    longstring creatorDetails; // details set by requester
    //: Array of assets with price which can be used to ask base asset
    AtomicSwapBidQuoteAsset quoteAssets<>;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

}