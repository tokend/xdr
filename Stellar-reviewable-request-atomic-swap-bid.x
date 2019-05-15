%#include "xdr/Stellar-types.h"
%#include "xdr/Stellar-ledger-entries-atomic-swap-bid.h"

namespace stellar
{

struct AtomicSwapBidCreationRequest
{
    BalanceID baseBalance;
    uint64 amount;
    longstring creatorDetails; // details set by requester

    AtomicSwapBidQuoteAsset quoteAssets<>;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

}