%#include "xdr/ledger-entries.h"

namespace stellar {

/* ManageAccountRole

    Create or delete the policy attachment for any account, specific account type or account id

    Threshold: high

    Result: ManageAccountRoleResult
*/

//: Actions that can be performed with the account role
enum ManageAccountRoleAction
{
    CREATE = 0,
    UPDATE = 1,
    REMOVE = 2
};

//: CreateAccountRoleData is used to pass necessary params to create a new account role
struct CreateAccountRoleData
{
    //: Arbitrary stringified json object that will be attached to the role
    longstring details;
    //: Array of ids of existing unique rules
    uint64 ruleIDs<>;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: UpdateAccountRoleData is used to pass necessary params to update existing account role
struct UpdateAccountRoleData
{
    //: Identifier of existing signer role
    uint64 roleID;
    //: Arbitrary stringified json object that will be attached to the role
    longstring details;
    //: Array of ids of existing unique rules
    uint64 ruleIDs<>;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: RemoveAccountRoleData is used to pass necessary params to remove an existing account role
struct RemoveAccountRoleData
{
    //: Identifier of an existing account role
    uint64 roleID;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: ManageAccountRoleOp is used to create, update or remove account role
struct ManageAccountRoleOp
{
    //: data is used to pass one of `ManageAccountRoleAction` with required params
    union switch (ManageAccountRoleAction action)
    {
    case CREATE:
        CreateAccountRoleData createData;
    case UPDATE:
        UpdateAccountRoleData updateData;
    case REMOVE:
        RemoveAccountRoleData removeData;
    } data;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageAccountRoleOp Result ********/

//: Result codes of ManageAccountRoleResultCode
enum ManageAccountRoleResultCode
{
    //: This means that the specified action in `data` of ManageAccountRoleOp was successfully performed
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: There is no account role with such id
    NOT_FOUND = -1,
    //: THe role cannot be removed if it is attached to at least one account
    ROLE_IS_USED = -2,
    //: Passed details has an invalid json structure
    INVALID_DETAILS = -3,
    //: There is no rule with id passed through `ruleIDs`
    NO_SUCH_RULE = -4,
    //: It is not allowed to duplicate ids in `ruleIDs` array
    RULE_ID_DUPLICATION = -5
};

//: Result of the operation performed 
union ManageAccountRoleResult switch (ManageAccountRoleResultCode code)
{
    case SUCCESS:
        //: Is used to pass useful params if the operation is successful
        struct {
            //: id of the role that was managed
            uint64 roleID;

            //: reserved for future use
            union switch (LedgerVersion v)
            {
            case EMPTY_VERSION:
                void;
            }
            ext;
        } success;
    case RULE_ID_DUPLICATION:
    case NO_SUCH_RULE:
        //: ID of a rule that was either duplicated or does not exist
        uint64 ruleID;
    default:
        void;
};

}