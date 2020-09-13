%#include "xdr/ledger-entries.h"

namespace stellar
{
/* CancelDataUpdateRequestOp

   Cancels change role reviable request

   Result: CancelDataUpdateRequestResult
*/

//: CancelDataUpdateRequestOp is used to cancel reviwable request for data Update.
//: If successful, request with the corresponding ID will be deleted
struct CancelDataUpdateRequestOp
{
    //: ID of the DataUpdateRequest request to be canceled
    uint64 requestID;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;

};

/******* CancelDataUpdateRequestResultCode Result ********/
//: Result codes for CancelDataUpdateRequest operation
enum CancelDataUpdateRequestResultCode
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

//: Result of successful `CancelDataUpdateRequestOp` application
struct CancelDataUpdateSuccess {

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result of CancelDataUpdateRequest operation application along with the result code
union CancelDataUpdateRequestResult switch (CancelDataUpdateRequestResultCode code)
{
    case SUCCESS:
        CancelDataUpdateSuccess success;
    default:
        void;
};
}
