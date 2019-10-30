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
        ReviewableRequestOperationRule opRules<>;

        uint64 securityType;

        //: Bit mask of tasks that is allowed to add to reviewable request pending tasks
        uint64 tasksToAdd;
        //: Bit mask of tasks that is allowed to remove from reviewable request pending tasks
        uint64 tasksToRemove;

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

        EmptyExt ext;
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
    CHANGE_ROLES = 10,
    PARTICIPATE = 11,
    BIND = 12,
    UPDATE_MAX_ISSUANCE = 13,
    CHECK = 14,
    CLOSE = 15,
    UPDATE_END_TIME = 16,
    CREATE_WITH_TASKS = 17,
    CREATE_FOR_OTHER_WITH_TASKS = 18,
    RECEIVE = 19,
    PERFORM = 20
};

struct ReviewableRequestOperationRule 
{
    RuleResource resource;

    RuleAction action;

    EmptyExt ext;
};

}
