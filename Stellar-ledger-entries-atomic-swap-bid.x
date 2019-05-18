%#include "xdr/Stellar-types.h"

namespace stellar
{

//: AtomicSwapBidQuoteAsset represents asset with price which can be used to buy base asset
struct AtomicSwapBidQuoteAsset
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

struct AtomicSwapBidEntry
{
    uint64 bidID;
    AccountID ownerID;
    AssetCode baseAsset;
    BalanceID baseBalance;
    uint64 amount;
    uint64 lockedAmount;
    uint64 createdAt;

    bool isCancelled;

    longstring details;

    AtomicSwapBidQuoteAsset quoteAssets<>;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}