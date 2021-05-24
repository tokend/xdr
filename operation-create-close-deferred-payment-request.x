%#include "xdr/ledger-entries.h"
%#include "xdr/reviewable-request-close-deferred-payment.h"

namespace stellar
{

//: CreateCloseDeferredPaymentRequestOp is used to create `CLOSE_DEFERRED_PAYMENT` request
struct CreateCloseDeferredPaymentRequestOp
{

    uint64 requestID;

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

    UNDERFUNDED = -1,
    INVALID_CREATOR_DETAILS = -2,
    NOT_AUTHORIZED = -3,
    DESTINATION_ACCOUNT_NOT_FOUND = -4,
    INCORRECT_PRECISION = -5,
    ASSET_MISMATCH = -6,
    LINE_FULL = -7,
    TASKS_NOT_FOUND = -8,
    INVALID_AMOUNT = -9,
    DESTINATION_BALANCE_NOT_FOUND = -10,
    REQUEST_NOT_FOUND = -11
};


enum CloseDeferredPaymentEffect
{
    CHARGED = 0,
    DELETED = 1
};

struct CloseDeferredPaymentResult
{
    uint64 deferredPaymentID;

    AccountID destination;
    BalanceID destinationBalance;

    CloseDeferredPaymentEffect effect;

    EmptyExt ext;
};



//: Success result of CreateASwapAskCreationRequestOp application
struct CreateCloseDeferredPaymentRequestSuccess
{
    uint64 requestID;
    bool fulfilled;
    uint64 deferredPaymentID;

    CloseDeferredPaymentResult* extendedResult;

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
