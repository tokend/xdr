%#include "xdr/Stellar-types.h"
%#include "xdr/Stellar-ledger-entries-atomic-swap-bid.h"

namespace stellar
{

struct ASwapBidCreationRequest
{
    BalanceID baseBalance;
    uint64 amount;
    uint64 fee;
    longstring details;

    ASwapBidQuoteAsset quoteAssets<>;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

}