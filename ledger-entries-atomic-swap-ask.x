%#include "xdr/types.h"

namespace stellar
{

//: AtomicSwapAskQuoteAsset represents asset with price which can be used to buy base asset
struct AtomicSwapAskQuoteAsset
{
    //: Code of quote asset
    AssetCode quoteAsset;
    //: amount of quote asset which is needed to buy one base asset
    uint64 price;
    //: reserved for the future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct AtomicSwapAskEntry
{
    uint64 id;
    AccountID ownerID;
    AssetCode baseAsset;
    BalanceID baseBalance;
    uint64 amount;
    uint64 lockedAmount;
    uint64 createdAt;

    bool isCancelled;

    longstring details;

    AtomicSwapAskQuoteAsset quoteAssets<>;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}