%#include "xdr/Stellar-types.h"

namespace stellar
{

struct AtomicSwapBidEntry
{
    uint64 bidID;
    AccountID ownerID;
    AssetCode baseAsset; // A
    AssetCode quoteAsset; // B
    BalanceID baseBalance;
    uint64 baseAmount;
    uint64 createdAt;

    uint64 fee;
    uint64 percentFee;

    // price of A in terms of B
    uint64 price;

    longstring details;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}