%#include "xdr/types.h"
%#include "xdr/ledger-entries-atomic-swap-ask.h"

namespace stellar
{

//: CreateAtomicSwapAskRequest is used to create atomic swap ask entry with passed fields
struct CreateAtomicSwapAskRequest
{
    //: ID of balance with base asset
    BalanceID baseBalance;
    //: Amount to be sold through atomic swaps
    uint64 amount;
    //: Arbitrary stringified json object provided by a requester
    longstring creatorDetails; // details set by requester
    //: Array of assets with price which can be used to ask base asset
    AtomicSwapAskQuoteAsset quoteAssets<>;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

}