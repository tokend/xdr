%#include "xdr/types.h"

namespace stellar
{

//: `CreateChangeRoleRequestOp` is used to create reviewable requests
//: that, with admin's approval, will change the role of `destinationAccount`
//: from current role to `accountRoleToSet`
struct CreateChangeRoleRequestOp
{
    //: Set zero to create new request, set non zero to update existing request
    uint64 requestID;

    //: AccountID of an account whose role will be changed
    AccountID destinationAccount;
    //: ID of account role that will be attached to `destinationAccount`
    uint64 accountRoleToSet;
    //: Arbitrary stringified json object that can be used to attach data to be reviewed by an admin
    longstring creatorDetails;

    //: Bit mask that will be used instead of the value from key-value entry by
    //: `change_role_tasks:<currentRoleID>:<accountRoleToSet>` key
    uint32* allTasks;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* CreateUpdateKYCRequest Result ********/

//: Result codes of CreateChangeRoleRequestOp
enum CreateChangeRoleRequestResultCode
{
    //: Change role request has either been successfully created
    //: or auto approved
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: There is no destination account with such accountID
    ACC_TO_UPDATE_DOES_NOT_EXIST = -1,
    //: There is another change role request for such destination account
    REQUEST_ALREADY_EXISTS = -2,
    //: There is no request with such `requestID`
    REQUEST_DOES_NOT_EXIST = -4,
    //: Only `destinationAccount` can update change role request
    //: `destinationAccount` must be equal source Account
    NOT_ALLOWED_TO_UPDATE_REQUEST = -6,
    //: It is not allowed to change `destinationAccount`, `accountRoleToSet`
    //: or set `allTasks` on update change role request
    INVALID_CHANGE_ROLE_REQUEST_DATA = -7,
    //: `creatorDetails` must be in a valid JSON format
    INVALID_CREATOR_DETAILS = -8,
    //: There is no key-value entry by `change_role_tasks` key in the system;
    //: configuration does not allow changing the role from current to `accountRoleToSet`
    CHANGE_ROLE_TASKS_NOT_FOUND = -9,
    //: There is no account role with provided id
    ACCOUNT_ROLE_TO_SET_DOES_NOT_EXIST = -10
};

//: Result of operation application 
union CreateChangeRoleRequestResult switch (CreateChangeRoleRequestResultCode code)
{
case SUCCESS:
    struct {
        //: ID of a created or updated request
        uint64 requestID;
        //: True if request was auto approved (pending tasks == 0),
        //: `destinationAccount` must have new account role
        bool fulfilled;
        // Reserved for future use
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
