%#include "xdr/ledger-entries.h"

namespace stellar
{

//: CancelCloseDeferredPaymentRequestOp is used to cancel existing deferred payment creation request
struct CancelCloseDeferredPaymentRequestOp
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

//: Result codes of CancelCloseDeferredPaymentRequestOp
enum CancelCloseDeferredPaymentRequestResultCode
{
    //: Atomic swap ask was successfully removed or marked as canceled
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    NOT_FOUND = -1
};

//: Success result of CancelCloseDeferredPaymentRequestOp application
struct CancelCloseDeferredPaymentRequestResultSuccess
{
    //: reserved for the future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: Result of CancelCloseDeferredPaymentRequestOp application
union CancelCloseDeferredPaymentRequestResult switch (CancelCloseDeferredPaymentRequestResultCode code)
{
case SUCCESS:
    //: is used to pass useful fields after successful operation applying
    CancelCloseDeferredPaymentRequestResultSuccess success;
default:
    void;
};

}