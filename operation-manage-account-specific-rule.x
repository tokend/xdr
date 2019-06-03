%#include "xdr/ledger-keys.h"

namespace stellar
{

//: Actions that can be performed with account specific rule
enum ManageAccountSpecificRuleAction
{
    CREATE = 0,
    REMOVE = 1
};

//: CreateAccountSpecificRuleData is used to pass necessary params to create a new account specific rule
struct CreateAccountSpecificRuleData
{
    //: ledgerKey is used to specify an entity with primary key that can be used through operations
    LedgerKey ledgerKey;
    //: Certain account for which rule is applied, null means rule is global
    AccountID* accountID;
    //: True if such rule is deniable, otherwise allows
    bool forbids;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: RemoveAccountSpecificRuleData is used to pass necessary params to remove existing account specific rule
struct RemoveAccountSpecificRuleData
{
    //: Identifier of existing account specific rule
    uint64 ruleID;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: ManageAccountSpecificRuleOp is used to create or remove account specific rule
struct ManageAccountSpecificRuleOp
{
    //: data is used to pass one of `ManageAccountSpecificRuleAction` with required params
    union switch (ManageAccountSpecificRuleAction action)
    {
    case CREATE:
        CreateAccountSpecificRuleData createData;
    case REMOVE:
        RemoveAccountSpecificRuleData removeData;
    } data;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result codes of ManageAccountSpecificRuleResult
enum ManageAccountSpecificRuleResultCode
{
    //: Means that specified action in `data` of ManageAccountSpecificRuleOp was successfully performed
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: There is no rule with such id
    NOT_FOUND = -1,
    //: There is no sale with such id
    SALE_NOT_FOUND = -2,
    //: Only entry (sale) owner or admin can perform such operation
    NOT_AUTHORIZED = -3,
    //: Not allowed to create duplicated rules
    ALREADY_EXISTS = -4,
    //: Not allowed to create rule with the same accountID and ledger key, but different forbids value
    REVERSED_ALREADY_EXISTS = -5,
    //: Not allowed to use such entry type in ledger key
    ENTRY_TYPE_NOT_SUPPORTED = -6,
    //: There is no account rule with such id
    ACCOUNT_NOT_FOUND = -7,
    //: Version of entry does not allow to add specific rules
    SPECIFIC_RULE_NOT_SUPPORTED = -8,
    //: Not allowed to remove global rule
    REMOVING_GLOBAL_RULE_FORBIDDEN = -9
};

//: Result of operation applying
union ManageAccountSpecificRuleResult switch (ManageAccountSpecificRuleResultCode code)
{
case SUCCESS:
    //: Is used to pass useful params if operation is success
    struct {
        //: id of the rule that was managed
        uint64 ruleID;

        //: reserved for future use
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    } success;
default:
    void;
};

}
