%#include "xdr/types.h"
%#include "xdr/resource-account-rule.h"

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
case ATOMIC_SWAP_ASK:
    struct
    {
        uint64 assetType;
        AssetCode assetCode;

        EmptyExt ext;
    } atomicSwapAsk;
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
case POLL:
    struct
    {
        //: ID of the poll
        uint64 pollID;

        //: permission type of poll
        uint32 permissionType;

        //: reserved for future extension
        EmptyExt ext;
    } poll;
case VOTE:
    struct
    {
        //: ID of the poll
        uint64 pollID;

        //: permission type of poll
        uint32 permissionType;

        //: reserved for future extension
        EmptyExt ext;
    } vote;
case INITIATE_KYC_RECOVERY:
    struct
    {
        //: Role id
        uint64 roleID;

        //: reserved for future extension
        EmptyExt ext;
    } initiateKYCRecovery;
case ACCOUNT_SPECIFIC_RULE:
    //: reserved for future extension
    union switch(LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    case ADD_ACC_SPECIFIC_RULE_RESOURCE:
        struct
        {
            //: Describes properties of some ledger key that
            //: can be used to restrict the usage of account specific rules
            LedgerKey ledgerKey;

            //: reserved for future extension
            EmptyExt ext;
        } accountSpecificRule;
    } accountSpecificRuleExt;
case SWAP:
    struct
    {
        //: code of the asset
        AssetCode assetCode;
        //: type of the asset
        uint64 assetType;

        //: reserved for future extension
        EmptyExt ext;
    } swap;
case DATA:
    struct
    {
        //: Numeric type of the data
        uint64 type;
        //: Reserved for future extension
        EmptyExt ext;
    } data;
case CUSTOM:
    CustomRuleResource custom;
case LIQUIDITY_POOL:
    struct
    {
        //: Code of the first asset in LP pair
        AssetCode firstAsset;
        //: Type of the first asset in LP pair
        uint64 firstAssetType;

        //: Code of the second asset in LP pair
        AssetCode secondAsset;
        //: Type of the seconds asset in LP pair
        uint64 secondAssetType;

        //: Reserved for future extension
        EmptyExt ext;
    } liquidityPool;
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
    CHECK = 14,
    CLOSE = 15,
    UPDATE_END_TIME = 16,
    CREATE_WITH_TASKS = 17,
    CREATE_FOR_OTHER_WITH_TASKS = 18,
    REMOVE_FOR_OTHER = 19,
    EXCHANGE = 20,
    UPDATE_FOR_OTHER = 21,
    CUSTOM = 22,
    TRANSFER_OWNERSHIP = 23,
    LP_ADD_LIQUIDITY = 24,
    LP_REMOVE_LIQUIDITY = 25,
    LP_SWAP = 26
};


}
