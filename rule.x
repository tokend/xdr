%#include "xdr/types.h"
%#include "xdr/resource-account-rule.h"

namespace stellar
{

//: Describes properties of some entries that can be used to restrict the usage of entries
union RuleResource switch (LedgerEntryType type)
{
case REVIEWABLE_REQUEST:
    //: Describes properties that are equal to managed reviewable request entry fields
    struct
    {
        //: Describes properties of some reviewable request types that
        //: can be used to restrict the usage of reviewable requests
        union switch (ReviewableRequestType requestType)
        {
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
        default:
            //: reserved for future extension
            EmptyExt ext;
        } details;

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
case ROLE:
    //: Describes properties that are equal to managed signer role entry fields
    struct
    {
        //: For signer role creating resource will be triggered if `roleID` equals `0`
        uint64 roleID;

        EmptyExt ext;
    } role;
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
case INITIATE_KYC_RECOVERY:
    struct
    {
        //: Role id
        uint64 roleID;

        //: reserved for future extension
        EmptyExt ext;
    } initiateKYCRecovery;
case PAYMENT:
    struct
    {
        //: asset code
        AssetCode assetCode;
        //: asset type
        uint64 assetType;
        //: payment type
        uint64 paymentType;

        //: reserved for future extension
        EmptyExt ext;
    } payment;
case ISSUANCE:
    struct
    {
        uint64 issuanceType;
        //: asset code
        AssetCode assetCode;
        //: asset type
        uint64 assetType;

        EmptyExt ext;
    } issuance;
case DESTRUCTION:
    struct
    {
        uint64 destructionType;
        //: asset code
        AssetCode assetCode;
        //: asset type
        uint64 assetType;

    } destruction;
default:
    //: reserved for future extension
    EmptyExt ext;
};

//: Actions that can be applied to a signer rule resource
enum RuleAction
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
    RECEIVE = 19
};


}
