%#include "xdr/ledger-entries.h"

namespace stellar
{
/* CancelDataOwnerUpdateRequestOp
   Cancels change role reviable request
   Result: CancelDataOwnerUpdateRequestResult
*/

//: CancelDataOwnerUpdateRequestOp is used to cancel reviwable request for an owner of data Update.
//: If successful, request with the corresponding ID will be deleted
struct CancelDataOwnerUpdateRequestOp
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

/******* CancelDataOwnerUpdateRequestResultCode Result ********/
//: Result codes for CancelDataOwnerUpdateRequest operation
enum CancelDataOwnerUpdateRequestResultCode
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
struct CancelDataOwnerUpdateSuccess {

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result of CancelDataOwnerUpdateRequest operation application along with the result code
union CancelDataOwnerUpdateRequestResult switch (CancelDataOwnerUpdateRequestResultCode code)
{
    case SUCCESS:
        CancelDataOwnerUpdateSuccess success;
    default:
        void;
};
}