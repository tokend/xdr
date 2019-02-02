%#include "xdr/Stellar-types.h"


namespace stellar
{

union RequestTypedResource switch (ReviewableRequestType requestType)
{
case SALE:
    struct
    {
        uint64 type;

        EmptyExt ext;
    } sale;
default:
    EmptyExt ext;
};

union AccountRuleResource switch (LedgerEntryType type)
{
case TRANSACTION:
    void;
case ASSET:
    struct
    {
        AssetCode assetCode;
        uint64 assetType;

        EmptyExt ext;
    } asset;
case REVIEWABLE_REQUEST:
    struct
    {
        RequestTypedResource details;

        EmptyExt ext;
    } reviewableRequest;
case ANY:
    void;
case OFFER_ENTRY:
    struct
    {
        uint64 baseAssetType;
        uint64 quoteAssetType;

        AssetCode baseAssetCode;
        AssetCode quoteAssetCode;

        EmptyExt ext;
    } offer;
case SALE:
    struct
    {
        uint64 saleID;
        uint64 saleType;

        EmptyExt ext;
    } sale;
case ATOMIC_SWAP_BID:
    struct
    {
        uint64 assetType;
        AssetCode assetCode;

        EmptyExt ext;
    } atomicSwapBid;
default:
    EmptyExt ext;
};

}