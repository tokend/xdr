%#include "xdr/types.h"
%#include "xdr/operation-payment.h"
%#include "xdr/reviewable-request-payment.h"

namespace stellar 
{
struct CreatePaymentRequestOp
{
    //: Payment request details
    CreatePaymentRequest request;

    //: (optional) Bit mask whose flags must be cleared in order for CreateSale request to be approved, which will be used by key sale_create_tasks:<asset_code>
    //: instead of key-value
    uint32* allTasks;

    //: reserved for future extension
    EmptyExt ext;
};

enum CreatePaymentRequestResultCode 
{
    //: CreatePaymentRequestOp was successfully applied
    SUCCESS = 0,

    //: Payment is invalid
    INVALID_PAYMENT = -1,
    //: Tasks for the payment request were neither provided in the request nor loaded through KeyValue
    PAYMENT_TASKS_NOT_FOUND = -2,
    //: Creator details are not in a valid JSON format
    INVALID_CREATOR_DETAILS = -3
};

//: Result of the successful payment request creation
struct CreatePaymentRequestSuccessResult 
{
    //: ID of the Payment request
    uint64 requestID;
    //: Indicates whether or not the payment request was auto approved
    bool fulfilled;

    //: Result of the payment application
    PaymentResult* paymentResult;

    //: reserved for future extension
    EmptyExt ext;
};

//: Result of CreatePaymentRequestOp application
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