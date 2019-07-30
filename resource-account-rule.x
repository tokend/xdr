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
case CREATE_ATOMIC_SWAP_BID:
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
case CREATE_POLL:
    //: is used to restrict the creating of a `CREATE_POLL` reviewable request type
    struct
    {
        //: permission type of poll
        uint32 permissionType;

        //: reserved for future extension
        EmptyExt ext;
    } createPoll;
default:
    //: reserved for future extension
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
case ACCOUNT_SPECIFIC_RULE:
    struct
    {
        //: Describes properties of some ledger key that
        //: can be used to restrict the usage of account specific rules
        LedgerKey ledgerKey;

        //: reserved for future extension
        EmptyExt ext;
    } accountSpecificRule;
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
    CREATE_FOR_OTHER_WITH_TASKS = 19
};

}
