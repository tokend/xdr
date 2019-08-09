%#include "xdr/types.h"
%#include "xdr/resource-account-rule.h"

namespace stellar
{

//: Describes properties of some entries that can be used to restrict the usage of entries
union SignerRuleResource switch (LedgerEntryType type)
{
case ANY:
    void;
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
case DATA:
    struct 
    {
        uint64 type;
        EmptyExt ext;
    } data;
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
    CREATE_FOR_OTHER_WITH_TASKS = 18
};


}
