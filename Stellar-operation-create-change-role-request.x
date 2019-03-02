%#include "xdr/Stellar-types.h"

namespace stellar
{

//: `CreateChangeRoleRequestOp` is used to create reviewable requests
//: that, after the reviewer's approval, will change the role of `destinationAccount`
//: from current to `accountRoleToSet`.
struct CreateChangeRoleRequestOp
{
    //: Set zero to create a new request, set non zero to update the existing request
    uint64 requestID;

    //: AccountID of an account whose role will be changed
    AccountID destinationAccount;
    //: ID of account role that will be attached to `destinationAccount`
    uint64 accountRoleToSet;
    //: Arbitrary stringified json object that can be used to attach data to be reviewed.
    longstring creatorDetails;

    //: Bit mask that will be used instead of the value from the key-value entry by
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
    //: or auto approved.
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: There is no `destinationAccount` with such accountID.
    ACC_TO_UPDATE_DOES_NOT_EXIST = -1,
    //: There is another change role request for such a destination account.
    REQUEST_ALREADY_EXISTS = -2,
    //: There is no request with such `requestID`.
    REQUEST_DOES_NOT_EXIST = -4,
    //: Only `destinationAccount` can update the change role request.
    //: `DestinationAccount` must be the same as the source account.
    NOT_ALLOWED_TO_UPDATE_REQUEST = -6,
    //: It is not allowed to change `destinationAccount`, `accountRoleToSet`
    //: or set `allTasks` on the update change role request.
    INVALID_CHANGE_ROLE_REQUEST_DATA = -7,
    //: `CreatorDetails` must be in a valid JSON format.
    INVALID_CREATOR_DETAILS = -8,
    //: There is no key-value entry by `change_role_tasks` key in the system;
    //: configuration does not allow changing the role from current to `accountRoleToSet`.
    CHANGE_ROLE_TASKS_NOT_FOUND = -9
};

//: Result of operation application.
union CreateChangeRoleRequestResult switch (CreateChangeRoleRequestResultCode code)
{
case SUCCESS:
    struct {
        //: ID of a created or updated request.
        uint64 requestID;
        //: True if a request was auto approved;
        //: `destinationAccount` must have a new account role.
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