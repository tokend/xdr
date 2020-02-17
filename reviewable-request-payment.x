%#include "xdr/operation-payment.h"

namespace stellar 
{
struct CreatePaymentRequest 
{
    PaymentOp paymentOp;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    case MOVEMENT_REQUESTS_DETAILS:
        longstring creatorDetails;
    } ext;
};
}