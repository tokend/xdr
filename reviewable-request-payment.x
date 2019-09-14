%#include "xdr/operation-payment.h"

namespace stellar 
{
struct CreatePaymentRequest 
{
    PaymentOp paymentOp;

    EmptyExt ext;
};
}