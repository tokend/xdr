%#include "xdr/Stellar-types.h"

namespace stellar
{

union SignerRuleResource switch (LedgerEntryType type)
{
case REVIEWABLE_REQUEST:
    struct
    {
        RequestTypedResource details;

        uint64 tasksToAdd;
        uint64 tasksToRemove;
        uint64 allTasks;

        EmptyExt ext;
    } reviewableRequest;
case ASSET:
    struct
    {
        AssetCode assetCode;
        uint64 assetType;

        EmptyExt ext;
    } asset;
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
case SIGNER_RULE:
    struct
    {
        bool isDefault;

        EmptyExt ext;
    } signerRule;
case SIGNER_ROLE:
    struct
    {
        uint64 roleID;

        EmptyExt ext;
    } signerRole;
case SIGNER:
    struct
    {
        uint64 roleID;

        EmptyExt ext;
    } signer;
default:
    EmptyExt ext;
};

}