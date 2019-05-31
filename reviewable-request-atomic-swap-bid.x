%#include "xdr/types.h"
%#include "xdr/ledger-entries-atomic-swap-bid.h"

namespace stellar
{

struct ASwapBidCreationRequest
{
    BalanceID baseBalance;
    uint64 amount;
    longstring creatorDetails; // details set by requester

    ASwapBidQuoteAsset quoteAssets<>;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

}