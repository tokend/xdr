%#include "xdr/ledger-entries.h"

namespace stellar
{

//: CancelDeferredPaymentCreationRequestOp is used to cancel existing deferred payment creation request
struct CancelDeferredPaymentCreationRequestOp
{
    //: id of existing request
    uint64 requestID;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: Result codes of CancelDeferredPaymentCreationRequestOp
enum CancelDeferredPaymentCreationRequestResultCode
{
    //: Atomic swap ask was successfully removed or marked as canceled
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: There is no atomic swap ask with such id
    NOT_FOUND = -1, // request does not exist
    REQUEST_ID_INVALID = -2,
    LINE_FULL = -3
};

//: Success result of CancelDeferredPaymentCreationRequestOp application
struct CancelDeferredPaymentCreationRequestResultSuccess
{
    //: reserved for the future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: Result of CancelDeferredPaymentCreationRequestOp application
union CancelDeferredPaymentCreationRequestResult switch (CancelDeferredPaymentCreationRequestResultCode code)
{
case SUCCESS:
    //: is used to pass useful fields after successful operation applying
    CancelDeferredPaymentCreationRequestResultSuccess success;
default:
    void;
};

}