%#include "xdr/ledger-entries.h"

namespace stellar
{
/* CancelDataCreationRequestOp

   Cancels change role reviable request

   Result: CancelDataCreationRequestResult
*/

//: CancelDataCreationRequestOp is used to cancel reviwable request for data creation.
//: If successful, request with the corresponding ID will be deleted
struct CancelDataCreationRequestOp
{
    //: ID of the DataCreationRequest request to be canceled
    uint64 requestID;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;

};

/******* CancelDataCreationRequestResultCode Result ********/
//: Result codes for CancelDataCreationRequest operation
enum CancelDataCreationRequestResultCode
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

//: Result of successful `CancelDataCreationRequestOp` application
struct CancelDataCreationSuccess {

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result of CancelDataCreationRequest operation application along with the result code
union CancelDataCreationRequestResult switch (CancelDataCreationRequestResultCode code)
{
    case SUCCESS:
        CancelDataCreationSuccess success;
    default:
        void;
};
}
