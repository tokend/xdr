%#include "xdr/Stellar-types.h"

namespace stellar
{

union RequestTypedResource switch (ReviewableRequestType requestType)
{
case CREATE_SALE:
    struct
    {
        uint64 type;

        EmptyExt ext;
    } sale;
case CREATE_ISSUANCE:
    struct
    {
        AssetCode assetCode;
        uint64 assetType;

        EmptyExt ext;
    } issuance;
case CREATE_WITHDRAW:
    struct
    {
        AssetCode assetCode;
        uint64 assetType;

        EmptyExt ext;
    } withdraw;
default:
    EmptyExt ext;
};

union AccountRuleResource switch (LedgerEntryType type)
{
case TRANSACTION:
    EmptyExt tx;
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

        bool isBuy;

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

enum AccountRuleAction
{
    ANY = 1,
    CREATE = 2,
    CREATE_FOR_OTHER = 3,
    CREATE_WITH_TASKS = 4,
    MANAGE = 5,
    SEND = 6,
    WITHDRAW = 7,
    RECEIVE_ISSUANCE = 8,
    RECEIVE_PAYMENT = 9,
    RECEIVE_ATOMIC_SWAP = 10,
    PARTICIPATE = 11,
    BIND = 12,
    UPDATE_MAX_ISSUANCE = 13,
    CHECK = 14,
    CANCEL = 15
};

}