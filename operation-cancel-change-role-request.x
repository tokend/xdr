%#include "xdr/ledger-entries.h"

namespace stellar
{
/* CancelChangeRoleRequestOp

   Cancels change role reviable request

   Result: CancelChangeRoleRequestResult
*/

//: CancelChangeRoleRequestOp is used to cancel reviwable request for changing role.
//: If successful, request with the corresponding ID will be deleted
struct CancelChangeRoleRequestOp
{
    //: ID of the ChangeRoleRequest request to be canceled
    uint64 requestID;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;

};

/******* CancelChangeRoleRequestResultCode Result ********/
//: Result codes for CancelChangeRoleRequest operation
enum CancelChangeRoleRequestResultCode
{
    // codes considered as "success" for the operation
    //: Operation is successfully applied
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: ID of a request cannot be 0
    REQUEST_ID_INVALID = -1, // request id can not be equal zero
    //: ChangeRole request with provided ID is not found
    REQUEST_NOT_FOUND = -2 // trying to cancel not existing reviewable request
};

//: Result of successful `CancelChangeRoleRequestOp` application
struct CancelChangeRoleSuccess {

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result of CancelChangeRoleRequest operation application along with the result code
union CancelChangeRoleRequestResult switch (CancelChangeRoleRequestResultCode code)
{
    case SUCCESS:
        CancelChangeRoleSuccess success;
    default:
        void;
};
}
