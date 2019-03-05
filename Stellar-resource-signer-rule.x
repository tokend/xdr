%#include "xdr/Stellar-types.h"

namespace stellar
{

//: Describes properties of some entries that can be used to restrict the usage of entries
union SignerRuleResource switch (LedgerEntryType type)
{
case REVIEWABLE_REQUEST:
    //: Describes properties that are equal to managed reviewable request entry fields
    struct
    {
        //: Describes properties of some reviewable request types that
        //: can be used to restrict the usage of reviewable requests
        ReviewableRequestResource details;

        //: Bit mask of tasks that is allowed to add to reviewable request pending tasks
        uint64 tasksToAdd;
        //: Bit mask of tasks that is allowed to remove from reviewable request pending tasks
        uint64 tasksToRemove;
        //: Bit mask of tasks that is allowed to use as reviewable request pending tasks
        uint64 allTasks;

        EmptyExt ext;
    } reviewableRequest;
case ASSET:
    //: Describes properties that are equal to managed asset entry fields
    struct
    {
        AssetCode assetCode;
        uint64 assetType;

        EmptyExt ext;
    } asset;
case ANY:
    void;
case OFFER_ENTRY:
    //: Describes properties that are equal to managed offer entry fields and their properties
    struct
    {
        //: type of base asset
        uint64 baseAssetType;
        //: type of quote asset
        uint64 quoteAssetType;

        //: code of base asset
        AssetCode baseAssetCode;
        //: code of quote asset
        AssetCode quoteAssetCode;

        bool isBuy;

        EmptyExt ext;
    } offer;
case SALE:
    //: Describes properties that are equal to managed offer entry fields
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
    //: Describes properties that are equal to managed signer rule entry fields
    struct
    {
        bool isDefault;

        EmptyExt ext;
    } signerRule;
case SIGNER_ROLE:
    //: Describes properties that are equal to managed signer role entry fields
    struct
    {
        //: For signer role creating resource will be triggered if `roleID` equals `0`
        uint64 roleID;

        EmptyExt ext;
    } signerRole;
case SIGNER:
    //: Describes properties that are equal to managed signer entry fields
    struct
    {
        uint64 roleID;

        EmptyExt ext;
    } signer;
case KEY_VALUE:
    //: Describes properties that are equal to managed key value entry fields
    struct
    {
        //: prefix of key
        longstring keyPrefix;

        //: reserved for future extension
        EmptyExt ext;
    } keyValue;
default:
    //: reserved for future extension
    EmptyExt ext;
};

//: Actions that can be applied to a signer rule resource
enum SignerRuleAction
{
    ANY = 1,
    CREATE = 2,
    CREATE_FOR_OTHER = 3,
    UPDATE = 4,
    MANAGE = 5,
    SEND = 6,
    REMOVE = 7,
    CANCEL = 8,
    REVIEW = 9,
    RECEIVE_ATOMIC_SWAP = 10,
    PARTICIPATE = 11,
    BIND = 12,
    UPDATE_MAX_ISSUANCE = 13,
    CHECK = 14
};


}