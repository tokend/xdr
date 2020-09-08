%#include "xdr/ledger-entries.h"
%#include "xdr/reviewable-request-atomic-swap-ask.h"

namespace stellar
{

//: CreateCloseDeferredPaymentRequestOp is used to create `CLOSE_DEFERRED_PAYMENT` request
struct CreateCloseDeferredPaymentRequestOp
{
    //: Body of request which will be created
    CloseDeferredPaymentRequest request;

    uint32* allTasks;
    //: reserved for the future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result codes of CreateAtomicSwapBidRequestOp
enum CreateCloseDeferredPaymentRequestResultCode
{
    //: `CLOSE_DEFERRED_PAYMENT` request has either been successfully created
    //: or auto approved
    SUCCESS = 0,

};

//: Success result of CreateASwapAskCreationRequestOp application
struct CreateCloseDeferredPaymentRequestSuccess
{
    uint64 requestID;
    bool fulfilled;
    uint64 deferredPaymentID;

    //: reserved for the future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: Result of CreateCloseDeferredPaymentRequestOp application
union CreateCloseDeferredPaymentRequestResult switch (CreateCloseDeferredPaymentRequestResultCode code)
{
case SUCCESS:
    //: is used to pass useful fields after successful operation applying
    CreateCloseDeferredPaymentRequestSuccess success;
default:
    void;
};

}