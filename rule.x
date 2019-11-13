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

        uint32 securityType;

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
        uint32 securityType;

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
        uint64 roleIDs<>;

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
case DATA:
    struct
    {
        uint32 securityType;
        EmptyExt ext;
    } data;
default:
    //: reserved for future extension
    EmptyExt ext;
};

//: Actions that can be applied to a signer rule resource
enum RuleActionType
{
    ANY = 1,
    CREATE = 2,
    CREATE_FOR_OTHER = 3,
    UPDATE = 4,
    ISSUE = 5,
    SEND = 6,
    REMOVE = 7,
    DESTROY = 8,
    REVIEW = 9,
    CHANGE_ROLES = 10,
    INITIATE_RECOVERY = 11,
    RECOVER = 12,
    UPDATE_MAX_ISSUANCE = 13,
    DESTROY_FOR_OTHER = 14,
    CREATE_WITH_TASKS = 17,
    CREATE_FOR_OTHER_WITH_TASKS = 18,
    RECEIVE = 19,
    RECEIVE_ISSUANCE = 20
};

union RuleAction switch (RuleActionType type) 
{
case ISSUE:
    struct {
        uint32 securityType;

        EmptyExt ext;
    } issue;
case DESTROY:
    struct {
        uint32 securityType;

        EmptyExt ext;
    } destroy;
case SEND:
    struct {
        uint32 securityType;

        EmptyExt ext;
    } send;
case RECEIVE:
    struct {
        uint32 securityType;

        EmptyExt ext;
    } receive;
case RECEIVE_ISSUANCE:
    struct {
        uint32 securityType;

        EmptyExt ext;
    } receiveIssuance;
case CHANGE_ROLES:
    struct {
        uint64 roleIDs<>; // if roleIDsToSet (from operation body) the same, action will triggered

        EmptyExt ext;
    } changeRoles;
case INITIATE_RECOVERY:
    struct {
        uint64 roleIDs<>;

        EmptyExt ext;
    } initiateRecovery;
case DESTROY_FOR_OTHER:
    struct {
        uint32 securityType;

        EmptyExt ext;
    } destroyForOther;
default:
    EmptyExt ext;
};

struct ReviewableRequestOperationRule 
{
    RuleResource resource;

    RuleAction action;

    EmptyExt ext;
};

}
