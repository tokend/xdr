%#include "xdr/ledger-entries.h"
%#include "xdr/reviewable-request-create-deferred-payment.h"

namespace stellar
{

//: CreateDeferredPaymentCreationRequestOp is used to create `CREATE_DEFERRED_PAYMENT` request
struct CreateDeferredPaymentCreationRequestOp
{

    uint64 requestID;
    //: Body of request which will be created
    CreateDeferredPaymentRequest request;

    //: (optional) Bit mask whose flags must be cleared in order for `CREATE_ATOMIC_SWAP_BID` request to be approved,
    //: which will be used instead of key-value by `create_deferred_payment_creation_request_tasks` key
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
enum CreateDeferredPaymentCreationRequestResultCode
{
    //: `CREATE_DEFERRED_PAYMENT` request has either been successfully created
    //: or auto approved
    SUCCESS = 0,

    SOURCE_BALANCE_NOT_FOUND = -1,
    DESTINATION_ACCOUNT_NOT_FOUND = -2,
    INCORRECT_PRECISION = -3,
    UNDERFUNDED = -4,
    TASKS_NOT_FOUND = -5,
    INVALID_CREATOR_DETAILS = -6,
    INVALID_AMOUNT = -7,
    REQUEST_NOT_FOUND = -8
};

//: Success result of CreateASwapAskCreationRequestOp application
struct CreateDeferredPaymentCreationRequestSuccess
{
    //: id of created request
    uint64 requestID;
    //: Indicates whether or not the `CREATE_ATOMIC_SWAP_ASK` request was auto approved and fulfilled
    bool fulfilled;
    //: ID of a newly created ask (if the ask  creation request has been auto approved)
    uint64 deferredPaymentID;

    //: reserved for the future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: Result of CreateDeferredPaymentCreationRequestOp application
union CreateDeferredPaymentCreationRequestResult switch (CreateDeferredPaymentCreationRequestResultCode code)
{
case SUCCESS:
    //: is used to pass useful fields after successful operation applying
    CreateDeferredPaymentCreationRequestSuccess success;
default:
    void;
};

}
