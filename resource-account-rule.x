%#include "xdr/ledger-keys.h"
%#include "xdr/ledger-entries-reviewable-request.h"

namespace stellar
{

//: Describes properties of some reviewable request types that
//: can be used to restrict the usage of reviewable requests
union ReviewableRequestResource switch (ReviewableRequestType requestType)
{
case CREATE_SALE:
    //: is used to restrict the usage of a reviewable request with create_sale type
    struct
    {
        //: type of sale
        uint64 type;

        //: reserved for future extension
        EmptyExt ext;
    } createSale;
case CREATE_ISSUANCE:
    //: is used to restrict the usage of a reviewable request with create_issuance type
    struct
    {
        //: code of asset
        AssetCode assetCode;
        //: type of asset
        uint64 assetType;

        //: reserved for future extension
        EmptyExt ext;
    } createIssuance;
case CREATE_WITHDRAW:
    //: is used to restrict the usage of a reviewable request with create_withdraw type
    struct
    {
        //: code of asset
        AssetCode assetCode;
        //: type of asset
        uint64 assetType;

        //: reserved for future extension
        EmptyExt ext;
    } createWithdraw;
case CREATE_ATOMIC_SWAP_ASK:
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    case ATOMIC_SWAP_RETURNING:
        //: is used to restrict the usage of a reviewable request with create_atomic_swap_ask type
        struct
        {
            //: code of asset
            AssetCode assetCode;
            //: type of asset
            uint64 assetType;

            //: reserved for future extension
            EmptyExt ext;
        } createAtomicSwapAsk;
    } createAtomicSwapAskExt;
case CREATE_ATOMIC_SWAP_BID:
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    case ATOMIC_SWAP_RETURNING:
        //: is used to restrict the usage of a reviewable request with create_atomic_swap_bid type
        struct
        {
            //: code of asset
            AssetCode assetCode;
            //: type of asset
            uint64 assetType;

            //: reserved for future extension
            EmptyExt ext;
        } createAtomicSwapBid;
    } createAtomicSwapBidExt;
case CREATE_POLL:
    //: is used to restrict the creating of a `CREATE_POLL` reviewable request type
    struct
    {
        //: permission type of poll
        uint32 permissionType;

        //: reserved for future extension
        EmptyExt ext;
    } createPoll;
case MANAGE_OFFER:
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
        //: 0 means creation,
        //: 1 means removing,
        //: 2 means participate in sale,
        //: 3 means remove participation in sale,
        //: UINT32_MAX means any action.
        uint32 manageAction;

        //: ID of the order book.
        uint64 orderBookID;

        //: reserved for future extension
        EmptyExt ext;
    } manageOffer;
case CREATE_PAYMENT:
    struct
    {
        //: Code of asset in which payment is being made
        AssetCode assetCode;
        //: Type of asset in which payment is being made
        uint64 assetType;

        //: reserved for future extension
        EmptyExt ext;
    } createPayment;
case PERFORM_REDEMPTION:
    struct
    {
        //: Code of asset in which redemption is being made
        AssetCode assetCode;
        //: Type of asset in which redemption is being made
        uint64 assetType;

        //: reserved for future extension
        EmptyExt ext;
    } performRedemption;
case DATA_CREATION:
    struct
    {
        //: Numeric type of the data
        uint64 type;
        //: Reserved for future extension
        EmptyExt ext;
    } dataCreation;
case DATA_UPDATE:
    struct
    {
        //: Numeric type of the data
        uint64 type;
        //: Reserved for future extension
        EmptyExt ext;
    } dataUpdate;
case DATA_REMOVE:
    struct
    {
        //: Numeric type of the data
        uint64 type;
        //: Reserved for future extension
        EmptyExt ext;
    } dataRemove;
case CREATE_DEFERRED_PAYMENT:
    struct
    {
        AssetCode assetCode;

        uint64 assetType;
        EmptyExt ext;
    } createDeferredPayment;
case CLOSE_DEFERRED_PAYMENT:
    struct
    {
        AssetCode assetCode;

        uint64 assetType;
        EmptyExt ext;
    } closeDeferredPayment;
default:
    //: reserved for future extension
    EmptyExt ext;
};

//: Describes custom rule resource that can be used outside of the Core for flexible access control
struct CustomRuleResource {
    //: Action attributes
    longstring *action;
    //: Resource attributes
    longstring resource;

    EmptyExt ext;
};


//: Describes properties of some entries that can be used to restrict the usage of entries
union AccountRuleResource switch (LedgerEntryType type)
{
case ASSET:
    //: Describes properties that are equal to managed asset entry fields
    struct
    {
        AssetCode assetCode;
        uint64 assetType;

        EmptyExt ext;
    } asset;
case REVIEWABLE_REQUEST:
    //: Describes properties that are equal to managed reviewable request entry fields
    struct
    {
        //: Describes properties of some reviewable request types that
        //: can be used to restrict the usage of reviewable requests
        ReviewableRequestResource details;

        //: reserved for future extension
        EmptyExt ext;
    } reviewableRequest;
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

        //: reserved for future extension
        EmptyExt ext;
    } offer;
case SALE:
    //: Describes properties that are equal to managed offer entry fields
    struct
    {
        uint64 saleID;
        uint64 saleType;

        //: reserved for future extension
        EmptyExt ext;
    } sale;
case ATOMIC_SWAP_ASK:
    struct
    {
        uint64 assetType;
        AssetCode assetCode;

        EmptyExt ext;
    } atomicSwapAsk;
case KEY_VALUE:
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
        //: type of asset
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
default:
    //: reserved for future extension
    EmptyExt ext;
};

//: Actions that can be applied to account rule resource
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
    CANCEL = 15,
    CLOSE = 16,
    REMOVE = 17,
    UPDATE_END_TIME = 18,
    CREATE_FOR_OTHER_WITH_TASKS = 19,
    REMOVE_FOR_OTHER = 20,
    EXCHANGE = 21,
    RECEIVE_REDEMPTION = 22,
    UPDATE = 23,
    UPDATE_FOR_OTHER = 24,
    CUSTOM = 25
};

}
