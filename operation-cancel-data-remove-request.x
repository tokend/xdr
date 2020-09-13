%#include "xdr/ledger-entries.h"

namespace stellar
{
/* CancelDataRemoveRequestOp

   Cancels change role reviable request

   Result: CancelDataRemoveRequestResult
*/

//: CancelDataRemoveRequestOp is used to cancel reviwable request for data Remove.
//: If successful, request with the corresponding ID will be deleted
struct CancelDataRemoveRequestOp
{
    //: ID of the DataRemoveRequest request to be canceled
    uint64 requestID;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;

};

/******* CancelDataRemoveRequestResultCode Result ********/
//: Result codes for CancelDataRemoveRequest operation
enum CancelDataRemoveRequestResultCode
{
    // codes considered as "success" for the operation
    //: Operation is successfully applied
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: ID of a request cannot be 0
    REQUEST_ID_INVALID = -1, // request id can not be equal zero
    //: request with provided ID is not found
    REQUEST_NOT_FOUND = -2 // trying to cancel not existing reviewable request
};

//: Result of successful `CancelDataRemoveRequestOp` application
struct CancelDataRemoveSuccess {

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result of CancelDataRemoveRequest operation application along with the result code
union CancelDataRemoveRequestResult switch (CancelDataRemoveRequestResultCode code)
{
    case SUCCESS:
        CancelDataRemoveSuccess success;
    default:
        void;
};
}
