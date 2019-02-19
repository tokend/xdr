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

enum SignerRuleAction
{
    ANY = 1,
    CREATE = 2,
    MANAGE = 3,
    SEND = 4,
    WITHDRAW = 5,
    ISSUE = 6,
    REVIEW = 7,
    RECEIVE_ATOMIC_SWAP = 8,
    CREATE_TO_SELL = 9,
    CREATE_TO_BUY = 10,
    PARTICIPATE = 11,
    BIND = 12,
    UPDATE_MAX_ISSUANCE = 13,
    CHECK = 14,
     UPDATE = 15,
    CREATE_FOR_OTHER = 16,
    CANCEL = 17,
    REMOVE = 18
};


}