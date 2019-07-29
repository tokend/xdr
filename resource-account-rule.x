%#include "xdr/ledger-keys.h"
%#include "xdr/ledger-entries-reviewable-request.h"

namespace stellar
{

//: Describes properties of some reviewable request types that
//: can be used to restrict the usage of reviewable requests
union ReviewableRequestResource switch (ReviewableRequestType requestType)
{
default:
    EmptyExt ext;
};

//: Describes properties of some entries that can be used to restrict the usage of entries
union AccountRuleResource switch (LedgerEntryType type)
{
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
case KEY_VALUE:
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
