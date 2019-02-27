%#include "xdr/Stellar-types.h"

namespace stellar
{

//: CreateChangeRoleRequestOp is used to create reviewable request
//: which after approval from admin will change role for `destinationAccount`
//: from current role to `accountRoleToSet`
struct CreateChangeRoleRequestOp
{
    //: Set zero to create new request, set non zero to update existing request
    uint64 requestID;

    //: AccountID of account which role will be changed
    AccountID destinationAccount;
    //: ID of account role which will be attached to `destinationAccount`
    uint64 accountRoleToSet;
    //: Arbitrary stringified json object that can be used to attach data to be reviewed by the admin
    longstring creatorDetails;

    //: Bit mask which will be used instead of value from key-value entry by
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
    //: Means that change role request successfully created
    //: or auto approved if pending tasks of requests was zero
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
    //: Not allowed to change `destinationAccount`, `accountRoleToSet`
    //: or set `allTasks` on update change role request
    INVALID_CHANGE_ROLE_REQUEST_DATA = -7,
    //: `creatorDetails` must be valid json structure
    INVALID_CREATOR_DETAILS = -8,
    //: There is no value in key-value entry by `change_role_tasks` key
    //: configuration does not allow to change role from current to `accountRoleToSet`
    CHANGE_ROLE_TASKS_NOT_FOUND = -9
};

//: Result of operation applying
union CreateChangeRoleRequestResult switch (CreateChangeRoleRequestResultCode code)
{
case SUCCESS:
    struct {
        //: ID of created or updated request
        uint64 requestID;
        //: True if request auto approved (pending tasks == 0),
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