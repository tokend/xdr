%#include "xdr/Stellar-ledger-keys.h"

namespace stellar
{

//: Actions that can be performed with account rule
enum ManageParticipationAccountRuleAction
{
    CREATE = 0,
    REMOVE = 1
};

//: CreateAccountRuleData is used to pass necessary params to create a new account rule
struct CreateParticipationAccountRuleData
{
    //: Resource is used to specify an entity (for some - with properties) that can be managed through operations
    LedgerKey ledgerKey;
    //: Value from enum that can be applied to `resource`
    AccountID* accountID;
    //: True if such `action` on such `resource` is prohibited, otherwise allows
    bool forbids;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: RemoveAccountRuleData is used to pass necessary params to remove existing account rule
struct RemoveParticipationAccountRuleData
{
    //: Identifier of existing account rule
    uint64 ruleID;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: ManageAccountRuleOp is used to create, update or remove account rule
struct ManageParticipationAccountRuleOp
{
    //: data is used to pass one of `ManageAccountRuleAction` with required params
    union switch (ManageParticipationAccountRuleAction action)
    {
    case CREATE:
        CreateParticipationAccountRuleData createData;
    case REMOVE:
        RemoveParticipationAccountRuleData removeData;
    } data;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageAccountRolePermissionOp Result ********/

//: Result codes of ManageAccountRuleResultCode
enum ManageParticipationAccountRuleResultCode
{
    //: Means that specified action in `data` of ManageAccountRuleOp was successfully performed
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: There is no account rule with such id
    NOT_FOUND = -1
};

//: Result of operation applying
union ManageParticipationAccountRuleResult switch (ManageParticipationAccountRuleResultCode code)
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
