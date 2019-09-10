%#include "xdr/types.h"
%#include "xdr/operation-payment.h"
%#include "xdr/reviewable-request-payment.h"

namespace stellar 
{
struct CreatePaymentRequestOp
{
    CreatePaymentRequest request;

    uint32* allTasks;

    EmptyExt ext;
};

enum CreatePaymentRequestResultCode 
{
    SUCCESS = 0,

    INVALID_PAYMENT = -1,
    PAYMENT_TASKS_NOT_FOUND = -2
};

struct CreatePaymentRequestSuccessResult 
{
    uint64 requestID;
    bool fulfilled;

    PaymentResult* paymentResult;

    EmptyExt ext;
};

union CreatePaymentRequestResult switch (CreatePaymentRequestResultCode code) 
{
case SUCCESS:
    CreatePaymentRequestSuccessResult success;
case INVALID_PAYMENT:
    PaymentResultCode paymentCode;
default:
    void;
};
}