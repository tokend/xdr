%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* CancelSaleCreationRequestOp

    Cancels Sale creation request

    Threshold: high

    Result: CancelSaleCreationRequestResult
*/

struct CancelSaleCreationRequestOp
{
    uint64 requestID;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;

};

/******* CancelSaleCreationRequest Result ********/

enum CancelSaleCreationRequestResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    REQUEST_ID_INVALID = -1, // request id can not be equal zero
    REQUEST_NOT_FOUND = -2 // trying to cancel not existing reviewable request
};

struct CancelSaleCreationSuccess {

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};


union CancelSaleCreationRequestResult switch (CancelSaleCreationRequestResultCode code)
{
    case SUCCESS:
        CancelSaleCreationSuccess success;
    default:
        void;
};

}
