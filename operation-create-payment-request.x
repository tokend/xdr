%#include "xdr/types.h"

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

    INVALID_PAYMENT = -1
};

struct CreatePaymentRequestSuccessResult 
{
    uint64 requestID;

    EmptyExt ext;
};

union CreatePaymentRequestResult switch (CreatePaymentRequestResultCode code) 
{
case SUCCESS:
    CreatePaymentRequestSuccessResult success;
case INVALID_PAYMENT:
    PaymentResultCode validationCode;
default:
    void;
};
}