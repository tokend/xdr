%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* CancelSaleCreationRequestOp

    Cancels Sale creation request

    Threshold: high

    Result: CancelSaleCreationRequestResult
*/

//: CancelSaleCreationRequest operation is used to cancel sale creation request which on successful application will delete
//: SaleCreationRequest with provided ID
struct CancelSaleCreationRequestOp
{
    //: ID of the SaleCreation request to cancel
    uint64 requestID;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;

};

/******* CancelSaleCreationRequest Result ********/
//: Result codes for CancelSaleCreationRequest operation
enum CancelSaleCreationRequestResultCode
{
    // codes considered as "success" for the operation
    //: Operation successfully applied
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: ID of the request cannot be 0
    REQUEST_ID_INVALID = -1, // request id can not be equal zero
    //: SaleCreation request with provided ID not found
    REQUEST_NOT_FOUND = -2 // trying to cancel not existing reviewable request
};

//: Result of successful application of `CancelSaleCreationRequestOp`
struct CancelSaleCreationSuccess {

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result of CancelSaleCreationRequest operation application along with result code
union CancelSaleCreationRequestResult switch (CancelSaleCreationRequestResultCode code)
{
    case SUCCESS:
        CancelSaleCreationSuccess success;
    default:
        void;
};

}
